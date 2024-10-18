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
use_tta.def     = @(val)false;

% Lesion Threshold
lesion_threshold         = cfg_entry;
lesion_threshold.tag     = 'lesion_threshold';
lesion_threshold.name    = 'Lesion Threshold';
lesion_threshold.help    = {'Set the threshold for lesion segmentation (0-1). Higher values result in more conservative lesion detection.'};
lesion_threshold.strtype = 'r';
lesion_threshold.num     = [1 1];
lesion_threshold.def     = @(val)0.167;

% Output Directory
outdir         = cfg_files;
outdir.tag     = 'outdir';
outdir.name    = 'Output Directory';
outdir.help    = {'Select the output directory for segmented images. If left empty, segmented images will be saved in the same directory as input images.'};
outdir.filter  = 'dir';
outdir.ufilter = '.*';
outdir.num     = [0 1];
outdir.val     = {{''}};  % Default to empty (use input directory)

% Fill Holes option
fill_holes         = cfg_menu;
fill_holes.tag     = 'fill_holes';
fill_holes.name    = 'Fill Holes';
fill_holes.help    = {'Fill holes in the lesion mask. This uses a binary hole filling algorithm to clean up the lesion mask.'};
fill_holes.labels  = {'No', 'Yes'};
fill_holes.values  = {false, true};
fill_holes.def     = @(val)false;

% Executable branch
synthstroke      = cfg_exbranch;
synthstroke.tag  = 'synthstroke';
synthstroke.name = 'SynthStroke';
synthstroke.val  = {input, lesion_threshold, use_tta, fill_holes, outdir};
synthstroke.help = {'Perform stroke segmentation on brain MRI images.'};
synthstroke.prog = @spm_run_synthstroke;
synthstroke.vout = @vout_synthstroke;
end

function out = spm_run_synthstroke(job)
out.lesion = spm_SynthStroke(job);
end

function dep = vout_synthstroke(job)
dep            = cfg_dep;
dep.sname      = 'Segmented Images';
dep.src_output = substruct('.','lesion');
dep.tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
end
