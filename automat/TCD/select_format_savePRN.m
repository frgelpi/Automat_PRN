% Function that takes all the .csv files in the folder PATH_CSV_ORIGINAL,
% and format according to the selected colums and remove the headings.


function select_format_savePRN(PATH_CSV_ORIGINAL,PATH_CSV_FORMAT,columns,int_digits,dec_digits)

    %% LOAD OF FILES IN PATH_ORIGINAL
    filez=dir(PATH_CSV_ORIGINAL);
    
    for i=1:size(filez,1)
    
        name=filez(i).name;
        file_path = append(PATH_CSV_ORIGINAL,"\",name);
        oldExt = '.csv'; % Specify the old extension
        newExt = '.prn'; % Specify the new extension
        newName = strrep(name, oldExt, newExt);
        new_file_path = append(PATH_CSV_FORMAT,"\",newName);
    
        byte = filez(i).bytes;
    
        if byte ~= 0     % exclude empty files (and hidden files)
            
            % Load the .exp file from PATH_ORIGINAL
            mat = read_file(file_path);
            
            % Select the first column with samples
            samples = mat(:,1);
            
            for i = 1:numel(samples) % Loop through each cell in the array
                if regex_is_number(samples{i}) % Check if the cell contains a number
                    start_cut=i;
                    break
                end
            end
            
            MAT = mat(start_cut:end,columns);
            
            % Set format data to the file
            for i = 1:size(MAT,1)
            
                m = MAT(i,:);
            
                for j = 1:size(m,2)
                    if regex_is_number(m{j})
                        str = m{j}(1:end);
                        MAT(i,j) = cellstr(format_decimal(str,int_digits,dec_digits));
                    end
                end
            end
            
            %% Save as .prn file from 
            
            % Sets lengths
            n_columns = length(columns);
            n_rows =  length(MAT);
            
            % Sets column delimiter (tab) and row delimiter (new line)
            columnDelimiter = '\t';
            rowDelimiter = '\r\n';

            % Open the file for writing
            fileID = fopen(new_file_path, 'w');
            
            % Write the data to the file with tab separation for columns and new line for rows
            for i = 1:n_rows

                for j = 1:n_columns
                    fprintf(fileID, '%s', MAT{i, j});
                    if j < n_columns
                        fprintf(fileID, columnDelimiter);
                    end
                end

                fprintf(fileID, rowDelimiter);

            end
            
            % Close the file
            fclose(fileID);

        end
    end

end