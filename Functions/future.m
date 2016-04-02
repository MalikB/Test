function [time,data] = future( time,data,window,input)

len = length(data);
sd_b = std(data(1:len));

%% Energy Budget
        m = len/window; % number of rows
        m = round(m);
        if isnan(m) || isinf(m)
            m = 5;
        end
        budget = zeros(m,window);
        z = 1;
        for x1 = 1:m
            for y = 1:window
            budget(x1,y) = data(z);
            z = z + 1;
            end
        end

%% Predicitive Algorithims

for x = 1:window
    
    switch input.op
       
        case 'EWMA'
        %%EWMA
        data(len+x) = (exp(-.2312))*data(len+(x-1))+(1-exp(-.2312))*data(len+(x-2));
    % look into diffrent constants
%         for i = 0:3
%     data(len+x) = sum((exp(-.02312))*((1-exp(-.02312))^i)*data((len+(i-1))));
%         end

        case 'Energy Budget'
        %%Energy Budget
        inter_d = sum(budget(m,:))/(window);
        intra_d = sum(budget(:,x))/(m);
        data(len+x) = ( inter_d + intra_d )/2;
     
        otherwise
        %%Pure Average
        data(len+x) = sum(data(1:len))/len;
    end
    time(len+x) = time(len+(x-1))+.5;
end

%% Error Checking
len = length(data);
sd_a = std(data(1:len));
sprintf('Checkign Vaule: %d' ,sd_b - sd_a)

end

