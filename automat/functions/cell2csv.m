function cell2csv(filename, cellArray, separator)
    fh = fopen(filename, 'w');
    for i = 1:size(cellArray, 1)
        for j = 1:size(cellArray, 2)
            fprintf(fh, '%s', cellArray{i,j});
            if j ~= size(cellArray, 2)
                fprintf(fh, separator);
            end
        end
        fprintf(fh, '\n');
    end
    fclose(fh);
end