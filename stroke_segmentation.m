function stroke_segmentation(niipath, modelfile, output_dir, use_tta)
% STROKE_SEGMENTATION Perform stroke segmentation on a brain MRI image.
%
%   STROKE_SEGMENTATION(niipath, modelfile, output_path) processes a NIfTI
%   file containing a brain MRI image to segment stroke regions using a
%   pre-trained ONNX model.
%
%   Inputs:
%       niipath    - String, path to the input NIfTI file (.nii or .nii.gz)
%       modelfile  - String, path to the ONNX model file
%       output_dir - String, path where the output NIfTI file will be saved
%       use_tta     - Boolean, whether to use test time augmentation (TTA)
%
%   Output:
%       The function saves the stroke segmentation result as a NIfTI file
%       at the specified output_path. The output is a probability map of
%       stroke regions.
%
%   Example:
%       niipath = './data/patient001.nii.gz';
%       modelfile = './models/stroke_segmentation_model.onnx';
%       output_dir = './results';
%       stroke_segmentation(niipath, modelfile, output_dir, true);
%
%   Notes:
%       - Requires MATLAB with Image Processing Toolbox, Deep Learning Toolbox,
%         Statistics and Machine Learning Toolbox, and MATLAB Converter for
%         ONNX Model Format.
%       - The input image is automatically normalized and resized to 192x192x192.
%       - The function handles both compressed (.nii.gz) and uncompressed (.nii)
%         input files.
%       - If use_tta is true, the function will perform test time augmentation
%         by averaging the predictions of the model with flipped inputs.
%
%   See also: NIFTIREAD, NIFTIWRITE, IMPORTNETWORKFROMONNX

    % Set default value for use_tta if not provided
    if nargin < 4
        use_tta = false;
    end

    % Ensure the output directory exists
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end

    disp('Starting stroke segmentation process...');
    tic;  % Start timer for overall process

    % Check if the input file is compressed (.nii.gz) and uncompress if necessary
    [~, ~, ext] = fileparts(niipath);
    if strcmpi(ext, '.gz')
        disp('Input file is compressed. Uncompressing...');
        [filepath, name, ~] = fileparts(niipath);
        uncompressed_path = fullfile(filepath, name);
        gunzip(niipath, filepath);
        niipath = uncompressed_path;
    end
    [filepath, name, ext] = fileparts(niipath);

    % Load the network
    % It should be faster to load from MATLAB once the ONNX model is converted
    % We should check for a .mat file first, and if it doesn't exist, convert

    disp('Loading model...');
    tic;
    [mdir, mname, mext] = fileparts(modelfile);
    if exist(fullfile(mdir, mname + ".mat"), "file")
        disp('Loading pre-converted model...');
        load(fullfile(mdir, mname + ".mat"), "net");
    else
        disp('Converting ONNX model...');
        net = importNetworkFromONNX(modelfile);

        % Initialize the network if not already done
        disp('Initializing ONNX model...');
        X = dlarray(rand(1, 1, 192, 192, 192), 'BCSSS');
        if ~net.Initialized
            net = initialize(net, X);
        end
        disp('ONNX model initialized.');

        % Save the network
        disp('Saving converted model...');
        save(fullfile(mdir, mname + ".mat"), "net");
        disp('Converted model saved.');
    end
    toc;
    disp('Model loaded successfully.');
    
    % Read the input NIfTI file
    disp('Reading input NIfTI file...');
    tic;
    info = niftiinfo(niipath);
    V = niftiread(info);
    toc;
    disp('NIfTI file read successfully.');
    
    % Save the original size of the input volume (first three dimensions)
    original_size = size(V);
    original_size = original_size(1:3);  % Ensure we're dealing with 3D only

    % Rescale to [0, 1] for histogram normalization
    disp('Rescaling image to [0, 1]...')
    tic;
    V_scaled = single(V);
    V_scaled = V_scaled - min(V_scaled(:));
    V_scaled = V_scaled / max(V_scaled(:));
    toc;
    disp('Image rescaling completed.')

    % Perform histogram normalization
    disp('Performing histogram normalization...');
    tic;
    V_hist = histeq(V_scaled);
    toc;
    disp('Histogram normalization completed.');
    
    % Z-score normalize the histogram normalized image
    disp('Z-scoring histogram normalized image...');
    tic;
    V_mean = mean(V_hist(:));
    V_std = std(V_hist(:));
    V_normalized = (V_hist - V_mean) / V_std;  % Z-score normalization
    toc;
    disp('Histogram normalized image z-scored.');
    
    % Permute and resize the input volume (if necessary)
    disp('Preparing input volume for prediction...');
    tic;
    V_permute = permute(V_normalized, [1, 2, 3]);  % Correct permutation for 3D spatial dimensions
    V_resize(1,1,:,:,:) = crop_or_pad_volume(V_permute, [192 192 192]);  % Resize to 192x192x192
    toc;
    disp('Input volume prepared.');
    
    % Convert the resized volume to a tensor
    V_tensor = dlarray(single(V_resize), "BCSSS");
    
    % Perform prediction
    disp('Performing prediction (this may take a while)...');
    tic;
    if use_tta
        logits_dl = tta_pred(V_tensor, net);
    else
        logits_dl = predict(net, V_tensor);
    end
    probs_dl = exp(logits_dl) ./ (exp(logits_dl).sum(4));
    probs_array = extractdata(probs_dl);
    toc;
    disp('Prediction completed.');
    
    % Extract argmax
    disp('Processing prediction results...');
    tic;
    [~, argmax_matrix] = max(probs_array, [], 4);
    argmax_matrix = squeeze(uint8(argmax_matrix));
    
    % Extract stroke segmentation from channel 6 (argmax)
    stroke_prob = squeeze(probs_array(:,:,:,6));
    
    % Adjust the predicted image back to the original size
    stroke_prob_cropped = crop_or_pad_volume(stroke_prob, [180 180 180]);
    stroke_prob_cropped = crop_or_pad_volume(stroke_prob_cropped, original_size);
    stroke_prob_cropped = single(stroke_prob_cropped);
    stroke_seg_cropped = uint8(stroke_prob_cropped);
    toc;
    disp('Prediction results processed.');
    
    % Save the predicted lesion as a NIfTI file
    disp('Saving prediction as NIfTI file...');
    tic;
    info.Filename = char(fullfile(output_dir, name + "_stroke_seg.nii"));
    info.Datatype = 'uint8';
    niftiwrite(stroke_seg_cropped, info.Filename, info);
    toc;
    disp(['NIfTI file saved as: ' info.Filename]);

    % Save the probability map as a NIfTI file
    disp('Saving probability map as NIfTI file...');
    tic;
    info.Filename = char(fullfile(output_dir, name + "_stroke_prob.nii"));
    info.Datatype = 'single';
    niftiwrite(stroke_prob_cropped, info.Filename, info);
    toc;
    disp(['NIfTI file saved as: ' info.Filename]);

    % Also save the full argmax matrix
    argmax_cropped = crop_or_pad_volume(argmax_matrix, [180 180 180]);
    argmax_cropped = crop_or_pad_volume(argmax_cropped, original_size);
    info.Filename = char(fullfile(output_dir, name + "_argmax.nii"));
    info.Datatype = 'uint8';
    niftiwrite(argmax_cropped, info.Filename, info);
    disp(['argmax matrix saved as: ' info.Filename]);

    total_time = toc;  % End timer for overall process
    disp(['Stroke segmentation completed in ' num2str(total_time) ' seconds.']);
end
