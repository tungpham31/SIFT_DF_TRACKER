function [ df ] = siftToDF( sift, nBin1, nBin2 )
% Turn the given sift representation of an image into a distribution field.
% Input: a sift representation, number of bins for the x-coordinate, number
% of bins for the y-coordinate.
% Output: a distribution field with 4 dimensions.

df = zeros(size(sift, 1), size(sift, 2), nBin1, nBin2);
for i = 1 : size(sift, 1)
    for j = 1 : size(sift, 2)
        bin1 = calBin(nBin1, sift(i, j, 1));
        bin2 = calBin(nBin2, sift(i, j, 2));
        df(i, j, bin1, bin2) = 1;
    end
end
end

function [theBin] = calBin(nBin, val)
    VAL_RANGE = 511; % range of the sift value.
    binRange = round(VAL_RANGE / nBin);
    theBin = fix((val + 255) / binRange) + 1;
end

