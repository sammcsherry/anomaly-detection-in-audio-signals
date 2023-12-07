%clean round 2
function cleanedX2 = cleanAnomaliesX2(cleanAnomalies)
    MaxVal = max(cleanAnomalies);
    MinVal = min(cleanAnomalies);
    thresh = 0.5*(MaxVal-MinVal);
    cleanAnomalies(cleanAnomalies<thresh) = 0;
    cleanedX2 = cleanAnomalies;

end
