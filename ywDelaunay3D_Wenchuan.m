clear
clc
close all

figure;
subplot(221);hold on;
n=50
x=rand(1,n);
y=rand(1,n);
z=rand(1,n);

eqtFN='china3ml.eqt';

[eqTime,eqLongi,eqLati,eqMag,eqDepth]=ywReadEQT(eqtFN);
m=find(eqTime>=datenum(2008,5,12) & eqTime<=datenum(2009,5,12) & eqLongi>=102 & eqLongi<=110 & eqLati>=30 & eqLati<=34 & eqMag>=4);
eqTime=eqTime(m);   eqLongi=eqLongi(m); eqLati=eqLati(m);   eqMag=eqMag(m); %eqDepth=eqDepth(m);
x=(eqLongi-103.4)*110;
y=(eqLati-31)*110;
z=(eqTime-datenum(2008,5,12));
[rgLongi,rgLati]=textread('wc.txt');
rgLongi=(rgLongi-103.4)*110;
rgLati=(rgLati-31)*110;
hold on;plot(rgLongi,rgLati);
in=inpolygon(x,y,rgLongi,rgLati);
eqProperty=in;%x.*0;
% eqProperty(in)=1;

m1=find(eqProperty==1);
plot3(x,y,z,'o');
plot3(x(m1),y(m1),z(m1),'o','markerfacecolor','r');
grid on;view([-46,38]);
tri=delaunay(x,y,z);
subplot(222);
h=trimesh(tri,x,y,z);
set(h,'edgealpha',1,'facealpha',0) ;
grid on;view([-46,38]);

subplot(223);hold on;
h=trisurf(tri,x,y,z);
set(h,'edgealpha',0,'facealpha',0.3) ;
h=trimesh(tri,x,y,z);
set(h,'edgealpha',1,'facealpha',0) ;

grid on;view([-46,38]);

x1=x(tri(:,1));
y1=y(tri(:,1));
z1=z(tri(:,1));

x2=x(tri(:,2));
y2=y(tri(:,2));
z2=z(tri(:,2));

x3=x(tri(:,3));
y3=y(tri(:,3));
z3=z(tri(:,3));

x4=x(tri(:,4));
y4=y(tri(:,4));
z4=z(tri(:,4));

[dis12]=ywGetDis3D(x1,y1,z1,x2,y2,z2);
[dis23]=ywGetDis3D(x3,y3,z3,x2,y2,z2);
[dis13]=ywGetDis3D(x1,y1,z1,x3,y3,z3);
[dis14]=ywGetDis3D(x1,y1,z1,x4,y4,z4);
[dis24]=ywGetDis3D(x4,y4,z4,x2,y2,z2);
[dis34]=ywGetDis3D(x3,y3,z3,x4,y4,z4);

dis=[dis12;dis23;dis13;dis14;dis24;dis34];
dis=sort(dis);
subplot(224);
% plot(((dis)),'.-');

dis1=min(dis);
dis21=max(dis)-min(dis);
drawP=0:0.01:1;
cc=0;
drawP(1)=0;
for(p=0:0.01:1)
     dis2=dis1+dis21*p;
     m=find(dis<=dis2 & dis>=(dis1+dis21*(p-0.01)));
     cc=cc+1;
     drawP(cc)=p;
     drawDis(cc)=length(m);
end
% drawDis=min(dis)+(max(dis)-min(dis)).*drawP;
% plot(drawP,drawDis);
histogram(dis,[0:0.1:50]);xlim([0 50]);

figure;
LcArr=[0:0.1:1.0];
LcArr=[0:1:200];
for(i=1:length(LcArr))
    newTri=tri;
    Lc=LcArr(i);
    m12=find(dis12>=Lc);
    newTri(m12,1)=nan;
    newTri(m12,2)=nan;
    m23=find(dis23>=Lc);
    newTri(m23,2)=nan;
    newTri(m23,3)=nan;
    m13=find(dis13>=Lc);
    newTri(m13,1)=nan;
    newTri(m13,3)=nan;
    m14=find(dis14>=Lc);
    newTri(m14,1)=nan;
    newTri(m14,4)=nan;
    m24=find(dis24>=Lc);
    newTri(m24,2)=nan;
    newTri(m24,4)=nan;
    m34=find(dis34>=Lc);
    newTri(m34,3)=nan;
    newTri(m34,4)=nan;
    if(i<=4)
        subplot(2,2,i);hold on;
        h=trisurf(newTri,x,y,z);
        set(h,'edgealpha',0,'facealpha',0.3) ;
        h=trimesh(newTri,x,y,z);
        set(h,'edgealpha',1,'facealpha',0) ;
        plot3(x,y,z,'o');
        grid on;view([-46,38]);
    end
    
    newTri1=newTri(:);
    newTri1(isnan(newTri1))=[];
    judgedProperty=x.*0;
    judgedProperty(newTri1)=1;
    ywScore(i)=ywGetScore(eqProperty,judgedProperty);
end
figure;plot(LcArr,ywScore,'o-');
[mv,mvIndex]=max(ywScore);
bestLc=LcArr(mvIndex);

newTri=tri;
Lc=bestLc;
m12=find(dis12>=Lc);
newTri(m12,1)=nan;
newTri(m12,2)=nan;
m23=find(dis23>=Lc);
newTri(m23,2)=nan;
newTri(m23,3)=nan;
m13=find(dis13>=Lc);
newTri(m13,1)=nan;
newTri(m13,3)=nan;
m14=find(dis14>=Lc);
newTri(m14,1)=nan;
newTri(m14,4)=nan;
m24=find(dis24>=Lc);
newTri(m24,2)=nan;
newTri(m24,4)=nan;
m34=find(dis34>=Lc);
newTri(m34,3)=nan;
newTri(m34,4)=nan;

newTri1=newTri(:);
newTri1(isnan(newTri1))=[];
judgedProperty=x.*0;
judgedProperty(unique(newTri1))=1;
figure;hold on;
% h=trisurf(newTri,x,y,z);
% set(h,'edgealpha',0,'facealpha',0.3) ;
h=trimesh(newTri,x,y,z);
set(h,'edgealpha',1,'facealpha',0) ;
plot3(x,y,z,'.k');
grid on;view([-46,38]);
m3=find(eqProperty==1 & judgedProperty==0);
hold on;plot3(x(m3),y(m3),z(m3),'.r');
% m3=find(judgedProperty==1);
% hold on;plot3(x(m3),y(m3),z(m3),'.b');
m5=find(eqMag>=5);
x5=(eqLongi(m5)-103.4)*110;
y5=(eqLati(m5)-31)*110;
z5=eqTime-datenum(2008,5,12);
plot3(x(m5),y(m5),z(m5),'or','markerfacecolor','r');
axis equal
