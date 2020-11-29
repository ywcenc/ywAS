function[ywLinkIndex1,ywLinkIndex2,ywDst]=ywSLC1_GetRelationShip(ywEqDT,ywEqLongi,ywEqLati,C,ywDraw)
    %1-牵牵手
    [ywMinDstIndex]=ywGetMinDst(ywEqDT,ywEqLongi,ywEqLati,C);
    indexArr1=1:length(ywMinDstIndex);

    if(ywDraw==1)
        figure;hold on;
        subplot(321);hold on;
        for(i=1:length(ywMinDstIndex))
            index1=indexArr1(i);
            index2=ywMinDstIndex(i);
            plot([ywEqLongi(index1) ywEqLongi(index2)],[ywEqLati(index1) ywEqLati(index2)],'-k.');
        end
    end
    %2-组家庭
    homeCount=0;
    allHomes{1}=[];
    for(i=1:length(ywMinDstIndex))
        in=0;
        for(j=1:length(allHomes))
            m=find(allHomes{j}==i);
            if(~isempty(m))
                in=1;
                break;
            end
        end
        if(in==0)
            homeCount=homeCount+1;
            [homeIndexArr]=ywGetHomeIndexArr(indexArr1,ywMinDstIndex,i);
            allHomes{homeCount}=homeIndexArr;
        end        
    end
    if(ywDraw==1)
        subplot(322);hold on;
        for(i=1:length(ywMinDstIndex))
            index1=indexArr1(i);
            index2=ywMinDstIndex(i);
            plot([ywEqLongi(index1) ywEqLongi(index2)],[ywEqLati(index1) ywEqLati(index2)],'-b.');
        end
    end
    %3-建社群
    bigHome=allHomes{1};
    addedLink1=[];addedLink2=[];
    while(1==1)
%         jd=length(bigHome)
        if(length(bigHome)==length(ywEqLongi))
            break;
        end
        [homeIn,otherIn]=ywGetMinDstNotHome(ywEqDT,ywEqLongi,ywEqLati,C,bigHome);
        if(ywDraw==1)
            hold on;plot([ywEqLongi(homeIn) ywEqLongi(otherIn)],[ywEqLati(homeIn) ywEqLati(otherIn)],'.-r');
        end
        addedLink1=[addedLink1; homeIn];
        addedLink2=[addedLink2; otherIn];
        for(i=1:length(allHomes))
            m=find(allHomes{i}==otherIn);
            if(~isempty(m))
                bigHome=unique([bigHome; allHomes{i}]);
                break;
            end
        end
    end
    %4-关系网
    link1=[indexArr1';addedLink1];
    link2=[ywMinDstIndex';addedLink2];
    if(ywDraw==1)
        hold on;
        for(i=1:length(link1))
            index1=link1(i);
            index2=link2(i);
            plot([ywEqLongi(index1) ywEqLongi(index2)],[ywEqLati(index1) ywEqLati(index2)],'-g.');
        end
    end
    [ywDst]=ywGetDst(ywEqDT,ywEqLongi,ywEqLati,C,link1,link2);
    if(ywDraw==1)
        subplot(323);
        plot(log10(sort(ywDst)),'o');
    end
%     Lc=10.^median(log10(sort(ywDst)));
%     Dbest=D;%     Dbest=9.4*sqrt(Lc)-25.2;     
    ywLinkIndex1=link1;
    ywLinkIndex2=link2;   
   
end