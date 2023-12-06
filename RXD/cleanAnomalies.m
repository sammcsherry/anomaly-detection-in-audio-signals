%for anomalies thresholded with the KERNEL distribution in function
%get_threshold.
function cleanedAnomalies = cleanAnomalies(thresholdedData, q10, q90, N)
   
   dataLength = length(thresholdedData);
   averageVect = zeros(dataLength, 1);

   for i = N+1:dataLength - N
        data_pts = thresholdedData(i-N:i+N);
        average = mean(data_pts);
        averageVect(i) = average;
   end    
   %CHECK STATISTICAL VALIDITY OF RESCALE!!!!!
   rescaleTest = 1.5;
   x1 = lt(q10,averageVect*rescaleTest);
   x2 = lt(averageVect*rescaleTest,q90);
   
   averageVect(and(x1,x2)) = 0;
   
   cleanedAnomalies = averageVect;
end