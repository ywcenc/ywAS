clear 
clc
close all

% % % % % x = gallery('uniformdata',[30 1],0);
% % % % % y = gallery('uniformdata',[30 1],1);
% % % % % z = gallery('uniformdata',[30 1],2);
% % % % % 
% x=rand(1,30)';
% y=rand(1,30)';
% z=rand(1,30)';
% xyz=[x,y,z];
% save -ascii xyz.txt xyz
%[x,y,z]=textread('xyz.txt');
[x,y,z]=textread('ywXYZ3D.txt');


DT = delaunayTriangulation(x,y,z);
tri=delaunay(x,y,z);
hp=figure('position',[369    52   717   614]);subplot(221);
plot3(x,y,z,'ok');
grid on;box on;
%     xlim([0 1]);ylim([0 1]);zlim([0 1]);
    ax = gca;
    ax.XAxis.MinorTick = 'on';
%     ax.XAxis.MinorTickValues =[0:0.05:1];
    ax.YAxis.MinorTick = 'on';
%     ax.YAxis.MinorTickValues =[0:0.05:1];
    ax.ZAxis.MinorTick = 'on';
%     ax.ZAxis.MinorTickValues =[0:0.05:1];

    ax.XAxis.TickLength=[0.03,0.03];
    ax.YAxis.TickLength=[0.03,0.03];
    ax.ZAxis.TickLength=[0.03,0.03];

    view([-25 37]);
    xlabel('x');ylabel('y');zlabel('z');
subplot(222);hold on;
    [sideIndex1,sideIndex2]=ywGetSideIndexUsing3DTri(tri);
    hold on;
        sIn1=sideIndex1;
        sIn2=sideIndex2;
    plot3(x,y,z,'ok');
    for(j=1:length(sIn2))
        plot3([x(sIn1(j)) x(sIn2(j))],[y(sIn1(j)) y(sIn2(j))],[z(sIn1(j)) z(sIn2(j))],':k','color',[.5 .5 .5]);
    end
    ax = gca;
    ax.XAxis.MinorTick = 'on';
%     ax.XAxis.MinorTickValues =[0:0.05:1];
    ax.YAxis.MinorTick = 'on';
%     ax.YAxis.MinorTickValues =[0:0.05:1];
    ax.ZAxis.MinorTick = 'on';
%     ax.ZAxis.MinorTickValues =[0:0.05:1];

    ax.XAxis.TickLength=[0.03,0.03];
    ax.YAxis.TickLength=[0.03,0.03];
    ax.ZAxis.TickLength=[0.03,0.03];
    view([-25 37]);
    grid on;box on;
    xlabel('x');ylabel('y');zlabel('z');
    hold on;plot3(x,y,z,'ok');
subplot(223);
ywTetramesh(DT,'FaceAlpha',0.3);
grid on;box on;
%     xlim([0 1]);ylim([0 1]);zlim([0 1]);
    ax = gca;
    ax.XAxis.MinorTick = 'on';
%     ax.XAxis.MinorTickValues =[0:0.05:1];
    ax.YAxis.MinorTick = 'on';
%     ax.YAxis.MinorTickValues =[0:0.05:1];
    ax.ZAxis.MinorTick = 'on';
%     ax.ZAxis.MinorTickValues =[0:0.05:1];

    ax.XAxis.TickLength=[0.03,0.03];
    ax.YAxis.TickLength=[0.03,0.03];
    ax.ZAxis.TickLength=[0.03,0.03];

    view([-25 37]);
    xlabel('x');ylabel('y');zlabel('z');
        hold on;plot3(x,y,z,'ok');
        
        subplot(224);
ywTetramesh(DT,'FaceAlpha',1);
grid on;box on;
%     xlim([0 1]);ylim([0 1]);zlim([0 1]);
    ax = gca;
    ax.XAxis.MinorTick = 'on';
%     ax.XAxis.MinorTickValues =[0:0.05:1];
    ax.YAxis.MinorTick = 'on';
%     ax.YAxis.MinorTickValues =[0:0.05:1];
    ax.ZAxis.MinorTick = 'on';
%     ax.ZAxis.MinorTickValues =[0:0.05:1];

    ax.XAxis.TickLength=[0.03,0.03];
    ax.YAxis.TickLength=[0.03,0.03];
    ax.ZAxis.TickLength=[0.03,0.03];

    view([-25 37]);
    xlabel('x');ylabel('y');zlabel('z');
        hold on;plot3(x,y,z,'ok');

subplot(224);

% subplot(224);
% 
% [K,v] = convexHull(DT);
% trisurf(K,DT.Points(:,1),DT.Points(:,2),DT.Points(:,3));
% grid on;box on;
%     xlim([0 1]);ylim([0 1]);zlim([0 1]);
%     ax = gca;
%     ax.XAxis.MinorTick = 'on';
%     ax.XAxis.MinorTickValues =[0:0.05:1];
%     ax.YAxis.MinorTick = 'on';
%     ax.YAxis.MinorTickValues =[0:0.05:1];
%     ax.ZAxis.MinorTick = 'on';
%     ax.ZAxis.MinorTickValues =[0:0.05:1];
% 
%     ax.XAxis.TickLength=[0.03,0.03];
%     ax.YAxis.TickLength=[0.03,0.03];
%     ax.ZAxis.TickLength=[0.03,0.03];
% 
%     view([-25 37]);
%      xlabel('x');ylabel('y');zlabel('z');
%          hold on;plot3(x,y,z,'ok');
