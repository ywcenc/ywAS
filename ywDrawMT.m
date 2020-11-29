

%ywGR

clear
clc
close all

eqtFN='china3ml.eqt';
eqtFN='ãë´¨µØÇø.eqt';

startDTArr=[datenum(2008,5,12)];
endDTArr=[datenum(2008,8,12)];
McArr=[1];
McArr2=[8.5];
dt0=datenum(2008,5,12);
for(i=1:length(startDTArr))
    [eqTime,eqLongi,eqLati,eqMag,eqDepth]=ywReadEQT(eqtFN);
%     m=find(eqTime>=datenum(2008,5,12) & eqTime<=datenum(2008,8,12) & eqLongi>=102 & eqLongi<=110 & eqLati>=30 & eqLati<=34 & eqMag>=3);
    m=find(eqTime>=startDTArr(i) & eqTime<=endDTArr(i) & eqLongi>=102 & eqLongi<=110 & eqLati>=30 & eqLati<=34 & eqMag>=1);
    eqTime=eqTime(m);   eqLongi=eqLongi(m); eqLati=eqLati(m);   eqMag=eqMag(m); eqDepth=eqDepth(m);

    figure('position',[200 200 800 420]);hold on;box on;

    m=find(eqMag>=1 & eqMag<2);
    plot(eqTime(m)-dt0,eqMag(m),'.','color',[.5 .5 .5]);
    m=find(eqMag>=2 & eqMag<3);
    plot(eqTime(m)-dt0,eqMag(m),'.k');
    m=find(eqMag>=3 & eqMag<4);
    plot(eqTime(m)-dt0,eqMag(m),'.c');
    m=find(eqMag>=4 & eqMag<5);
    plot(eqTime(m)-dt0,eqMag(m),'.b');
    m=find(eqMag>=5 & eqMag<16);
    plot(eqTime(m)-dt0,eqMag(m),'.r');
    
    ax = gca;
    ax.XAxis.MinorTick = 'on';
%     ax.XAxis.MinorTickValues =[datenum(2008,5,12):datenum(2008,8,21)];
    ax.XAxis.MinorTickValues =[0:1:100];
    ax.YAxis.MinorTick = 'on';
    ax.YAxis.MinorTickValues =[1:0.1:8.5];
    ax.XAxis.TickLength=[0.012,0.012];
    ax.YAxis.TickLength=[0.012,0.012];
%     datetick('x','mm-dd');    
    ylim([0.8 8.5]);
    xlim([-1 94]);
    grid on;
    legend([{'1.0¡ÜM£¼2.0'};{'2.0¡ÜM£¼3.0'};{'3.0¡ÜM£¼4.0'};{'4.0¡ÜM£¼5.0'};{'5.0¡ÜM'}],'Orientation','horizon');
    xlabel('Number of days since 2008-5-12');
    ylabel('Magnitude(ML)');
    
    
    figure('position',[200 200 800 420]);hold on;box on;

    m=find(eqMag>=1 & eqMag<2);
    plot3(eqLongi(m),eqLati(m),eqTime(m)-dt0,'.','color',[.5 .5 .5]);
    m=find(eqMag>=2 & eqMag<3);
    plot3(eqLongi(m),eqLati(m),eqTime(m)-dt0,'.k');
    m=find(eqMag>=3 & eqMag<4);
    plot3(eqLongi(m),eqLati(m),eqTime(m)-dt0,'.c');
    m=find(eqMag>=4 & eqMag<5);
    plot3(eqLongi(m),eqLati(m),eqTime(m)-dt0,'.b');
    m=find(eqMag>=5 & eqMag<16);
    plot3(eqLongi(m),eqLati(m),eqTime(m)-dt0,'.r');
    
    
    ax = gca;
    ax.XAxis.MinorTick = 'on';
%     ax.XAxis.MinorTickValues =[0:1:100];
    ax.YAxis.MinorTick = 'on';
    ax.ZAxis.MinorTick = 'on';
    ax.XAxis.MinorTickValues =[102:0.1:110];
    ax.YAxis.MinorTickValues =[28:0.1:36];

    ax.ZAxis.MinorTickValues =[0:10:94];
    ax.ZAxis.TickLength=[0.05,0.05];
    %ax.ZAxis.TickLength=[0.012,0.012];
    axis equal
    grid on;
    legend([{'1.0¡ÜM£¼2.0'};{'2.0¡ÜM£¼3.0'};{'3.0¡ÜM£¼4.0'};{'4.0¡ÜM£¼5.0'};{'5.0¡ÜM'}],'Orientation','horizon');
    xlabel('Longitude(¡ã)');
    ylabel('Latitude(¡ã)');
    
    faultFN='chinafault.MIF.matlab';
    [ftLongi,ftLati]=textread(faultFN,'%f%f');
    hold on;plot3(ftLongi,ftLati,ftLongi.*0+100,'color',[165, 42, 42]./255);
    xlim([101.9 110.1]);ylim([29.8 34.2]);
end

