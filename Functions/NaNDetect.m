function [ data ] = NaNDetect( data)
%% NaN Sequence Detection & NaN Removal in Data Set
len = length(data);
nan_count = 0;
shutdown = 0;
shutdown_times = [];
shutdown_limit = 10; % set to number of point corresposing to time i.e.(5 minutes = 10 points)
x1 = 1;

for x = 1:len
   if isnan(data(x)) == 1
       nan_count = nan_count+1;
       if x == 1
           data(x) = 0;
%        elseif x <= (win+1)
%            data(x) = data(x-1);
       else
           sta = x - 4; % look back two minutes
           if sta < 1 || sta == 0
               sta = 1;
           end
           fin = x - 1;
           data(x)= mean(data(sta:fin));
       end
       
       if nan_count == shutdown_limit;
           shutdown = shutdown+1;
       end
       if nan_count > shutdown_limit;
           shutdown_times(x1) = x;
           x1 = x1+1;
       end
   else
       if nan_count > 0
            nan_count = 0;
       end
   end
end

%total_shutdown_time = length(shutdown_times) *30;

end

