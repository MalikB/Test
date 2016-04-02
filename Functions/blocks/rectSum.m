function rsum = rectSum(x,y, mode)
[x, id] = sort(x);
y = y(id);
switch mode
    case 'l'
        yy = y(1:end-1);
    case 'r'
        yy = y(2:end);
    case 'm'
        yy = y(1:end-1) + diff(y) / 2;
    otherwise
        yy = y(1:end-1);
end
xx = diff(x);
areaVec = xx .* yy;
rsum = cumsum(areaVec);
end