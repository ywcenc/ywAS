function[ywScore]=ywGetScore(eqProperty,judgedEqProperty)
    %shold clouded and have clouded
    m1=find(eqProperty==1);
    m11=find(judgedEqProperty(m1)==1);
    fraction1=length(m11)/length(m1);
    %shold not clouded and have not clouded
    m0=find(eqProperty==0);
    m00=find(judgedEqProperty(m0)==0);
    fraction2=length(m00)/length(m0);
    ywScore=fraction1+fraction2-1;
end