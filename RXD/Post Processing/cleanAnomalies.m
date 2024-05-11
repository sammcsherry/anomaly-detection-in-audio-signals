function cleanedAnomalies = cleanAnomalies(thresholdedData, neighbours)
%thresholdedData = input data is the RXD results;
%neighbours = number of data points either side included in the average
   dataLength = length(thresholdedData);
   averageVect = zeros(dataLength, 1);

   for i = neighbours+1:dataLength - neighbours
        dataPts = thresholdedData(i-neighbours:i+neighbours);
        average = mean(dataPts);
        averageVect(i) = average;
   end    
   %current code consideres end cases to have an average of zero.
   %this could be rewritten to consider a one-sided average in this case.

   %figure, plot(averageVect), title('average vect');

   %dist and new threshold:
   pd = fitdist(averageVect, 'Normal' );
   mu = mean(pd);
   sd = std(pd);
% Maybe use < instead of lt in line 22? - Cyrus
   ineq = lt(averageVect, mu+2.5*sd); 
   averageVect(ineq) = 0;

  % figure, hold on;
  % plot(pd), xline(mu+2.5*sd), title('Normal dist with threshold'), hold off;
   
   cleanedAnomalies = averageVect;
end