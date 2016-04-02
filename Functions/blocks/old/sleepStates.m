function [eSleep] = sleepStates(vIn, LPM, time)
    % I_TRX = 160e-6; %A TRX sleep digital ON
    % I_TRX = 1.5e-3; %A TRX idle
    % also possible: 8 uA auto RX polling every second
    % I_Trx = .4e-6; %A, digital voltage reg OFF
    
    %MCU energy consumption based on LPM
    switch LPM
        case 'active'
            I_LPM = 0;
        case {0, 'idle', 'IDLE'}
            I_LPM = 165e-6;
        case {3,4,'standby', 'STANDBY'}
            I_LPM = .7e-6;
    end
    
    eSleep = vIn * time * (I_LPM + I_Trx);
    
    
end