function thresholdedData = getThreshold(anomalyVector, setThreshold)
%applies kernel dist to data
%set threshold as a percentage[0,1] 
    thresholdedData = anomalyVector';
    pd = fitdist(thresholdedData, 'Kernel', 'Kernel','epanechnikov');
   
    percentile = quantile(thresholdedData, setThreshold);

    x2 = lt(thresholdedData, percentile); 
    thresholdedData(x2) = 0;

    %uncomment to plot data and dist:
    
    %figure, hold on;
    %plot(pd), xline(percentile), title('data and applied dist'), hold off;
    
end

