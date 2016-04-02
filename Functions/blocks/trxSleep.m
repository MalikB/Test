function [eTRX] = trxSleep(config, time)
% 0 1.5e-3; %A TRX idle
% 1 160e-6; %A TRX sleep digital ON
% 2 .4e-6; %A, digital voltage reg OFF
% 3 8 uA auto RX polling every second
    switch config.trxLPM
        case 0
            I_trx = 1.5e-3; %Amps
        case 1
            I_trx = 160e-6;
        case 2
            I_trx = .4e-6;
        case 3
            I_trx = 8e-6;
        otherwise
            I_trx = 160e-6;
    end
        eTRX = config.vIn * I_trx * time;
end