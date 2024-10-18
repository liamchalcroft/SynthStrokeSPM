function output = spm_binary_fill_holes(input, structure, origin)
% SPM_BINARY_FILL_HOLES Fill the holes in binary objects
%
% INPUTS:
%   input     - N-D binary array with holes to be filled
%   structure - (optional) Structuring element used in the computation
%   origin    - (optional) Position of the structuring element
%
% OUTPUT:
%   output    - Transformation of the initial image where holes have been filled
%
% This function is based on the SciPy implementation of binary_fill_holes

% Input validation and default values
if nargin < 1
    error('Input image is required');
end

if nargin < 2 || isempty(structure)
    structure = ones(3,3,3);
end

if nargin < 3
    origin = floor(size(structure) / 2);
end

% Ensure input is logical
input = logical(input);

% Create mask (complement of input)
mask = ~input;

% Create temporary array
tmp = false(size(mask));

% Perform binary dilation
dilated = imdilate(tmp, structure);
dilated(mask) = true;

% Invert the result
output = ~dilated;

end
