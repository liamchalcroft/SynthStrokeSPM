classdef ConstantOfShape_To_SubLayer1035 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.

    %#codegen
    %#ok<*PROPLC>
    %#ok<*NBRAK>
    %#ok<*INUSL>
    %#ok<*VARARG>

    properties (Learnable)
        x_model_model_1__154
    end

    properties
        ONNXParams         % An ONNXParameters object containing parameters used by this layer.
    end

    methods
        function this = ConstantOfShape_To_SubLayer1035(name, onnxParams)
            this.Name = name;
            this.NumOutputs = 2;
            this.OutputNames = {'x_model_model_1__141', 'x_model_model_1__140'};
            this.ONNXParams = onnxParams;
            this.x_model_model_1__154 = onnxParams.Learnables.x_model_model_1__154;
        end

        function [x_model_model_1__141, x_model_model_1__140] = predict(this, x_model_model_1__142)
            if isdlarray(x_model_model_1__142)
                x_model_model_1__142 = stripdims(x_model_model_1__142);
            end
            x_model_model_1__142NumDims = 5;
            onnxParams = this.ONNXParams;
            onnxParams.Learnables.x_model_model_1__154 = this.x_model_model_1__154;
            [x_model_model_1__141, x_model_model_1__140, x_model_model_1__141NumDims, x_model_model_1__140NumDims] = ConstantOfShape_To_SubFcn(x_model_model_1__142, x_model_model_1__142NumDims, onnxParams, 'Training', false, ...
                'InputDataPermutation', {[5 4 1 2 3], ['as-is']}, ...
                'OutputDataPermutation', {[3 4 5 2 1], [3 4 5 2 1], ['as-is'], ['as-is']});
            if any(cellfun(@(A)~isnumeric(A) && ~islogical(A), {x_model_model_1__141, x_model_model_1__140}))
                fprintf('Runtime error in network. At least one output of custom layer ''%s'' is a non-numeric, non-logical value.\n', 'ConstantOfShape_To_SubLayer1035');
                error(message('nnet_cnn_onnx:onnx:BadCustomLayerRuntimeOutput', 'ConstantOfShape_To_SubLayer1035'));
            end
            x_model_model_1__141 = dlarray(single(x_model_model_1__141), 'SSSCB');
            x_model_model_1__140 = dlarray(single(x_model_model_1__140), 'SSSCB');
            if ~coder.target('MATLAB')
                x_model_model_1__141 = extractdata(x_model_model_1__141);
                x_model_model_1__140 = extractdata(x_model_model_1__140);
            end
        end

        function [x_model_model_1__141, x_model_model_1__140] = forward(this, x_model_model_1__142)
            if isdlarray(x_model_model_1__142)
                x_model_model_1__142 = stripdims(x_model_model_1__142);
            end
            x_model_model_1__142NumDims = 5;
            onnxParams = this.ONNXParams;
            onnxParams.Learnables.x_model_model_1__154 = this.x_model_model_1__154;
            [x_model_model_1__141, x_model_model_1__140, x_model_model_1__141NumDims, x_model_model_1__140NumDims] = ConstantOfShape_To_SubFcn(x_model_model_1__142, x_model_model_1__142NumDims, onnxParams, 'Training', true, ...
                'InputDataPermutation', {[5 4 1 2 3], ['as-is']}, ...
                'OutputDataPermutation', {[3 4 5 2 1], [3 4 5 2 1], ['as-is'], ['as-is']});
            if any(cellfun(@(A)~isnumeric(A) && ~islogical(A), {x_model_model_1__141, x_model_model_1__140}))
                fprintf('Runtime error in network. At least one output of custom layer ''%s'' is a non-numeric, non-logical value.\n', 'ConstantOfShape_To_SubLayer1035');
                error(message('nnet_cnn_onnx:onnx:BadCustomLayerRuntimeOutput', 'ConstantOfShape_To_SubLayer1035'));
            end
            x_model_model_1__141 = dlarray(single(x_model_model_1__141), 'SSSCB');
            x_model_model_1__140 = dlarray(single(x_model_model_1__140), 'SSSCB');
            if ~coder.target('MATLAB')
                x_model_model_1__141 = extractdata(x_model_model_1__141);
                x_model_model_1__140 = extractdata(x_model_model_1__140);
            end
        end
    end
end

function [x_model_model_1__141, x_model_model_1__140, x_model_model_1__141NumDims, x_model_model_1__140NumDims, state] = ConstantOfShape_To_SubFcn(x_model_model_1__142, x_model_model_1__142NumDims, params, varargin)
%CONSTANTOFSHAPE_TO_SUBFCN Function implementing an imported ONNX network.
%
% THIS FILE WAS AUTO-GENERATED BY importONNXFunction.
% ONNX Operator Set Version: 17
%
% Variable names in this function are taken from the original ONNX file.
%
% [X_MODEL_MODEL_1__141, X_MODEL_MODEL_1__140] = ConstantOfShape_To_SubFcn(X_MODEL_MODEL_1__142, PARAMS)
%			- Evaluates the imported ONNX network CONSTANTOFSHAPE_TO_SUBFCN with input(s)
%			X_MODEL_MODEL_1__142 and the imported network parameters in PARAMS. Returns
%			network output(s) in X_MODEL_MODEL_1__141, X_MODEL_MODEL_1__140.
%
% [X_MODEL_MODEL_1__141, X_MODEL_MODEL_1__140, STATE] = ConstantOfShape_To_SubFcn(X_MODEL_MODEL_1__142, PARAMS)
%			- Additionally returns state variables in STATE. When training,
%			use this form and set TRAINING to true.
%
% [__] = ConstantOfShape_To_SubFcn(X_MODEL_MODEL_1__142, PARAMS, 'NAME1', VAL1, 'NAME2', VAL2, ...)
%			- Specifies additional name-value pairs described below:
%
% 'Training'
% 			Boolean indicating whether the network is being evaluated for
%			prediction or training. If TRAINING is true, state variables
%			will be updated.
%
% 'InputDataPermutation'
%			'auto' - Automatically attempt to determine the permutation
%			 between the dimensions of the input data and the dimensions of
%			the ONNX model input. For example, the permutation from HWCN
%			(MATLAB standard) to NCHW (ONNX standard) uses the vector
%			[4 3 1 2]. See the documentation for IMPORTONNXFUNCTION for
%			more information about automatic permutation.
%
%			'none' - Input(s) are passed in the ONNX model format. See 'Inputs'.
%
%			numeric vector - The permutation vector describing the
%			transformation between input data dimensions and the expected
%			ONNX input dimensions.%
%			cell array - If the network has multiple inputs, each cell
%			contains 'auto', 'none', or a numeric vector.
%
% 'OutputDataPermutation'
%			'auto' - Automatically attempt to determine the permutation
%			between the dimensions of the output and a conventional MATLAB
%			dimension ordering. For example, the permutation from NC (ONNX
%			standard) to CN (MATLAB standard) uses the vector [2 1]. See
%			the documentation for IMPORTONNXFUNCTION for more information
%			about automatic permutation.
%
%			'none' - Return output(s) as given by the ONNX model. See 'Outputs'.
%
%			numeric vector - The permutation vector describing the
%			transformation between the ONNX output dimensions and the
%			desired output dimensions.%
%			cell array - If the network has multiple outputs, each cell
%			contains 'auto', 'none' or a numeric vector.
%
% Inputs:
% -------
% X_MODEL_MODEL_1__142
%			- Input(s) to the ONNX network.
%			  The input size(s) expected by the ONNX file are:
%				  X_MODEL_MODEL_1__142:		[Unknown, Unknown, Unknown, Unknown, Unknown]				Type: FLOAT
%			  By default, the function will try to permute the input(s)
%			  into this dimension ordering. If the default is incorrect,
%			  use the 'InputDataPermutation' argument to control the
%			  permutation.
%
%
% PARAMS	- Network parameters returned by 'importONNXFunction'.
%
%
% Outputs:
% --------
% X_MODEL_MODEL_1__141, X_MODEL_MODEL_1__140
%			- Output(s) of the ONNX network.
%			  Without permutation, the size(s) of the outputs are:
%				  X_MODEL_MODEL_1__141:		[Unknown, Unknown, Unknown, Unknown, Unknown]				Type: FLOAT
%				  X_MODEL_MODEL_1__140:		[Unknown, Unknown, Unknown, Unknown, Unknown]				Type: FLOAT
%			  By default, the function will try to permute the output(s)
%			  from this dimension ordering into a conventional MATLAB
%			  ordering. If the default is incorrect, use the
%			  'OutputDataPermutation' argument to control the permutation.
%
% STATE		- (Optional) State variables. When TRAINING is true, these will
% 			  have been updated from the original values in PARAMS.State.
%
%
%  See also importONNXFunction

% Preprocess the input data and arguments:
[x_model_model_1__142, Training, outputDataPerms, anyDlarrayInputs] = preprocessInput(x_model_model_1__142, params, varargin{:});
% Put all variables into a single struct to implement dynamic scoping:
[Vars, NumDims] = packageVariables(params, {'x_model_model_1__142'}, {x_model_model_1__142}, [x_model_model_1__142NumDims]);
% Call the top-level graph function:
[x_model_model_1__141, x_model_model_1__140, x_model_model_1__141NumDims, x_model_model_1__140NumDims, state] = ConstantOfShape_To_SGraph1027(x_model_model_1__142, NumDims.x_model_model_1__142, Vars, NumDims, Training, params.State);
% Postprocess the output data
[x_model_model_1__141, x_model_model_1__140] = postprocessOutput(x_model_model_1__141, x_model_model_1__140, outputDataPerms, anyDlarrayInputs, Training, varargin{:});
end

function [x_model_model_1__141, x_model_model_1__140, x_model_model_1__141NumDims1033, x_model_model_1__140NumDims1034, state] = ConstantOfShape_To_SGraph1027(x_model_model_1__142, x_model_model_1__142NumDims1032, Vars, NumDims, Training, state)
% Function implementing the graph 'ConstantOfShape_To_SGraph1027'
% Update Vars and NumDims from the graph's formal input parameters. Note that state variables are already in Vars.
Vars.x_model_model_1__142 = x_model_model_1__142;
NumDims.x_model_model_1__142 = x_model_model_1__142NumDims1032;

% Execute the operators:
% ConstantOfShape:
[Vars.x_model_model_1__145, NumDims.x_model_model_1__145] = onnxConstantOfShape(Vars.ConstantOfShapeValue1028, Vars.x_model_model_1__154);

% Concat:
[Vars.x_model_model_1__144, NumDims.x_model_model_1__144] = onnxConcat(0, {Vars.x_model_model_1__146, Vars.x_model_model_1__145}, [NumDims.x_model_model_1__146, NumDims.x_model_model_1__145]);

% Reshape:
[shape, NumDims.x_model_model_1__157] = prepareReshapeArgs(Vars.x_model_model_1__144, Vars.x_model_model_1__147, NumDims.x_model_model_1__144, 0);
Vars.x_model_model_1__157 = reshape(Vars.x_model_model_1__144, shape{:});

% Slice:
[Indices, NumDims.x_model_model_1__158] = prepareSliceArgs(Vars.x_model_model_1__157, Vars.x_model_model_1__149, Vars.x_model_model_1__150, Vars.x_model_model_1__148, Vars.x_model_model_1__151, NumDims.x_model_model_1__157);
Vars.x_model_model_1__158 = subsref(Vars.x_model_model_1__157, Indices);

% Transpose:
[perm, NumDims.x_model_model_1__159] = prepareTransposeArgs(Vars.TransposePerm1029, NumDims.x_model_model_1__158);
if ~isempty(perm)
    Vars.x_model_model_1__159 = permute(Vars.x_model_model_1__158, perm);
end

% Reshape:
[shape, NumDims.x_model_model_1__156] = prepareReshapeArgs(Vars.x_model_model_1__159, Vars.x_model_model_1__152, NumDims.x_model_model_1__159, 0);
Vars.x_model_model_1__156 = reshape(Vars.x_model_model_1__159, shape{:});

% Cast:
if islogical(Vars.x_model_model_1__156)
    Vars.x_model_model_1__156 = single(Vars.x_model_model_1__156);
end
Vars.x_model_model_1__143 = cast(int64(extractdata(Vars.x_model_model_1__156)), 'like', Vars.x_model_model_1__156);
NumDims.x_model_model_1__143 = NumDims.x_model_model_1__156;

% Pad:
[Vars.x_model_model_1__155, NumDims.x_model_model_1__155] = onnxPad(Vars.x_model_model_1__142, Vars.x_model_model_1__143, Vars.x_model_model_1__153, 'constant', dlarray([0:NumDims.x_model_model_1__142]'), NumDims.x_model_model_1__142);

% ReduceMean:
dims = prepareReduceArgs(Vars.ReduceMeanAxes1030, NumDims.x_model_model_1__155);
Vars.x_model_model_1__139 = mean(Vars.x_model_model_1__155, dims);
NumDims.x_model_model_1__139 = NumDims.x_model_model_1__155;

% Sub:
Vars.x_model_model_1__141 = Vars.x_model_model_1__155 - Vars.x_model_model_1__139;
NumDims.x_model_model_1__141 = max(NumDims.x_model_model_1__155, NumDims.x_model_model_1__139);

% ReduceMean:
dims = prepareReduceArgs(Vars.ReduceMeanAxes1031, NumDims.x_model_model_1__155);
Vars.x_model_model_1__138 = mean(Vars.x_model_model_1__155, dims);
NumDims.x_model_model_1__138 = NumDims.x_model_model_1__155;

% Sub:
Vars.x_model_model_1__140 = Vars.x_model_model_1__155 - Vars.x_model_model_1__138;
NumDims.x_model_model_1__140 = max(NumDims.x_model_model_1__155, NumDims.x_model_model_1__138);

% Set graph output arguments from Vars and NumDims:
x_model_model_1__141 = Vars.x_model_model_1__141;
x_model_model_1__141NumDims1033 = NumDims.x_model_model_1__141;
x_model_model_1__140 = Vars.x_model_model_1__140;
x_model_model_1__140NumDims1034 = NumDims.x_model_model_1__140;
% Set output state from Vars:
state = updateStruct(state, Vars);
end

function [inputDataPerms, outputDataPerms, Training] = parseInputs(x_model_model_1__142, numDataOutputs, params, varargin)
% Function to validate inputs to ConstantOfShape_To_SubFcn:
p = inputParser;
isValidArrayInput = @(x)isnumeric(x) || isstring(x);
isValidONNXParameters = @(x)isa(x, 'ONNXParameters');
addRequired(p, 'x_model_model_1__142', isValidArrayInput);
addRequired(p, 'params', isValidONNXParameters);
addParameter(p, 'InputDataPermutation', 'auto');
addParameter(p, 'OutputDataPermutation', 'auto');
addParameter(p, 'Training', false);
parse(p, x_model_model_1__142, params, varargin{:});
inputDataPerms = p.Results.InputDataPermutation;
outputDataPerms = p.Results.OutputDataPermutation;
Training = p.Results.Training;
if isnumeric(inputDataPerms)
    inputDataPerms = {inputDataPerms};
end
if isstring(inputDataPerms) && isscalar(inputDataPerms) || ischar(inputDataPerms)
    inputDataPerms = repmat({inputDataPerms},1,1);
end
if isnumeric(outputDataPerms)
    outputDataPerms = {outputDataPerms};
end
if isstring(outputDataPerms) && isscalar(outputDataPerms) || ischar(outputDataPerms)
    outputDataPerms = repmat({outputDataPerms},1,numDataOutputs);
end
end

function [x_model_model_1__142, Training, outputDataPerms, anyDlarrayInputs] = preprocessInput(x_model_model_1__142, params, varargin)
% Parse input arguments
[inputDataPerms, outputDataPerms, Training] = parseInputs(x_model_model_1__142, 2, params, varargin{:});
anyDlarrayInputs = any(cellfun(@(x)isa(x, 'dlarray'), {x_model_model_1__142}));
% Make the input variables into unlabelled dlarrays:
x_model_model_1__142 = makeUnlabeledDlarray(x_model_model_1__142);
% Permute inputs if requested:
x_model_model_1__142 = permuteInputVar(x_model_model_1__142, inputDataPerms{1}, 5);
end

function [x_model_model_1__141, x_model_model_1__140] = postprocessOutput(x_model_model_1__141, x_model_model_1__140, outputDataPerms, anyDlarrayInputs, Training, varargin)
% Set output type:
if ~anyDlarrayInputs && ~Training
    if isdlarray(x_model_model_1__141)
        x_model_model_1__141 = extractdata(x_model_model_1__141);
    end
    if isdlarray(x_model_model_1__140)
        x_model_model_1__140 = extractdata(x_model_model_1__140);
    end
end
% Permute outputs if requested:
x_model_model_1__141 = permuteOutputVar(x_model_model_1__141, outputDataPerms{1}, 5);
x_model_model_1__140 = permuteOutputVar(x_model_model_1__140, outputDataPerms{2}, 5);
end


%% dlarray functions implementing ONNX operators:

function [Y, numDimsY] = onnxConcat(ONNXAxis, XCell, numDimsXArray)
% Concatentation that treats all empties the same. Necessary because
% dlarray.cat does not allow, for example, cat(1, 1x1, 1x0) because the
% second dimension sizes do not match.

% Copyright 2021 The MathWorks, Inc.

numDimsY = numDimsXArray(1);
XCell(cellfun(@isempty, XCell)) = [];
if isempty(XCell)
    Y = dlarray([]);
else
    if ONNXAxis<0
        ONNXAxis = ONNXAxis + numDimsY;
    end
    DLTAxis = numDimsY - ONNXAxis;
    Y = cat(DLTAxis, XCell{:});
end
end

function [Y, numDimsY] = onnxConstantOfShape(value, ONNXShape)
% Returns a DLT tensor with the reverse of the ONNXShape.

% Copyright 2020 The MathWorks, Inc.

DLTShape = fliplr(extractdata(ONNXShape(:)'));
numDimsY = numel(DLTShape);
switch numDimsY
    case 0
        % If shape is empty, output is a scalar
        Y = value;
    case 1
        Y = ones(DLTShape,1) .* value;
    otherwise
        Y = ones(DLTShape) .* value;
end
end

function [Y, numDimsY] = onnxPad(X, pads, value, mode, ONNXAxis, numDimsX)
% Implements the ONNX Pad operator

% ONNX 'pads' is a vector: [x1_begin, x2_begin...x1_end, x2_end,...], with
% x1,x2, listed in FORWARD ONNX dimension ordering, because it is data
% within a dimension and so is not flipped. xi_begin is the number of
% pixels added at the beginning of axis `i` and xi_end, the number of
% pixels added at the end of axis `i`.  pads can be negative, in which case
% that number of pixels is removed.

% Copyright 2020-2024 The MathWorks, Inc.

pads = pads(:)';
numDimsY = numDimsX;
if ONNXAxis < 0
    ONNXAxis = ONNXAxis + numDimsX;
end
% Fill in pads to length 2*numDimsX if size(ONNXAxis,1) < numDimsX
if size(ONNXAxis,1) < numDimsX
    helpPads = dlarray(zeros(1,2*numDimsX));
    helpPads([ONNXAxis+1,ONNXAxis+numDimsX+1]) = pads;
    pads = helpPads;
end

if numDimsX==1
    % X is Nx1. Temporarily make it reverse-ONNX 2D (1xN), then transpose
    % the result back to 1D at the end.
    X = X';
    numDimsX = 2;
    pads = [pads(1) 0 pads(2) 0];  % Don't pad the dummy dimension
    numDimsY = 1;
end
sizeX  = size(X, 1:numDimsX);
fwdPadMat = reshape(extractdata(pads), [], 2)';  % row1 = begins, row2 = ends
% Columns of padmat are in reverse ONNX ordering. Still the case that row1
% = begins, row2 = ends:
padmat = fliplr(fwdPadMat);
sizeY  = sum([sizeX; padmat]);
% Create output tensor of the right size
Y = value*ones(sizeY, 'like', X);
% Construct subsref indices for inserting (and cropping) the original
for i=1:numel(sizeX)
    Ysubs{i} = max(1,1+padmat(1,i)) : min(sizeY(i), sizeY(i)-padmat(2,i));
    Xsubs{i} = max(1,1-padmat(1,i)) : min(sizeX(i), sizeX(i)+padmat(2,i));
end
Sy      = struct('type', '()');
Sy.subs = Ysubs;
Sx      = struct('type', '()');
Sx.subs = Xsubs;
% Insert/crop the original into the result
Y = subsasgn(Y, Sy, subsref(X, Sx));
% Handle 'reflect' and 'edge' modes, but don't do it if X was 1D, 0x1.
if ismember(mode, ["edge", "reflect"]) && ~(numDimsY==1 && sizeX(2)==0)
    for dim = 1:numDimsX
        if any(padmat(:,dim)>0)
            % Setup a call to subsasgn
            prepad  = padmat(1,dim);
            postpad = padmat(2,dim);
            if prepad > 0
                [Sy, Sx] = prepadIndices(sizeX, prepad, dim, mode);
                Y = subsasgn(Y, Sy, subsref(Y, Sx));
            end
            if postpad > 0
                [Sy, Sx] = postpadIndices(sizeX, sizeY, prepad, postpad, dim, mode);
                Y = subsasgn(Y, Sy, subsref(Y, Sx));
            end
        end
    end
end
% Transpose the result back to 1D if the input was 1D
if numDimsY==1
    Y = Y';
end

% Subfunctions in onnxPad:
    function [Sy, Sx] = prepadIndices(sizeX, prepad, dim, mode)
        Sy   	= struct('type', '()');
        Sy.subs	= repmat({':'}, [1 numel(sizeX)]);
        Sx   	= Sy;
        % Write into the first 'prepad' elements of Y.dim.
        Sy.subs{dim} = 1:prepad;
        switch mode
            case 'reflect'
                % Create indices 2:prepad+1 of X.dim, in the reverse order, with
                % wraparound. Then add prepad to convert them to Y indices.
                Sx.subs{dim} = wrapIndices(prepad+1 : -1 : 2, sizeX(dim)) + prepad;
            case 'edge'
                % Create replicated indices 1 of X.dim. Then add prepad to
                % convert them to Y indices.
                Sx.subs{dim} = repmat(1, [1 prepad]) + prepad;
            otherwise
                assert(false);
        end
    end

    function [Sy, Sx] = postpadIndices(sizeX, sizeY, prepad, postpad, dim, mode)
        Sy   	= struct('type', '()');
        Sy.subs	= repmat({':'}, [1 numel(sizeX)]);
        Sx   	= Sy;
        % Write into the last 'postpad' elements of Y.dim.
        Sy.subs{dim} = sizeY(dim)-postpad+1 : sizeY(dim);
        switch mode
            case 'reflect'
                % Create indices in the reverse order, with wraparound. Then add
                % prepad to convert them to Y indices.
                Sx.subs{dim} = wrapIndices(sizeX(dim)-1 : -1 : sizeX(dim)-postpad, sizeX(dim)) + prepad;
            case 'edge'
                % Create replicated end indices . Then add prepad to convert them
                % to Y indices.
                Sx.subs{dim} = repmat(sizeX(dim), [1 postpad]) + prepad;
            otherwise
                assert(false);
        end
    end

    function j = wrapIndices(i, maxIdx)
        % i can be positive, negative or zero. Legal output indices are in the
        % range 1:maxIdx.
        j = mod(i-1, maxIdx) + 1;
    end
end


function dims = prepareReduceArgs(ONNXAxes, numDimsX)
% Prepares arguments for implementing the ONNX Reduce operator

%   Copyright 2020 The MathWorks, Inc.

if isempty(ONNXAxes)
    ONNXAxes = 0:numDimsX-1;   % All axes
end
ONNXAxes(ONNXAxes<0) = ONNXAxes(ONNXAxes<0) + numDimsX;
dims = numDimsX - ONNXAxes;
end

function [DLTShape, numDimsY] = prepareReshapeArgs(X, ONNXShape, numDimsX, allowzero)
% Prepares arguments for implementing the ONNX Reshape operator

%   Copyright 2020-2024 The MathWorks, Inc.

ONNXShape = flip(extractdata(ONNXShape));            % First flip the shape to make it correspond to the dimensions of X.
% In ONNX, 0 means "unchanged" if allowzero is false, and -1 means "infer". In DLT, there is no
% "unchanged", and [] means "infer".
DLTShape = num2cell(ONNXShape);                      % Make a cell array so we can include [].
% Replace zeros with the actual size if allowzero is false
if any(ONNXShape==0) && allowzero==0
    i0 = find(ONNXShape==0);
    DLTShape(i0) = num2cell(size(X, numDimsX - numel(ONNXShape) + i0));  % right-align the shape vector and dims
end
if any(ONNXShape == -1)
    % Replace -1 with []
    i = ONNXShape == -1;
    DLTShape{i} = [];
end
if numel(DLTShape)==1
    DLTShape = [DLTShape 1];
end
numDimsY = numel(ONNXShape);
end

function [S, numDimsY] = prepareSliceArgs(X, Starts, Ends, Axes, Steps, numDimsX)
% Prepares arguments for implementing the ONNX Slice operator

%   Copyright 2020 The MathWorks, Inc.

% Starts, Ends and Axes are all origin 0. Axes refer to the ONNX dimension
% ordering, but X uses the reverse, DLT ordering. Starts, Ends, Axes, and
% Steps correspond positionally. Axes and Steps may be omitted, with
% defaults described in the ONNX spec.

% Set default Axes and Steps if not supplied
if isempty(Axes)
    Axes = 0:numDimsX-1;   % All axes
end
Axes(Axes<0) = Axes(Axes<0) + numDimsX; % Handle negative Axes.
if isempty(Steps)
    Steps = ones(1, numel(Starts));
end
% Init all dims to :
S.subs = repmat({':'}, 1, numDimsX);
S.type = '()';
% Set Starts and Ends for each axis
for i = 1:numel(Axes)
    DLTDim = numDimsX - Axes(i);                                               % The DLT dim is the reverse of the ONNX dim.
    % "If a negative value is passed for any of the start or end indices,
    % it represents number of elements before the end of that dimension."
    if Starts(i) < 0
        Starts(i) = size(X,DLTDim) + Starts(i);
    end
    if Ends(i) < 0
        Ends(i) = max(-1, size(X,DLTDim) + Ends(i));                        % The -1 case is when we're slicing backward and want to include 0.
    end
    % "If the value passed to start or end is larger than the n (the number
    % of elements in this dimension), it represents n."
    if Starts(i) > size(X,DLTDim)
        Starts(i) = size(X,DLTDim);
    end
    if Ends(i) > size(X,DLTDim)
        Ends(i) = size(X,DLTDim);
    end
    if Steps(i) > 0
        S.subs{DLTDim} = 1 + (Starts(i) : Steps(i) : Ends(i)-1);            % 1 + (Origin 0 indexing with end index excluded)
    else
        S.subs{DLTDim} = 1 + (Starts(i) : Steps(i) : Ends(i)+1);            % 1 + (Origin 0 indexing with end index excluded)
    end
end
numDimsY = numDimsX;
end

function [perm, numDimsA] = prepareTransposeArgs(ONNXPerm, numDimsA)
% Prepares arguments for implementing the ONNX Transpose operator

%   Copyright 2020 The MathWorks, Inc.

if numDimsA <= 1        % Tensors of numDims 0 or 1 are unchanged by ONNX Transpose.
    perm = [];
else
    if isempty(ONNXPerm)        % Empty ONNXPerm means reverse the dimensions.
        perm = numDimsA:-1:1;
    else
        perm = numDimsA-flip(ONNXPerm);
    end
end
end

%% Utility functions:

function s = appendStructs(varargin)
% s = appendStructs(s1, s2,...). Assign all fields in s1, s2,... into s.

%   Copyright 2020 The MathWorks, Inc.

if isempty(varargin)
    s = struct;
else
    s = varargin{1};
    for i = 2:numel(varargin)
        fromstr = varargin{i};
        fs = fieldnames(fromstr);
        for j = 1:numel(fs)
            s.(fs{j}) = fromstr.(fs{j});
        end
    end
end
end

function checkInputSize(inputShape, expectedShape, inputName)

%   Copyright 2020-2021 The MathWorks, Inc.

if numel(expectedShape)==0
    % The input is a scalar
    if ~isequal(inputShape, [1 1])
        inputSizeStr = makeSizeString(inputShape);
        error(message('nnet_cnn_onnx:onnx:InputNeedsResize',inputName, "[1,1]", inputSizeStr));
    end
elseif numel(expectedShape)==1
    % The input is a vector
    if ~shapeIsColumnVector(inputShape) || ~iSizesMatch({inputShape(1)}, expectedShape)
        expectedShape{2} = 1;
        expectedSizeStr = makeSizeString(expectedShape);
        inputSizeStr = makeSizeString(inputShape);
        error(message('nnet_cnn_onnx:onnx:InputNeedsResize',inputName, expectedSizeStr, inputSizeStr));
    end
else
    % The input has 2 dimensions or more

    % The input dimensions have been reversed; flip them back to compare to the
    % expected ONNX shape.
    inputShape = fliplr(inputShape);

    % If the expected shape has fewer dims than the input shape, error.
    if numel(expectedShape) < numel(inputShape)
        expectedSizeStr = strjoin(["[", strjoin(string(expectedShape), ","), "]"], "");
        error(message('nnet_cnn_onnx:onnx:InputHasGreaterNDims', inputName, expectedSizeStr));
    end

    % Prepad the input shape with trailing ones up to the number of elements in
    % expectedShape
    inputShape = num2cell([ones(1, numel(expectedShape) - length(inputShape)) inputShape]);

    % Find the number of variable size dimensions in the expected shape
    numVariableInputs = sum(cellfun(@(x) isa(x, 'char') || isa(x, 'string'), expectedShape));

    % Find the number of input dimensions that are not in the expected shape
    % and cannot be represented by a variable dimension
    nonMatchingInputDims = setdiff(string(inputShape), string(expectedShape));
    numNonMatchingInputDims  = numel(nonMatchingInputDims) - numVariableInputs;

    expectedSizeStr = makeSizeString(expectedShape);
    inputSizeStr = makeSizeString(inputShape);
    if numNonMatchingInputDims == 0 && ~iSizesMatch(inputShape, expectedShape)
        % The actual and expected input dimensions match, but in
        % a different order. The input needs to be permuted.
        error(message('nnet_cnn_onnx:onnx:InputNeedsPermute',inputName, expectedSizeStr, inputSizeStr));
    elseif numNonMatchingInputDims > 0
        % The actual and expected input sizes do not match.
        error(message('nnet_cnn_onnx:onnx:InputNeedsResize',inputName, expectedSizeStr, inputSizeStr));
    end
end
end

function doesMatch = iSizesMatch(inputShape, expectedShape)
% Check whether the input and expected shapes match, in order.
% Size elements match if (1) the elements are equal, or (2) the expected
% size element is a variable (represented by a character vector or string)
doesMatch = true;
for i=1:numel(inputShape)
    if ~(isequal(inputShape{i},expectedShape{i}) || ischar(expectedShape{i}) || isstring(expectedShape{i}))
        doesMatch = false;
        return
    end
end
end

function sizeStr = makeSizeString(shape)
sizeStr = strjoin(["[", strjoin(string(shape), ","), "]"], "");
end

function isVec = shapeIsColumnVector(shape)
if numel(shape) == 2 && shape(2) == 1
    isVec = true;
else
    isVec = false;
end
end
function X = makeUnlabeledDlarray(X)
% Make numeric X into an unlabelled dlarray

%   Copyright 2020-2021 The MathWorks, Inc.

if isa(X, 'dlarray')
    X = stripdims(X);
elseif isnumeric(X)
    if isinteger(X)
        % Make ints double so they can combine with anything without
        % reducing precision
        X = double(X);
    end
    X = dlarray(X);
end
end

function [Vars, NumDims] = packageVariables(params, inputNames, inputValues, inputNumDims)

%   Copyright 2020 The MathWorks, Inc.

% inputNames, inputValues are cell arrays. inputRanks is a numeric vector.
Vars = appendStructs(params.Learnables, params.Nonlearnables, params.State);
NumDims = params.NumDimensions;
% Add graph inputs
for i = 1:numel(inputNames)
    Vars.(inputNames{i}) = inputValues{i};
    NumDims.(inputNames{i}) = inputNumDims(i);
end
end

function X = permuteInputVar(X, userDataPerm, onnxNDims)

%   Copyright 2020-2021 The MathWorks, Inc.
% Returns reverse-ONNX ordering
if onnxNDims == 0
    return;
elseif onnxNDims == 1 && isvector(X)
    X = X(:);
    return;
elseif isnumeric(userDataPerm)
    % Permute into reverse ONNX ordering
    if numel(userDataPerm) ~= onnxNDims
        error(message('nnet_cnn_onnx:onnx:InputPermutationSize', numel(userDataPerm), onnxNDims));
    end
    perm = fliplr(userDataPerm);
elseif isequal(userDataPerm, 'auto') && onnxNDims == 4
    % Permute MATLAB HWCN to reverse onnx (WHCN)
    perm = [2 1 3 4];
elseif isequal(userDataPerm, 'as-is')
    % Do not permute the input
    perm = 1:ndims(X);
else
    % userDataPerm is either 'none' or 'auto' with no default, which means
    % it's already in onnx ordering, so just make it reverse onnx
    perm = max(2,onnxNDims):-1:1;
end
X = permute(X, perm);
end

function Y = permuteOutputVar(Y, userDataPerm, onnxNDims)

%   Copyright 2020-2021 The MathWorks, Inc.
switch onnxNDims
    case 0
        perm = [];
    case 1
        if isnumeric(userDataPerm)
            % Use the user's permutation because Y is a column vector which
            % already matches ONNX.
            perm = userDataPerm;
        elseif isequal(userDataPerm, 'auto')
            % Treat the 1D onnx vector as a 2D column and transpose it
            perm = [2 1];
        else
            % userDataPerm is 'none'. Leave Y alone because it already
            % matches onnx.
            perm = [];
        end
    otherwise
        % ndims >= 2
        if isnumeric(userDataPerm)
            % Use the inverse of the user's permutation. This is not just the
            % flip of the permutation vector.
            perm = onnxNDims + 1 - userDataPerm;
        elseif isequal(userDataPerm, 'auto')
            if onnxNDims == 2
                % Permute reverse ONNX CN to DLT CN (do nothing)
                perm = [];
            elseif onnxNDims == 4
                % Permute reverse onnx (WHCN) to MATLAB HWCN
                perm = [2 1 3 4];
            else
                % User wants the output in ONNX ordering, so just reverse it from
                % reverse onnx
                perm = onnxNDims:-1:1;
            end
        elseif isequal(userDataPerm, 'as-is')
            % Do not permute the input
            perm = 1:ndims(Y);
        else
            % userDataPerm is 'none', so just make it reverse onnx
            perm = onnxNDims:-1:1;
        end
end
if ~isempty(perm)
    Y = permute(Y, perm);
end
end

function s = updateStruct(s, t)
% Set all existing fields in s from fields in t, ignoring extra fields in
% t.
%   Copyright 2020 The MathWorks, Inc.

for name = transpose(fieldnames(s))
    s.(name{1}) = t.(name{1});
end
end