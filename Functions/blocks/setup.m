%% Set Up Environment
digits(128); %calculate at higher precision
%% General MCU operation
config.vIn = 2.2;
config.LPM = 3;
config.f_oco = 8e6;
config.I_active = 1220e-6;
config.eThreshold  = .32;

%config.windowLength = 5*60; %seconds

%% Sampling Operation
config.adcProfile = loadADCProfile('sensorProfile.xlsx');
config.trials = 10; %number of readings each sensor makes at a time
config.numSamp = length(config.adcProfile); %# of sensors attached = # of samples for each reading
config.adcTime = 3e-6; % seconds

%% Radio Operation

config.power = 0; % dBm
config.mode = 1; %parameter specifies allowed sensitivity (1 or 2);
config.dataRate = 1e3; %bits/sec
config.T_tx = 5*60; % length period of Radio (sec) = cycle length = windowLength / k where k = % of cycles
config.k = 3; 
config.txDataParam = 0; % 1 transmit samples from all trials 0 transmit average
config.trxLPM = 1;
%{
0 1.5e-3; %A TRX idle
1 160e-6; %A TRX sleep digital ON
2 .4e-6; %A, digital voltage reg OFF
3 8 uA auto RX polling every second
%}