clear
clc
close all


t=1:10;
x=tan(t);
y=cos(t);
z=sin(t);
figure;
subplot(221);hold on;
n=50
x=rand(1,n);
y=rand(1,n);
z=rand(1,n);
plot3(x,y,z,'o');
grid on;view([-46,38]);

tri=delaunay(x,y,z);
subplot(222);
h=trimesh(tri,x,y,z);
set(h,'edgealpha',1,'facealpha',0) ;
grid on;view([-46,38]);

subplot(223);
h=trisurf(tri,x,y,z);
set(h,'edgealpha',0,'facealpha',0.3) ;
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

dis=[dis12,dis23,dis13,dis14,dis24,dis34];
dis=sort(dis);
subplot(224);
plot(diff(diff(dis)),'.-');

figure;
LcArr=[0.2 0.3 0.4 0.7];
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
    subplot(2,2,i);hold on;
    h=trisurf(newTri,x,y,z);
    set(h,'edgealpha',0,'facealpha',0.3);
    h=trimesh(newTri,x,y,z);
    set(h,'edgealpha',1,'facealpha',0);

    plot3(x,y,z,'o');
    grid on;view([-46,38]);
end


