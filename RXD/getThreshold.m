%kernelDist

function [thresholdedData, q90] = getThreshold(anomalyVector)
    colAnomalyVector = anomalyVector';
    pd = fitdist(colAnomalyVector, 'Kernel', 'Kernel','epanechnikov');
   
    q90 = quantile(colAnomalyVector, .9);
    
    %colAnomalyVector(q10<colAnomalyVector<q90) = 0;

    x2 = lt(colAnomalyVector, q90); 

    colAnomalyVector(x2) = 0;

    thresholdedData = colAnomalyVector;
    
    figure, hold on;
    plot(pd), xline(q90), title('data and applied dist'), hold off;
    
end

