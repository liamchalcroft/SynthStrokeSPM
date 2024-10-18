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

function synthstroke = spm_cfg_SynthStroke
% SPM_CFG_SYNTHSTROKE Configuration file for SynthStroke toolbox

% Input Images
input         = cfg_files;
input.tag     = 'input';
input.name    = 'Input Images';
input.help    = {'Select the input MRI images for stroke segmentation.'};
input.filter  = 'image';
input.ufilter = '.*';
input.num     = [1 Inf];

% Use TTA option
use_tta         = cfg_menu;
use_tta.tag     = 'use_tta';
use_tta.name    = 'Use Test Time Augmentation';
use_tta.help    = {'Use Test Time Augmentation for improved segmentation.'};
use_tta.labels  = {'No', 'Yes'};
use_tta.values  = {false, true};
use_tta.def     = @(val)use_tta.values{1};

% Executable branch
synthstroke      = cfg_exbranch;
synthstroke.tag  = 'synthstroke';
synthstroke.name = 'SynthStroke';
synthstroke.val  = {input, use_tta};
synthstroke.help = {'Perform stroke segmentation on brain MRI images.'};
synthstroke.prog = @spm_run_synthstroke;
synthstroke.vout = @vout_synthstroke;
end

function out = spm_run_synthstroke(job)
out.segmented = spm_SynthStroke(job);
end

function dep = vout_synthstroke(job)
dep            = cfg_dep;
dep.sname      = 'Segmented Images';
dep.src_output = substruct('.','segmented');
dep.tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
end

function synthstroke = tbx_cfg_SynthStroke
% TBX_CFG_SYNTHSTROKE Toolbox configuration function for SynthStroke

if ~isdeployed, addpath(fullfile(spm('dir'),'toolbox','SynthStroke')); end

synthstroke        = cfg_choice;
synthstroke.tag    = 'synthstroke';
synthstroke.name   = 'SynthStroke';
synthstroke.help   = {'Toolbox for stroke segmentation in brain MRI images.'};
synthstroke.values = {spm_cfg_SynthStroke};
end

