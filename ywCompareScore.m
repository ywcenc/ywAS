clear
clc
close all;

eqtFN='china3ml.eqt';
[eqTime,eqLongi,eqLati,eqMag,eqDepth]=ywReadEQT(eqtFN);
m=find(eqTime>=datenum(2008,5,12) & eqTime<=datenum(2008,8,12) & eqLongi>=102 & eqLongi<=110 & eqLati>=30 & eqLati<=34);
eqTime=eqTime(m);   eqLongi=eqLongi(m); eqLati=eqLati(m);   eqMag=eqMag(m); %eqDepth=eqDepth(m);

[rgLongi,rgLati]=textread('wc.txt');
in=inpolygon(eqLongi,eqLati,rgLongi,rgLati);
eqProperty=in;%x.*0;

%kk-0.48
%GC--0.18
%KLC
%delaunay
%%%%%%%%%%%%%% k k
DArr=[0:1:50];
C=1;ywDraw=0;

[ywLinkIndex1,ywLinkIndex2,ywDst]=ywSLC1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
[tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z]=ywDelauny1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);

for(i=1:length(DArr))
    %%%%%%%%%%%%%% KK
    [ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywKK(eqTime,eqMag,eqLongi,eqLati);
    scoreKK(i)=ywGetScore(eqProperty,ywJudgedResult);
    %%%%%%%%%%%%%% CS
    [ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywCS(eqTime,eqMag,eqLongi,eqLati);
    scoreCS(i)=ywGetScore(eqProperty,ywJudgedResult);
    %%%%%%%%%%%%%% SLC
    D=DArr(i);
    [ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywSLC2_CutRelationShip(eqLongi,eqLati,ywLinkIndex1,ywLinkIndex2,ywDst,D,ywDraw); 
    scoreSLC(i)=ywGetScore(eqProperty,ywJudgedResult);
    %%%%%%%%%%%%%% Delaunay
    D=DArr(i);
    [ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywDelauny2_CutRelationShip2(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw);
    scoreDelaunay(i)=ywGetScore(eqProperty,ywJudgedResult);
end
figure;hold on;
plot(DArr,scoreKK,'o-','markerfacecolor','w');
plot(DArr,scoreCS,'p-','markerfacecolor','w');
plot(DArr,scoreSLC,'^-','markerfacecolor','w');
plot(DArr,scoreDelaunay,'s-','markerfacecolor','w');
xlabel('D(ST-km)');ylabel('Score');
legend([{'K-K'};{'C-S'};{'SLC'};{'Delaunay'}]);
ylim([-0.1 1.01]);xlim([-1 51]);

box on;
    ax = gca;
    ax.XAxis.MinorTick = 'on';
    ax.XAxis.MinorTickValues =[-1:1:51];
    ax.YAxis.MinorTick = 'on';
    ax.YAxis.MinorTickValues =[-0.1:0.02:1];
    ax.XAxis.TickLength=[0.02,0.02];
    ax.YAxis.TickLength=[0.02,0.02];
