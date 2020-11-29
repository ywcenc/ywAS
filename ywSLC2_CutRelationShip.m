function[ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywSLC2_CutRelationShip(ywEqLongi,ywEqLati,link1,link2,ywDst,D,ywDraw)    
    %5-Ωÿ∂œÕ¯
    m=find(ywDst>D);
    tmpLink1=link1;
    tmpLink1(m)=[];
    tmpLink2=link2;
    tmpLink2(m)=[];
    
    %6-’“µ•…Ì
    [lia]=ismember(1:length(ywEqLongi),[tmpLink1,tmpLink2]);
    ywJudgedResult=lia';
    m1=find(lia==1);
    m2=find(lia==0);
    if(ywDraw==1)
        subplot(324);hold on;
        for(i=1:length(link1))
            index1=link1(i);
            index2=link2(i);
            plot([ywEqLongi(index1) ywEqLongi(index2)],[ywEqLati(index1) ywEqLati(index2)],'-g.');
        end
        plot(ywEqLongi(m1),ywEqLati(m1) ,'r.');
    end
    ywAfterShockIndex=m1;
    ywBGIndex=m2;
    if(ywDraw==1)
        subplot(325);
        plot(ywEqLongi(ywBGIndex),ywEqLati(ywBGIndex) ,'k.');
        subplot(326);
        plot(ywEqLongi(ywAfterShockIndex),ywEqLati(ywAfterShockIndex) ,'r.');
    end
end