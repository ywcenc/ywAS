function[ywMinDstIndex]=ywGetMinDst(ywEqDT,ywEqLongi,ywEqLati,C)
    for(i=1:length(ywEqDT))
%         jd=i/length(ywEqDT)
        dis=distance(ywEqLati(i),ywEqLongi(i),ywEqLati,ywEqLongi);
        dis=dis*pi/180*6371.828;%km        
        dt=ywEqDT-ywEqDT(i);%day
        dst=sqrt(dis.*dis+C^2*dt.*dt);
        dst(i)=1E+38;        
        [minV,minVIndex]=min(dst);
        ywMinDstIndex(i)=minVIndex;
    end    
end