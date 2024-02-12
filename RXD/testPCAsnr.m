function testPCAsnr(data)
    
    varianceThreshold = (50:100).';
    npts = length(varianceThreshold);
    SNR = zeros(size(varianceThreshold));

    for  i = 1:npts %change this range first 
        [reducedData] = performPCA(data, varianceThreshold(i));
        SNR(i) = snr(reducedData);
    end
    figure, plot(varianceThreshold, SNR, '-o');
end
        
