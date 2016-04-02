function [ averaged_data ] = MovingAverage( data,win )

% win = input('How many points would you like to average along or percentage of total points in the data set? ' );

len = length(data);
averaged_data = zeros(len,1);

if win == 0
    win = 50;
elseif isempty(win)
    win = 50;
end

%% Moving Average
for x = 1:len
    b = x+win;
    if b >= len
        b = len;
    end
    
    a = data(x:b);
        averaged_data(x) =  1/win * sum(a,'default');
        
%    if isnan(data(x)) == 1
%        data(x)= average_data(x-1);
%    end
end

%% Data Crunch - Rate of Change Calculations 
% x = 2;
% while x <= l
%      roc(x-1) = (s_power(x) - s_power(x-1))/(s_sec(x) - s_sec(x-1));
%      roc2(x-1) = (trend(x) - trend(x-1))/(s_sec(x) - s_sec(x-1));
%      x=x+1;
% end

end

