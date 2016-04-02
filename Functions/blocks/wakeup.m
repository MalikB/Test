function [energy, time] = wakeup(config)
%{
USAGE:
energy = total energy expended upon wakeup
time = total wakeup time

LPM = power mode from which MCU wakes up into active mode
f_oco = oscillator frequency
I_active = MCU active current
vIn = MCU operating voltage
%}
%wake MCU from rest mode
switch(config.LPM)
    %{
        I_LPM = low power mode current
        tWake = wakeup time from LPM
        qWake = charge used when waking up; E = qWake*vIn
    %}
    case 'active'
        I_LPM = 0;
        tWake = 0;
        qWake = 0;
        tFRAM = 0;
    case {0, 'idle', 'IDLE'}
        I_LPM = 165e-6;
        tWake = (.4e-6 + 1.5e-6/config.f_oco);
        qWake = 4.4e-9;
        tFRAM = 0; %sec
    case {3,4,'standby', 'STANDBY'}
        I_LPM = .7e-6;
        tWake = 10e-6;
        qWake = 16.5e-9;
        tFRAM = 10e-6;
    otherwise
        I_LPM = .7e-6;
        tWake = 10e-6;
        qWake = 16.5e-9; 
        tFRAM = 10e-6;
end
energy = config.vIn * (qWake + config.I_active*tFRAM); %energy used to start MCU and configure FRAM;
time = tWake + tFRAM; %time to switch to active mode and configure FRAM
end
