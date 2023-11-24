function anomalyVector = calculateAllMahalanobis(coeffs, averageVector, inverseCovarianceMatrix)
    % Calculate the anomaly vector for each frame
    % Attempt at vectorization. lamda function with a range of input index
    % Please change if you have a better way of vectorizing
   anomalyVector = arrayfun(@(index) calculateMahalanobis(coeffs(index, :), inverseCovarianceMatrix, averageVector), 1:size(coeffs, 1));
end
