%kernelDist

function [thresholdedData2, q10, q90] = getThreshold2(anomalyVector)
    colAnomalyVector = anomalyVector';
    pd = fitdist(colAnomalyVector, 'Kernel', 'Kernel','epanechnikov');
   
    q10 = quantile(colAnomalyVector, .1);
    q90 = quantile(colAnomalyVector, .9);
    

    %colAnomalyVector(q10<colAnomalyVector<q90) = 0;

    x1 = lt(q10, colAnomalyVector);
    x2 = lt(colAnomalyVector, q90); 

    colAnomalyVector(and(x1,x2)) = 0;

    thresholdedData2 = colAnomalyVector;
    
    figure, hold on;
    plot(pd), xline(q10), xline(q90), title('helpp'), hold off;
    
end

