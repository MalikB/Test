function [energy, time]= operateMCU(config, time)
    eActive = config.I_active*config.vIn*time;
    [eWake, tWake] = wakeup(config);
    energy = eActive + eWake;
    time = time + tWake;
end