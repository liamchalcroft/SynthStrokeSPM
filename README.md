<div align="center">

# SynthStroke SPM Toolbox
### Automated Stroke Lesion Segmentation for SPM12

[![Paper](https://img.shields.io/badge/Paper-MELBA%202025-blue?style=for-the-badge&logo=arxiv)](http://dx.doi.org/10.59275/j.melba.2025-f3g6)
[![PyTorch](https://img.shields.io/badge/PyTorch-Implementation-orange?style=for-the-badge&logo=github)](https://github.com/liamchalcroft/SynthStroke)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2024a+-green?style=for-the-badge&logo=mathworks)](https://www.mathworks.com/products/matlab.html)
[![License](https://img.shields.io/badge/License-MIT-red?style=for-the-badge)](LICENSE)

*SPM12 toolbox implementation of "[Synthetic Data for Robust Stroke Segmentation](http://dx.doi.org/10.59275/j.melba.2025-f3g6)" published in Machine Learning for Biomedical Imaging (MELBA) 2025.*

</div>

---

## About

This SPM12 toolbox provides automated stroke lesion segmentation for brain MRI and CT images using deep learning. The toolbox integrates directly into SPM's batch system and includes a pre-trained U-Net model trained on synthetic stroke data for robust performance across different imaging protocols.

**Features:**
- Pre-trained U-Net model for automated stroke lesion segmentation
- Native SPM12 batch interface integration
- Support for both T1-weighted MRI and CT imaging
- Test Time Augmentation (TTA) for improved accuracy
- Automatic 1mm isotropic resampling with restoration to original resolution
- Morphological hole filling and configurable probability thresholds

**Paper**: Chalcroft, L., Pappas, I., Price, C. J., & Ashburner, J. (2025). [Synthetic Data for Robust Stroke Segmentation](http://dx.doi.org/10.59275/j.melba.2025-f3g6). *Machine Learning for Biomedical Imaging*, 3, 317–346.

*Note: This tool is currently in early development. Please report any issues on GitHub to help improve the tool's reliability.*

---

## Installation

### Prerequisites
- [MATLAB](https://www.mathworks.com/products/matlab.html) (R2024a or later recommended)
- [SPM12](https://www.fil.ion.ucl.ac.uk/spm/) (SPM25 should work but is untested)
- [Deep Learning Toolbox](https://www.mathworks.com/products/deep-learning.html)
- [Image Processing Toolbox](https://www.mathworks.com/products/image.html)
- [**Deep Learning Toolbox Converter for ONNX Model Format**](https://www.mathworks.com/matlabcentral/fileexchange/67296-deep-learning-toolbox-converter-for-onnx-model-format) (Support Package)

### Installation Steps

1. **Download the toolbox:**
   ```bash
   git clone https://github.com/liamchalcroft/SynthStrokeSPM.git
   ```

2. **Install ONNX support package:**
   - Open MATLAB → HOME tab → Add-Ons → Get Add-Ons
   - Search for "Deep Learning Toolbox Converter for ONNX Model Format"
   - Install the package

3. **Place in SPM toolbox directory:**
   ```bash
   mv SynthStrokeSPM /path/to/spm12/toolbox/
   ```

4. **Restart SPM12** or refresh the toolbox menu

The toolbox requires no compilation and works entirely within MATLAB.

---

## Usage

### Quick Start

1. **Open SPM12** and navigate to **Batch** → **SPM** → **Tools** → **SynthStroke**
2. **Test with sample data:** Select `test_input/ct_img.nii` or `test_input/mprage_img.nii`
3. **Run batch** to generate segmentation results

### Standard Workflow

1. **Load images:** Select your T1-weighted MRI or CT scans (.nii/.img files)
2. **Configure options:**
   - **Use TTA**: Enable for improved accuracy (slower processing)
   - **Fill Holes**: Remove small gaps in lesion masks
   - **Lesion Threshold**: Adjust sensitivity (default: 0.5)
   - **Output Directory**: Specify save location (optional)
3. **Run batch processing**

### Expected Processing Time
- **Single image**: 1-2 minutes (standard), 5-10 minutes (with TTA)
- **Batch processing**: Scales linearly with number of images

---

## Output Files

The toolbox generates the following files:

- `c1*` - Background tissue posterior probability map
- `c2*` - Stroke lesion posterior probability map  
- `lesion_*` - Binary lesion mask (thresholded with optional hole filling)

---

## Support

For issues, questions, or contributions:
- **Bug reports**: [Open an issue](https://github.com/liamchalcroft/SynthStrokeSPM/issues)
- **PyTorch implementation**: [SynthStroke repository](https://github.com/liamchalcroft/SynthStroke)
- **Questions**: Contact via GitHub issues

---

## Citation

If you use this work in your research, please cite:

```bibtex
@article{Chalcroft2025,
  title = {Synthetic Data for Robust Stroke Segmentation},
  volume = {3},
  ISSN = {2766-905X},
  url = {http://dx.doi.org/10.59275/j.melba.2025-f3g6},
  DOI = {10.59275/j.melba.2025-f3g6},
  number = {August 2025},
  journal = {Machine Learning for Biomedical Imaging},
  publisher = {Machine Learning for Biomedical Imaging},
  author = {Chalcroft, Liam and Pappas, Ioannis and Price, Cathy J. and Ashburner, John},
  year = {2025},
  month = aug,
  pages = {317–346}
}
```

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
