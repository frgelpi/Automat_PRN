% Function that takes all the .csv files in the folder PATH_CSV_ORIGINAL,
% and add a column with the time according to the sample frequency.


function add_time_samples(PATH_CSV_ORIGINAL,PATH_CSV_FORMAT,fs, column_with_numbers)

    %% LOAD OF FILES IN PATH_ORIGINAL
    filez=dir(PATH_CSV_ORIGINAL);
    
    for i=1:size(filez,1)
    
        name=filez(i).name;
        file_path = append(PATH_CSV_ORIGINAL,"\",name);
        new_file_path = append(PATH_CSV_FORMAT,"\",name);
    
        byte = filez(i).bytes;
    
        if byte ~= 0     % exclude empty files (and hidden files)
            
            % Load the .exp file from PATH_ORIGINAL
            mat = read_file(file_path);

            % Select a colum with value in number format
            samples = mat(:,column_with_numbers);

            j=0; % Counter of the samples
            F = 1; % turn to 0 when the first number is found

            for i = 1:numel(samples) % Loop through each cell in the array

                if F==1
                    if regex_is_number(samples{i}) % Check if the cell contains a number
                        F=0;
                        samples{i} = j * fs;
                        j=j+1;
                    end
                else
                    samples{i} = j * 1/fs; % Multiply the samples' counter by the sampling frequency
                    j=j+1;
                end
                
            end

        mat = [samples, mat ];
        
        % Save as .csv file from PATH_CSV
        writecell(mat, new_file_path);

        end
    end

end



function log = regex_is_number(str)

    pattern = '^\d+$';
    log = ~isempty(regexp(str, pattern));

end



