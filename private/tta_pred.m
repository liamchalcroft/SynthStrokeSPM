function logits_dl = tta_pred(V, net)
  % TTA_PRED Performs Test Time Augmentation (TTA) prediction
  %
  % This function applies Test Time Augmentation to improve prediction
  % accuracy by averaging predictions from multiple flipped versions of
  % the input volume. It uses all possible combinations of flips along
  % the three spatial dimensions, resulting in 8 different orientations.
  %
  % Inputs:
  %   V   - Input volume (5D tensor: BCSSS format)
  %   net - Trained neural network model
  %
  % Outputs:
  %   logits_dl - Logits after TTA
  %
  flips = {
      [false false false],
      [true false false],
      [false true false],
      [false false true],
      [true true false],
      [true false true],
      [false true true],
      [true true true]
  };

  logits_dl = zeros(size(V));

  for i = 1:length(flips)
    V_flipped = V;
    if flips{i}(1)
        V_flipped = flip(V_flipped, 1);
    end
    if flips{i}(2)
        V_flipped = flip(V_flipped, 2);
    end
    if flips{i}(3)
        V_flipped = flip(V_flipped, 3);
    end
    
    logits_dl = predict(net, V_flipped);
    
    if flips{i}(1)
        logits_dl = flip(logits_dl, 1);
    end
    if flips{i}(2)
        logits_dl = flip(logits_dl, 2);
    end
    if flips{i}(3)
        logits_dl = flip(logits_dl, 3);
    end
    
    logits_dl = logits_dl + logits_dl;
  end

  logits_dl = logits_dl / length(flips);
end