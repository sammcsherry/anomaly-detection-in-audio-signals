function plotAnomalyScores(timeArray, anomalyVector, plotTitle, xLabel, yLabel)
    % plot the anomaly vector
    plot(timeArray, anomalyVector);
    xlabel(xLabel);
    ylabel(yLabel);
    title(plotTitle);
end
