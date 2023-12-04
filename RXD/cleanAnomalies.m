function cleanedAnomalies = cleanAnomalies(thresholdedData, timeArray,s, N)
   
   dataLength = length(thresholdedData);
   averageVect = zeros(dataLength, 1);

   for i = N+1:dataLength - N
        data_pts = thresholdedData(i-N:i+N);
        average = mean(data_pts);
        averageVect(i) = average;
   end    
   averageVect(averageVect<0.5*4*s) = 0;
   cleanedAnomalies = averageVect;
end