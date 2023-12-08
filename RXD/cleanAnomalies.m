function cleanedAnomalies = cleanAnomalies(thresholdedData, N)
%thresholdedData = input data is the RXD results;
%N = number of data points either side included in the average
   dataLength = length(thresholdedData);
   averageVect = zeros(dataLength, 1);

   for i = N+1:dataLength - N
        data_pts = thresholdedData(i-N:i+N);
        average = mean(data_pts);
        averageVect(i) = average;
   end    
   %current code consideres end cases to have an average of zero.
   %this could be rewritten to consider a one-sided average in this case.

   %figure, plot(averageVect), title('average vect');

   %dist and new threshold:
   pd = fitdist(averageVect, 'Normal' );
   mu = mean(pd);
   sd = std(pd);

   ineq = lt(averageVect, mu+2.5*sd); 
   averageVect(ineq) = 0;

  % figure, hold on;
  % plot(pd), xline(mu+2.5*sd), title('Normal dist with threshold'), hold off;
   
   cleanedAnomalies = averageVect;
end