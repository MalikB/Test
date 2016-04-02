function [energy time bytes] = processBlock(LPM, vIn, action, varargin)

%{
Daniil Budanov 2016
processBlock returns the energy expenditures for the
    MSP430FR59x MCU

USAGE:
[energy time] = processBlock(LPM, vIn, action, ARGS)

[energy time] = processBlock(LPM, vIn, 'sample')
or
[energy time] = processBlock(LPM, vIn, 'sample', numReadings)

[energy time] = processBlock(LPM, vIn, 'tx', numBytes, dataRate)
[energy time] = processBlock(LPM, vIn, 'rx', numBytes, dataRate)


LPM (int) or (char) determines the rest mode of the MCU
vIn (double) is the system voltage; MSP430 operates 1.8-3.6 V
%}
% 

f_oco = 8e6; %Hz; the oscillator frequency
I_active = 1220e-6; %amps; active mode current
[eWake tWake] = wakeup(LPM, f_oco, I_active, vIn);
switch(action)
    case {'sample', 'adc', 'ADC', 0}
        if(length(varargin) >= 1) %nargin is total number of inputs
            numRead = varargin{1}; %number of sensors to read from
        else
            numRead = 1;
        end
        [eAction tAction bytes] = adcRead(I_active, vIn, numRead);
   %{
    case {'tx', 'TX', 'transmit', 1}
        if(length(varargin) >= 2)
            numBytes = varargin{1}; %number of sensors to read from
            dataRate = varargin{2};
            
        else
            numBytes = 960; % 960 bytes = 480 int
            dataRate = 1000; % 1 kb/sec
        end
        [eAction tAction] = tx(vIn, numBytes, pwr, dataRate)
        bytes = 0;
    case {'rx', 'RX', 'receive', 2}
        numBytes = varargin{1};
        dataRate = varargin{2};
        [eAction tAction bytes] = rx(vIn, numBytes, dataRate)
        %}
end
energy = eAction + eWake;
time = tWake + tAction;
end
