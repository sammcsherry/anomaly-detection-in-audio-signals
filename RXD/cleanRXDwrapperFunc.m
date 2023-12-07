function finalAnomalies = cleanRXDwrapperFunc(anomalyVector)
    [thresholdedData, q10, q90] = getThreshold(anomalyVector);
    cleanedAnomalies = cleanAnomalies(thresholdedData, q10, q90, N);
    cleanedX2 = cleanAnomaliesX2(cleanedAnomalies);
    finalAnomalies = cleanedX2;
end