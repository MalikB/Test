function [eTRX, tTRX] = trxBlock(config, numBit)
%generate TRX block

% TODO: Implement an ACK RX/TX pulse % 

    % Energy and time to transmit data
    [eTXTransmit, tTXTransmit] = tx(config.vIn, numBit, config.power, config.dataRate);
    % energy expended while using MCU in active mode; includes wakeup time
    [eRunTRX, tRunTRX] = operateMCU(config, tTXTransmit);
    % net energy and time used while transmitting
    eTRX = eTXTransmit + eRunTRX; 
    tTRX = tRunTRX;
end