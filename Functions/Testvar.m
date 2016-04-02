power
samp_power = zeros(100,1);
a = samp_power(x:b);
        trend(x) =  1/win * sum(a,'default');




% vl = length(b);
% % dvar = var(b(1:vl));
% % while isnan(dvar)
% %     vl = vl - 1e3;
% %     dvar = var(b(1:vl));
% % end
% %% NaN Test
% y = length(b);
% xx = zeros(1,length(b));
% x = 1;
% while x <= y
%    if isnan(b(x)) == 1
%        xx(x) = 1;
%    end
%     x=x+1;
% end
% %% Ranged Max Test & Stat Anaylsis
% r = 70;
% aa1 = find(b >= (r/100)*max(c));
% time = (length(aa1)*30)/3600; % unit: Hours
% time
% dmean_max = mean(b(aa1))
% dstd_max = std(b(aa1));
% dev1u_max = dmean_max + dstd_max
% dev1d_max = dmean_max - dstd_max
% %% Storage test
% Voltage = importdata('voltage.mat'); 
% Avoltage = cell2mat(Voltage);
% 
% import_t = importdata('stepTime.mat'); 
% Atime = cell2mat(import_t);

