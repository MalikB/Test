function Histogram( data,file_name )
%% Histogram - Harvested Power
mp = max(data);

pl1 = input('Max Power to Sustain Sleep Power (mW):');
if isempty(pl1)
          pl1 = .05*mp;
end
pl2 = input('Max Power to Sustain Low Power (mW):');
if isempty(pl2)
          pl2 = .25*mp;
end
pl3 = input('Max Power to Sustain High Power (mW):');
if isempty(pl3)
          pl3 = .75*mp;
end
 
p_levels = discretize(h_power,[0 pl1 pl2 pl3 mp],'categorical',{'Low Power','Low Power2','Reg. Power','High Power'});


    figure
    pie(p_levels)
    hold on
    title(['Power Ranges' ': ' file_name ])
    %  Add legend HERE --->>

    figure
    power_d = histogram(h_power);
    power_d.Normalization = 'countdensity';
    ylim([0 (ms/1e6)])
    xlim([0 mp])
    title(['Power Distribution' ': ' file_name ])
    xlabel('Power Levels')
    ylabel('Time(minutes)')
    axis tight



end

