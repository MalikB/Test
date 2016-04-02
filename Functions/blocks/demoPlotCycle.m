setup
close all;

% set n
n = 0;

[eNet, eNetMCU, eNetTRX, cycleADC, cycleTRX] = operateCycle(config, n);
%rectSum(cycleADC(1,:), cycleADC(2, :), 'm');
% plot(cycleADC(1,:), cycleADC(2,:), 'b');
semilogy(cycleADC(1,:), cycleADC(2,:), 'b');

hold on;

rectSum(cycleTRX(1,:), cycleTRX(2, :), 'm')
disp(eNetTRX);
% plot(cycleTRX(1,:), cycleTRX(2,:), 'r');
semilogy(cycleTRX(1,:), cycleTRX(2,:), 'r');

xlabel('Time (seconds)');
ylabel('Power(watts)');
title('Single Cycle Power Usage');

legend('Sample Readings', 'Transmission');