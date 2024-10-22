function resliced_data = reslice_data(input_data, current_voxel_size, target_voxel_size)
    % RESLICE_DATA Reslices a NIfTI image to a specified voxel size
    %
    % [resliced_data, resliced_vol] = RESLICE_DATA(input_nii, target_voxel_size) 
    % reslices the input NIfTI image to the specified voxel size using SPM's reslice function.
    %
    % Inputs:
    %   input_data - 3D array of the input image
    %   input_voxel_size - 1x3 array, original voxel size in mm
    %   target_voxel_size - 1x3 array, desired voxel size in mm
    %
    % Outputs:
    %   resliced_data - 3D array of the resliced image data

    % Calculate the new dimensions
    old_dim = size(input_data);
    new_dim = round(old_dim .* (current_voxel_size ./ target_voxel_size));

    % Create original and query grid points
    [x1, x2, x3] = ndgrid(1:old_dim(1), 1:old_dim(2), 1:old_dim(3));
    [xq1, xq2, xq3] = ndgrid(linspace(1, old_dim(1), new_dim(1)), ...
                             linspace(1, old_dim(2), new_dim(2)), ...
                             linspace(1, old_dim(3), new_dim(3)));

    % Perform interpolation
    resliced_data = interpn(x1, x2, x3, input_data, xq1, xq2, xq3, 'linear');
end
