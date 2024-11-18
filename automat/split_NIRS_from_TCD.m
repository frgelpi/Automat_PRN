%% SPLIT NIRS AND SYNCRONIZE WITH TCD
clear all
close all
clc

% Script that given a NIRS .prn file cut out taking from the corresponding 
% TCD .csv file the time intervals for the different tasks, and adds a 
% column for the markers. If different markers are present in the TCD the 
% script split into sub files the NIRS files.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET YOUR INPUTS
% If not inserted manually (PATH_NIRS_split), the script generates a folder to save the NIRS
% splitted files in the level above the PATH_NIRS path.
% The inputs that must be given are PATH_NIRS, FILE_NIRS, PATH_TCD and FILE_TCD.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PATH_NIRS = '\\ipsd.local\user\psd\fgelpi\My Documents\leicester\automatization\Jenny_test\NIRS_PRN';
FILE_NIRS = 'VESDM001TASK.prn';

PATH_TCD = '\\ipsd.local\user\psd\fgelpi\My Documents\leicester\automatization\Jenny_test\TCD_CSV_TIME';
FILE_TCD = 'VESDM001_VESDM001_19_50_2024 02.csv';

% PATH_NIRS_split = 'C:\Users\franc\OneDrive\Documents\leicester\automatization\NIRS\PATH_NIRS_split';

% PARAMETERS INPUTS
marker_column = 13; % Column that contains the markers in the TCD file (count the column number)
time_before = 60; % Time in s that you want ot cut before the marker
time_after = 90; % Time in s that you want ot cut after the marker
int_digits=6;   %number of integer(or space) before the .
dec_digits=3;   %number of decimals after the .
fs = 100; % sampling frequency TCD

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create folder if it is not given
if exist('PATH_NIRS_split','var')==0
    PATH = fileparts(PATH_NIRS);
    name_folder = 'PATH_NIRS_split';
    PATH_NIRS_split = append(PATH,'\',name_folder);
    mkdir(PATH,name_folder)
end

file_path = append(PATH_TCD,'\',FILE_TCD);
TCD = read_file(file_path);

file_path = append(PATH_NIRS,'\',FILE_NIRS);
NIRS = importdata(file_path);

samples_before = time_before * fs; % seconds * sampling frequncy
samples_after = time_after * fs; % seconds * sampling frequncy

function_split_NIRS_from_TCD(PATH_NIRS_split, FILE_NIRS, NIRS, TCD, marker_column, samples_before, samples_after, int_digits, dec_digits);


