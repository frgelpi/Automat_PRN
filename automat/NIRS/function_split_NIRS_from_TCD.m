% Function that given a NIRS .prn file cut out taking from the corresponding 
% TCD .csv file the time intervals for the different tasks.
function function_split_NIRS_from_TCD(PATH_NIRS_split, name_file, NIRS, TCD, marker_column, samples_before, samples_after, int_digits, dec_digits)

    % name file without .prn
    new_name = regexp(name_file, '^(.*?)\.', 'tokens', 'once');

    % Select marker column
    markers = TCD(:,marker_column);

    % Identify markers
    str_markers = find(cellfun(@(x) ~isempty(x), markers));     

    if isempty(str_markers)

        % Baseline case with no markers: resave the same file with
        % BL at the end
        new_file_path = append(PATH_NIRS_split,"\",new_name,"RB.prn");
        save_prn(NIRS, int_digits, dec_digits, new_file_path);
        fprintf('NIRS time end: %4.2f TCD time end: %s.\n',NIRS(end,1),TCD{end,1});

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
            initial = initial- samples_before;
            if initial < 0 %correction for first marker
                initial = 1;
            end

            % Ending of cut
            final = final + samples_after;
            if final > length(markers) %correction for last marker
                final = length(markers);
            end

            % Find start and end times
            start_time = TCD{initial,1};
            end_time = TCD{final,1};

            % Find corresponding indexes in NIRS
            [~, index_start] = min(abs(NIRS(:,1) - str2double(start_time)));
            [~, index_end] = min(abs(NIRS(:,1) - str2double(end_time)));
            
            new_file_path = append(PATH_NIRS_split,"\",new_name,mark,".prn");
            save_prn(NIRS(index_start:index_end,:), int_digits, dec_digits, new_file_path);
            fprintf('Task: %s\n', mark{1});
            fprintf('NIRS time start: %4.2f TCD time start: %s\n',NIRS(index_start,1),TCD{initial,1});
            fprintf('NIRS time end: %4.2f TCD time end: %s\n',NIRS(index_end,1),TCD{final,1});
            fprintf('\n');

        end


    end



end