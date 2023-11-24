function thresholded_data = get_threshold(anomaly_vector, timeArray)

   col_anomaly_vector = anomaly_vector';
   pd = fitdist(col_anomaly_vector, 'Normal');
   s = std(pd);   
   col_anomaly_vector(col_anomaly_vector<5*s) = 0;
   thresholded_data = col_anomaly_vector;
   
   figure,
   plot(timeArray, thresholded_data), title('Thresholded Anomaly Data')
   xlabel('Time (s)');
   ylabel('Anomaly Score');
   
end
