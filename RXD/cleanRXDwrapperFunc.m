function finalAnomalies = cleanRXDwrapperFunc(anomalyVector, N)
    [thresholdedData, q90] = getThreshold(anomalyVector);
    cleanedAnomalies = cleanAnomalies(thresholdedData, q90, N);
    finalAnomalies = cleanedAnomalies;
end