function[homeIn,otherIn]=ywGetMinDstNotHome(ywEqDT,ywEqLongi,ywEqLati,C,homeIndex)
    for(i=1:length(homeIndex))
%         jd=i/length(ywEqDT)
        dis=distance(ywEqLati(homeIndex(i)),ywEqLongi(homeIndex(i)),ywEqLati,ywEqLongi);
        dis=dis*pi/180*6371.828;%km        
        dt=ywEqDT-ywEqDT(homeIndex(i));%day
        dst=sqrt(dis.*dis+C^2*dt.*dt);
        dst(homeIndex)=1E+38;        

        [minV(i),minVIndex(i)]=min(dst);
    end    
    [mv,mvIndex]=min(minV);
    homeIn=homeIndex(mvIndex);
    otherIn=minVIndex(mvIndex);
end