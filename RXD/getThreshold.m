function thresholdedData = getThreshold(anomalyVector, setThreshold)
%set threshold as a percentage[0,1]
    thresholdedData = anomalyVector;
    percentile = quantile(thresholdedData, setThreshold);
    ineq = lt(thresholdedData, percentile); 
    thresholdedData(ineq) = 0;
end

