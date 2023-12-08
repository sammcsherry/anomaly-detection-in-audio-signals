%for anomalies thresholded with the KERNEL distribution in function
function cleanedAnomalies = cleanAnomalies(thresholdedData, N)
   dataLength = length(thresholdedData);
   averageVect = zeros(dataLength, 1);

   for i = N+1:dataLength - N
        data_pts = thresholdedData(i-N:i+N);
        average = mean(data_pts);
        averageVect(i) = average;
   end    
   %current code consideres end cases to have an average of zero.
   %this could be rewritten to consider a one-sided average in this case.

   %figure, plot(averageVect), title('average vect');

   %new dist and new threshold
   col2row = averageVect';
   cleanedAnomalies = getThreshold(col2row, 0.90);
   
end