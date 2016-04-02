function [ Uinput ] = UserInput( )

[num txt raw] = xlsread('Uinput');

Uinput = struct('file_name',[],'HT',[],'PM',[],'SC',[],'data',[],'limit',[]);

% Uinput.file_name = input('What is the file name? ','s');
Uinput.file_name = raw{1,2};
if isempty(Uinput.file_name)
    Uinput.file_name = 'SetupA.txt';
end

%%Harvesting Techniques
Uinput.HT = struct('HT',[],'area',[],'effciency',[],'i_sc',[]);

% Uinput.HT.HT = input('Harvesting Technique Used? ','s');
Uinput.HT.HT = raw{2,2};
if isempty(Uinput.HT.HT)
    Uinput.HT.HT = 'Solar';
end

switch Uinput.HT.HT
    
    case 'Solar'
        
% Uinput.HT.area = input('Area of the Solar Cell? (cm^2)');
Uinput.HT.area = raw{4,2};
if isempty(Uinput.HT.area)
      Uinput.HT.area = 40;
end
% Uinput.HT.effciency = input('Effcieny of the Solar Cell? (Decmial Form)');
Uinput.HT.effciency = raw{5,2};
if isempty(Uinput.HT.effciency)
      Uinput.HT.effciency = .07;
end
% Uinput.HT.i_sc = input('What is the maximum current provided by solar cell? (A)');
Uinput.HT.i_sc = raw{6,2};
if isempty(Uinput.HT.i_sc)
      Uinput.HT.i_sc = 2;
          
end
    case 'Human Kinetic'
        disp('To be Specified')
    otherwise
        disp('Harvesting Technique Not Specified')
end
%%Predictive Methods
Uinput.PM = struct('op',[],'n',[]);

% Uinput.PM.op = input('What predictive method would you like to use? ');
Uinput.PM.op = raw{10,2};
if isempty(Uinput.PM.op)
    Uinput.PM.op = 'Energy Budget';
end
% Uinput.PM.n = input('How many divsion per window would you like to make? ');
Uinput.PM.n = raw{11,2};
if isempty(Uinput.PM.n)
    Uinput.PM.n = 5;
end

%%Super Capcitor Values
Uinput.SC = struct('C',[],'TC',[],'t_voltage',[],'min_E',[]);

% Uinput.SC.C = input('What is the capcitance of the super-cap? (F)');
Uinput.SC.C = raw{13,2};
if isempty(Uinput.SC.C)
    Uinput.SC.C = 100; 
end
% Uinput.SC.TC = input('What is the Time Constant of the super-cap? (F)');
% if isempty(Uinput.SC.TC)
%     Uinput.SC.TC = 2e7; 
% end

% Uinput.SC.t_voltage= input('What is the terminal voltage of the super-cap? (V)');
Uinput.SC.t_voltage = raw{14,2};
if isempty(Uinput.SC.t_voltage)
    Uinput.SC.t_voltage = 2.7;
end
Uinput.SC.t_voltage = 0.5*Uinput.SC.C*(Uinput.SC.t_voltage)^2; % Converted to Maximum Energy

% Uinput.SC.min_E = input('Minimun useful voltage of the system? (V)');
Uinput.SC.min_E = raw{15,2};
if isempty(Uinput.SC.min_E)
    Uinput.SC.min_E = .09;
end
Uinput.SC.min_E = 0.5*Uinput.SC.C*(Uinput.SC.min_E)^2;

%% Window Intailzed
% window = input('How long is your window (minutes, 0 = smallest window of 30 seconds)? ');
% window = window * 2 %%Each point is 30 seconds thus 2 points/minute
Uinput.data.window = raw{17,2};
if isempty(Uinput.data.window)
    Uinput.data.window = 10; % number of points
end

Uinput.data.res = raw{18,2};
if isempty(Uinput.data.res)
    Uinput.data.res = 30; % seconds
end
%% Predictive Cycles
Uinput.limit = raw{20,2};
if isempty(Uinput.limit)
    Uinput.limit = 1; % number of points
end
end

