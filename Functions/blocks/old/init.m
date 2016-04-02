function config = init(windowLength);
    %% General MCU operation
    config.vIn = 3;
    config.LPM = 0;
    config.f_oco = 8e6;
    config.I_active = 1220e-6;
    config.windowLength = 5*60; %seconds

    config.adcProfile = loadADCProfile('sensorProfile.xlsx');
    config.numSamp = length(config.adcProfile); %# of sensors attached = # of samples for each reading

    %% Radio Operation

    config.power = 0; % dBm
    config.mode = 1; %parameter specifies allowed sensitivity (1 or 2);
    config.dataRate = 1e3; %bits/sec
%     config.T_tx = 5; % length period of Radio (sec) = cycle length = windowLength / k where k = % of cycles
%     config.k = 5;
end