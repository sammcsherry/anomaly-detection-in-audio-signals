% Needs clarification. Bring up at next meeting as I am slightly confused -
% Cyrus
function zeroPadding (audioData, frameOverlapLength, frameLength, sampleRate, varargin)
VecA =  tempFFT;
VecB = tempMel;
VecC = tempMFCC;

%differenceidx = ~ismember(VecB,VecA)
if (length(VecA) < length(VecB))&&(length(VecB)< length(VecC))
    C = length(VecC) - length(VecA);
PaddingVecA = [zeros(1,C) VecA];

    D = length(VecC) - length(VecB);
PaddingVecB = [zeros(1,D) VecB];

elseif (length(VecA) < length(VecC))&&(length(VecC) < length(VecB))
    C = length(VecB) - length(VecA);
PaddingVecA = [zeros(1,C) VecA]  ;

    D = length(VecC) - length(VecB);
PaddingVecB = [zeros(1,D) VecB];

elseif (length(VecC) < length(VecA))&&(length(VecA) < length(VecB))
    C = length(VecB) - length(VecC);
PaddingVecC = [zeros(1,C) VecC]  ;

    D = length(VecB) - length(VecA);
PaddingVecA = [zeros(1,D) VecA];

elseif (length(VecC) < length(VecB))&&(length(VecB) < length(VecA))
    C = length(VecA) - length(VecC);
PaddingVecC = [zeros(1,C) VecC]  ;

    D = length(VecA) - length(VecB);
PaddingVecB = [zeros(1,D) VecB];

elseif (length(VecB) < length(VecA))&&(length(VecA) < length(VecC))
    C = length(VecC) - length(VecB);
PaddingVecB = [zeros(1,C) VecB]  ;

    D = length(VecC) - length(VecA);
PaddingVecA = [zeros(1,D) VecA];

elseif (length(VecB) < length(VecC))&&(length(VecC) < length(VecA))
    C = length(VecA) - length(VecB);
PaddingVecB = [zeros(1,C) VecB]  ;

    D = length(VecA) - length(VecC);
PaddingVecC = [zeros(1,D) VecC];

elseif (length(VecB) < length(VecC))&&(length(VecC) == length(VecA))
    C = length(VecC) - length(VecB);
PaddingVecB = [zeros(1,C) VecB];

elseif (length(VecB) > length(VecC))&&(length(VecC) == length(VecA))
    C = length(VecB) - length(VecC);
PaddingVecC = [zeros(1,C) VecC]  ;
PaddingVecA = [zeros(1,C) VecA];

elseif (length(VecA) < length(VecC))&&(length(VecC) == length(VecB))
    C = length(VecC) - length(VecA);
PaddingVecA = [zeros(1,C) VecA]  ;

elseif (length(VecA) > length(VecC))&&(length(VecC) == length(VecB))
    C = length(VecA) - length(VecC);
PaddingVecC = [zeros(1,C) VecC]  ;
PaddingVecB = [zeros(1,C) VecB];

elseif (length(VecC) < length(VecA))&&(length(VecA) == length(VecB))
    C = length(VecA) - length(VecC);
PaddingVecC = [zeros(1,C) VecC] ;

elseif (length(VecC) > length(VecA))&&(length(VecA) == length(VecB))
    C = length(VecC) - length(VecA);
PaddingVecA = [zeros(1,C) VecA]  ;
PaddingVecB = [zeros(1,C) VecB];
end

end