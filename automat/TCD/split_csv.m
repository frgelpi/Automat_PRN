% Function that takes all the .csv files in the folder PATH_CSV_ORIGINAL
% and slip them according to the markers in the marker_colum (position of
% the last column where the markers are)

function split_csv(PATH_CSV_ORIGINAL,PATH_CSV_FORMAT,marker_column,time_before, time_after)

    %% LOAD OF FILES IN PATH_ORIGINAL
    
    filez=dir(PATH_CSV_ORIGINAL);
    
    for i=1:size(filez,1)
    
        name=filez(i).name;
        file_path = append(PATH_CSV_ORIGINAL,"\",name);
        new_name = regexp(name, '^(.*?)\.', 'tokens', 'once');
    
        byte = filez(i).bytes;
    
        if byte ~= 0     % exclude empty files (and hidden files)
    
            % Load the .exp file from PATH_ORIGINAL
            mat = read_file(file_path);

            % Select marker column
            markers = mat(:,marker_column);

            % Identify markers
            str_markers = find(cellfun(@(x) ~isempty(x), markers));     

            if isempty(str_markers)

                % Baseline case with no markers: resave the same file with
                % BL at the end
                new_file_path = append(PATH_CSV_FORMAT,"\",new_name,"RB.csv");
                writecell(mat, new_file_path);

            else
            
                selected_marekrs = markers(str_markers);
                
                k=1;
                while k<length(selected_marekrs)
                    mark = selected_marekrs(k);
                    initial = str_markers(k);

                    while strcmpi(selected_marekrs{k},mark)
                        final = str_markers(k);
                        k=k+1;
                        if k>length(selected_marekrs)
                            break
                        end
                    end

                    % Starting of cut 
                    initial = initial- time_before;
                    if initial < 0 %correction for first marker
                        initial = 1;
                    end

                    % Ending of cut
                    final = final + time_after;
                    if final > length(markers) %correction for last marker
                        final = length(markers);
                    end

                    new_file_path = append(PATH_CSV_FORMAT,"\",new_name,mark,".csv");
                    writecell(mat(initial:final,:), new_file_path);

                end


            end

    
            % Save as .csv file from PATH_CSV
%             writecell(mat, new_file_path);
    
        end
    
    end

end