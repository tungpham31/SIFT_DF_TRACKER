function [ bestPos ] = findTargetInNewImage( targetDF, image, startPos, params )
% Find the target patch in the new image and return its upper left corner
% position.

% Define the displacement.
dx = [0; 0; -1; 1];
dy = [-1; 1; 0; 0];

% Initialize variables.
currentPos = startPos;
startPatch = image(startPos(1) : startPos(1) + params.wsize(1) - 1, startPos(2) : startPos(2) + params.wsize(2) - 1);
minDist = computeDistDF(targetDF, imageToDF(startPatch, params));
dist = -1 * ones(size(image, 1), size(image, 2));
dist(startPos(1), startPos(2)) = minDist;

while true 
    minDir = -1;
    for i = 1 : 4 
        x = currentPos(1) + dx(i);
        y = currentPos(2) + dy(i);
        
        if inboard(x, y, size(image))
            if (dist(x, y) == -1)
                patch = image(x : x + params.wsize(1) - 1, y : y + params.wsize(2) - 1);
                dist(x, y) = computeDistDF(targetDF, imageToDF(patch, params));
            end
            
            % If the current distance is better than mindist, record it.
            if (dist(x, y) < minDist)
                minDist = dist(x, y);
                minDir = i;
            end
        end
    end
    
    if (minDir == -1) break;
    end
    currentPos(1) = currentPos(1) + dx(minDir);
    currentPos(2) = currentPos(2) + dy(minDir);
end

bestPos = currentPos;
end

function [res] = inboard(x, y, dims)
    if (1 <= x && x <= dims(1) && 1 <= y && y <= dims(2))
        res = true;
    else
        res = false;
    end
end

