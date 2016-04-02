function [time,data] = ReadData( file_name,lineskp)
%% TXT File read
[time,data] = textread(file_name,'%d%f%*[^\n]','delimiter','\t','headerlines',lineskp);
data = data' / 1e6; %convert from microWatts to Watts
time = time /60; %convert to minutes

end