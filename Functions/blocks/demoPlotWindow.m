clear; clc;
setup;

close all;

hold off;

config.k = 3;

eAvailable = .32; % .32J min with current config at k=3

[eWindow, eWindowMCU, eWindowTRX, windowADC, windowTRX, bytes] = operateWindow(eAvailable, config);

semilogy(windowADC(1,:), windowADC(2,:), 'b');

hold on;

semilogy(windowTRX(1,:), windowTRX(2,:), 'r');

xlabel('Time (seconds)');
ylabel('Power(watts)');
titleText = sprintf('Window Power Usage: %dJ per Window', eAvailable');
title(titleText);

legend('Sample Readings', 'Transmission');
descr = {
    sprintf('Window = %d s', config.k * config.T_tx);
    sprintf('k = %d', config.k);
    sprintf('k = %d', config.k);
    't = 0:1000'};
% text(400,1e-3,descr);