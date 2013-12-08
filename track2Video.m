function [ video ] = track2Video( params, tracks )
% Input: the parameters, and the track of the object along the images.
% Output: a video tracking the object based on the track.

video = avifile(sprintf('%s.avi', params.output_name));

% Create the video.
tracks
for i = 1 : size(tracks, 1)
    image = double(imread(sprintf('%s%05d.%s', params.file_path, i + params.start_frame, params.file_format)));
    image = drawRect(image, tracks(i, :), params.wsize(1), params.wsize(2));
    video = addframe(video, image);
end

video = close(video);
end

