 %% AUTOMATIZATION of the PRE-PROCESSING  OF .exp FILES (TCD, BP, ...) to .PRN
clear all
close all
clc
 % General script with all the functions needed to pre-process the data. 
 % Each step can be run separately, and the input folders can be modified
 % manually. If not inserted manually, the script generates folders for each
 % of the function in the folder in the level above PATH_EXP.
 % The only input that must be given is PATH_EXP.

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % SET YOUR INPUT FOLDERS
 % If not inserted manually, the script generates folders for each
 % of the function in the folder in the level above PATH_EXP.
 % The only input that must be given is PATH_EXP.
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 % PATH_EXP (folder where the .exp files are stored)
PATH_EXP = '\\ipsd.local\user\psd\fgelpi\My Documents\leicester\automatization\Jenny_test\TCD_original';


 % OPTIONAL INPUTS

% Path where you can save the .csv (without samples, splitting nor format, identical to .exp)
%  PATH_CSV = "C:\Users\franc\OneDrive\Documents\leicester\automatization\csv_TCD";

% Path where you can save the .csv (with samples time column but no formatting nor splitting)
% PATH_CSV_TIME = "C:\Users\franc\OneDrive\Documents\leicester\automatization\csv_TCD_samples";

% Path where you can save the .csv splitted according to the markers (with sample time column but no formatting)
% PATH_CSV_SPLIT = "C:\Users\franc\OneDrive\Documents\leicester\automatization\csv_TCD_split";

% Path where you can save the .prn final files
% PATH_PRN = "C:\Users\franc\OneDrive\Documents\leicester\automatization\prn_TCD_rn";


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. TAKES THE .EXP FILES IN A FOLDER AND CONVERTS THEM IN .CSV (save them in TCD_CSV folder)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars -except PATH_EXP PATH_CSV PATH_CSV_TIME

% Create folder if it doesn't exist
if exist('PATH_CSV','var')==0
    PATH_TCD = fileparts(PATH_EXP);
    name_folder = 'TCD_CSV';
    PATH_CSV = append(PATH_TCD,'\',name_folder);
    mkdir(PATH_TCD,name_folder)
end

% Function that copies and convert .exp files into .csv
from_exp_to_csv(PATH_EXP,PATH_CSV)


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. FORMATTING .CSV FILES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.A Add the time column
% You can set the sampling frequency (fs) and the column to use as
% reference (column_with_values)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars -except PATH_EXP PATH_CSV PATH_CSV_TIME PATH_CSV_SPLIT fs 

% PARAMETERS INPUTS
fs = 100; % Sampling frequency
column_with_values = 2; % Position of any column that contains a number format value (ex. samples, MCA, ...but not Time)

% Create folder if it doesn't exist
if exist('PATH_CSV_TIME','var')==0
    PATH_TCD = fileparts(PATH_EXP);
    name_folder = 'TCD_CSV_TIME';
    PATH_CSV_TIME = append(PATH_TCD,'\',name_folder);
    mkdir(PATH_TCD,name_folder)
end

% Function that add the first column with samples time
add_time_samples(PATH_CSV,PATH_CSV_TIME,fs, column_with_values);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.B Split according the marker
% You can set the column to use for the markes (marker_column) and the time
% in s to store before and after the marker 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars -except PATH_EXP PATH_CSV PATH_CSV_TIME PATH_CSV_SPLIT fs 

% PARAMETERS INPUTS
marker_column = 13; % Column that contains the markers (count the column number)
%time_before_after
time_before = 60; % Time in s that you want ot cut before the marker
time_after = 90; % Time in s that you want ot cut after the marker

samples_before = time_before * fs; % seconds * sampling frequncy
samples_after = time_after * fs; % seconds * sampling frequncy

% Create folder if it doesn't exist
if exist('PATH_CSV_SPLIT','var')==0
    PATH_TCD = fileparts(PATH_EXP);
    name_folder = 'TCD_CSV_SPLIT';
    PATH_CSV_SPLIT = append(PATH_TCD,'\',name_folder);
    mkdir(PATH_TCD,name_folder)
end

% Function that split the .csv file according to the markers column
split_csv(PATH_CSV_TIME,PATH_CSV_SPLIT,marker_column,samples_before,samples_after);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.C Select the columns and their order, format and save as .PRN
% You can set the columns to include in the prn and their order (columns),
% the format of you saved variables (number of decimals and integer values)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars -except PATH_EXP PATH_CSV PATH_CSV_TIME PATH_CSV_SPLIT PATH_PRN fs 

% Number of column that you want to select in the order you want them (i.e., inlcude also time (1) and marker column(13))
% [1            4     5     8   12      11  13] correspond to
% [samples_time MCA_L MCA_R ABP ECG_Raw CO2 MArkers]
columns = [1, 4, 5, 8, 12, 10, 13]; 

int_digits=6;   %number of integer(or space) before the .
dec_digits=3;   %number of decimals after the .

% Create folder if it doesn't exist
if exist('PATH_PRN','var')==0
    PATH_TCD = fileparts(PATH_EXP);
    name_folder = 'TCD_PRN';
    PATH_PRN = append(PATH_TCD,'\',name_folder);
    mkdir(PATH_TCD,name_folder)
end

% Function that save the .prn according to the format
select_format_savePRN(PATH_CSV_SPLIT,PATH_PRN, columns,int_digits,dec_digits);
