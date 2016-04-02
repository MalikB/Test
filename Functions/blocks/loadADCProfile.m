function adcProfile = loadADCProfile(fname)
%{
ADC profile format
adcProfile.xlsx
Header:
SensorName | operationVoltage(V) | Current(A) | Power (W) I info
%}
adcProfile = [];
[num txt raw] = xlsread(fname);
txt = txt(2:end, 1);
powerGiven = ~isnan(num(:,3));
for i = 1:length(num(:,1))
    adcProfile(i).name = txt{i};
    if powerGiven(i)
        pwr = num(i,3);
    else
        pwr = num(i,1)*num(i,2);
    end
    adcProfile(i).power = pwr;
    adcProfile(i).info = raw{i+1,4};
    
end
end