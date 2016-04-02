function [time,samp_power,h_power,data] = ReadData( file_name,lineskp,damp,period,HT)

% % fid = fopen(file_name);
% % data = textscan(fid,'%d%f%*[^\n]','delimiter','\t','headliners',lineskp);
% % fclose(fid)

%% Input Default
if nargin <= 4
    HT = 'solar';
elseif nargin <= 3
    period = 'h';
    HT = 'solar';
elseif nargin <=2
    period = 'h';
    damp = 0;
    HT = 'solar';
elseif nargin <=1
    period = 'h';
    damp = 0;
    HT = 'solar';
    lineskp = 1 ;
elseif nargin <= 0
    period = 'h';
    damp = 0;
    HT = 'solar';
    lineskp = 1 ;
    file_name = 'mobile-car-test.txt.';
end


%% TXT File read
[sec,power] = textread(file_name,'%d%f%*[^\n]','delimiter','\t','headerlines',lineskp);
%% User Input
do_plot = input('Plot or Run? [p/r]','s');
xls_make = input('Make a csv file for this data? [y/n] \n Will contain all values decribed in Read Me File organized by columns.','s');
%% Consants Detrimined

if period == 0
    skip = 1;
elseif period == 1
    skip = 2;
elseif period == 5
    skip = 10;
elseif period == 10
    skip = 20;
elseif period == 30
    skip = 60;
elseif period == 'h' || period == 60
    skip = 120;
else
    skip = 1;
end

window = input('How long is your window?(units: sec, smallest window = 30 seconds))');
window = window * period;

len = length(sec);
time = sec(1:skip:len);
ms = max(time);



len = length(power);
samp_power = power(1:skip:len);
len_o = length(samp_power);
% roc = zeros(l,1);
% roc2 = zeros(l,1);
trend = zeros(len_o,1);

if damp == 0 
    win = 50;
else
    damp = damp/100;
    win = round(damp*len_o);
end

%% NaN Sequence Detection & NaN Removal in Data Set
nan_count = 0;
shutdown = 0;
shutdown_times = [];
shutdown_limit = period;
g_count = 0 ;
x1 = 1;
for x = 1:len_o 
   if isnan(samp_power(x)) == 1
       g_count = g_count+1;
       nan_count = nan_count+1;
       if x == 1
           samp_power(x) = 0;
       elseif (win+1)>= x
           samp_power(x)= samp_power(x-1);
       else
           sta = x - (win+1);
           fin = x - 1;
           samp_power(x)= mean(samp_power(sta:fin));
       end
       if g_count == shutdown_limit;
           shutdown = shutdown+1;
       end
       if g_count > shutdown_limit;
           shutdown_times(x1) = x;
           x1 = x1+1;
       end
   else
       if g_count > 0
            g_count = 0;
       end
   end
end

total_shutdown_time = length(shutdown_times) *30;

% plot(time,samp_power,'y')
%% Prediction Algorithm 
[samp_power,time] = future(time,samp_power,period,len,window);
len = length(samp_power);
% figure
% plot(time,samp_power,'r')
%% Data Crunch - Running Average
for x = 1:len
    b = x+win;
    if b >= len
        b = len;
    end
    
    a = samp_power(x:b);
        trend(x) =  1/win * sum(a,'default');
        
   if isnan(samp_power(x)) == 1
       samp_power(x)= trend(x-1);
   end
  
end

%% Data Crunch - Rate of Change Calculations 
% x = 2;
% while x <= l
%      roc(x-1) = (s_power(x) - s_power(x-1))/(s_sec(x) - s_sec(x-1));
%      roc2(x-1) = (trend(x) - trend(x-1))/(s_sec(x) - s_sec(x-1));
%      x=x+1;
% end

%% Power Harvested - In Watts
h_power = harvested(samp_power,HT,len);

%% Stored Power
e_stored = storage(h_power,len);

%% Statical Anaylsis
dvar = var(samp_power);
dstd = std(samp_power);
dmean = mean(samp_power);
dev1u = dmean + dstd;
dev1d = dmean - dstd;

maxv = find(samp_power == max(samp_power));
minv = find(samp_power == min(samp_power));

% maxv2 = find(trend == max(trend));
% minv2 = find(trend == min(trend));

%%Statical Anaylsis - Harvested Power 
h_dstd = std(h_power);
h_dmean = mean(h_power);
h_dev1u = dmean + dstd;
h_dev1d = dmean - dstd;
h_maxv = find(h_power == max(h_power));
h_minv = find(h_power == min(h_power));

%%Statical Anaylsis - Stored Voltage 
p_dstd = std(h_power);
p_dmean = mean(h_power);
p_dev1u = dmean + dstd;
p_dev1d = dmean - dstd;
p_maxv = find(h_power == max(h_power));
p_minv = find(h_power == min(h_power));

ms = max(time);
mp = max(h_power);

%% Histogram - Harvested Power
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
% C = categorical(b,[0 pr1 pr2 mp],{'Low Power', 'Reg. Power','Reg. Power2', 'High Power'}, 'Ordinal',true);

% histogram(C)
% N = countcats(C);
% pareto(N,C)

%% Info Cell Arrays
n1 = 'HarvestedMean';
% n2 = 'FirstSTD';
n3 = 'MaxPower';
n4 = 'MinPower';
n5 = 'NaNcount';
n6 = 'MaxHarvested';
n7 = 'MinHarvested';
n8 = 'MeanHarvested';
n9 = 'ShutDowns';
n10 = 'TotalSDTime';

%               n2,[h_dev1u h_dev1d],...

data = struct(n1,h_dmean,...
              n3,max(samp_power),...
              n4,min(samp_power),...
              n5,nan_count,...
              n6,max(h_power),...
              n7,min(h_power),...
              n8,h_dmean,...
              n9,shutdown,...
              n10,total_shutdown_time...
              );

%{
          DATA SET FOR STORED AND PREDICTIVE POWER SET?
n1 = 'HarvestedMean';
% n2 = 'FirstSTD';
n3 = 'MaxPower';
n4 = 'MinPower';
n5 = 'NaNcount';
n6 = 'MaxHarvested';
n7 = 'MinHarvested';
n8 = 'MeanHarvested';
n9 = 'ShutDowns';
n10 = 'TotalSDTime';

%               n2,[h_dev1u h_dev1d],...

data = struct(n1,h_dmean,...
              n3,max(samp_power),...
              n4,min(samp_power),...
              n5,nan_count,...
              n6,max(h_power),...
              n7,min(h_power),...
              n8,h_dmean,...
              n9,shutdown,...
              n10,total_shutdown_time...
              );
 %}         
%% PLOTING
% % Lables, max, min, power and rate of change plotted, Averaged plot shoing
% % trends as well as varinacne

if strcmp(do_plot,'p')
% PLOTS THE DETECTED POWER FROM THE SYSTEM & SMOOTHED CURVE SHOWING TREND
    plot(time,samp_power,'r')
      hax=axes;
    hold on
    plot(time,trend,'c')
    plot(time(maxv),samp_power(maxv),'kd')
    plot(time(minv),samp_power(minv),'md')
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


%     %%Plotting - Harvested Power
%     figure
% % PLOTS THE EXPECTED HARVESTED POWER FROM CONVERSION - SEE FUNCTION harvested
%     plot(time,h_power,'r')
%     hold on
%     plot(time(h_maxv),h_power(h_maxv),'kd')
%     plot(time(h_minv),h_power(h_minv),'md')
%     line([0 ms],[h_dmean h_dmean], 'Color','g','LineStyle','--');
%     %line([0 ms],[h_dev1d h_dev1d], 'Color','b','LineStyle','--');
%     %line([0 ms],[h_dev1u h_dev1u], 'Color','b','LineStyle','--');
%     plot(time(shutdown_times),h_power(shutdown_times),'rx')
%     hold off
%     axis tight
%     title(['Harvested Power' ': ' file_name ])
%     xlabel('Time (minutes)')
%     ylabel('Power Harvested (W)')
%     %  Add legend HERE --->>
%     legend('show')

    %%Plotting - SuperCap Voltage
    figure
    hax=axes;
% PLOTS THE STORED VOLTAGE IN THE SUPERCAP - SEE FUNCTION p_stored
    hold on    
    plot(time,e_stored,'r')
    plot(time(p_maxv),e_stored(p_maxv),'kd')
    plot(time(p_minv),e_stored(p_minv),'md')
    line([0 ms],[p_dmean p_dmean], 'Color','g','LineStyle','--');
    line([0 ms],[h_dev1d h_dev1d], 'Color','b','LineStyle','--');
    line([0 ms],[h_dev1u h_dev1u], 'Color','b','LineStyle','--');
    line([time(len_o) time(len_o)],get(hax,'YLim'),'Color','r','LineStyle','--');
    plot(time(shutdown_times),e_stored(shutdown_times),'rx')
    hold off
    axis tight
    ylim auto %([0 10])
    title(['Stored Voltage' ': ' file_name ])
    xlabel('Time (minutes)')
    ylabel('Voltage Collected (V)')
    %  Add legend HERE --->>
%     legend('show')
    
%     figure
%     pie(p_levels)
%     hold on
%     title(['Power Ranges' ': ' file_name ])
%     %  Add legend HERE --->>
% 
%     figure
%     power_d = histogram(h_power);
%     power_d.Normalization = 'countdensity';
%     ylim([0 (ms/1e6)])
%     xlim([0 mp])
%     title(['Power Distribution' ': ' file_name ])
%     xlabel('Power Levels')
%     ylabel('Time(minutes)')
%     axis tight
end
%% XLS File Creation
if strcmp(xls_make,'y')
    new_filename = ['ANALYSIS_OF_' file_name '.xlsx'];
    Info_Title = {'Time(sec)','Power Detected(mW)','Power Harvested(W)', 'Voltage Collected (V)'};
    [rstatus,rmessage] = xlswrite(new_filename,Info_Title,'A1');
    Info = [time, samp_power, h_power, e_stored];
    [rstatus1,rmessage1] = xlswrite(new_filename,Info,'A2');
    if rstatus && rstatus1 == 1
        rstatus = 'xls file write on sheet 1 was good';
        rstatus
    else
    rmessage
    rmessage1
    end
    [rstatus,rmessage] = xlswrite(new_filename,struct2cell(data),'E1');
    [rstatus1,rmessage1] = xlswrite(new_filename,fieldnames(data),'F1');
    if rstatus && rstatus1 == 1
        rstatus = 'xls file write on sheet 2 was good';
        rstatus
    else
    rmessage
    rmessage1
    end
end
%% Print Values - for Debugging
samp_power(112)
end