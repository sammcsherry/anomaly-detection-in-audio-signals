function RXD = calculateMahalanobis(vector, inverseCovarianceMatrix, averageVector)
    RXD = sqrt(abs((vector - averageVector)*(inverseCovarianceMatrix)*(vector - averageVector).' ));
end