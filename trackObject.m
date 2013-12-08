function [ tracks ] = trackObject( params )
% Input: the parameter of the video and for the distribution fields.
% Output: the tracks of the object in the images, each track is a position
% of the upper left corner of the tracking rectangle.

% Read in the target.
target = double(imread(sprintf('%s%05d.%s', params.file_path, 1, params.file_format)));
target = target(params.init_pos(1) : params.init_pos(1) + params.wsize(1) - 1, params.init_pos(2) : params.init_pos(2) + params.wsize(2) - 1);
% Compute the sift representation of the image.
sift = imageToSift(target);
% Compute the distribution field of the sift representation.
df = siftToDF(sift, params.nbins(1), params.nbins(2));
% Smooth the distribution field of the target with different levels of
% blur.
for i=1:length(params.space_width)
    target_models{i} = smoothDF(df, [params.space_width(i) params.feature_width], [params.space_sig(i), params.feature_sig]);
end;

% Initialize before tracking.
nFrames = params.end_frame - params.start_frame + 1;
tracks(1, 1) = params.init_pos(1);
tracks(1, 2) = params.init_pos(2);
lastPos = params.init_pos;

% Tracking the object through the sequence of images.
for i = 2 : nFrames
    % read the next image
    image = double(imread(sprintf('%s%05d.%s', params.file_path, i + params.start_frame - 1, params.file_format)));
    
    % find the target in the new image.
    newPos = findTargetInNewImage(target_models{1}, image, lastPos, params);
    
    % display the frame with the tracker.
    displayTracker(image, newPos, params);
    
    % Update variables.
    target_models = updateTargetModels(target_models, image, newPos, params);
    lastPos = newPos;
    tracks(i, 1) = newPos(1);
    tracks(i, 2) = newPos(2);
end
end

