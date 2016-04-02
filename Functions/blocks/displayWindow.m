function displayWindow(eAvailable)
%eAvailable has .32J min with current config at k=3

close all;
setup;
%disp(config.T_tx);


hold off;

config.k = 3;


[eWindow, eWindowMCU, eWindowTRX, windowADC, windowTRX, bytes, D] = operateWindow(eAvailable, config);
subplot(3,1,1);
semilogy(windowADC(1,:), windowADC(2,:), 'b');

hold on;

semilogy(windowTRX(1,:), windowTRX(2,:), 'r');

xlabel('Time (seconds)');
ylabel('Power(watts)');
titleText = sprintf('Window Power Usage: %dJ per Window', eAvailable');
title(titleText);

legend('Sample Readings', 'Transmission');
hold off;

subplot(3,1,2);
plot(windowTRX(1,:), 100*D.MCU*ones(1, length(windowTRX(1,:))), 'b');
axis([0 (config.k*config.T_tx) 0 2]);

subplot(3,1,3);
plot(windowTRX(1,:), 100*D.TRX*ones(1, length(windowTRX(1,:))), 'r');

end