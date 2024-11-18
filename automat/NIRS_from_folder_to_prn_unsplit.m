 %% AUTOMATIZATION of the PRE-PROCESSING  OF fNIRS folder to .PRN
clear all
close all
clc
 % General script with the function needed to pre-process the fNIRS data. 
 % The data for each recording should be store in the folder PATH_NIRS.  
 % The script generates a .prn file as outputFileName, and save it the folder
 % outputFolderPath. 
 % The script does NOT split the file in task. For that you must use the
 % script split_NIRS_from_TCD.

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % SET YOUR INPUTs
 % If not inserted manually, the script generates a .prn file with the same 
 % name as the original folder (folderPath) in a default folder one level above.
 % The only input that must be given is PATH_NIRS.
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    PATH_NIRS = "\\ipsd.local\user\psd\fgelpi\My Documents\leicester\automatization\Jenny_test\VESDM001";
    outputFolderPath = "\\ipsd.local\user\psd\fgelpi\My Documents\leicester\automatization\Jenny_test";

    outputFileName = "test";

 % Create name if it doesn't exist
 if exist('outputFileName','var')==0
    [folderPath, folderName, ~] = fileparts(PATH_NIRS);
    outputFileName = folderName;
 end

 % Create folder if it doesn't exist
 if exist('outputFolderPath','var')==0
    PATH_up = fileparts(PATH_NIRS);
    name_folder = 'PATH_NIRS_PRN_unsplit';
    outputFolderPath = append(PATH_up,'\',name_folder);
    mkdir(PATH_up,name_folder)
 end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % You can set the columns to include in the format of you saved variables
 % (number of decimals and integer values)

 int_digits=6;   %number of integer(or space) before the .
 dec_digits=3;   %number of decimals after the .

 mergeCSVFiles(PATH_NIRS, outputFolderPath, outputFileName, int_digits, dec_digits)