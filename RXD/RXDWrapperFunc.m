function [anomalyVector] = RXDWrapperFunc(coeffs)
    averageVector = mean(coeffs, 1);
    covariance_matrix = cov(coeffs);
    inverseCovarianceMatrix = inv(covariance_matrix); %needs optimising
    anomalyVector = calculateAllMahalanobis(coeffs, averageVector, inverseCovarianceMatrix);
end