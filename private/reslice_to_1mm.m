function [resliced_nii, resliced_data] = reslice_to_1mm(input_nii)
    % RESLICE_TO_1MM Reslices a NIfTI image to 1mm isotropic resolution
    %
    % [resliced_nii, resliced_data] = RESLICE_TO_1MM(input_nii) reslices the input
    % NIfTI image to 1mm isotropic resolution using SPM's reslice function.
    %
    % Inputs:
    %   input_nii - NIfTI structure of the input image
    %
    % Outputs:
    %   resliced_nii - NIfTI structure of the resliced image
    %   resliced_data - 3D array of the resliced image data

    % Create a new NIfTI structure for the resliced image
    resliced_nii = input_nii;

    % Set the desired voxel size to 1mm isotropic
    voxel_size = [1 1 1];

    % Calculate the new dimensions
    old_dim = input_nii.dim;
    old_voxel_size = sqrt(sum(input_nii.mat(1:3,1:3).^2));
    new_dim = round(old_dim .* old_voxel_size ./ voxel_size);

    % Create a new transformation matrix
    scale = old_voxel_size ./ voxel_size;
    resliced_nii.mat = diag([scale 1]) * input_nii.mat;

    % Update the dimensions
    resliced_nii.dim = new_dim;

    % Reslice the image
    resliced_data = spm_slice_vol(input_nii, spm_matrix([0 0 0]), new_dim, 1);

    % Update the NIfTI structure
    resliced_nii.private.dat.dim = new_dim;
    resliced_nii.private.dat.scl_slope = 1;
    resliced_nii.private.dat.scl_inter = 0;
end
