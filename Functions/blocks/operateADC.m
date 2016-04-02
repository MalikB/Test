 function [eTot, tADC, bytes] = operateADC(config)
    %sensorProfile = loadADCProfile(profileName);
    numSens = length(config.adcProfile);
    [eADC, tADC, bytes]= adcRead(config.vIn, config.trials*numSens); %trials is the number of readings each sensor does at a time
    eSens = sum([config.adcProfile(:).power]) * config.adcTime; %takes 3 microseconds to operate ADC
    eTot = eADC + eSens;
end