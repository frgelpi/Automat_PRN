
PATH = 'C:\Users\franc\OneDrive\Documents\MATLAB\automat\prova'; %path of the folder with the excel files
PATH_NEW = 'C:\Users\franc\OneDrive\Documents\MATLAB\automat\new'; %path of the folder with the excel files
cd(PATH)
files = dir('*.csv'); % List all files in the current directory

for i = 1:length(files)
    filename = files(i).name;
    data = xlsread(filename); % Read data from Excel file
    
    % Define the specific rows you want to remove based on your criteria
    rows_to_remove = [3, 5, 7:19, 22, 23, 26, 27, 30, 32, 34:46, 49, 52, 53, 54]; % Example: Remove rows 2, 5, and 7

    n=size(data,1);
    m=length(rows_to_remove);
    
    % Remove specific rows from the data
    data(rows_to_remove, :) = [];
    data = data(1:n-m,:);
    
    % Create the full file path
    fullpath = fullfile(PATH_NEW, filename);
    
    % Write the data to the CSV file
    writematrix(data, fullpath);
end