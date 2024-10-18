# SynthStroke Toolbox for SPM

SynthStroke is a MATLAB toolbox for SPM that performs stroke segmentation on brain MRI images using a pre-trained U-Net model.

## Installation

1. Copy the `SynthStroke` folder to the `toolbox` directory in your SPM installation.
2. Add the path to the SynthStroke toolbox in MATLAB:
   ```matlab
   addpath(fullfile(spm('dir'), 'toolbox', 'SynthStroke'))
   ```
3. Restart SPM or run `spm_jobman('initcfg')` to update the SPM menu.

## Usage

1. Open SPM and go to "Batch".
2. In the SPM menu, navigate to "Tools" > "SynthStroke" > "SynthStroke".
3. Add input images and configure options as needed.
4. Run the batch job to perform stroke segmentation.

## Requirements

- SPM12
- MATLAB R2019b or later
- Deep Learning Toolbox

## License

[Add your license information here]

