function out = spm_SynthStroke(job)
% SPM_SYNTHSTROKE Perform stroke segmentation on brain MRI images
% This function is called by SPM to segment stroke lesions

% Get the path of the current file (spm_SynthStroke.m)
current_file_path = mfilename('fullpath');
% Get the directory of the current file
[toolbox_dir, ~, ~] = fileparts(current_file_path);
% Construct the path to the model file
model_path = fullfile(toolbox_dir, 'data', 'unet.mat');

% Load the model
if exist(model_path, 'file')
    load(model_path, 'net');
else
    error('Model file not found: %s', model_path);
end

% Process each input image
for i = 1:numel(job.input)
    % Load the input image
    V = spm_vol(job.input{i});

    img = spm_read_vols(V);

    % If the input is CT data, clip to 0 and 100 HU
    if job.ct_data
        img = max(0, min(100, img));
    end

    % Reslice the image to 1mm isotropic resolution
    original_voxel_size = sqrt(sum(V.mat(1:3,1:3).^2));
    img_isotropic = reslice_data(img, original_voxel_size, [1 1 1]);
    
    % Perform stroke segmentation
    posteriors_isotropic = stroke_segmentation(img_isotropic, net, job.use_tta);

    % Reslice the predictions to the original voxel size
    % Reslice each channel one-by-one
    posteriors = zeros([size(img) size(posteriors_isotropic, 4)]);
    for channel = 1:size(posteriors_isotropic, 4)
        posteriors(:,:,:,channel) = reslice_data(posteriors_isotropic(:,:,:,channel), [1 1 1], original_voxel_size);
    end

    % Threshold the posteriors
    lesion = uint8(squeeze(posteriors(:,:,:,end)) > job.lesion_threshold);

    % Fill the holes in the lesion mask
    if job.fill_holes
        lesion = uint8(binary_fill_holes(lesion));
    end

    % Determine the output directory
    if isempty(job.outdir)
        [outdir, ~, ~] = fileparts(job.input{i});
    else
        disp('Not empty');
        outdir = job.outdir{1};
    end

    % If the output directory does not exist, create it
    if ~exist(outdir, 'dir')
        mkdir(outdir);
    end

    % Save the posteriors as separate volumes for each class
    [~, nam, ~] = fileparts(job.input{i});
    V_seg = V;
    V_seg.dt = [spm_type('float32') spm_platform('bigend')];  % Ensure float32 data type
    
    for j = 2:size(posteriors, 4)
        posteriors_file = fullfile(outdir, sprintf('%sPosterior_SynthStroke_%s_class%d.nii',job.prefix, nam, j-1));
        V_seg.fname = posteriors_file;
        V_seg.descrip = sprintf('SynthStroke Posterior Probabilities - Class %d', j-1);
        spm_write_vol(V_seg, posteriors(:,:,:,j));
    end

    % Save the segmented image
    [~, nam, ~] = fileparts(job.input{i});
    out.lesion{i} = fullfile(outdir, [job.prefix 'Lesion_SynthStroke_' nam '.nii']);
    V_seg = V;
    V_seg.fname = out.lesion{i};
    V_seg.descrip = sprintf('SynthStroke Lesion Segmentation (threshold: %.2f)', job.lesion_threshold);
    spm_write_vol(V_seg, lesion);
end
end
