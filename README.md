# SynthStroke: SPM Toolbox for Stroke Lesion Segmentation

SynthStroke is a powerful toolbox for SPM (Statistical Parametric Mapping) that performs automated stroke lesion segmentation on brain MRI images using deep learning techniques.

## Features

- Automated stroke lesion segmentation
- Integration with SPM12
- Support for Test Time Augmentation (TTA)
- Binary hole filling for lesion masks
- Customizable output options

## Installation

1. Download the SynthStroke toolbox.
2. Place the SynthStroke folder in your SPM toolbox directory:
   ```
   /path/to/spm12/toolbox/SynthStroke
   ```
3. Restart SPM12 or refresh the SPM toolbox menu.

## Usage

1. Open SPM12
2. Navigate to "Batch" → "SPM" → "Tools" → "SynthStroke"
3. In the batch editor:
   - Select your input image(s)
   - Choose your desired options
   - Set the output directory (optional)
   - Run the batch

## Options

- **Use TTA**: Enable Test Time Augmentation for potentially improved results
- **Fill holes**: Apply binary hole filling to the lesion mask
- **Lesion threshold**: Set the threshold for lesion classification (0-1)
- **Output prefix**: Customize the prefix for output files

## Output

SynthStroke generates:
- Posterior probability maps for each class
- Binary lesion mask

## Requirements

- MATLAB (R2019b or later recommended)
- SPM12
- Deep Learning Toolbox

## Support

For issues, questions, or contributions, please open an issue on our GitHub repository or contact [Your Contact Information].

## Citation

If you use SynthStroke in your research, please cite:
If you use SynthStroke in your research, please cite:

Chalcroft, L., Pappas, I., Price, C. J., & Ashburner, J. (2024). Synthetic Data for Robust Stroke Segmentation. arXiv preprint arXiv:2404.01946. https://arxiv.org/abs/2404.01946

## License

This project is licensed under the MIT License.

Copyright (c) [2024] [Liam Chalcroft]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
