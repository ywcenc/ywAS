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

figure('position',[132    39   678   635]);
subplot(4,2,1);
m=find(eqProperty==1);
plot(eqLongi(m),eqLati(m),'ok','markersize',2,'markerfacecolor','w');
xlim([102 110.5]);ylim([30 34]);box on;
subplot(4,2,2);
m=find(eqProperty==0);
plot(eqLongi(m),eqLati(m),'ok','markersize',2,'markerfacecolor','w');
xlim([102 110.5]);ylim([30 34]);box on;


%%%%%%%%%%%%%% k k
[ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywKK(eqTime,eqMag,eqLongi,eqLati);
subplot(423);hold on;
plot(eqLongi(ywAfterShockIndex),eqLati(ywAfterShockIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'+r');xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'wrong recognition'};{'unable to recognize'}]);
box on;
% title(['score=' num2str(ywGetScore(eqProperty,ywJudgedResult))]);
subplot(424);hold on;
plot(eqLongi(ywBGIndex),eqLati(ywBGIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'+r');xlim([102 110.5]);ylim([30 34]);
% legend([{'succees recognized'};{'wrong recognized'};{'missed'}]);
box on;

%%%%%%%%%%%%%% C S
[ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywCS(eqTime,eqMag,eqLongi,eqLati);
subplot(425);hold on;
plot(eqLongi(ywAfterShockIndex),eqLati(ywAfterShockIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'+r');xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;
% title(['score=' num2str(ywGetScore(eqProperty,ywJudgedResult))]);
subplot(426);hold on;
plot(eqLongi(ywBGIndex),eqLati(ywBGIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'+r');xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;

figure('position',[132    39   678   635]);
%%%%%%%%%%%%%% G C
[ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywGC(eqTime,eqMag,eqLongi,eqLati);
subplot(421);hold on;
plot(eqLongi(ywAfterShockIndex),eqLati(ywAfterShockIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'+r');xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;
% title(['score=' num2str(ywGetScore(eqProperty,ywJudgedResult))]);
subplot(422);hold on;
plot(eqLongi(ywBGIndex),eqLati(ywBGIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'+r');xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;

%%%%%%%%%%%%%% SLC
C=1;D=8;ywDraw=0;
[ywLinkIndex1,ywLinkIndex2,ywDst]=ywSLC1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
[ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywSLC2_CutRelationShip(eqLongi,eqLati,ywLinkIndex1,ywLinkIndex2,ywDst,D,ywDraw); 
subplot(423);hold on;
plot(eqLongi(ywAfterShockIndex),eqLati(ywAfterShockIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==0 & ywJudgedResult==1);
if(~isnan(m))
    plot(eqLongi(m),eqLati(m),'xb');
end
m=find(eqProperty==1 & ywJudgedResult==0);
if(~isnan(m))
    plot(eqLongi(m),eqLati(m),'+r');
end
xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;
% title(['score=' num2str(ywGetScore(eqProperty,ywJudgedResult))]);
subplot(424);hold on;
plot(eqLongi(ywBGIndex),eqLati(ywBGIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'+r');xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;

%%%%%%%%%%%%%% Delaunay
D=19;
[tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z]=ywDelauny1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
[ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywDelauny2_CutRelationShip(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw);
subplot(425);hold on;
plot(eqLongi(ywAfterShockIndex),eqLati(ywAfterShockIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==0 & ywJudgedResult==1);
if(~isnan(m))
    plot(eqLongi(m),eqLati(m),'xb');
end
m=find(eqProperty==1 & ywJudgedResult==0);
if(~isnan(m))
    plot(eqLongi(m),eqLati(m),'+r');
end
xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;
% title(['score=' num2str(ywGetScore(eqProperty,ywJudgedResult))]);

subplot(426);hold on;
plot(eqLongi(ywBGIndex),eqLati(ywBGIndex),'ok','markersize',2,'markerfacecolor','w');hold on;
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'+r');xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;

subplot(427);hold on;
plot(103.4,31,'ok','markersize',2,'markerfacecolor','w');hold on;
plot(103.4,31,'xb');
plot(103.4,31,'+r');xlim([102 110.5]);ylim([30 34]);
legend([{'correct'};{'incorrect'};{'missed'}]);
box on;
% LcArr(1)=0;tmpC=0;
% D=8;
% C=1;ywDraw=0;
% %  [ywLinkIndex1,ywLinkIndex2,ywDst]=ywSLC1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
% [tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z]=ywDelauny1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
%  for(D=0:1:50)
%     jddddddddddddddddd=D
%     tmpC=tmpC+1;
%     LcArr(tmpC)=D;
%    % [ywJudgedResult,ywAfterShock,ywBGIndex]=ywSLC2_CutRelationShip(eqLongi,eqLati,ywLinkIndex1,ywLinkIndex2,ywDst,D,ywDraw); 
%      [ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywDelauny2_CutRelationShip(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw);
%     ywScore(tmpC)=ywGetScore(eqProperty,ywJudgedResult);
%  end
% [mv,mvIndex]=max(ywScore);
% figure;plot(LcArr,ywScore);
% D=LcArr(mvIndex);
% ywDraw=1;
% % [tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z]=ywDelauny1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
% % [ywJudgedResult,ywAfterShock,ywBGIndex]=ywDelauny2_CutRelationShip(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw);
% 
% [ywLinkIndex1,ywLinkIndex2,ywDst]=ywSLC1_GetRelationShip(eqTime,eqLongi,eqLati,C,ywDraw);
% [ywJudgedResult,ywAfterShock,ywBGIndex]=ywSLC2_CutRelationShip(eqLongi,eqLati,ywLinkIndex1,ywLinkIndex2,ywDst,D,ywDraw); 
% 
% m1=find(ywAfterShock==1);
% m0=find(ywAfterShock==0);
% m1=unique(ywAfterShock);
% m0=unique(ywBGIndex);
% 
% figure;subplot(221);plot(eqLongi,eqLati,'.k');title('all');
% subplot(222);plot(eqLongi(m1),eqLati(m1),'.b');legend([{'aftershock'}]);
% subplot(223);hold on;plot(eqLongi(m0),eqLati(m0),'.r');
% legend([{'backGround'}]);
% 
% figure;plot(eqTime(m0),eqMag(m0));datetick('x',26);title('BG');
% figure;plot(eqTime(m1),eqMag(m1));datetick('x',26);title('aftershock');
