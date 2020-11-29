% D C ÖµµÄÓ°Ïì
clear
clc
close all;
warning off;
eqtFN='china3ml.eqt';
[eqTime,eqLongi,eqLati,eqMag,eqDepth]=ywReadEQT(eqtFN);
m=find(eqTime>=datenum(2008,5,12) & eqTime<=datenum(2008,8,12) & eqLongi>=102 & eqLongi<=110 & eqLati>=30 & eqLati<=34);
eqTime=eqTime(m);   eqLongi=eqLongi(m); eqLati=eqLati(m);   eqMag=eqMag(m); eqDepth=eqDepth(m);

[rgLongi,rgLati]=textread('wc.txt');
in=inpolygon(eqLongi,eqLati,rgLongi,rgLati);
eqProperty=in;%x.*0;

CArr=[0.1:0.05:19.9];
ywDraw=0;
DArr=[1:1:99];
drawX(1)=0;drawY(1)=0;drawZ(1)=0;
cc=0;
for(ii=1:length(DArr))
    D=DArr(ii)
    for(i=1:length(CArr))
        C=CArr(i);
        [tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z]=ywDelauny1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
        [ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywDelauny2_CutRelationShip(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw);
        drawX(ii,i)=C;
        drawY(ii,i)=D;
        drawZ(ii,i)=ywGetScore(eqProperty,ywJudgedResult);
    end
end
figure;
pcolor(drawX,drawY,drawZ);
surf(drawX,drawY,drawZ,'edgecolor','none');
view([0 90]);
box on;
xlabel('C (km day^-^1)');ylabel('D (km)');

cdX(1)=0;   cdY(1)=0;   cdc=0;
for(i=1:length(CArr))
    cdX(i)=CArr(i);
    zz=drawZ(:,i);
    [mv,mvIn]=max(zz);
    cdY(i)=drawY(mvIn,i);
end
hold on;plot3(cdX,cdY,cdX.*0+1,'o-w','markerfacecolor','w');


    ax = gca;
    ax.XAxis.MinorTick = 'on';
    %ax.XAxis.MinorTickValues =[0:1:20];
    ax.YAxis.MinorTick = 'on';
    %ax.YAxis.MinorTickValues =[0.75:0.01:1];
    ax.ZAxis.MinorTick = 'on';

    ax.XAxis.TickLength=[0.02,0.02];
    ax.YAxis.TickLength=[0.02,0.02];
    ax.ZAxis.TickLength=[0.02,0.02];
    zlabel('Score');
    view ([-31,21]);
figure;plot(cdX,cdY,'o-','markerfacecolor','w');hold on;
p=fittype('a*x.^0.5+b','independent','x');
f=fit(cdX',cdY',p);
hold on;plot(cdX',f(cdX'),'-r','markerfacecolor','w','linewidth',2);
a=[6.212 6.453 6.694];
b=[13.39 14.15 14.91];
plot(cdX,a(1).*sqrt(cdX)+b(1),'-.r');
plot(cdX,a(3).*sqrt(cdX)+b(3),'--r');
legend([{'Picked data'};{'Fitted curve'};{'-95% confidence interval'};{'+95% confidence interval'}]);

xlabel('\it\fontname{Times New Roman}C \rm (km day^-^1)');
ylabel('\it\fontname{Times New Roman}D\rmbest (km)');

% p=fittype('a*x.^0.5+b','independent','x');
% f=fit(cdX',cdY',p);

    ax = gca;
    ax.XAxis.MinorTick = 'on';
    %ax.XAxis.MinorTickValues =[0:1:20];
    ax.YAxis.MinorTick = 'on';
    %ax.YAxis.MinorTickValues =[0.75:0.01:1];
    ax.XAxis.TickLength=[0.02,0.02];
    ax.YAxis.TickLength=[0.02,0.02];
    
    
    
cdX(1)=0;   cdY(1)=0;   cdc=0;
for(i=1:length(CArr))
    cdX(i)=CArr(i);
    zz=drawZ(:,i);
    [mv,mvIn]=max(zz);
    cdY(i)=drawY(mvIn,i);
end