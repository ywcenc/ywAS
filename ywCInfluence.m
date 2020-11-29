%C ÖµµÄÓ°Ïì
clear
clc
close all;

eqtFN='china3ml.eqt';
[eqTime,eqLongi,eqLati,eqMag,eqDepth]=ywReadEQT(eqtFN);
m=find(eqTime>=datenum(2008,5,12) & eqTime<=datenum(2008,8,12) & eqLongi>=102 & eqLongi<=110 & eqLati>=30 & eqLati<=34);
eqTime=eqTime(m);   eqLongi=eqLongi(m); eqLati=eqLati(m);   eqMag=eqMag(m); eqDepth=eqDepth(m);

[rgLongi,rgLati]=textread('wc.txt');
in=inpolygon(eqLongi,eqLati,rgLongi,rgLati);
eqProperty=in;%x.*0;

D=19;
CArr=[0.1:0.05:4];
ywDraw=0;
for(i=1:length(CArr))
    i
    [tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z]=ywDelauny1_GetRelationShip(eqTime,eqLongi,eqLati,CArr(i),ywDraw);
    [ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywDelauny2_CutRelationShip(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw);
    scoreDelaunay(i)=ywGetScore(eqProperty,ywJudgedResult);
end
figure;plot(CArr,scoreDelaunay,'ks-','markerfacecolor','w');
m1=find(CArr==1);
hold on;plot(CArr(m1),scoreDelaunay(m1),'ks-','markerfacecolor','b');
[mv,mIndex]=max(scoreDelaunay);
hold on;plot(CArr(mIndex),scoreDelaunay(mIndex),'ks-','markerfacecolor','r');
xlabel('\it\fontname{Times New Roman}C \rm (km day^-^1)');
ylabel('Score');
legend([{'scores'};{'when C=1'};{['when C=' num2str(CArr(mIndex))]}]);
    xlim([0 4.1]);
    ax = gca;
    ax.XAxis.MinorTick = 'on';
    ax.XAxis.MinorTickValues =[0:0.1:4.1];
    ax.YAxis.MinorTick = 'on';
    ax.YAxis.MinorTickValues =[0.75:0.01:1];
    ax.XAxis.TickLength=[0.02,0.02];
    ax.YAxis.TickLength=[0.02,0.02];