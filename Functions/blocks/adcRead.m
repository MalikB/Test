function [energy, time, bytes] = adcRead(vIn, numRead)
%{
USAGE:
[energy time] = adcRead(I_active, vIn, numRead)
energy = total energy used by ADC in sampling
time = total time it takes for ADC to sample
I_active = current consumed by MCU in active mode
vIn = operating voltage of MCU
numRead = number of sensors that need to be read;
%}
    % data is given for 2.2V and 3V operation; decide which is more
    % applicable
    vClosest = abs([vIn - 2.2, vIn - 3]);
    [~, idV] = min(vClosest);
    currents = [140e-6 145e-6];
    I_adc = currents(idV);
    % time it takes to sample; minimum given is 1us, scaled it up to 3us to
    % be safe
    tSample = (3e-6)*numRead;
    % time it takes to convert sample in ADC
    tConvert = 3.5e-6*numRead;
    % time it takes to write word to FRAM
    tWrite = 125e-9 * numRead;
    % total ADC time
    time = tSample + tConvert + tWrite;
    
    % E_mcu = time * I_active * vIn; %energy the MCU uses to run during this time
    % E_adc = I_adc*(tSample + tConvert)*vIn; %energy used by the ADC
    energy = I_adc*(tSample + tConvert)*vIn;
    % # of bytes the reading yields
    bytes = numRead * 2;
end
