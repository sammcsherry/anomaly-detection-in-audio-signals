function plotAnomalyScores(timeArray, anomalyVector, plotTitle)
    % plot the anomaly vector
    anomalyVector
    plot(timeArray, anomalyVector);
    xlabel('Time (s)');
    ylabel('Anomaly Score');
    title(plotTitle);
end
