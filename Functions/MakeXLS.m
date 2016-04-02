function MakeXLS( file_name, time, data, h_power, stored, data_stat, data_stat1) )
%% XLS File Creation
    new_filename = ['ANALYSIS_OF_' file_name '.xlsx'];
    Info_Title = {'Time(sec)','Power Detected(mW)','Power Harvested(W)', 'Energy Collected (V)'};
    [rstatus,rmessage] = xlswrite(new_filename,Info_Title,'A1');
    Info = [time, data, h_power, stored];
    [rstatus1,rmessage1] = xlswrite(new_filename,Info,'A2');
    if rstatus && rstatus1 == 1
        disp('xls file write on sheet 1 was good')
    else
    rmessage
    rmessage1
    end
    
    [rstatus,rmessage] = xlswrite(new_filename,struct2cell(data_stat),'E1');
    [rstatus1,rmessage1] = xlswrite(new_filename,fieldnames(data_stat),'F1');
    if rstatus && rstatus1 == 1
        disp('xls file write on sheet 2 was good')
    else
    rmessage
    rmessage1
    
    [rstatus,rmessage] = xlswrite(new_filename,struct2cell(data_stat1),'E10');
    [rstatus1,rmessage1] = xlswrite(new_filename,fieldnames(data_stat1),'F10');
    if rstatus && rstatus1 == 1
        disp('xls file write on sheet 2 was good')
    else
    rmessage
    rmessage1
    end

end

