function [ df ] = imageToDF( image, params )
% Given an image, convert the image to the sift representation and then
% convert it to distribution field.

sift = imageToSift(image);
df = siftToDF(sift, params.nbins(1), params.nbins(2));
end

