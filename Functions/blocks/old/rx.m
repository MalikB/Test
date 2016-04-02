function [eRx tRx] = rx(vIn, numBytes, dataRate, mode)
% Rate must be 2.4, 10, 250, or 500 kBsud
% this RX script assumes that the radio can wake up and with minimal
% polling begin receiving data
% eRx = 0;
% tRx = 0;
% wake up the radio
% mode is 0 or 1
%   1 -- at sensitivity limit
%   2 -- above sensitivity limit
tWakeTrx  = 249e-9; %sec
I_wakeTrx = 400e-9; %A

bitRate = [2.4e3 10e3 250e3 500e3];
I_sensLim = [17e-3 17.3e-3 18.8e-3 19.5];
I_gtSensLim = [14.5e-3 14.9e-3 15.7e-3 17e-3];
currents = [I_sensLim; I_gtSensLim];

%interpolate the current used for the given data rate;
I_rx = interp1(bitRate, currents(mode, :), dataRate, 'pchip');
tReceive = 8*numBytes / dataRate;

eRx = tReceive * vIn * I_rx + tWakeTrx * I_wakeTrx * vIn;
tRx = tReceive + tWakeTrx;

% CC2500 cost 200 nJ/bit [EnHANTs]

% ePerByte = 8*200e-9;
% eRx = (numBytes * ePerByte)+vIn*(tWakeTrx*I_wakeTrx);
% tRx = numBytes/dataRate;
%reception overheads involve guard time, CCA
% overheads will later be assumed
end