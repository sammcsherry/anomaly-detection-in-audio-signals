function tiledPlot(timeArray, plotTitles, figTitle, varargin)
    n = length(varargin);
    ft = figTitle;    
    figure('Name', ft);
    tiledlayout(1,n);
    hold on;

    for i = 1:n
        nexttile
        plotAnomalyScores(timeArray, cell2mat(varargin(i)), plotTitles(i))
    end
end

    