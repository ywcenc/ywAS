function[ywIsAfterShock,ywAfterShockIndex,ywBGIndex]=ywGC(ywEqDT,ywEqMag,ywEqLongi,ywEqLati)
    ywIsAfterShock=ywEqMag.*0;
    for(i=1:length(ywEqDT))
        jd=i/length(ywEqDT)
        m1=ywEqMag(i);
        [R0,T0]= ywGetT0R0GC(m1);
        dis=distance(ywEqLati(i),ywEqLongi(i),ywEqLati,ywEqLongi);
        dis=dis*pi/180*6371.828;%km
        dt=ywEqDT-ywEqDT(i);
        m=find(dt>0 & dt<=T0 & dis<=R0);
        ywIsAfterShock(m)=1;
    end   
    ywAfterShockIndex=find(ywIsAfterShock==1);
    ywBGIndex=find(ywIsAfterShock==0);
end