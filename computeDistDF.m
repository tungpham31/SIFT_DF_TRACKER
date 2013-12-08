function [ dist ] = computeDistDF( df1, df2 )
% Compute the distance between two distribution fields.

differenceDF = df1(:) - df2(:); 
dist = sum(sum(sum(sum(abs(differenceDF)))))./(100 * size(df1, 1) * size(df1, 2));
end

