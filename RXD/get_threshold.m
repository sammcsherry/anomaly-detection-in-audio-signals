function [thresholded_data,s] = get_threshold(anomaly_vector)

   col_anomaly_vector = anomaly_vector';
   pd = fitdist(col_anomaly_vector, 'Normal');
   s = std(pd);   
   col_anomaly_vector(col_anomaly_vector<4*s) = 0;
   thresholded_data = col_anomaly_vector;
end
