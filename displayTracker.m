function [ ] = displayTracker( image, pos, params )
% Display the image with a frame whose upper left corner is at pos.

image = drawRect(image, pos, params.wsize(1), params.wsize(2));
imagesc(image);
colormap('gray');
pause(0.1);
end

