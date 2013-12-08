function [ newImage ] = drawRect( image, upperLeftCorner, width, length )
% Draw a rectangle in the original image.
% Input: image - the original image; upperLeftCorner - a row vector
% represent the pos of the upper left corner of the rectangle; width - the
% width of the rectangle; length - the length of the rectangle.

% Compute the upper right corner.
upperRightCorner(1) = upperLeftCorner(1);
upperRightCorner(2) = min(size(image, 2), upperLeftCorner(2) + length);

% Compute the lower left corner.
lowerLeftCorner(1) = min(size(image, 1), upperLeftCorner(1) + width);
lowerLeftCorner(2) = upperLeftCorner(2);

% Compute the lower right corner.
lowerRightCorner(1) = lowerLeftCorner(1);
lowerRightCorner(2) = upperRightCorner(2);

% Draw upper line.
newImage = drawLine(image, upperLeftCorner, upperRightCorner);
% Draw right line.
newImage = drawLine(newImage, upperRightCorner, lowerRightCorner);
% Draw lower line.
newImage = drawLine(newImage, lowerLeftCorner, lowerRightCorner);
% Draw left line.
newImage = drawLine(newImage, lowerLeftCorner, upperLeftCorner);
end

function [ newImage ] = drawLine( image, point1, point2 )
% Draw a line between the two points.

newImage = image;
if (point1(1) == point2(1))
    newImage(point1(1), min(point1(2), point2(2)) : max(point1(2), point2(2))) = 1;
end

if (point1(2) == point2(2))
    newImage(min(point1(1), point2(1)) : max(point1(1), point2(1)), point1(2)) = 1;
end
end

