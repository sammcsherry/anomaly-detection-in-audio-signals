function anomalyVector = calculateMahalanobis(coeffs)
    averageVector = mean(coeffs, 1);
    epsilon = 1e-6;  % Small constant
    covarianceMatrix = cov(coeffs) + epsilon * eye(size(coeffs, 2));
    delta = coeffs - averageVector;
    anomalyVector = sqrt(sum((delta*pinv(covarianceMatrix)) .* delta, 2)).';

end