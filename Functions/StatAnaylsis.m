function [data_stats, data_stats1] = StatAnaylsis( harvested, stored )
%%Statical Anaylsis - Harvested Power 
h_dstd = std(harvested);
h_dmean = mean(harvested);
h_dev1u = dmean + dstd;
h_dev1d = dmean - dstd;
h_maxv = find(harvested == max(harvested));
h_minv = find(harvested == min(harvested));

%%Statical Anaylsis - Stored Voltage 
p_dstd = std(stored);
p_dmean = mean(stored);
p_dev1u = dmean + dstd;
p_dev1d = dmean - dstd;
p_maxv = find(stored == max(stored));
p_minv = find(stored == min(stored));

%%Info Cell Arrays
n1 = 'HarvestedMean';
% n2 = 'FirstSTD';
n3 = 'MaxPower';
n4 = 'MinPower';
% n5 = 'NaNcount';
n6 = 'MaxHarvested';
n7 = 'MinHarvested';
n8 = 'MeanHarvested';
n9 = 'ShutDowns';
% n10 = 'TotalSDTime';

%               n2,[h_dev1u h_dev1d],...
%               n5,nan_count,...
%  n10,total_shutdown_time...

data_stats = struct(n1,h_dmean,...
              n3,max(harvested),...
              n4,min(harvested),...
              n6,max(harvested),...
              n7,min(harvested),...
              n8,h_dmean,...
              n9,shutdown);


n1 = 'StoredMean';
% n2 = 'FirstSTD';
n3 = 'MaxPower';
n4 = 'MinPower';
% n5 = 'NaNcount';
n6 = 'MaxHarvested';
n7 = 'MinHarvested';
n8 = 'MeanHarvested';
n9 = 'ShutDowns';
% n10 = 'TotalSDTime';

%               n2,[h_dev1u h_dev1d],...
%               n5,nan_count,...
%  n10,total_shutdown_time...

data_stats1 = struct(n1,h_dmean,...
              n3,max(data),...
              n4,min(data),...
              n6,max(harvested),...
              n7,min(harvested),...
              n8,h_dmean,...
              n9,shutdown);

end

