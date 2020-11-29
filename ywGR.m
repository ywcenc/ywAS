%ywGR

clear
clc
close all

eqtFN='china3ml.eqt';
eqtFN='ãë´¨µØÇø.eqt';
% eqtFN='tangshan.eqt';

startDTArr=[datenum(2008,5,12);datenum(2008,5,27);datenum(2008,5,12)];
endDTArr=[datenum(2008,5,27);datenum(2008,8,12);datenum(2021,5,12)];
McArr=[4;3;2.5];
McArr2=[5.6;5.6;5.5];
% McArr2=[6.4;6.4];

for(i=1:length(startDTArr))
    [eqTime,eqLongi,eqLati,eqMag,eqDepth]=ywReadEQT(eqtFN);
%     m=find(eqTime>=datenum(2008,5,12) & eqTime<=datenum(2008,8,12) & eqLongi>=102 & eqLongi<=110 & eqLati>=30 & eqLati<=34 & eqMag>=3);
    m=find(eqTime>=startDTArr(i) & eqTime<=endDTArr(i) & eqLongi>=102 & eqLongi<=110 & eqLati>=30 & eqLati<=34);% & eqMag>=3);
    eqTime=eqTime(m);   eqLongi=eqLongi(m); eqLati=eqLati(m);   eqMag=eqMag(m); eqDepth=eqDepth(m);

    c=0;
    for(mag=1.0:0.1:7.0)
        c=c+1;
        drawX(c)=mag;
        m=find(eqMag>=mag);
        drawY(c)=length(m);
    end
%     subplot(3,2,(i-1)*2+1);
    figure('position',[200 200 800 320]);%hold on;
    subplot(1,2,1);
    semilogy(drawX,drawY,'ok-','markerfacecolor','w');

    m45=find(drawX>=McArr(i) & drawX<=McArr2(i));
    lineX=drawX(m45);
    lineY=log10(drawY(m45));

    [kb,err]=polyfit(lineX,lineY,1);
    hold on;
    lx2=[McArr(i):0.1:McArr2(i)];
    plot(lx2,10.^(kb(1)*(lx2)+kb(2)),'-r','linewidth',2);
    m4=find(drawX==McArr(i));
    semilogy(drawX(m4),drawY(m4),'ok','markerfacecolor','g');

    legend([{'Frequency-Time'};{'G-R relationship'};{'Mc'}],'location','southwest');
    xlabel('Magnitude(ML)');
    ylabel('Frequency');
    hold off;
    ax = gca;
    ax.XAxis.MinorTick = 'on';
    ax.XAxis.MinorTickValues =[1:0.1:7];
    ax.XAxis.TickLength=[0.03,0.03];
    ax.YAxis.TickLength=[0.03,0.03];
    ylim([0.5 1500]);
    xlim([0.9 7.1]);
    
    subplot(1,2,2);
    plot(drawX,drawY,'ok-','markerfacecolor','w');
    m45=find(drawX>=McArr(i) & drawX<=McArr2(i));
    lineX=drawX(m45);
    lineY=log10(drawY(m45));

    [kb,err]=polyfit(lineX,lineY,1);
    hold on;
    lx2=[1:0.1:7];
    kb
    plot(lx2,10.^(kb(1)*(lx2)+kb(2)),'-b','linewidth',2);
    
%     lx2=[McArr(i):0.1:McArr2(i)];
%     kb
%     plot(lx2,10.^(kb(1)*(lx2)+kb(2)),'-r','linewidth',2);

    m4=find(drawX==McArr(i));
    plot(drawX(m4),drawY(m4),'ok','markerfacecolor','g');

    legend([{'Frequency-Time'};{'G-R relationship'};{'Mc'};]);
    xlabel('Magnitude(ML)');
    ylabel('Frequency');
    hold off;
    ylim([-100 1500]);    xlim([0.9 7.1]);

    ax = gca;
    ax.XAxis.MinorTick = 'on';
    ax.XAxis.MinorTickValues =[1:0.1:7];
    ax.YAxis.MinorTick = 'on';
    ax.YAxis.MinorTickValues =[0:100:1500];
    ax.XAxis.TickLength=[0.03,0.03];
    ax.YAxis.TickLength=[0.03,0.03];
end

