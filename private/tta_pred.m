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

  accumulated_logits = [];

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
    
    current_logits = predict(net, V_flipped);
    
    if flips{i}(1)
        current_logits = flip(current_logits, 1);
    end
    if flips{i}(2)
        current_logits = flip(current_logits, 2);
    end
    if flips{i}(3)
        current_logits = flip(current_logits, 3);
    end
    
    if i == 1
        accumulated_logits = current_logits;
    else
        accumulated_logits = accumulated_logits + current_logits;
    end
  end

  logits_dl = accumulated_logits;

  logits_dl = logits_dl / length(flips);
end