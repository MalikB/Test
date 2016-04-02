%Run Scirpt for  Simulation

v = UserInput();
win = v.data.window;
lineskp = 1;
[time,irrandance] = ReadData(v.file_name,lineskp);
len = length(time);
irrandance = NaNDetect(irrandance);
irrandance = MovingAverage(irrandance,win);
[harvestedEnergy,E_av] = harvested(irrandance,win,v.HT,v.data);
disp('Energy Available in the Last Window (J):')
disp(E_av(end))

disp('Start Operation')
setup;
[opADC, opTRX ,D_MCU, D_TRX, eNeed] = extendedOperation(config, E_av);
disp('Finish Operation')

[eSC] = storage(E_av,eNeed,v.SC,win);
disp('Energy Available in SuperCap in the Last Window (J):')
disp(eSC(end))

%Add FeedBack

PlotVal


%% Predictive Loop
loop = true;
disp(['Predictive Method Used : ' v.PM.op])
while(loop)
    loop = input('Stop? (y/n) ','s');
    if isempty(loop)
        loop = true;
    elseif strcmpi(loop,'y')
        loop = false;
        continue
    end
    
    for x = 1:v.limit
[time,irrandance] = future(time,irrandance,win,v.PM);

[harvestedEnergy,E_av] = harvested(irrandance,win,v.HT,v.data);
disp('Energy Available in the Next Window (J):')
disp(E_av(end))

disp('Start Operation')
[opADC, opTRX ,D_MCU, D_TRX, eNeed] = extendedOperation(config, E_av);
disp('Finish Operation')

[eSC] = storage(E_av,eNeed,v.SC,win);
disp('Energy Available in SuperCap in the Next Window (J):')
disp(eSC(end))
    end
%Add FeedBack

PlotVal

%{
% Old
% % [time,irrandance] = future(time,irrandance,win,v.PM);
% % plot(time,irrandance,'r')
% % hold on
% % plot(time,av_irrandance,'k')
% % plot(time(win),irrandance(win),'xb')
% % hold off
% % [harvestedEnergy,harvestedVoltage,E_av] = harvested(irrandance,win,v.HT);
% % figure
% % plot(time, harvestedEnergy,'b')
% % disp('Energy Available in the Next Window (J):')
% % disp(E_av(end))
% % [storedEnergy, E_sc] = storage(harvestedVoltage,win,v.SC);
% % figure
% % plot(time,storedEnergy,'k')
% % disp('Energy Available in SuperCap in the Next Window (J):')
% % disp(E_sc)
% % disp((E_sc*30)/2)
%}
end
