%for anomalies thresholded with the normal distribution in function
%get_threshold.
function cleanedAnomalies = cleanAnomalies(thresholdedData ,s, mu, N)
   
   dataLength = length(thresholdedData);
   averageVect = zeros(dataLength, 1);

   for i = N+1:dataLength - N
        data_pts = thresholdedData(i-N:i+N);
        average = mean(data_pts);
        averageVect(i) = average;
   end    

   x1 = lt(mu,averageVect);
   x2 = lt(averageVect,(mu+1*s));
   x3 = gt(mu,averageVect);
   x4 = gt(averageVect,(mu-1*s));
   
   averageVect(and(x1,x2)) = 0;
   averageVect(and(x3,x4)) = 0;
   
   cleanedAnomalies = averageVect;
end