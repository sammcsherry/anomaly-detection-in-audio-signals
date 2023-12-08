function thresholdedData = getThreshold(anomalyVector, setThreshold)
%applies kernel dist to data
%set threshold as a percentage[0,1] 
    thresholdedData = anomalyVector';
  %  pd = fitdist(thresholdedData, 'Kernel', 'Kernel','epanechnikov');
   
    percentile = quantile(thresholdedData, setThreshold);

    ineq = lt(thresholdedData, percentile); 
    thresholdedData(ineq) = 0;
end

