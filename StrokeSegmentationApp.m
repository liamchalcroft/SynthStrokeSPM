classdef StrokeSegmentationApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        FileMenu               matlab.ui.container.Menu
        OpenMenuItem           matlab.ui.container.Menu
        ExitMenuItem           matlab.ui.container.Menu
        SegmentButton          matlab.ui.control.Button
        LesionToggleButton     matlab.ui.control.StateButton
        TTACheckBox            matlab.ui.control.CheckBox
        SlidingWindowCheckBox  matlab.ui.control.CheckBox
        Viewer3D               matlab.ui.control.UIAxes
        StatusLabel            matlab.ui.control.Label
    end

    % Properties that correspond to app data
    properties (Access = private)
        OriginalVolume     % Original image volume
        SegmentedVolume    % Segmented image volume
        NiftiInfo          % NIfTI information structure
        CurrentSlice       % Current slice being displayed
        ShowLesion         % Boolean to toggle lesion visibility
        Model              % Pre-loaded ONNX model
        ModelPath          % Path to the ONNX model file
    end

    methods (Access = private)

        function updateViewer(app)
            % Update the 3D viewer based on current state
            if isempty(app.OriginalVolume)
                return;
            end

            slice = app.OriginalVolume(:,:,app.CurrentSlice);
            
            if app.ShowLesion && ~isempty(app.SegmentedVolume)
                lesion_slice = app.SegmentedVolume(:,:,app.CurrentSlice) > 0;
                rgb_slice = repmat(mat2gray(slice), [1 1 3]);
                rgb_slice(:,:,1) = rgb_slice(:,:,1) + 0.5 * lesion_slice;
                imshow(rgb_slice, 'Parent', app.Viewer3D);
            else
                imshow(slice, [], 'Parent', app.Viewer3D);
            end
            
            title(app.Viewer3D, sprintf('Slice %d/%d', app.CurrentSlice, size(app.OriginalVolume, 3)));
        end

        function segmentImage(app)
            % Perform segmentation using the pre-loaded model
            if isempty(app.Model)
                app.StatusLabel.Text = 'Error: Model not loaded';
                return;
            end

            app.StatusLabel.Text = 'Segmenting image...';
            drawnow;

            try
                [app.OriginalVolume, app.SegmentedVolume, app.NiftiInfo] = stroke_segmentation(...
                    app.NiftiInfo.Filename, ...
                    app.Model, ...
                    app.TTACheckBox.Value, ...
                    app.SlidingWindowCheckBox.Value);
                
                app.CurrentSlice = round(size(app.OriginalVolume, 3) / 2);
                app.updateViewer();
                app.StatusLabel.Text = 'Segmentation complete';
            catch ME
                app.StatusLabel.Text = ['Error: ', ME.message];
            end
        end

        function loadModel(app)
            % Load the ONNX model asynchronously
            app.StatusLabel.Text = 'Loading model...';
            drawnow;

            try
                app.Model = importONNXNetwork(app.ModelPath);
                app.StatusLabel.Text = 'Model loaded successfully';
                app.SegmentButton.Enable = 'on';
            catch ME
                app.StatusLabel.Text = ['Error loading model: ', ME.message];
                app.SegmentButton.Enable = 'off';
            end
        end

    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.ShowLesion = false;
            app.CurrentSlice = 1;
            app.ModelPath = './unet.onnx';  % Update this path
            app.SegmentButton.Enable = 'off';
            
            % Start asynchronous model loading
            future = parfeval(backgroundPool, @app.loadModel, 0);
        end

        % Menu item selected function: OpenMenuItem
        function OpenMenuItemSelected(app, event)
            [file, path] = uigetfile({'*.nii;*.nii.gz', 'NIfTI Files (*.nii, *.nii.gz)'});
            if isequal(file, 0)
                return;
            end
            app.NiftiInfo = niftiinfo(fullfile(path, file));
            app.OriginalVolume = niftiread(app.NiftiInfo);
            app.CurrentSlice = round(size(app.OriginalVolume, 3) / 2);
            app.updateViewer();
            app.StatusLabel.Text = 'Image loaded successfully';
        end

        % Button pushed function: SegmentButton
        function SegmentButtonPushed(app, event)
            app.segmentImage();
        end

        % Value changed function: LesionToggleButton
        function LesionToggleButtonValueChanged(app, event)
            app.ShowLesion = app.LesionToggleButton.Value;
            app.updateViewer();
        end

        % Key press function: UIFigure
        function UIFigureKeyPress(app, event)
            switch event.Key
                case 'leftarrow'
                    app.CurrentSlice = max(1, app.CurrentSlice - 1);
                case 'rightarrow'
                    app.CurrentSlice = min(size(app.OriginalVolume, 3), app.CurrentSlice + 1);
            end
            app.updateViewer();
        end

    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)
            % Create UIFigure
            app.UIFigure = uifigure();
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'Stroke Segmentation Viewer';
            app.UIFigure.KeyPressFcn = createCallbackFcn(app, @UIFigureKeyPress, true);

            % Create FileMenu
            app.FileMenu = uimenu(app.UIFigure);
            app.FileMenu.Text = 'File';

            % Create OpenMenuItem
            app.OpenMenuItem = uimenu(app.FileMenu);
            app.OpenMenuItem.Text = 'Open';
            app.OpenMenuItem.MenuSelectedFcn = createCallbackFcn(app, @OpenMenuItemSelected, true);

            % Create ExitMenuItem
            app.ExitMenuItem = uimenu(app.FileMenu);
            app.ExitMenuItem.Text = 'Exit';
            app.ExitMenuItem.MenuSelectedFcn = createCallbackFcn(app, @ExitMenuItemSelected, true);

            % Create SegmentButton
            app.SegmentButton = uibutton(app.UIFigure, 'push');
            app.SegmentButton.Position = [20 20 100 22];
            app.SegmentButton.Text = 'Segment';
            app.SegmentButton.ButtonPushedFcn = createCallbackFcn(app, @SegmentButtonPushed, true);

            % Create LesionToggleButton
            app.LesionToggleButton = uibutton(app.UIFigure, 'state');
            app.LesionToggleButton.Position = [130 20 100 22];
            app.LesionToggleButton.Text = 'Show Lesion';
            app.LesionToggleButton.ValueChangedFcn = createCallbackFcn(app, @LesionToggleButtonValueChanged, true);

            % Create TTACheckBox
            app.TTACheckBox = uicheckbox(app.UIFigure);
            app.TTACheckBox.Position = [240 20 100 22];
            app.TTACheckBox.Text = 'Use TTA';

            % Create SlidingWindowCheckBox
            app.SlidingWindowCheckBox = uicheckbox(app.UIFigure);
            app.SlidingWindowCheckBox.Position = [350 20 150 22];
            app.SlidingWindowCheckBox.Text = 'Use Sliding Window';

            % Create Viewer3D
            app.Viewer3D = uiaxes(app.UIFigure);
            app.Viewer3D.Position = [20 50 600 400];
            title(app.Viewer3D, 'Slice Viewer');
            xlabel(app.Viewer3D, 'X');
            ylabel(app.Viewer3D, 'Y');

            % Create StatusLabel
            app.StatusLabel = uilabel(app.UIFigure);
            app.StatusLabel.Position = [20 450 600 22];
            app.StatusLabel.Text = 'Ready';
        end
    end

    methods (Access = public)

        % Construct app
        function app = StrokeSegmentationApp
            createComponents(app)
            registerApp(app, app.UIFigure)
            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)
            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
