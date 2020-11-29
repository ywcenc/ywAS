function [ywIsIn]=ywIsInArray(value,Arr)
    m=find(value==Arr);
    if(isempty(m))
        ywIsIn=0;
    else
        ywIsIn=1;
    end
end