% Function that open, scan and rearrange in a matlab readable format the
% .exp and csv files

function mat = read_file(file_path)

    fileID = fopen(file_path, 'r');
    data = textscan(fileID, '%s %s %s %s %s %s %s %s %s %s %s %s %s', 'Delimiter', {',','\t'});
    fclose(fileID);

    % reorganise as matrix
    n = length(data);
    col = 1;
    m = length(data{1});
    row =1;
    mat = cell(m,n);

    for i=1:n

        column = data{1,i};

        for j=1:m
            mat{j,i} = column{j};
            row = row +1;
        end

        col = col+1;

    end

end