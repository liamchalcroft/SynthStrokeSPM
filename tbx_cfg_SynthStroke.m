function synthstroke = tbx_cfg_SynthStroke
% TBX_CFG_SYNTHSTROKE Toolbox configuration function for SynthStrokeSPM

synthstroke        = cfg_choice;
synthstroke.tag    = 'synthstrokespm';
synthstroke.name   = 'SynthStrokeSPM';
synthstroke.help   = {'Toolbox for stroke segmentation in brain MRI images.'};
synthstroke.values = {spm_cfg_SynthStroke};

end
