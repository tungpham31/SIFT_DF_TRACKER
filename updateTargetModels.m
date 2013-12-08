function [ newTargetModels ] = updateTargetModels( target_models, image, startPos, params )
% Update the target models with the new image.

patch = image(startPos(1) : startPos(1) + params.wsize(1) - 1, startPos(2) : startPos(2) + params.wsize(2) - 1);
sift = imageToSift(patch);
df = siftToDF(sift, params.nbins(1), params.nbins(2));

for i = 1 : length(params.space_width)
    df = smoothDF(df, [params.space_width(i) params.feature_width], [params.space_sig(i), params.feature_sig]);
    newTargetModels{i} = 0.95.*target_models{i} + 0.05.*df;
end;
end

