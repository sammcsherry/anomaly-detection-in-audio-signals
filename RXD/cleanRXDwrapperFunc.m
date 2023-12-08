function finalAnomalies = cleanRXDwrapperFunc(anomalyVector, setThreshold, N)
    thresholdedData = getThreshold(anomalyVector, setThreshold);
    cleanedAnomalies = cleanAnomalies(thresholdedData, N);
    finalAnomalies = cleanedAnomalies;
end