function [ sift ] = imageToSift( image )
% Convert an image to its sift representation.
% The first element of sift is the x-magnitude, the second element is
% y-magnitude.

dx = [0 1 0 -1];
dy = [1 0 -1 0];

for i = 1 : size(image, 1)
    for j = 1 : size(image, 2)
        totalX = 0;
        totalY = 0;
        for t = 1 : 4 
            x = i + dx(t);
            y = j + dy(t);
            if inboard(x, y, size(image))
                totalX = totalX + (image(x, y) - image(i, j)) * dx(t);
                totalY = totalY + (image(x, y) - image(i, j)) * dy(t);
            end
        end
        sift(i, j, 1) = totalX;
        sift(i, j, 2) = totalY;
    end
end
end

function [ res ] = inboard( x, y, imageSize )
    if (1 <= x && x <= imageSize(1) && 1 <= y && y <= imageSize(2))
        res = 1;
    else res = 0;
    end
end

