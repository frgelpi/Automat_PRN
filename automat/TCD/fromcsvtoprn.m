
function fromcsvtoprn(PATH_CSV_ORIGINAL,PATH_PRN_FORMAT)


    folderPath = PATH_CSV_ORIGINAL; % Specify the path to your folder
    oldExt = '.csv'; % Specify the old extension
    newExt = '.prn'; % Specify the new extension
    
    files = dir(fullfile(folderPath, strcat('*', oldExt))); % Get a list of all files with the old extension
    
    for i = 1:length(files)
        oldName = files(i).name;
        newName = strrep(oldName, oldExt, newExt);
        oldName= append(PATH_CSV_ORIGINAL,"\",oldName);
        newName = append(PATH_PRN_FORMAT,"\",newName);
        copyfile(oldName, newName);
    end
end