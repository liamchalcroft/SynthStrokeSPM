function out = spm_SynthStroke(job)
% SPM_SYNTHSTROKE Perform stroke segmentation on brain MRI images
% This function is called by SPM to segment stroke lesions

% Load the model
load('data/unet.mat', 'net');

% Process each input image
for i = 1:numel(job.input)
    % Load the input image
    V = spm_vol(job.input{i});
    img = spm_read_vols(V);
    
    % Perform stroke segmentation
    segmented = stroke_segmentation(img, net, job.use_tta);
    
    % Save the segmented image
    [pth, nam, ext] = fileparts(job.input{i});
    out.segmented{i} = fullfile(pth, [nam '_segmented' ext]);
    V_seg = V;
    V_seg.fname = out.segmented{i};
    V_seg.descrip = 'Stroke Segmentation';
    spm_write_vol(V_seg, segmented);
end
end
