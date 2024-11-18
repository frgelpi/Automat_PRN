%% SAVE_PRN: function that given a matrix save it in the .prn format with specific format
function save_prn(MAT, int_digits, dec_digits, file_path)

    % Sets lengths
    n_columns = size(MAT,2);
    n_rows =  size(MAT,1);

    mat = cell(n_rows, n_columns);

    % Set format data to the file
    for i = 1:n_rows
        for j = 1:n_columns
            mat(i,j) = cellstr(format_decimal(MAT(i,j),int_digits,dec_digits));
        end
    end
    
    
    % Sets column delimiter (tab) and row delimiter (new line)
    columnDelimiter = '\t';
    rowDelimiter = '\r\n';

    % Open the file for writing
    fileID = fopen(file_path, 'w');
    
    % Write the data to the file with tab separation for columns and new line for rows
    for i = 1:n_rows

        for j = 1:n_columns
            fprintf(fileID, '%s', mat{i, j});
            if j < n_columns
                fprintf(fileID, columnDelimiter);
            end
        end

        fprintf(fileID, rowDelimiter);

    end
    
    % Close the file
    fclose(fileID);

end