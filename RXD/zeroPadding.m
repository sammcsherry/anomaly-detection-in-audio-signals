%Vector A, B, C ~ are just examples vectors suposed to be for the tempFFT,
%tempMel, tempMFCC. THe names will probably need to be changed in this
%code.
% we think we've solved this problem - Cyrus ( •_•)>⌐■-■. We were wrong
% (T_T)
function [PaddingVecA, PaddingVecB, PaddingVecC]= zeroPadding(VecA, VecB,VecC)

    Vectors = {VecA, VecB, VecC};
    index = 1;
    for Vector = 1:numel(Vectors)
        if iscolumn(Vectors{index});
            newVectors{index} = Vectors{index}';
        
        elseif isrow(Vector)
            newVectors{index} = Vectors{index};
        end
        index = index+1;
    end

    VecA = newVectors{1};
    VecB = newVectors{2};
    VecC = newVectors{3};

    if (length(VecA) < length(VecB))&&(length(VecB)< length(VecC))
        C = length(VecC) - length(VecA);
    PaddingVecA = [zeros(1,C) VecA];
    
        D = length(VecC) - length(VecB);
    PaddingVecB = [zeros(1,D) VecB];
    PaddingVecC = VecC;
    
    elseif (length(VecA) < length(VecC))&&(length(VecC) < length(VecB))
        C = length(VecB) - length(VecA);
    PaddingVecA = [zeros(1,C) VecA];
    
        D = length(VecB) - length(VecC);
    PaddingVecC = [zeros(1,D) VecC];
    PaddingVecB = VecB;

    elseif (length(VecC) < length(VecA))&&(length(VecA) < length(VecB))
        C = length(VecB) - length(VecC);
    PaddingVecC = [zeros(1,C) VecC];
    
        D = length(VecB) - length(VecA);
    PaddingVecA = [zeros(1,D) VecA];
    PaddingVecB = VecB;
    
    elseif (length(VecC) < length(VecB))&&(length(VecB) < length(VecA))
        C = length(VecA) - length(VecC);
    PaddingVecC = [zeros(1,C) VecC];
    
        D = length(VecA) - length(VecB);
    PaddingVecB = [zeros(1,D) VecB];
    PaddingVecA = VecA;

    elseif (length(VecB) < length(VecA))&&(length(VecA) < length(VecC))
        C = length(VecC) - length(VecB);
    PaddingVecB = [zeros(1,C) VecB];
    
        D = length(VecC) - length(VecA);
    PaddingVecA = [zeros(1,D) VecA];
    PaddingVecC = VecC;
    
    elseif (length(VecB) < length(VecC))&&(length(VecC) < length(VecA))
        C = length(VecA) - length(VecB);
    PaddingVecB = [zeros(1,C) VecB];
    
        D = length(VecA) - length(VecC);
    PaddingVecC = [zeros(1,D) VecC];
    PaddingVecA = VecA;
    
    elseif (length(VecB) < length(VecC))&&(length(VecC) == length(VecA))
        C = length(VecC) - length(VecB);
    PaddingVecB = [zeros(1,C) VecB];
    PaddingVecA = VecA;
    PaddingVecC = VecC;
    
    elseif (length(VecB) > length(VecC))&&(length(VecC) == length(VecA))
        C = length(VecB) - length(VecC);
    PaddingVecC = [zeros(1,C) VecC];
    PaddingVecA = [zeros(1,C) VecA];
    PaddingVecB = VecB;

    elseif (length(VecA) < length(VecC))&&(length(VecC) == length(VecB))
        C = length(VecC) - length(VecA);
    PaddingVecA = [zeros(1,C) VecA];
    PaddingVecB = VecB;
    PaddingVecC = VecC;
    
    elseif (length(VecA) > length(VecC))&&(length(VecC) == length(VecB))
        C = length(VecA) - length(VecC);
    PaddingVecC = [zeros(1,C) VecC];
    PaddingVecB = [zeros(1,C) VecB];
    PaddingVecA = VecA;
    
    elseif (length(VecC) < length(VecA))&&(length(VecA) == length(VecB))
        C = length(VecA) - length(VecC);
    PaddingVecC = [zeros(1,C) VecC];
    PaddingVecB = VecB;
    PaddingVecA = VecA;
    
    elseif (length(VecC) > length(VecA))&&(length(VecA) == length(VecB))
        C = length(VecC) - length(VecA);
    PaddingVecA = [zeros(1,C) VecA];
    PaddingVecB = [zeros(1,C) VecB];
    PaddingVecC = VecC;
end
 PaddingVecA;
 PaddingVecB;
 PaddingVecC;
end


