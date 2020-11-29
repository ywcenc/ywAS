%
clear
clc
close all

c=4;
x=rand(1,c);
y=rand(1,c);
z=rand(1,c);
tri=delaunay(x,y,z);
[sideIndex1,sideIndex2]=ywGetSideIndexUsing3DTri(tri);

hold on;
sIn1=sideIndex1;
sIn2=sideIndex2;
plot3(x,y,z,'o');
for(j=1:length(sIn2))
    plot3([x(sIn1(j)) x(sIn2(j))],[y(sIn1(j)) y(sIn2(j))],[z(sIn1(j)) z(sIn2(j))],'o-r');
end

tri(1,1)=nan;
[sideIndex1,sideIndex2]=ywGetSideIndexUsing3DTri(tri);

sIn1=sideIndex1;
sIn2=sideIndex2;
% plot3(x,y,z,'o');
for(j=1:length(sIn2))
    if(isnan(sIn1(j)) || isnan(sIn2(j)))
        continue;
    end
    plot3([x(sIn1(j)) x(sIn2(j))],[y(sIn1(j)) y(sIn2(j))],[z(sIn1(j)) z(sIn2(j))],'o-b');
end

grid on;view([-46,38]);



% % % ���⣬�ѿرȽ��ϸ�
% % % ����ʮ�����ݽ���
% % % ��������ڶ�û�ˣ��ǲ����е�©���ˣ�
% % % �������кܶ�������
% % % �ϲ�+GNSS���ݽ���,
% % % ���ٷ�����
