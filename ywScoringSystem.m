%Õ÷‘≤-scoring system
clear
clc
close all
figure('position',[403   246   480   420]);

t=[0:0.1:2*pi];
rgX=0.3*cos(t);
rgY=0.2*sin(t);


% x=rand(1,10)-0.5;
% y=rand(1,10)-0.5;
% x2=(rand(1,10)-0.5)/2;
% y2=(rand(1,10)-0.5)/4;
% x=[x x2];
% y=[y y2];
% xyScoringSystem=[x',y'];
% save -ascii xyScoringSystem.txt xyScoringSystem
[x,y]=textread('xyScoringSystem.txt');

subplot(221);hold on
plot(rgX,rgY,'k');
plot(x,y,'ob');
[in]=inpolygon(x,y,rgX,rgY);
plot(x(in),y(in),'or');
plot(x,y,'.k');
xlim([-0.6 0.6]);ylim([-0.6 0.6]);
axis equal
box on;
ax = gca;
ax.XAxis.MinorTick = 'on';
%ax.XAxis.MinorTickValues =[-1:1:51];
ax.YAxis.MinorTick = 'on';
%ax.YAxis.MinorTickValues =[-0.1:0.02:1];
ax.XAxis.TickLength=[0.04,0.04];
ax.YAxis.TickLength=[0.04,0.04];
%grid minor
xlabel('x');ylabel('y');


subplot(222);hold on
plot(rgX,rgY,'k');
plot(x,y,'ob');
[in]=inpolygon(x,y,rgX,rgY);
plot(x(in),y(in),'or');
plot(x,y,'xk');
xlim([-0.6 0.6]);ylim([-0.6 0.6]);
axis equal
box on;
ax = gca;
ax.XAxis.MinorTick = 'on';
%ax.XAxis.MinorTickValues =[-1:1:51];
ax.YAxis.MinorTick = 'on';
%ax.YAxis.MinorTickValues =[-0.1:0.02:1];
ax.XAxis.TickLength=[0.04,0.04];
ax.YAxis.TickLength=[0.04,0.04];
%grid minor
xlabel('x');ylabel('y');


subplot(223);hold on
plot(rgX,rgY,'k');
plot(x,y,'ob');
[in]=inpolygon(x,y,rgX,rgY);
plot(x(in),y(in),'or');
plot(x(in),y(in),'xk');
plot(x(~in),y(~in),'.k');

xlim([-0.6 0.6]);ylim([-0.6 0.6]);
axis equal
box on;
ax = gca;
ax.XAxis.MinorTick = 'on';
%ax.XAxis.MinorTickValues =[-1:1:51];
ax.YAxis.MinorTick = 'on';
%ax.YAxis.MinorTickValues =[-0.1:0.02:1];
ax.XAxis.TickLength=[0.04,0.04];
ax.YAxis.TickLength=[0.04,0.04];
%grid minor
xlabel('x');ylabel('y');


subplot(224);hold on
plot(rgX,rgY,'k');
plot(x,y,'ob');
[in]=inpolygon(x,y,rgX,rgY);
plot(x(in),y(in),'or');
plot(x(in),y(in),'.k');
plot(x(~in),y(~in),'xk');

xlim([-0.6 0.6]);ylim([-0.6 0.6]);
axis equal
box on;
ax = gca;
ax.XAxis.MinorTick = 'on';
%ax.XAxis.MinorTickValues =[-1:1:51];
ax.YAxis.MinorTick = 'on';
%ax.YAxis.MinorTickValues =[-0.1:0.02:1];
ax.XAxis.TickLength=[0.04,0.04];
ax.YAxis.TickLength=[0.04,0.04];
%grid minor
xlabel('x');ylabel('y');
