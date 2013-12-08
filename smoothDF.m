function [ smoothedDF ] = smoothDF( df, kernelWidth, sigmaKernel )
% NOT TESTED YET!!!!!!!!!
% Input: a distribution field.
% Output: the smoothed version of the df using gaussian convolution.

smoothedDF = df;
% Convolve in space.
kernel = fspecial('gaussian', kernelWidth(1), sigmaKernel(1));
for i = 1 : size(df, 3)
    for j = 1 : size(df, 4)
        smoothedDF(:, :, i, j) = conv2(df(:, :, i, j), kernel, 'same');
    end
end

%smoothedDF

% Convolve in the feature space.
kernel = fspecial('gaussian', kernelWidth(2), sigmaKernel(2));
for i = 1 : size(df, 1)
    for j = 1 : size(df, 2)
        smoothedDF(i, j, :, :) = conv2(reshape(smoothedDF(i, j, :, :), size(df, 3), size(df, 4)), kernel, 'same');
    end
end


% Normalize the df.
for i = 1 : size(smoothedDF, 1)
    for j = 1 : size(smoothedDF, 2)
        sumVal = sum(sum(smoothedDF(i, j, :, :)));
        if (sumVal > 0)
            for x = 1 : size(smoothedDF, 3)
                for y = 1 : size(smoothedDF, 4)
                    smoothedDF(i, j, x, y) = smoothedDF(i, j, x, y) / sumVal;
                end
            end
        end
    end
end

end

