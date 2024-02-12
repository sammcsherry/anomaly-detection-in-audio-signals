function [reducedData] = performPCA(data, varianceThreshold)
    %explained variance refers to the amount of variance captured by the principle components
    [~, score, ~, ~, explainedVariance] = pca(data);

    % determine number of components to retain based on the variance threshold
    cumulativeVariance = cumsum(explainedVariance);
    % returns first index where threshold is met
    numComponents = find(cumulativeVariance >= varianceThreshold, 1, 'first');
    % truncate data based on number of principle components calculated
    reducedData = score(:, 1:numComponents);
end