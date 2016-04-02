% demoExtOp
close all;

%eAvVec = [0 .5 .32 0 .4 .5 .2 .6]
% eAvVec = rand(1, 1000);
eAvVec = E_av;

setup;

% eAvVec = [.5 .32 0 .4 .5 .2 .6];
% troublesome ex: eAvVec = 0.4314    0.9106    0.1818    0.2638    0.1455    0.1361    0.8693    0.5797    0.5499    0.1450
% eAvVec = [0.4314    0.9106    0.1818    0.2638    0.1455    0.1361    0.8693    0.5797    0.1450];
% eAvVec = [0.4314    0.9106     0.8693    0.5797    0.1450];
% eAvVec = [0.4314    0.9106    0.1818    0.2638    0.1455    0.1361    0.8693    0.5797    0.5499    0.1450];
% eAvVec = rand(1, 10);
%eAvVec = rand(1, 1000);
%eAvVec = [.32 .32 .31];

[opADC, opTRX ,D_MCU, D_TRX] = extendedOperation(config, eAvVec);
subplot(4,1,1)
numWin = 0:length(eAvVec)-1;
times = config.k*config.T_tx * numWin;
times = [times; times + config.k*config.T_tx-1e-9];
times = times(:)';
enVec = [eAvVec; eAvVec];
enVec = enVec(:)';
plot(times, enVec);
xlabel('Time (seconds)');
ylabel('Energy (J)');
title('Energy Available');


subplot(4,1,2)
% plot(opADC(1,:), opADC(2, :), 'b');
semilogy(opADC(1,:), opADC(2, :), 'b');
hold on;
semilogy(opTRX(1,:), opTRX(2,:), 'r');
% plot(opTRsX(1,:), opTRX(2,:), 'r');
xlabel('Time (seconds)');
ylabel('Power (watts)');
titleText = sprintf('Power usage for %d windows', length(eAvVec));
title(titleText);
legend('Sample Readings', 'Transmission');
subplot(4,1,3)
D_MCU = [D_MCU; D_MCU];
D_MCU = D_MCU(:)';
plot(times, D_MCU*100)
xlabel('Time (seconds)');
ylabel('D (%)');
title('MCU & TRX Duty Cycle');
hold on


subplot(4,1,4)
D_TRX = [D_TRX; D_TRX];
D_TRX = D_TRX(:)';
plot(times, D_TRX*100);
hold off
xlabel('Time (seconds)');
ylabel('D (%)');
title('TRX Duty Cycle');