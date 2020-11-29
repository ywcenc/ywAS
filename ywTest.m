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
ywAfterShock=ywKK(eqTime,eqMag,eqLongi,eqLati);
%ywAfterShock=ywCS(eqTime,eqMag,eqLongi,eqLati);
%ywAfterShock=ywGC(eqTime,eqMag,eqLongi,eqLati);
LcArr(1)=0;tmpC=0;
D=15;
C=1;ywDraw=0;
 [ywLinkIndex1,ywLinkIndex2,ywDst]=ywSLC1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
% [tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z]=ywDelauny1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
 for(D=0:1:200)
    jddddddddddddddddd=D
    tmpC=tmpC+1;
    LcArr(tmpC)=D;
    [ywJudgedResult,ywAfterShock,ywBGIndex]=ywSLC2_CutRelationShip(eqLongi,eqLati,ywLinkIndex1,ywLinkIndex2,ywDst,D,ywDraw); 
%     [ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywDelauny2_CutRelationShip(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw);
    ywScore(tmpC)=ywGetScore(eqProperty,ywJudgedResult);
 end
 [mv,mvIndex]=max(ywScore);
figure;plot(LcArr,ywScore);
D=LcArr(mvIndex);
ywDraw=1;
% [tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z]=ywDelauny1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
% [ywJudgedResult,ywAfterShock,ywBGIndex]=ywDelauny2_CutRelationShip(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw);

[ywLinkIndex1,ywLinkIndex2,ywDst]=ywSLC1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
[ywJudgedResult,ywAfterShock,ywBGIndex]=ywSLC2_CutRelationShip(eqLongi,eqLati,ywLinkIndex1,ywLinkIndex2,ywDst,D,ywDraw); 

m1=find(ywAfterShock==1);
m0=find(ywAfterShock==0);
m1=unique(ywAfterShock);
m0=unique(ywBGIndex);

figure;subplot(221);plot(eqLongi,eqLati,'.k');title('all');
subplot(222);plot(eqLongi(m1),eqLati(m1),'.b');legend([{'aftershock'}]);
subplot(223);hold on;plot(eqLongi(m0),eqLati(m0),'.r');
legend([{'backGround'}]);

figure;plot(eqTime(m0),eqMag(m0));datetick('x',26);title('BG');
figure;plot(eqTime(m1),eqMag(m1));datetick('x',26);title('aftershock');
