% findN(eAv, config) debugging
clear
setup
eAv = linspace(-1, 1, 1000);
nVals = [];
for i = 1:1000
    nVals = [nVals double(findN(eAv(i),config))];
end
plot(eAv, nVals)
