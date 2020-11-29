%
% ———分隔线————使用方法：
% clc;
% clear all;
% 
% x=0:0.1:5;
% y=cos(x);
% figure(1);clf;
% plot(x,y,'ko-')
% dxyMINOR(2,2)% nx,ny >0即可。若只需其中一个轴显示minortick,让另一个轴的nx或ny取为1。
                    % 例如dxyMINOR(1,2),则只有y轴显示minortick
                    %



function dxyMINOR(nx,ny)
%nx指定x轴主刻度间分开小刻度的份数
%ny指定y轴主刻度间分开小刻度的份数
%     引用实例
%     dxyMINOR(10,1)% nx,ny >0即可。若只需其中一个轴显示minortick,让另一个轴的nx或ny取为1。
                    % 例如dxyMINOR(1,2),则只有y轴显示minortick
                    

    ax = gca;

    %XY limit value

    xlim = ax.XLim;

    ylim = ax.YLim;

    %XY tick value

    xtick = ax.XTick;

    ytick = ax.YTick;

    %XY dtick

    dxtick = (xtick(2) - xtick(1));

    dytick = (ytick(2) - ytick(1));

    %XY minortick interval

    dmx = dxtick/nx;

    dmy = dytick/ny;

    %XY minortick value

    ax.XAxis.MinorTick = 'on';

    ax.XAxis.MinorTickValues = [xtick(1):dmx:xtick(end)];

    ax.YAxis.MinorTick = 'on';

    ax.YAxis.MinorTickValues = [ytick(1):dmy:ytick(end)];

    % first element is for 2d fig ticklength

    ax.TickLength = [0.015,0.05];

end