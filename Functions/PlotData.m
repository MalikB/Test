function PlotData( time, data, h_power, stored, Eav, data_stat, data_stat1 )

ms = max(time);
mp = max(data);
len = length(time);

if strcmp(do_plot,'p')
% PLOTS THE DETECTED POWER FROM THE SYSTEM & SMOOTHED CURVE SHOWING TREND
    plot(time,data,'r')
      hax=axes;
    hold on
    plot(time,trend,'c')
    plot(time(maxv),data(maxv),'kd')
    plot(time(minv),data(minv),'md')
% %     plot(time(maxv2),trend(maxv2),'kd')
% %     plot(time(minv2),trend(minv2),'md')
    line([time(len_o) time(len_o)],get(hax,'YLim'),'Color','r','LineStyle','--');
    line([0 ms],[dmean dmean], 'Color','g','LineStyle','--');
    line([0 ms],[dev1d dev1d], 'Color','b','LineStyle','--');
    line([0 ms],[dev1u dev1u], 'Color','b','LineStyle','--');
    hold off
    axis tight
    title(['Raw Data Trace & Trend' ': ' file_name ])
    xlabel(['Time (minutes)'])
    ylabel('Irradiance (mW/cm^2)')
    %  Add legend HERE --->>


    %%Plotting - Harvested Power
    figure
% PLOTS THE EXPECTED HARVESTED POWER FROM CONVERSION - SEE FUNCTION harvested
    plot(time,h_power,'r')
    hold on
    plot(time(h_maxv),h_power(h_maxv),'kd')
    plot(time(h_minv),h_power(h_minv),'md')
    line([0 ms],[h_dmean h_dmean], 'Color','g','LineStyle','--');
    %line([0 ms],[h_dev1d h_dev1d], 'Color','b','LineStyle','--');
    %line([0 ms],[h_dev1u h_dev1u], 'Color','b','LineStyle','--');
    plot(time(shutdown_times),h_power(shutdown_times),'rx')
    hold off
    axis tight
    title(['Harvested Power' ': ' file_name ])
    xlabel('Time (minutes)')
    ylabel('Power Harvested (W)')
    %  Add legend HERE --->>
    legend('show')

    %%Plotting - SuperCap Voltage
    figure
    hax=axes;
% PLOTS THE STORED VOLTAGE IN THE SUPERCAP - SEE FUNCTION p_stored
    hold on    
    plot(time,stored,'r')
    plot(time(p_maxv),stored(p_maxv),'kd')
    plot(time(p_minv),stored(p_minv),'md')
    line([0 ms],[p_dmean p_dmean], 'Color','g','LineStyle','--');
    line([0 ms],[p_dev1d p_dev1d], 'Color','b','LineStyle','--');
    line([0 ms],[p_dev1u p_dev1u], 'Color','b','LineStyle','--');
    line([time(len) time(len)],get(hax,'YLim'),'Color','r','LineStyle','--');
    plot(time(shutdown_times),stored(shutdown_times),'rx')
    hold off
    axis tight
    ylim auto %([0 10])
    title(['Stored Voltage' ': ' file_name ])
    xlabel('Time (minutes)')
    ylabel('Voltage Collected (V)')
    %  Add legend HERE --->>
%     legend('show')
    
end

end

