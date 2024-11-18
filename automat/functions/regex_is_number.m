function log = regex_is_number(str)

    % Check if the input is a string and convert it to a char row vector if needed
    if isnumeric(str)
        str = num2str(str);
    end

    pattern = '^-?\d*\.?\d+$|^[0-9]$';
    log = ~isempty(regexp(str, pattern, 'once'));

end