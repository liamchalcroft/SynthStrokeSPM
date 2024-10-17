% Function to crop or pad the volume back to the original size
function adjusted_volume = crop_or_pad_volume(volume, target_size)
% CROP_OR_PAD_VOLUME Adjust a 3D volume to a target size by cropping or padding.
%
%   adjusted_volume = CROP_OR_PAD_VOLUME(volume, target_size) adjusts the input
%   3D volume to match the specified target size by either cropping or padding
%   symmetrically along each dimension.
%
%   Inputs:
%       volume      - 3D numeric array, the input volume to be adjusted
%       target_size - 1x3 numeric array, the desired output size [x, y, z]
%
%   Output:
%       adjusted_volume - 3D numeric array, the adjusted volume matching the target size
%
%   The function performs the following operations:
%   1. If the input dimension is larger than the target, it crops centrally.
%   2. If the input dimension is smaller than the target, it pads symmetrically.
%   3. If the input dimension matches the target, it remains unchanged.
%
%   Example:
%       input_vol = rand(100, 120, 80);
%       target = [96, 128, 96];
%       output_vol = crop_or_pad_volume(input_vol, target);
%       size(output_vol)  % Returns: [96 128 96]
%
%   Note:
%   - The function assumes the input volume has at least 3 dimensions.
%   - Padding is done with zeros.
%   - Cropping and padding are performed symmetrically to maintain central alignment.
%
%   See also: PADARRAY, SIZE

% Get the actual size of the volume (only considering the first 3D dimensions)
[x, y, z] = size(volume);
  
% Initialize the output volume
adjusted_volume = volume;

% Handle the x-dimension (first dimension)
if x > target_size(1)
    % Crop if the current size is larger
    start_x = ceil((x - target_size(1)) / 2) + 1;
    end_x = start_x + target_size(1) - 1;
    adjusted_volume = adjusted_volume(start_x:end_x, :, :);
elseif x < target_size(1)
    % Pad symmetrically if the current size is smaller
    pad_before = floor((target_size(1) - x) / 2);
    pad_after = ceil((target_size(1) - x) / 2);
    adjusted_volume = padarray(adjusted_volume, [pad_before 0 0], 0, 'pre');
    adjusted_volume = padarray(adjusted_volume, [pad_after 0 0], 0, 'post');
end

% Handle the y-dimension (second dimension)
if y > target_size(2)
    % Crop if the current size is larger
    start_y = ceil((y - target_size(2)) / 2) + 1;
    end_y = start_y + target_size(2) - 1;
    adjusted_volume = adjusted_volume(:, start_y:end_y, :);
elseif y < target_size(2)
    % Pad symmetrically if the current size is smaller
    pad_before = floor((target_size(2) - y) / 2);
    pad_after = ceil((target_size(2) - y) / 2);
    adjusted_volume = padarray(adjusted_volume, [0 pad_before 0], 0, 'pre');
    adjusted_volume = padarray(adjusted_volume, [0 pad_after 0], 0, 'post');
end

% Handle the z-dimension (third dimension)
if z > target_size(3)
    % Crop if the current size is larger
    start_z = ceil((z - target_size(3)) / 2) + 1;
    end_z = start_z + target_size(3) - 1;
    adjusted_volume = adjusted_volume(:, :, start_z:end_z);
elseif z < target_size(3)
    % Pad symmetrically if the current size is smaller
    pad_before = floor((target_size(3) - z) / 2);
    pad_after = ceil((target_size(3) - z) / 2);
    adjusted_volume = padarray(adjusted_volume, [0 0 pad_before], 0, 'pre');
    adjusted_volume = padarray(adjusted_volume, [0 0 pad_after], 0, 'post');
end
end
