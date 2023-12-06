function [thresholded_data,s, mu] = get_threshold(anomalyVector)

   colAnomalyVector = anomalyVector';
   pd = fitdist(colAnomalyVector, 'Normal');
   s = std(pd);   
   mu = mean(pd);
   %ci95 = paramci(pd);

   figure, hold on;
   plot(pd), title('wtf'), hold off;
   
   x1 = lt(mu,colAnomalyVector);
   x2 = lt(colAnomalyVector,(mu+1*s));
   x3 = gt(mu,colAnomalyVector);
   x4 = gt(colAnomalyVector,(mu-1*s));
   
   colAnomalyVector(and(x1,x2)) = 0;
   colAnomalyVector(and(x3,x4)) = 0;
   
   thresholded_data = colAnomalyVector;
end
