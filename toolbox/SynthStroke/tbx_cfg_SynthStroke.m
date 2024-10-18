function synthstroke = tbx_cfg_SynthStroke
% TBX_CFG_SYNTHSTROKE Toolbox configuration function for SynthStroke

if ~isdeployed, addpath(fullfile(spm('dir'),'toolbox','SynthStroke')); end

synthstroke        = cfg_choice;
synthstroke.tag    = 'synthstroke';
synthstroke.name   = 'SynthStroke';
synthstroke.help   = {'Toolbox for stroke segmentation in brain MRI images.'};
synthstroke.values = {spm_cfg_SynthStroke};

end
