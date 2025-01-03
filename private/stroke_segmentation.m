function V_seg = stroke_segmentation(V, net, use_tta)
  % STROKE_SEGMENTATION Perform stroke segmentation on a brain MRI image.
  %
  %   STROKE_SEGMENTATION(V, net, use_tta) processes a NIfTI
  %   file containing a brain MRI image to segment stroke regions using a
  %   pre-trained ONNX model.
  %
  %   Inputs:
  %       V          - 3D array, input brain MRI image
  %       net        - ONNX network, pre-trained model for stroke segmentation
  %       use_tta    - Boolean, whether to use test time augmentation (TTA)
  %
  %   Output:
  %       V_seg      - 3D array, stroke segmentation result
  %
  %   Example:
  %       V = niftiread('./data/patient001.nii.gz');
  %       load('./models/unet.mat', 'net');
  %       V_seg = stroke_segmentation(V, net, true);
  %
  %   Notes:
  %       - The input image is automatically normalized and resized to 192x192x192.
  %       - If use_tta is true, the function will perform test time augmentation
  %         by averaging the predictions of the model with flipped inputs.
  %
  %   See also: NIFTIREAD, NIFTIWRITE, IMPORTNETWORKFROMONNX
  
      % Set default value for use_tta if not provided
      if nargin < 3
          use_tta = false;
      end
  
      % Save the original size of the input volume (first three dimensions)
      original_size = size(V);
      original_size = original_size(1:3);  % Ensure we're dealing with 3D only
  
      % Rescale to [0, 1] for histogram normalization
      disp('Rescaling image to [0, 1]...')
      tic;
      V_scaled = single(V);
      V_scaled = V_scaled - min(V_scaled(:));
      V_scaled = V_scaled / max(V_scaled(:));
      toc;
      disp('Image rescaling completed.')
  
      % Perform histogram normalization
      disp('Performing histogram normalization...');
      tic;
      V_hist = histeq(V_scaled);
      toc;
      disp('Histogram normalization completed.');
      
      % Z-score normalize the histogram normalized image
      disp('Z-scoring histogram normalized image...');
      tic;
      V_mean = mean(V_hist(:));
      V_std = std(V_hist(:));
      V_normalized = (V_hist - V_mean) / V_std;  % Z-score normalization
      toc;
      disp('Histogram normalized image z-scored.');
      
      % Permute and resize the input volume (if necessary)
      disp('Preparing input volume for prediction...');
      tic;
      V_permute = permute(V_normalized, [1, 2, 3]);  % Correct permutation for 3D spatial dimensions
      V_resize(1,1,:,:,:) = crop_or_pad_volume(V_permute, [192 192 192]);  % Resize to 192x192x192
      toc;
      disp('Input volume prepared.');
      
      % Convert the resized volume to a tensor
      V_tensor = dlarray(single(V_resize), "BCSSS");
      
      % Perform prediction
      disp('Performing prediction (this may take a while)...');
      tic;
      if use_tta
          logits_dl = tta_pred(V_tensor, net);
      else
          logits_dl = predict(net, V_tensor);
      end
      probs_dl = exp(logits_dl) ./ (exp(logits_dl).sum(4));
      probs_array = extractdata(probs_dl);
      toc;
      disp('Prediction completed.');

      % Crop posteriors to original size, setting anything out of FOV to background
      % Ideally we would use a sliding window if cropping was needed, but this is a TODO
      tic;
      V_seg = zeros([original_size, 6], "single");
      crop_tmp = crop_or_pad_volume(squeeze(probs_array(:,:,:,1)), [180 180 180]);
      V_seg(:,:,:,1) = crop_or_pad_volume(crop_tmp, original_size, 1);
      crop_tmp = crop_or_pad_volume(squeeze(probs_array(:,:,:,2)), [180 180 180]);
      V_seg(:,:,:,2) = crop_or_pad_volume(crop_tmp, original_size, 0);
      crop_tmp = crop_or_pad_volume(squeeze(probs_array(:,:,:,3)), [180 180 180]);
      V_seg(:,:,:,3) = crop_or_pad_volume(crop_tmp, original_size, 0);
      crop_tmp = crop_or_pad_volume(squeeze(probs_array(:,:,:,4)), [180 180 180]);
      V_seg(:,:,:,4) = crop_or_pad_volume(crop_tmp, original_size, 0);
      crop_tmp = crop_or_pad_volume(squeeze(probs_array(:,:,:,5)), [180 180 180]);
      V_seg(:,:,:,5) = crop_or_pad_volume(crop_tmp, original_size, 0);
      crop_tmp = crop_or_pad_volume(squeeze(probs_array(:,:,:,6)), [180 180 180]);
      V_seg(:,:,:,6) = crop_or_pad_volume(crop_tmp, original_size, 0);
      toc;
      disp('Prediction results processed.');
  end
  