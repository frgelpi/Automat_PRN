function result = format_decimal(str, int_digits, dec_digits)
    
    % Check if the input is a string and convert it to a char row vector if needed
    if isnumeric(str)
        str = num2str(str);
    end

    % Check if the input string contains a minus (-)
    if contains(str, '-')
        % Find the index of the decimal point
        idx_decimal = strfind(str, '.');
        
        % Extract the digits before/after the decimal point
        integer_part = str(1:idx_decimal-1);
        decimal_part = str(idx_decimal+1:end);

        % Pad with ' ' space if less than int_digits integral places
        if length(integer_part) < int_digits
            for i= 1:int_digits-length(integer_part)
                integer_part = [' ', integer_part];
            end
        end
        
        % Pad with zeros if less than dec_digits decimal places
        if length(decimal_part) < dec_digits
            for i= 1:dec_digits-length(decimal_part)
                decimal_part = [decimal_part, '0'];
            end
        end
        
        % Construct the result with exactly 3 decimal places
        result = [integer_part, '.', decimal_part(1:3)];
    % Check if the input string contains a decimal point
    else
        if contains(str, '.')
            % Find the index of the decimal point
            idx_decimal = strfind(str, '.');
            
            % Extract the digits before/after the decimal point
            integer_part = str(1:idx_decimal-1);
            decimal_part = str(idx_decimal+1:end);
    
            % Pad with ' ' space if less than int_digits integral places
            if length(integer_part) < int_digits
                for i= 1:int_digits-length(integer_part)
                    integer_part = [' ', integer_part];
                end
            end
            
            % Pad with zeros if less than dec_digits decimal places
            if length(decimal_part) < dec_digits
                for i= 1:dec_digits-length(decimal_part)
                    decimal_part = [decimal_part, '0'];
                end
            end
            
            % Construct the result with exactly 3 decimal places
            result = [integer_part, '.', decimal_part(1:3)];
        else

            % If there is no decimal point, add '.000' to the end of the string
            % and ' ' space before
            % Pad with 0 space if less than int_digits integral places
            decimal_part=[];
            for i= 1:dec_digits
                decimal_part = [decimal_part, '0'];
            end
            
            % Pad with ' ' space if less than int_digits integral places
            if length(str) < int_digits
                for i= 1:int_digits-length(str)
                    str = [' ', str];
                end
            end
            result = [str, '.', decimal_part];
        end
    end
end