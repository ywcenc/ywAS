function[ywAllDst]=ywGetAllDst(ywEqDT,ywEqLongi,ywEqLati,C)
    clear ywAllDst;
    ywAllDst=0;
    for(i=1:length(ywEqDT))
        jd=i/length(ywEqDT)
        dis=distance(ywEqLati(i),ywEqLongi(i),ywEqLati,ywEqLongi);
        dis=dis*pi/180*6371.828;%km        
        dt=ywEqDT-ywEqDT(i);%day
        dst=sqrt(dis.*dis+C^2*dt.*dt);
        dst(i)=[];
        ywAllDst=[ywAllDst;dst];
    end    
    ywAllDst(1)=[];
end