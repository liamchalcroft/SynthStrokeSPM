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
    
    % Perform stroke segmentation
    posteriors = stroke_segmentation(img, net, job.use_tta);
    lesion = uint8(squeeze(posteriors(:,:,:,end)) > job.lesion_threshold);

    % Fill the holes in the lesion mask
    if job.fill_holes
        lesion = uint8(spm_binary_fill_holes(lesion));
    end

    % Determine the output directory
    if isempty(job.outdir)
        outdir = fileparts(job.input{i});
    else
        outdir = job.outdir{1};
    end

    % If the output directory does not exist, create it
    if ~exist(outdir, 'dir')
        mkdir(outdir);
    end

    % Save the posteriors as separate volumes for each class
    [~, nam, ext] = fileparts(job.input{i});
    V_seg = V;
    V_seg.dt = [spm_type('float32') spm_platform('bigend')];  % Ensure float32 data type
    
    for j = 1:size(posteriors, 4)
        posteriors_file = fullfile(outdir, sprintf('Posterior_SynthStroke_%s_class%d.nii', nam, j));
        V_seg.fname = posteriors_file;
        V_seg.descrip = sprintf('SynthStroke Posterior Probabilities - Class %d', j);
        spm_write_vol(V_seg, posteriors(:,:,:,j));
    end

    % Save the segmented image
    [~, nam, ext] = fileparts(job.input{i});
    out.lesion{i} = fullfile(outdir, ['Lesion_SynthStroke_' nam '.nii']);
    V_seg = V;
    V_seg.fname = out.lesion{i};
    V_seg.descrip = sprintf('SynthStroke Lesion Segmentation (threshold: %.2f)', job.lesion_threshold);
    spm_write_vol(V_seg, lesion);
end
end
