function [ E_av , budget] = Trace_Eav( data,win )
    len = length(data);
    m = len/win; % number of rows
    m = round(m);
    if isnan(m) || isinf(m)
        m = 5;
    end
    E_av = zeros(1,m);
    n = win;
    budget = zeros(m,n);
    z = 1;
    for x1 = 1:m
        for y = 1:n
            if z > len
                z = len;
            end
        budget(x1,y) = data(z);
        z = z + 1;
        end
        E_av(x1) = sum(budget(x1,1:n));
    end
end

