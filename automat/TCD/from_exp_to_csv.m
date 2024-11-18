% Function that takes all the .exp files in the folder PATH_EXP, saves
% them as .csv in the folder PATH_CSV 

function from_exp_to_csv(PATH_EXP,PATH_CSV)

    %% LOAD OF FILES IN PATH_EXP
    
    filez=dir(PATH_EXP);
    
    for i=1:size(filez,1)
    
        name=filez(i).name;
        file_path = append(PATH_EXP,"\",name);
        new_name = regexp(name, '^(.*?)\.', 'tokens', 'once');
        new_file_path = append(PATH_CSV,"\",new_name,".csv");
    
        byte = filez(i).bytes;
    
        if byte ~= 0     % exclude empty files (and hidden files)
    
            % Load the .exp file from PATH_EXP
            mat = read_file(file_path);

            % Verify that the .exp file is the original one
            containsPatient = contains(mat{1, 1}, 'Patient');

            if containsPatient==0
                fprintf("File  %s is not original. Removing first column.", name)
                mat = mat(:,2:end);
            end
    
            % Save as .csv file from PATH_CSV
            writecell(mat, new_file_path);
    
        end
    
    end

end
