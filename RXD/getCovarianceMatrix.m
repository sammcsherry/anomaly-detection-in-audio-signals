function [covarianceMatrix] = getCovarianceMatrix(data, averageVector, numberOfVectors)
    covarianceMatrix = 1/(numberOfVectors-1)*(data-averageVector).'*(data-averageVector);
end