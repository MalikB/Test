function [eMCU] = mcuSleep(config, time)
    %MCU energy consumption based on LPM
    switch config.LPM
        case -1
            I_LPM = 0;
        case {0}
            I_LPM = 165e-6;
        case {3,4}
            I_LPM = .7e-6;
        otherwise
            I_LPM = .7e-6;
    end
    
    eMCU = config.vIn * time * I_LPM;
end