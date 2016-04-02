function [D_mcu, D_trx] = dutyCycle(config, n, tTRX, tMCU)
% Generate proportional duty cycles
    D_trx = (tTRX-wakeup(config)) / config.T_tx;
    tMcuActive = tMCU*n + tTRX;
    D_mcu = tMcuActive / config.T_tx;
end