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
        AxialViewer            matlab.ui.control.UIAxes
        CoronalViewer          matlab.ui.control.UIAxes
        SagittalViewer         matlab.ui.control.UIAxes
        StatusLabel            matlab.ui.control.Label
        RotateButton           matlab.ui.control.StateButton
    end

    % Properties that correspond to app data
    properties (Access = private)
        OriginalVolume     % Original image volume
        SegmentedVolume    % Segmented image volume
        NiftiInfo          % NIfTI information structure
        CurrentSlice       % Current slice being displayed [axial, coronal, sagittal]
        ShowLesion         logical = false  % Boolean to toggle lesion visibility
        Model              % Pre-loaded model
        IsRotated          logical = false  % Track whether the view is rotated
        ModelPath          % Path to the model file
        InitialNiftiPath   % Path to initial NIfTI file to load
    end

    methods (Access = private)

        function updateViewer(app)
            if isempty(app.OriginalVolume)
                return;
            end

            % Update Axial View
            axial_slice = app.OriginalVolume(:,:,app.CurrentSlice(1));
            app.updateSliceView(app.AxialViewer, axial_slice, 1);

            % Update Coronal View
            coronal_slice = squeeze(app.OriginalVolume(:,app.CurrentSlice(2),:))';
            app.updateSliceView(app.CoronalViewer, coronal_slice, 2);

            % Update Sagittal View
            sagittal_slice = squeeze(app.OriginalVolume(app.CurrentSlice(3),:,:))';
            app.updateSliceView(app.SagittalViewer, sagittal_slice, 3);
        end

        function updateSliceView(app, viewer, slice, view_index)
            if app.ShowLesion && ~isempty(app.SegmentedVolume)
                switch view_index
                    case 1
                        lesion_slice = app.SegmentedVolume(:,:,app.CurrentSlice(1)) > 0;
                    case 2
                        lesion_slice = squeeze(app.SegmentedVolume(:,app.CurrentSlice(2),:))' > 0;
                    case 3
                        lesion_slice = squeeze(app.SegmentedVolume(app.CurrentSlice(3),:,:))' > 0;
                end
                rgb_slice = repmat(mat2gray(slice), [1 1 3]);
                rgb_slice(:,:,1) = rgb_slice(:,:,1) + 0.5 * lesion_slice;
                imshow(rgb_slice, 'Parent', viewer);
            else
                imshow(slice, [], 'Parent', viewer);
            end

            hold(viewer, 'on');
            switch view_index
                case 1
                    plot(viewer, [app.CurrentSlice(3), app.CurrentSlice(3)], [1, size(slice, 1)], 'g-');
                    plot(viewer, [1, size(slice, 2)], [app.CurrentSlice(2), app.CurrentSlice(2)], 'r-');
                case 2
                    plot(viewer, [app.CurrentSlice(1), app.CurrentSlice(1)], [1, size(slice, 1)], 'b-');
                    plot(viewer, [1, size(slice, 2)], [app.CurrentSlice(3), app.CurrentSlice(3)], 'g-');
                case 3
                    plot(viewer, [app.CurrentSlice(1), app.CurrentSlice(1)], [1, size(slice, 1)], 'b-');
                    plot(viewer, [1, size(slice, 2)], [app.CurrentSlice(2), app.CurrentSlice(2)], 'r-');
            end
            hold(viewer, 'off');

            view_names = {'Axial', 'Coronal', 'Sagittal'};
            title(viewer, sprintf('%s Slice %d', view_names{view_index}, app.CurrentSlice(view_index)));
        end

        function sliceClickCallback(app, ~, event, view_index)
            if ~isempty(app.OriginalVolume)
                switch view_index
                    case 1 % Axial
                        app.CurrentSlice(2) = round(event.IntersectionPoint(1));
                        app.CurrentSlice(3) = round(event.IntersectionPoint(2));
                    case 2 % Coronal
                        app.CurrentSlice(1) = round(event.IntersectionPoint(1));
                        app.CurrentSlice(3) = round(event.IntersectionPoint(2));
                    case 3 % Sagittal
                        app.CurrentSlice(1) = round(event.IntersectionPoint(1));
                        app.CurrentSlice(2) = round(event.IntersectionPoint(2));
                end
                app.updateViewer();
            end
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
                app.SegmentedVolume = stroke_segmentation(app.OriginalVolume, app.Model, app.TTACheckBox.Value);
                
                app.CurrentSlice = round(size(app.OriginalVolume) / 2);
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
                load("./unet.mat", "net");
                app.Model = net;
                app.StatusLabel.Text = 'Model loaded successfully';
                app.SegmentButton.Enable = 'on';
            catch ME
                app.StatusLabel.Text = ['Error loading model: ', ME.message];
                app.SegmentButton.Enable = 'off';
            end
        end

        function modelLoadComplete(app, ~)
            % This function is called when the asynchronous model loading is complete
            if ~isempty(app.Model)
                app.StatusLabel.Text = 'Model loaded successfully';
                app.SegmentButton.Enable = 'on';
            else
                app.StatusLabel.Text = 'Error: Model failed to load';
                app.SegmentButton.Enable = 'off';
            end
        end

        function UIFigureWindowScrollWheel(app, event)
            if ~isempty(app.OriginalVolume)
                % Determine scroll direction
                if event.VerticalScrollCount > 0
                    % Scroll down, move to next slice
                    app.CurrentSlice = min(size(app.OriginalVolume, 3), app.CurrentSlice + 1);
                else
                    % Scroll up, move to previous slice
                    app.CurrentSlice = max(1, app.CurrentSlice - 1);
                end
                app.updateViewer();
            end
        end

        function loadInitialNifti(app)
            if ~isempty(app.InitialNiftiPath)
                try
                    app.NiftiInfo = niftiinfo(app.InitialNiftiPath);
                    app.OriginalVolume = niftiread(app.NiftiInfo);
                    app.CurrentSlice = round(size(app.OriginalVolume) / 2);
                    app.SegmentedVolume = []; % Clear previous segmentation
                    app.updateViewer();
                    app.StatusLabel.Text = 'Initial image loaded successfully';
                catch ME
                    app.StatusLabel.Text = ['Error loading initial image: ', ME.message];
                end
            end
        end

    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.ShowLesion = false;
            app.CurrentSlice = [1, 1, 1];
            app.ModelPath = './unet.mat';  % Update this path
            app.SegmentButton.Enable = 'off';
            app.StatusLabel.Text = 'Loading model...';
            
            % Start asynchronous model loading
            future = parfeval(backgroundPool, @app.loadModel, 0);
            afterAll(future, @(x) app.modelLoadComplete(x));

            % Load initial NIfTI file if provided
            app.loadInitialNifti();
        end

        % Menu item selected function: OpenMenuItem
        function OpenMenuItemSelected(app, event)
            [file, path] = uigetfile({'*.nii;*.nii.gz', 'NIfTI Files (*.nii, *.nii.gz)'});
            if isequal(file, 0)
                return;
            end
            app.NiftiInfo = niftiinfo(fullfile(path, file));
            app.OriginalVolume = niftiread(app.NiftiInfo);
            app.CurrentSlice = round(size(app.OriginalVolume) / 2);
            app.SegmentedVolume = []; % Clear previous segmentation
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

        % Menu selected function: ExitMenuItem
        function ExitMenuItemSelected(app, event)
            delete(app);
        end

        % Value changed function: RotateButton
        function RotateButtonValueChanged(app, event)
            app.IsRotated = app.RotateButton.Value;
            app.updateViewer();
        end

    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)
            % Create UIFigure
            app.UIFigure = uifigure();
            app.UIFigure.Position = [100 100 800 600];
            app.UIFigure.Name = 'Stroke Segmentation Viewer';

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

            % Create AxialViewer
            app.AxialViewer = uiaxes(app.UIFigure);
            app.AxialViewer.Position = [20 320 380 250];
            title(app.AxialViewer, 'Axial View');
            app.AxialViewer.ButtonDownFcn = @(~,event) app.sliceClickCallback(event, 1);

            % Create CoronalViewer
            app.CoronalViewer = uiaxes(app.UIFigure);
            app.CoronalViewer.Position = [410 320 380 250];
            title(app.CoronalViewer, 'Coronal View');
            app.CoronalViewer.ButtonDownFcn = @(~,event) app.sliceClickCallback(event, 2);

            % Create SagittalViewer
            app.SagittalViewer = uiaxes(app.UIFigure);
            app.SagittalViewer.Position = [20 50 380 250];
            title(app.SagittalViewer, 'Sagittal View');
            app.SagittalViewer.ButtonDownFcn = @(~,event) app.sliceClickCallback(event, 3);

            % Create StatusLabel
            app.StatusLabel = uilabel(app.UIFigure);
            app.StatusLabel.Position = [20 570 760 22];
            app.StatusLabel.Text = 'Ready';

            % Create RotateButton
            app.RotateButton = uibutton(app.UIFigure, 'state');
            app.RotateButton.Text = 'Rotate View';
            app.RotateButton.Position = [510 20 100 22];
            app.RotateButton.ValueChangedFcn = createCallbackFcn(app, @RotateButtonValueChanged, true);
        end
    end

    methods (Access = public)

        % Construct app
        function app = StrokeSegmentationApp(varargin)
            createComponents(app)
            registerApp(app, app.UIFigure)

            if nargin > 0
                app.InitialNiftiPath = varargin{1};
            end

            runStartupFcn(app, @startupFcn)

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
