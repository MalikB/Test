function [eTx, tTx] = tx(vIn, numBits, pwr, dataRate)
% Power (dBm) and current (mA) values given from the datasheet
    % fit current to given power
    pListed = [-12 -6 0 1];
    I_Listed = [11.1 15 21.2 21.5] * 1e-3;
    I_Transmit = interp1(pListed, I_Listed, pwr, 'pchip');
    % total transmit time (time using TRX)
    % ** LATER include possile overheads ex. CSMA and 
    tTx = numBits / dataRate;
    eTx = vIn * I_Transmit * tTx;
end