function run_stroke_segmentation_app(varargin)
    if nargin > 0
        StrokeSegmentationApp(varargin{1});
    else
        StrokeSegmentationApp();
    end
end
