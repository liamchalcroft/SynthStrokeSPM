classdef ReduceMean_To_SubLayer1130 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.

    %#codegen
    %#ok<*PROPLC>
    %#ok<*NBRAK>
    %#ok<*INUSL>
    %#ok<*VARARG>

    properties (Learnable)
    end

    properties
        ONNXParams         % An ONNXParameters object containing parameters used by this layer.
    end

    methods
        function this = ReduceMean_To_SubLayer1130(name, onnxParams)
            this.Name = name;
            this.OutputNames = {'x_model_model_1__64'};
            this.ONNXParams = onnxParams;
        end

        function [x_model_model_1__64] = predict(this, x_model_model_1__65)
            if isdlarray(x_model_model_1__65)
                x_model_model_1__65 = stripdims(x_model_model_1__65);
            end
            x_model_model_1__65NumDims = 5;
            onnxParams = this.ONNXParams;
            [x_model_model_1__64, x_model_model_1__64NumDims] = ReduceMean_To_SubFcn(x_model_model_1__65, x_model_model_1__65NumDims, onnxParams, 'Training', false, ...
                'InputDataPermutation', {[5 4 1 2 3], ['as-is']}, ...
                'OutputDataPermutation', {[3 4 5 2 1], ['as-is']});
            if any(cellfun(@(A)~isnumeric(A) && ~islogical(A), {x_model_model_1__64}))
                fprintf('Runtime error in network. At least one output of custom layer ''%s'' is a non-numeric, non-logical value.\n', 'ReduceMean_To_SubLayer1130');
                error(message('nnet_cnn_onnx:onnx:BadCustomLayerRuntimeOutput', 'ReduceMean_To_SubLayer1130'));
            end
            x_model_model_1__64 = dlarray(single(x_model_model_1__64), 'SSSCB');
            if ~coder.target('MATLAB')
                x_model_model_1__64 = extractdata(x_model_model_1__64);
            end
        end

        function [x_model_model_1__64] = forward(this, x_model_model_1__65)
            if isdlarray(x_model_model_1__65)
                x_model_model_1__65 = stripdims(x_model_model_1__65);
            end
            x_model_model_1__65NumDims = 5;
            onnxParams = this.ONNXParams;
            [x_model_model_1__64, x_model_model_1__64NumDims] = ReduceMean_To_SubFcn(x_model_model_1__65, x_model_model_1__65NumDims, onnxParams, 'Training', true, ...
                'InputDataPermutation', {[5 4 1 2 3], ['as-is']}, ...
                'OutputDataPermutation', {[3 4 5 2 1], ['as-is']});
            if any(cellfun(@(A)~isnumeric(A) && ~islogical(A), {x_model_model_1__64}))
                fprintf('Runtime error in network. At least one output of custom layer ''%s'' is a non-numeric, non-logical value.\n', 'ReduceMean_To_SubLayer1130');
                error(message('nnet_cnn_onnx:onnx:BadCustomLayerRuntimeOutput', 'ReduceMean_To_SubLayer1130'));
            end
            x_model_model_1__64 = dlarray(single(x_model_model_1__64), 'SSSCB');
            if ~coder.target('MATLAB')
                x_model_model_1__64 = extractdata(x_model_model_1__64);
            end
        end
    end
end

function [x_model_model_1__64, x_model_model_1__64NumDims, state] = ReduceMean_To_SubFcn(x_model_model_1__65, x_model_model_1__65NumDims, params, varargin)
%REDUCEMEAN_TO_SUBFCN Function implementing an imported ONNX network.
%
% THIS FILE WAS AUTO-GENERATED BY importONNXFunction.
% ONNX Operator Set Version: 17
%
% Variable names in this function are taken from the original ONNX file.
%
% [X_MODEL_MODEL_1__64] = ReduceMean_To_SubFcn(X_MODEL_MODEL_1__65, PARAMS)
%			- Evaluates the imported ONNX network REDUCEMEAN_TO_SUBFCN with input(s)
%			X_MODEL_MODEL_1__65 and the imported network parameters in PARAMS. Returns
%			network output(s) in X_MODEL_MODEL_1__64.
%
% [X_MODEL_MODEL_1__64, STATE] = ReduceMean_To_SubFcn(X_MODEL_MODEL_1__65, PARAMS)
%			- Additionally returns state variables in STATE. When training,
%			use this form and set TRAINING to true.
%
% [__] = ReduceMean_To_SubFcn(X_MODEL_MODEL_1__65, PARAMS, 'NAME1', VAL1, 'NAME2', VAL2, ...)
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
% X_MODEL_MODEL_1__65
%			- Input(s) to the ONNX network.
%			  The input size(s) expected by the ONNX file are:
%				  X_MODEL_MODEL_1__65:		[Unknown, Unknown, Unknown, Unknown, Unknown]				Type: FLOAT
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
% X_MODEL_MODEL_1__64
%			- Output(s) of the ONNX network.
%			  Without permutation, the size(s) of the outputs are:
%				  X_MODEL_MODEL_1__64:		[Unknown, Unknown, Unknown, Unknown, Unknown]				Type: FLOAT
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
[x_model_model_1__65, Training, outputDataPerms, anyDlarrayInputs] = preprocessInput(x_model_model_1__65, params, varargin{:});
% Put all variables into a single struct to implement dynamic scoping:
[Vars, NumDims] = packageVariables(params, {'x_model_model_1__65'}, {x_model_model_1__65}, [x_model_model_1__65NumDims]);
% Call the top-level graph function:
[x_model_model_1__64, x_model_model_1__64NumDims, state] = ReduceMean_To_SubGraph1126(x_model_model_1__65, NumDims.x_model_model_1__65, Vars, NumDims, Training, params.State);
% Postprocess the output data
[x_model_model_1__64] = postprocessOutput(x_model_model_1__64, outputDataPerms, anyDlarrayInputs, Training, varargin{:});
end

function [x_model_model_1__64, x_model_model_1__64NumDims1129, state] = ReduceMean_To_SubGraph1126(x_model_model_1__65, x_model_model_1__65NumDims1128, Vars, NumDims, Training, state)
% Function implementing the graph 'ReduceMean_To_SubGraph1126'
% Update Vars and NumDims from the graph's formal input parameters. Note that state variables are already in Vars.
Vars.x_model_model_1__65 = x_model_model_1__65;
NumDims.x_model_model_1__65 = x_model_model_1__65NumDims1128;

% Execute the operators:
% ReduceMean:
dims = prepareReduceArgs(Vars.ReduceMeanAxes1127, NumDims.x_model_model_1__65);
Vars.x_model_model_1__62 = mean(Vars.x_model_model_1__65, dims);
NumDims.x_model_model_1__62 = NumDims.x_model_model_1__65;

% Sub:
Vars.x_model_model_1__64 = Vars.x_model_model_1__65 - Vars.x_model_model_1__62;
NumDims.x_model_model_1__64 = max(NumDims.x_model_model_1__65, NumDims.x_model_model_1__62);

% Set graph output arguments from Vars and NumDims:
x_model_model_1__64 = Vars.x_model_model_1__64;
x_model_model_1__64NumDims1129 = NumDims.x_model_model_1__64;
% Set output state from Vars:
state = updateStruct(state, Vars);
end

function [inputDataPerms, outputDataPerms, Training] = parseInputs(x_model_model_1__65, numDataOutputs, params, varargin)
% Function to validate inputs to ReduceMean_To_SubFcn:
p = inputParser;
isValidArrayInput = @(x)isnumeric(x) || isstring(x);
isValidONNXParameters = @(x)isa(x, 'ONNXParameters');
addRequired(p, 'x_model_model_1__65', isValidArrayInput);
addRequired(p, 'params', isValidONNXParameters);
addParameter(p, 'InputDataPermutation', 'auto');
addParameter(p, 'OutputDataPermutation', 'auto');
addParameter(p, 'Training', false);
parse(p, x_model_model_1__65, params, varargin{:});
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

function [x_model_model_1__65, Training, outputDataPerms, anyDlarrayInputs] = preprocessInput(x_model_model_1__65, params, varargin)
% Parse input arguments
[inputDataPerms, outputDataPerms, Training] = parseInputs(x_model_model_1__65, 1, params, varargin{:});
anyDlarrayInputs = any(cellfun(@(x)isa(x, 'dlarray'), {x_model_model_1__65}));
% Make the input variables into unlabelled dlarrays:
x_model_model_1__65 = makeUnlabeledDlarray(x_model_model_1__65);
% Permute inputs if requested:
x_model_model_1__65 = permuteInputVar(x_model_model_1__65, inputDataPerms{1}, 5);
end

function [x_model_model_1__64] = postprocessOutput(x_model_model_1__64, outputDataPerms, anyDlarrayInputs, Training, varargin)
% Set output type:
if ~anyDlarrayInputs && ~Training
    if isdlarray(x_model_model_1__64)
        x_model_model_1__64 = extractdata(x_model_model_1__64);
    end
end
% Permute outputs if requested:
x_model_model_1__64 = permuteOutputVar(x_model_model_1__64, outputDataPerms{1}, 5);
end


%% dlarray functions implementing ONNX operators:

function dims = prepareReduceArgs(ONNXAxes, numDimsX)
% Prepares arguments for implementing the ONNX Reduce operator

%   Copyright 2020 The MathWorks, Inc.

if isempty(ONNXAxes)
    ONNXAxes = 0:numDimsX-1;   % All axes
end
ONNXAxes(ONNXAxes<0) = ONNXAxes(ONNXAxes<0) + numDimsX;
dims = numDimsX - ONNXAxes;
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
