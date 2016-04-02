function [eMCU, tMCU, bytes] = mcuBlock(config)
%generate MCU block
    % energy and time expended on operating the ADC a single time
    [eMCUSample, tMCUSample, bytes] = operateADC(config);
    % energy from active mode while operating ADC; time will be greater,
    % for included MCU wakeup times
    [eRunMCUadc, tRunMCUadc] = operateMCU(config, tMCUSample);
    % net energy and time
    eMCU = eMCUSample + eRunMCUadc; tMCU = tRunMCUadc;
end