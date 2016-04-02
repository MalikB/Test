function [ h_energy,E_av ] = harvested(data,win,input,input1)
l = length(data);
h_energy = zeros(1,l);
% h_voltage = zeros(1,l);
% Energy harvested for a given solar panel, In joules
switch input.HT
    
    case 'Solar'
    
    for x = 1:l
    h_energy(x) = (input.area * input.effciency * data(x)*input1.res);
%     h_voltage(x) = (input.area * input.effciency * data(x))/input.i_sc;
    end
    
    E_av = Trace_Eav(h_energy,win);

    case 'Human Kinetic'
        disp('To be Specified')
% Add Case Statements for more diffrent techniques
    otherwise
        disp('Harvesting Technique Not Specified')
        
end

