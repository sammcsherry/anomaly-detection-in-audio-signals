function [anomalyVector] = RXDWrapperFunc(coeffs)
    averageVector = mean(coeffs, 1);
    covariance_matrix = cov(coeffs);
    %inverseCovarianceMatrix = inv(covariance_matrix); %commented out as
    %not needed s
    %anomalyVector = calculateAllMahalanobis(coeffs, averageVector, inverseCovarianceMatrix);
    anomalyVector = calculateAllMahalanobis(coeffs, averageVector, covariance_matrix);
end