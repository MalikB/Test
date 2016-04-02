function contTimes = makeContTimes(vec, k, T)
% makes multiple time windows be concatanated (times change, data remains
% the same)
contTimes = [];
for i = 0:k-1
    contTimes = [contTimes, vec + i*T];
end
%   look into a clever matrix multiplication vectorized approach in future
%     timesMat = repmat(vec, k, 1);
%     multMat = (ones(k).*T) * diag(0:k-1);
%     pointsMat = (timesMat+multMat')';
%     vecNew = pointsMat(:)'
end