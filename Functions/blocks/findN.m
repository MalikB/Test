function n = findN( eAv, config) %currently running for single cycle; eAv = eAv_cycle = eAv_window / k
syms n;
[eMCU, tMCU, ~] = mcuBlock(config); % takes care of the number of trials
switch config.txDataParam
    case 0
        [eTRX, tTRX] = trxBlock(config, 8*n*config.numSamp); %transmit averaged data
    case 1
        [eTRX, tTRX] = trxBlock(config, 8*n*config.numSamp*config.trials); %transmit data
end
eSleepTRX = trxSleep(config, config.T_tx - tTRX);
eSleepMCU = mcuSleep(config, (config.T_tx - n*tMCU));

n = (round(vpasolve(eAv == eTRX + n*eMCU + eSleepTRX + eSleepMCU, n))); % took abs() before
n = n(1);
end

% problem if