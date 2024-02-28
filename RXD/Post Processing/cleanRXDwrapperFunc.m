function finalAnomalies = cleanRXDWrapperFunc(anomalyVector, setThreshold, neighbours)
    thresholdedData = getThreshold(anomalyVector, setThreshold);
    cleanedAnomalies = cleanAnomalies(thresholdedData, neighbours);
    finalAnomalies = cleanedAnomalies;
end