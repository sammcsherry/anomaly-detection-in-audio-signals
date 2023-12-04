%second method of cleaning anomalies:
function cleanedAnomaliesV2 = cleanAnomaliesV2(thresholdedData)
    cleanedAnomaliesV2 = smoothdata(thresholdedData);
end