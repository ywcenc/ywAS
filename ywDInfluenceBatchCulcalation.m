clear
clc
close all;
%fid=load('.\compareScore\2001kunlunshan8.1.txt');%D-score(a)
% fid=load('.\compareScore\2008yutian7.3.txt');%D-score(b)
%  fid=load('.\compareScore\2008wenchuan8.0.txt');%D-score(c)
%%%%%%%%%%%%%%%%%%% fid=load('.\compareScore\2010yushu7.1.txt');%D-score(d)
% fid=load('.\compareScore\20100414074936_0_7.2.txt');%D-score(h)

%fid=load('.\compareScore\2013lushan7.0.txt');%D-score(e)
%fid=load('.\compareScore\2014yutian7.3.txt');%D-score(f)
%fid=load('.\compareScore\2015niboer8.0.txt');%D-score(g)
fid=load('.\compareScore\2017jiuzaigou7.0.txt');%D-score(h)

% fid=load('.\compareScore\20000115073705_0_6.7.txt');%D-score(h)
%fid=load('.\compareScore\20000912082754_0_6.6.txt');%D-score(h)
%fid=load('.\compareScore\20010223080919_0_6.3.txt');%D-score(h)
%fid=load('.\compareScore\20050328160936_yw无_8.6.txt');%D-score(h)
%fid=load('.\compareScore\20120411083836_yw无_8.6.txt');%D-score(h)



% fid=load('.\compareScore\20001116045456_yw无_8.txt');%D-score(h)
%fid=load('.\compareScore\20010623203314_yw无_8.4.txt');%D-score(h)
%fid=load('.\compareScore\20030925195006_yw无_8.3.txt');%D-score(h)

% fid=load('.\compareScore\20041223145904_0_8.1.txt');%D-score(h)
%fid=load('.\compareScore\20041226042129_0_7.2.txt');%D-score(h)
%fid=load('.\compareScore\20050328160936_yw无_8.6.txt');%D-score(h)

%fid=load('.\compareScore\20060503152640_yw无_8.txt');%D-score(h)
%fid=load('.\compareScore\20061115111413_yw无_8.3.txt');%D-score(h)
%fid=load('.\compareScore\20070113042321_yw无_8.1.txt');%D-score(h)
%fid=load('.\compareScore\20070401203958_yw无_8.1.txt');%D-score(h)
%fid=load('.\compareScore\20070815234057_yw无_8.txt');%D-score(h)
%fid=load('.\compareScore\20070912111026_yw无_8.5.txt');%D-score(h)

%fid=load('.\compareScore\20090929174810_yw无_8.1.txt');%D-score(h)
%fid=load('.\compareScore\20100227063411_yw无_8.8.txt');%D-score(h)
%fid=load('.\compareScore\20110311054624_yw无_9.txt');%D-score(h)
%fid=load('.\compareScore\20120411083836_yw无_8.6.txt');%D-score(h)
%fid=load('.\compareScore\20130206011227_yw无_8.txt');%D-score(h)
% fid=load('.\compareScore\20130524054448_0_8.3.txt');%D-score(h)

%fid=load('.\compareScore\20140401234647_0_8.2.txt');%D-score(h)
%fid=load('.\compareScore\20150916225432_0_8.3.txt');%D-score(h)
% fid=load('.\compareScore\20170908044919_-1_8.2.txt');%D-score(h)
% fid=load('.\compareScore\20180819001940_-1_8.2.txt');%D-score(h)
% fid=load('.\compareScore\20190526074115_0_8.txt');%D-score(h)

% fid=load('.\compareScore\20030925195006_0_8.3.txt');%D-score(h)

epcenterLongi=fid(1,1);
epcenterLati=fid(1,2);
dtStr=num2str(fid(2,1));
dtStart=datenum(str2num(dtStr(1:4)),str2num(dtStr(5:6)),str2num(dtStr(7:8)));
dtStr=num2str(fid(2,2));
dtEnd=datenum(str2num(dtStr(1:4)),str2num(dtStr(5:6)),str2num(dtStr(7:8)));

leftUpLongi=fid(3,1);
leftUpLati=fid(3,2);
rightDownLongi=fid(4,1);
rightDownLati=fid(4,2);

rgLongi=fid(5:end,1);
rgLati=fid(5:end,2);
rgLongi(end+1)=rgLongi(1);
rgLati(end+1)=rgLati(1);

eqTime0=dtStart;


eqtFN='china3ml.eqt';
%  eqtFN='Neic40.eqt';
% 
% eqtFN='20001106.eqt';
% eqtFN='20010623.eqt';
% eqtFN='20030925.eqt';
% eqtFN='20041223.eqt';
%eqtFN='20041226.eqt';
%eqtFN='20050328.eqt';

%eqtFN='20060503.eqt';
%eqtFN='20061115.eqt';
% eqtFN='20070113.eqt';
% eqtFN='20070401.eqt';
% eqtFN='20070815.eqt';
% eqtFN='20070912.eqt';
% eqtFN='20090929.eqt';
% eqtFN='20100227.eqt';
% eqtFN='Japan2.eqt';
% eqtFN='20120411.eqt';
% eqtFN='20130206.eqt';
% eqtFN='20130524.eqt';


% eqtFN='20140401.eqt';
% eqtFN='20150916.eqt';
% eqtFN='20170908.eqt';
%  eqtFN='20180819.eqt';
%  eqtFN='20190526.eqt';

% eqtFN='201404111.eqt';
%  eqtFN='200309252.eqt';

%  eqtFN='china3ml.eqt';
[eqTime,eqLongi,eqLati,eqMag,eqDepth]=ywReadEQT(eqtFN);
m=find(eqTime>=dtStart & eqTime<=dtEnd & eqLongi>=leftUpLongi & eqLongi<=rightDownLongi & eqLati>=rightDownLati & eqLati<=leftUpLati);
eqTime=eqTime(m);   eqLongi=eqLongi(m); eqLati=eqLati(m);   eqMag=eqMag(m); %eqDepth=eqDepth(m);

%[rgLongi,rgLati]=textread('wc.txt');
in=inpolygon(eqLongi,eqLati,rgLongi,rgLati);
eqProperty=in;%x.*0;
figure('position',[403   246   884   337]./2);
 faultFN='chinafault.MIF.matlab';
    faultFN='徐锡伟_参考地震构造图.MIF.matlab';
    [ftLongi,ftLati]=textread(faultFN,'%f%f');
subplot(121);    hold on;plot(ftLongi,ftLati,'color',[.6 .6 .6]);%,[165, 42, 42]./255);

plot(eqLongi,eqLati,'.b');hold on;plot(rgLongi,rgLati,'k-');plot(eqLongi(in),eqLati(in),'.r');
xlabel('longitude(°E)');ylabel('latitude(°N)');

   
    [mv,mvI]=max(eqMag);
    plot(eqLongi(mvI),eqLati(mvI),'p','markerfacecolor','none','markersize',10,'markeredgecolor','k');

    axis equal;

    xlim([leftUpLongi rightDownLongi]);ylim([rightDownLati leftUpLati]);
    box on;
    ax = gca;
    ax.XAxis.MinorTick = 'on';
%     ax.XAxis.MinorTickValues =[-1:1:51];
    ax.YAxis.MinorTick = 'on';
    %ax.YAxis.MinorTickValues =[-0.1:0.02:1];
    ax.XAxis.TickLength=[0.04,0.04];
    ax.YAxis.TickLength=[0.04,0.04];
%kk-0.48
%GC--0.18
%KLC
%delaunay
%%%%%%%%%%%%%% k k
DArr=[0:5:200];
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
    [ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywDelauny2_CutRelationShip(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw);
    scoreDelaunay(i)=ywGetScore(eqProperty,ywJudgedResult);
    %%%%%%%%%%%%%% Delaunay2
    D=DArr(i);
    [ywJudgedResult,ywAfterShockIndex,ywBGIndex]=ywDelauny2_CutRelationShip2(tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z,D,ywDraw);
    scoreDelaunay2(i)=ywGetScore(eqProperty,ywJudgedResult);
end
subplot(122);hold on;
% % % plot(DArr,scoreKK,'o-','markerfacecolor','w');
% % % plot(DArr,scoreCS,'p-','markerfacecolor','w');
% % % plot(DArr,scoreSLC,'^-','markerfacecolor','w');
% % % %plot(DArr,scoreDelaunay,'s-','markerfacecolor','w');
% % % plot(DArr,scoreDelaunay2,'s-','markerfacecolor','w');
plot(DArr,scoreKK,'-','markerfacecolor','w');
plot(DArr,scoreCS,'-','markerfacecolor','w');
plot(DArr,scoreSLC,'-','markerfacecolor','w');
%plot(DArr,scoreDelaunay,'-','markerfacecolor','w');
plot(DArr,scoreDelaunay2,'-','markerfacecolor','w');


xlabel('D (ST-km)');ylabel('Score');
legend([{'K-K'};{'C-S'};{'SLC'};{'this paper'}]);
ylim([-0.1 1.1]);
xlim([-9 209]);

box on;
    ax = gca;
    ax.XAxis.MinorTick = 'on';
%     ax.XAxis.MinorTickValues =[-1:1:51];
    ax.YAxis.MinorTick = 'on';
    %ax.YAxis.MinorTickValues =[-0.1:0.02:1];
    ax.XAxis.TickLength=[0.04,0.04];
    ax.YAxis.TickLength=[0.04,0.04];
outInfo=[max(scoreKK) max(scoreCS) max(scoreSLC) max(scoreDelaunay2) max(scoreDelaunay)]