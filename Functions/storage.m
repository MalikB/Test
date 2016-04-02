function [ eSC ] = storage(eAv,eNeed,input,~)

% in series with hardware, after, charged with leftover voltage from source
% Look in daniil's code and fine the energy consumed by the HW
% Subtarct from incoming voltage and charge with that 
%Make a bollena in operate files indicate power from SC is used to activate
%the discharging state


len = length(eAv);
eSC = zeros(1,len);
hit = 0;

charge = true;
hold = false;
discharge = false;


% for x = 1:len-1
%     storedEnergy(x) = ((.5*input.C)*(h_voltage(x)^2)-(.5*input.C)*(h_voltage(1)^2));
%     E_sc = sum(storedEnergy((len-win):len));
% end

for x = 1:(len-1)
    
    if (eAv(x) - eNeed) < 0
        useSC = true;
        discharge = true;
        charge  = false;
    else
        useSC = false;
    end
    
if charge
%     eSC(x) = ((.5*input.C)*(h_voltage(x)^2)-(.5*input.C)*(h_voltage(1)^2));
    if useSC 
        discharge = true;
        charge  = false;
    end
    
    if x == 1
        eSC(x) = 0;
    else
        eSC(x) = eSC(x-1)+ (eAv(x) - eNeed); % Account for Engergy used from HW
    end
    
    if eSC(x) >= input.t_voltage
        hold = true;
        charge = false;
    end
    continue
end

if hold
     eSC(x) = input.t_voltage;
%      waste = waste + (h_voltage(x) - t_voltage);
     if useSC %Use boolean activeMode && E_av < E_needed 
         hold = false;
         discharge = true;
     end
     continue
end

if discharge
    
    if x == 1
        eSC(x) = 0;
    else
      eSC(x) = eSC(x-1) - eNeed;
    end
     %^implement disharging function: energy to be used in active mode for
     %the next window
     if eSC(x) < 0
         hit = hit +1;
         eSC(x) = 0;
     end
     if eSC(x) < input.min_E
        discharge = false;
        charge = true;
     end
     continue
end
end
disp('Took too Much :')
disp( hit)
% Esc = sum(eSC((len-win):len));
end