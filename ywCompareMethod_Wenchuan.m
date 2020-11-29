clear
clc
close all;

ywLim=1;
ywXLim=[101.9 110.1];
ywYLim=[29.9 34.1];
ywDTLim=1;
ywDTXLim=[datenum(2008,5,11) datenum(2008,8,13)];
ywDTYLim=[2.5 8.5];
eqtFN='china3ml.eqt';
% eqtFN='tangshan.eqt';
[eqTime,eqLongi,eqLati,eqMag,eqDepth]=ywReadEQT(eqtFN);
m=find(eqTime>=datenum(2008,5,12) & eqTime<=datenum(2008,8,12) & eqLongi>=102 & eqLongi<=110 & eqLati>=30 & eqLati<=34);
eqTime=eqTime(m);   eqLongi=eqLongi(m); eqLati=eqLati(m);   eqMag=eqMag(m); eqDepth=eqDepth(m);

 [rgLongi,rgLati]=textread('wc.txt');
% [rgLongi,rgLati]=textread('tangshan.txt');
in=inpolygon(eqLongi,eqLati,rgLongi,rgLati);
eqProperty=in;%x.*0;

hp1=figure('position',[132    39   678   635]);
hmt1=figure('position',[132    39   678   635]);
figure(hp1);
subplot(4,2,1);
m=find(eqProperty==1);
plot(eqLongi(m),eqLati(m),'ok','markersize',2,'markerfacecolor','w');
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
%xlim([102 110.5]);ylim([30 34]);
box on;
subplot(4,2,2);
m=find(eqProperty==0);
plot(eqLongi(m),eqLati(m),'ok','markersize',2,'markerfacecolor','w');
%xlim([102 110.5]);ylim([30 34]);
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
box on;
figure(hmt1);
subplot(4,2,1);
m=find(eqProperty==1);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;
subplot(4,2,2);
m=find(eqProperty==0);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;


%%%%%%%%%%%%%% k k
[ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywKK(eqTime,eqMag,eqLongi,eqLati);
figure(hp1);
subplot(423);hold on;
plot(eqLongi(ywAfterShockIndex),eqLati(ywAfterShockIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'+r');
%xlim([102 110.5]);ylim([30 34]);
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
% legend([{'judged should be judged'};{'wrong recognition'};{'unable to recognize'}]);
box on;
% title(['score=' num2str(ywGetScore(eqProperty,ywJudgedResult))]);
subplot(424);hold on;
plot(eqLongi(ywBGIndex),eqLati(ywBGIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'+r');
%xlim([102 110.5]);ylim([30 34]);
% legend([{'succees recognized'};{'wrong recognized'};{'missed'}]);
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
box on;

figure(hmt1);
subplot(423);hold on;
m=find(ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;

subplot(424);hold on;
m=find(ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;
figure(hp1);
%%%%%%%%%%%%%% C S
[ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywCS(eqTime,eqMag,eqLongi,eqLati);
subplot(425);hold on;
plot(eqLongi(ywAfterShockIndex),eqLati(ywAfterShockIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'+r');
%xlim([102 110.5]);ylim([30 34]);
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;
% title(['score=' num2str(ywGetScore(eqProperty,ywJudgedResult))]);
subplot(426);hold on;
plot(eqLongi(ywBGIndex),eqLati(ywBGIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'+r');
%xlim([102 110.5]);ylim([30 34]);
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;

figure(hmt1);
subplot(425);hold on;
m=find(ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;
subplot(426);hold on;
m=find(ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;


hp2=figure('position',[132    39   678   635]);
hmt2=figure('position',[132    39   678   635]);
%%%%%%%%%%%%%% G C
[ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywGC(eqTime,eqMag,eqLongi,eqLati);
figure(hp2);
subplot(421);hold on;
plot(eqLongi(ywAfterShockIndex),eqLati(ywAfterShockIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'+r');
%xlim([102 110.5]);ylim([30 34]);
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;
% title(['score=' num2str(ywGetScore(eqProperty,ywJudgedResult))]);
subplot(422);hold on;
plot(eqLongi(ywBGIndex),eqLati(ywBGIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'+r');
%xlim([102 110.5]);ylim([30 34]);
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;
figure(hmt2);
subplot(421);hold on;
m=find(ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;
subplot(422);hold on;
m=find(ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;

figure(hp2);
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
% xlim([102 110.5]);ylim([30 34]);
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;
% title(['score=' num2str(ywGetScore(eqProperty,ywJudgedResult))]);
subplot(424);hold on;
plot(eqLongi(ywBGIndex),eqLati(ywBGIndex),'ok','markersize',2,'markerfacecolor','w');
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'+r');
%xlim([102 110.5]);ylim([30 34]);
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;
figure(hmt2);
subplot(423);hold on;
m=find(ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;

subplot(424);hold on;
m=find(ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;

figure(hp2);
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
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
%xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;
% title(['score=' num2str(ywGetScore(eqProperty,ywJudgedResult))]);

subplot(426);hold on;
plot(eqLongi(ywBGIndex),eqLati(ywBGIndex),'ok','markersize',2,'markerfacecolor','w');hold on;
m=find(eqProperty==1 & ywJudgedResult==0);
plot(eqLongi(m),eqLati(m),'xb');
m=find(eqProperty==0 & ywJudgedResult==1);
plot(eqLongi(m),eqLati(m),'+r');
if(ywLim==1)
    xlim(ywXLim);ylim(ywYLim);
end
%xlim([102 110.5]);ylim([30 34]);
% legend([{'judged should be judged'};{'judged should not be judged'};{'missed'}]);
box on;

figure(hmt2);
subplot(425);hold on;
m=find(ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;
%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);

subplot(426);hold on;
m=find(ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
if(ywDTLim==1)
    xlim(ywDTXLim);
    ylim(ywDTYLim);
end
box on;
% datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);

figure(hp2);
subplot(427);hold on;
plot(103.4,31,'ok','markersize',2,'markerfacecolor','w');hold on;
plot(103.4,31,'xb');
plot(103.4,31,'+r');
%xlim([102 110.5]);ylim([30 34]);
legend([{'correct'};{'incorrect'};{'missed'}]);
box on;
figure(hmt2);
subplot(427);hold on;
m=find(ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ok','markersize',2,'markerfacecolor','k');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==1 & ywJudgedResult==0);
stem(eqTime(m),eqMag(m),'ob','markersize',2,'markerfacecolor','b');%datetick('x',26);ylim([2.5 8.5]);%xlim([datenum(1970,1,1) datenum(2020,8,1)]);
m=find(eqProperty==0 & ywJudgedResult==1);
stem(eqTime(m),eqMag(m),'or','markersize',2,'markerfacecolor','r');datetick('x','mm-dd');
legend([{'correct'};{'incorrect'};{'missed'}]);

