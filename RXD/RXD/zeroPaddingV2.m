function [vec1, vec2, vec3] = zeroPaddingV2(vec1, vec2, vec3)

length1 = length(vec1);
length2 = length(vec2);
length3 = length(vec3);

if ~(length1 == length2) && (length2 == length3)
   newLength = max([length1, length2, length3]);
   vec1 = horzcat(vec1, zeros(newLength - length1, 1));
   vec2 = horzcat(vec2, zeros(newLength - length2, 1));
   vec3 = horzcat(vec3, zeros(newLength - length3, 1));
end

end