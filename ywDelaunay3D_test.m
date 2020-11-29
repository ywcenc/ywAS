clear
clc
close all

hp=figure('position',[369    52   717   614]);
[x,y,z]=textread('ywXYZ3D.txt');
% x=rand(1,20)-0.5;
% y=rand(1,20)-0.5;
% z=rand(1,20)-0.5;
% x2=rand(1,20)*4-2;
% y2=rand(1,20)*4-2;
% z2=rand(1,20)*4-2;
% 
% x=[x,x2];y=[y,y2];z=[z,z2];
% xyz=[x;y;z]';
% save -ascii ywXYZ3D.txt xyz;
tri=delaunay(x,y,z);
[sideIndex1,sideIndex2]=ywGetSideIndexUsing3DTri(tri);
hold on;
    sIn1=sideIndex1;
    sIn2=sideIndex2;
plot3(x,y,z,'o');
for(j=1:length(sIn2))
    plot3([x(sIn1(j)) x(sIn2(j))],[y(sIn1(j)) y(sIn2(j))],[z(sIn1(j)) z(sIn2(j))],'o-r');
end
hold off;
dis=ywGetDis3D(x(sideIndex1),y(sideIndex1),z(sideIndex1),x(sideIndex2),y(sideIndex2),z(sideIndex2));
[dis,sIn]=sort(dis);
sideIndex1=sideIndex1(sIn);
sideIndex2=sideIndex2(sIn);
 


subplot(221);
disX=1:length(dis);
plot(disX,dis,'.-k');

sX=[80,150,200];hold on;plot(disX(sX),dis(sX),'or');
d1=dis(sX(1));
d2=dis(sX(2));
d3=dis(sX(3));
% hold on;plot(disX,dis.*0+median(dis),'--b');

   box on;
    xlabel('index');ylabel('distance');%zlabel('z');
    
    ax = gca;
    ax.XAxis.MinorTick = 'on';
    ax.YAxis.MinorTick = 'on';

    ax.XAxis.TickLength=[0.03,0.03];
    ax.YAxis.TickLength=[0.03,0.03];

LcArr=[d3;d2;d1];
[tri,dis12,dis23,dis13,dis14,dis24,dis34,x,y,z]=ywDelauny1_GetRelationShipXYZ(x,y,z,0);

for(i=1:length(LcArr))
    Lc=LcArr(i);
    sIn1=sideIndex1;
    sIn2=sideIndex2;
    subplot(2,2,i+1);hold on;     plot3(x,y,z,'ok');    
    for(j=1:length(sIn2))
        plot3([x(sIn1(j)) x(sIn2(j))],[y(sIn1(j)) y(sIn2(j))],[z(sIn1(j)) z(sIn2(j))],':k','color',[.5 .5 .5]);
    end
%     m=find(dis>Lc);
%     sIn1(m)=[];
%     sIn2(m)=[];
%     for(j=1:length(sIn2))
%         plot3([x(sIn1(j)) x(sIn2(j))],[y(sIn1(j)) y(sIn2(j))],[z(sIn1(j)) z(sIn2(j))],'o-r');
%     end
    newTri=tri;
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
%     if(ywDraw==1)
%         subplot(2,2,4);hold on;
%         h=trisurf(newTri,x,y,z);
%         set(h,'edgealpha',0,'facealpha',0.3);
%         h=trimesh(newTri,x,y,z);
%         set(h,'edgealpha',1,'facealpha',0);
%         plot3(x,y,z,'.');
%         grid on;view([-46,38]);
%     end
    h=trisurf(newTri,x,y,z);
    set(h,'edgealpha',0,'facealpha',1) ;
    for(j=1:length(newTri))
        if(isnan(newTri(j,1)) || isnan(newTri(j,2)) || isnan(newTri(j,3)) || isnan(newTri(j,4)))
            continue;
        end
        plot3([x(newTri(j,1)) x(newTri(j,2))],[y(newTri(j,1)) y(newTri(j,2))],[z(newTri(j,1)) z(newTri(j,2))],'o-k');
        plot3([x(newTri(j,1)) x(newTri(j,3))],[y(newTri(j,1)) y(newTri(j,3))],[z(newTri(j,1)) z(newTri(j,3))],'o-k');
        plot3([x(newTri(j,1)) x(newTri(j,4))],[y(newTri(j,1)) y(newTri(j,4))],[z(newTri(j,1)) z(newTri(j,4))],'o-k');
        plot3([x(newTri(j,2)) x(newTri(j,3))],[y(newTri(j,2)) y(newTri(j,3))],[z(newTri(j,2)) z(newTri(j,3))],'o-k');
        plot3([x(newTri(j,2)) x(newTri(j,4))],[y(newTri(j,2)) y(newTri(j,4))],[z(newTri(j,2)) z(newTri(j,4))],'o-k');
        plot3([x(newTri(j,3)) x(newTri(j,4))],[y(newTri(j,3)) y(newTri(j,4))],[z(newTri(j,3)) z(newTri(j,4))],'o-k');
    end
    
    grid on;
    view([-25 37]);

    grid on;box on;
    xlabel('x');ylabel('y');zlabel('z');
    
   % xlim([0 1]);ylim([0 1]);zlim([0 1]);
    ax = gca;
    ax.XAxis.MinorTick = 'on';
    %ax.XAxis.MinorTickValues =[0:0.05:1];
    ax.YAxis.MinorTick = 'on';
    %ax.YAxis.MinorTickValues =[0:0.05:1];
    ax.ZAxis.MinorTick = 'on';
    %ax.ZAxis.MinorTickValues =[0:0.05:1];

    ax.XAxis.TickLength=[0.03,0.03];
    ax.YAxis.TickLength=[0.03,0.03];
    ax.ZAxis.TickLength=[0.03,0.03];
end

