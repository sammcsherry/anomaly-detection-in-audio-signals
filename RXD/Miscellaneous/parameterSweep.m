clear;
audioFile = "jar.mp3";
audioPath = "AudioFiles/" + audioFile;
domain = "Mel";

randomAnomalyTimes = [7.2, 108.8, 111.1, 117.1];
randomAnomalyWidths = [1.2, 1.1, 0.6, 1.1];

tappingAnomalyTimes = [44.2, 42.8];
tappingAnomalyWidths = [1.7, 2.6];

jarAnomalyTimes = [46.9, 47.4, 48];
jarAnomalyWidths = [0.5, 0.5, 0.5];

CORAnomalyTimes = [417.5];
CORAnomalyWidths = [2.2];

SSWAnomalyTimes = [84.3, 321.5, 442.3];
SSWAnomalyWidths = [1.8, 1.3, 1.7];

sinWithSquaresAnomalyTimes = [3, 5, 5.5, 7];
sinWithSquaresAnomalyWidths = [0.001, 0.001, 0.001, 0.01];


frameDurations = 10e-3:1e-3:100e-3;
[fitness, timeTaken] = sweepFrameDuration(audioPath, frameDurations, domain, jarAnomalyTimes, jarAnomalyWidths);

plotTitles = ["Fitness vs Frame Duration", "Time Taken vs Frame Duration"];
figTitle = domain + " with varying Frame Durations for " + audioFile;
xLabels = ["Frame Durations (s)", "Frame Durations (s)"];
yLabels = ["Fitness", "Execution Time"];
tiledPlot(frameDurations, plotTitles, figTitle, xLabels, yLabels, fitness, timeTaken);
