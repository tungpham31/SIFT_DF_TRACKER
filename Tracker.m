% ***********************************************************************
% Copyright by Laura Sevilla-Lara & Erik L.Miller's work.
% I use this format from Laura&Eriks's work because it's pretty. I add new
% parameters and values though.
% ***********************************************************************

% Input parameters 
params.file_path = './data/david/img';
params.file_format = 'png';
params.output_name = 'david';
params.start_frame = 220;
params.end_frame = 462; 
params.init_pos = [70, 135];
params.wsize = [50, 45];

params.nbins = [16 16]; 
params.feature_width = 5; 
params.feature_sig = 0.625; 
params.space_width = [9, 15];
params.space_sig = [1, 2];
params.max_shift = 30;

% Records the track of the object along the images.
tracks = trackObject(params);

% Create video from the tracking.
video = track2Video(params, tracks);

% Play back the video.
implay(video);