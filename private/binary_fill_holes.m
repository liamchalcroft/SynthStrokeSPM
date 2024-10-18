function output = binary_fill_holes(input, connectivity)
% BINARY_FILL_HOLES Fill the holes in binary objects using flood fill
%
% INPUTS:
%   input        - N-D binary array with holes to be filled
%   connectivity - (optional) Connectivity for flood fill (default: 6 for 3D, 4 for 2D)
%
% OUTPUT:
%   output       - Binary array with holes filled
%
% This function uses a flood-fill algorithm for more drastic hole filling

% Input validation and default values
if nargin < 1
    error('Input image is required');
end

% Ensure input is logical
input = logical(input);

% Determine dimensionality and set default connectivity
dims = ndims(input);
if nargin < 2
    connectivity = 2 * dims;
end

% Flood fill from the edges
output = imfill(input, connectivity, 'holes');

end
