function reset_orientation(input_file, output_file)
    % RESET_ORIENTATION resets the orientation of a NIfTI image to RAS+
    %
    % RESET_ORIENTATION(input_file, output_file) resets the orientation of the
    % NIfTI image specified by input_file to RAS+ and saves the result to
    % output_file.
    %
    % Input:
    %   input_file - string, path to the input NIfTI image
    %   output_file - string, path to save the output NIfTI image
    %
    % Example:
    %   reset_orientation('input.nii', 'output.nii');

    % Load the NIfTI file
    input_nii = spm_vol(char(input_file));
    input_data = spm_read_vols(input_nii);

    % Create a new NIfTI structure for the reset image
    reset_nii = input_nii;

    % Reset orientation
    reset_nii.mat = eye(4);  % Set affine matrix to identity
    reset_nii.mat(1:3, 4) = -size(input_data) / 2;  % Center the volume

    % Update header information
    reset_nii.private.mat = reset_nii.mat;
    reset_nii.private.mat0 = reset_nii.mat;

    % Set the output filename
    reset_nii.fname = char(output_file);

    % Write the reset NIfTI file
    spm_write_vol(reset_nii, input_data);
end
