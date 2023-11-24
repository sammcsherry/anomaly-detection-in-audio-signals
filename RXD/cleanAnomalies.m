function cleanedAnomalies = cleanAnomalies(thresholdedData, timeArray,s)
   
   data_length = length(thresholdedData);
   average_vect = zeros(data_length, 1);

   for i = 4:data_length - 3
        data_pts = thresholdedData(i-3:i+3);
        average = mean(data_pts);
        average_vect(i) = average;
   end    
   average_vect(average_vect<0.35*5*s) = 0;
   cleanedAnomalies = average_vect;

   figure,
   plot(timeArray, cleanedAnomalies), title('Cleaned Thresholded Anomaly Data')
   xlabel('Time (s)');
   ylabel('Anomaly Score');
    
end