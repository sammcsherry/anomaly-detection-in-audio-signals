function thresholded_data = get_threshold(anomaly_vector, time_array)

   col_anomaly_vector = anomaly_vector';
   pd = fitdist(col_anomaly_vector, 'Normal');
   s = std(pd)
   
   col_anomaly_vector(col_anomaly_vector<5*s) = 1;
   thresholded_data = col_anomaly_vector;
   
   figure,
   plot(time_array, thresholded_data), title('Thresholded Anomaly Data')
   
   
end
