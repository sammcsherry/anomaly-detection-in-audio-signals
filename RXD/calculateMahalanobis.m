function anomalyVector = calculateMahalanobis(coeffs)
    averageVector = mean(coeffs, 1);
    covarianceMatrix = cov(coeffs);
    % Subtract the mean vector from every observation
    delta = coeffs - averageVector;
    % Calculate the Mahalanobis squared distance for all observations
    anomalyVector = sqrt(sum((delta/covarianceMatrix) .* delta, 2)).';

end