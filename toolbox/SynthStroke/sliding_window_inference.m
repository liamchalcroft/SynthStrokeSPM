function output = sliding_window_inference(input_volume, net, window_size, overlap)
    % SLIDING_WINDOW_INFERENCE Performs sliding window inference on a 3D volume
    %
    % output = SLIDING_WINDOW_INFERENCE(input_volume, net, window_size, overlap)
    % applies the neural network to overlapping windows of the input volume and
    % combines the results.
    %
    % Inputs:
    %   input_volume - 3D input volume
    %   net - Trained neural network
    %   window_size - Size of the sliding window (e.g., [192, 192, 192])
    %   overlap - Overlap between windows (e.g., [32, 32, 32])
    %
    % Outputs:
    %   output - 4D array containing the network output for the entire volume

    [h, w, d] = size(input_volume);
    
    % Calculate stride
    stride = window_size - overlap;
    
    % Initialize output volume
    output = zeros([size(input_volume), 6]);  % Assuming 6 output channels
    count = zeros(size(input_volume));
    
    for i = 1:stride(1):h-window_size(1)+1
        for j = 1:stride(2):w-window_size(2)+1
            for k = 1:stride(3):d-window_size(3)+1
                % Extract window
                window = input_volume(i:i+window_size(1)-1, j:j+window_size(2)-1, k:k+window_size(3)-1);
                
                % Prepare input for the network
                input_tensor = dlarray(single(reshape(window, [1, 1, window_size])), "BCSSS");
                
                % Run inference
                output_window = predict(net, input_tensor);
                output_window = extractdata(output_window);
                output_window = squeeze(output_window);
                
                % Add to output volume
                output(i:i+window_size(1)-1, j:j+window_size(2)-1, k:k+window_size(3)-1, :) = ...
                    output(i:i+window_size(1)-1, j:j+window_size(2)-1, k:k+window_size(3)-1, :) + output_window;
                
                % Update count
                count(i:i+window_size(1)-1, j:j+window_size(2)-1, k:k+window_size(3)-1) = ...
                    count(i:i+window_size(1)-1, j:j+window_size(2)-1, k:k+window_size(3)-1) + 1;
            end
        end
    end
    
    % Average the overlapping regions
    output = output ./ repmat(count, [1, 1, 1, 6]);
end
