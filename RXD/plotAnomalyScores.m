function plotAnomalyScores(time_array, anomaly_vector)
    % plot the anomaly vector
    figure;
    plot(time_array, anomaly_vector);
    xlabel('Time (s)');
    ylabel('Anomaly Score');
    title('Anomaly Vector Over Time');
end
