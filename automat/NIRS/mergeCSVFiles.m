% Function that given the folder generated for each reording by the fNIRS
% return an .prn file with as first column the timing followed by the
% channels in alphabetical order and formatted.

function mergeCSVFiles(folderPath, outputFolderPath, outputFileName, int_digits, dec_digits)

%     columns = [ 'Timings.csv', 'S1-D1.csv', 'S1-D3.csv', 'S2-D1.csv', ...
%                 'S2-D4.csv', 'S6-D3.csv', 'S6-D6.csv', 'S7-D4.csv', ...
%                 'S7-D6.csv'];

    files = dir(fullfile(folderPath, '*.csv'));
    data = cell(numel(files), 1);

    j=0; % to fix the indexing and put 'Timing.csv' first
    
    for i = 1:numel(files)

        filename = fullfile(folderPath, files(i).name);
        fileData = readtable(filename, 'Delimiter', ',');

        if contains(files(i).name,'Tim') % Should recognize Timings or any other as Time, Time01, ...
            i=1;
            j=1;
        elseif j == 0
            i=i+1;
        end
        data{i} = table2cell(fileData);
    end
    
    concatenatedMatrix = [];
    for i = 1:numel(data)
        currentMatrix = data{i};
        concatenatedMatrix = [concatenatedMatrix, currentMatrix];
    end

    % Set format data to the file
    for i = 1:size(concatenatedMatrix,1)
    
        m = concatenatedMatrix(i,:);
    
        for j = 1:size(m,2)
            if regex_is_number(m{j})
                str = m{j}(1:end);
                concatenatedMatrix(i,j) = cellstr(format_decimal(str,int_digits,dec_digits));
            end
        end
    end

    %% Save as .prn file from 
    outputFile = append(outputFolderPath,"\",outputFileName,".prn");
            
    % Sets lengths
    n_columns = size(concatenatedMatrix,2);
    n_rows =  size(concatenatedMatrix,1);
    
    % Sets column delimiter (tab) and row delimiter (new line)
    columnDelimiter = '\t';
    rowDelimiter = '\r\n';

    % Open the file for writing
    fileID = fopen(outputFile, 'w');
    
    % Write the data to the file with tab separation for columns and new line for rows
    for i = 1:n_rows

        for j = 1:n_columns
            fprintf(fileID, '%s', concatenatedMatrix{i, j});
            if j < n_columns
                fprintf(fileID, columnDelimiter);
            end
        end

        fprintf(fileID, rowDelimiter);

    end
    
    % Close the file
    fclose(fileID);

end