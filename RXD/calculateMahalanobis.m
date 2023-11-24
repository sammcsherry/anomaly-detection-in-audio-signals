function RXD = calculateMahalanobis(vector, covariance_matrix, averageVector)
    RXD = sqrt(abs(((vector - averageVector)/covariance_matrix)*(vector - averageVector).' ));
end