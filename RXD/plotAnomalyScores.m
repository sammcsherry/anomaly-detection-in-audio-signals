function plotAnomalyScores(time_array, anomaly_vector, plotTitle)
    % plot the anomaly vector
    
    plot(time_array, anomaly_vector);
    xlabel('Time (s)');
    ylabel('Anomaly Score');
    title(plotTitle);
end
