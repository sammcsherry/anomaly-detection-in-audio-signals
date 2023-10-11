

%V1 - x
%V2 - mu

function RXD = calculateRXD(featVector,R,n)
    A=aveVector(n)
    V = featVector - A;
    RXD = sqrt(V.' * (R^(-1)) * V)
end

