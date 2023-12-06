function tiledPlot(timeArray, plotTitles, figTitles, varargin)
    n = length(varargin)
    figure('Name','Anomalies vs Time');
    tiledlayout(1,n);
    hold on;

    for i = 1:n
        nexttile
        plotAnomalyScores(timeArray, cell2mat(varargin(i)), titles(i))
    end
end

    