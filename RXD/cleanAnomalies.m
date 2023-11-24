function cleanedAnomalies = cleanAnomalies(thresholded_data, timeArray)
   
   
    
    
   figure,
   plot(time_array, cleanedAnomalies), title('Cleaned Thresholded Anomaly Data')
   xlabel('Time (s)');
   ylabel('Anomaly Score');
    
end