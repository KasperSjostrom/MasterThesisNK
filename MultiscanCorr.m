clear;
clc;
close all;

% Setting up folder path
folder_path = 'C:\Users\nmc\OneDrive\Dokument\MATLAB\Vias_6';
folder_path2 = 'C:\Users\nmc\OneDrive\Dokument\MATLAB\GAP_05';
% Storing all the CSV files in the folder
file_list = dir(fullfile(folder_path, '*.txt'));

% Defining reference files and preprocessing their data
ref_file_name = 'Vias_06_U';
ref_file_name2 = 'Gap_0_5_U';
% Read reference data and preprocess
ref_data = readmatrix(fullfile(folder_path, ref_file_name), 'Delimiter', ';', 'DecimalSeparator', ',');
ref_data = ref_data(:,2);
ref_Data2= readmatrix(fullfile(folder_path2, ref_file_name2), 'Delimiter', ';', 'DecimalSeparator', ',');
ref_Data2=ref_Data2(:,2)
plot(ref_data);
hold on;
plot(ref_Data2)
ref_data = zscore(ref_data); 
ref_Data2= readmatrix(fullfile(folder_path2, ref_file_name2), 'Delimiter', ';', 'DecimalSeparator', ',');
ref_Data2=ref_Data2(:,2);
%ref_Data2 = zscore(ref_Data2);

% Loop through each TXT file, preprocess its data, and compare to the reference data
p_values = zeros(length(file_list)+1, 4);
for i = 1:length(file_list)+1
    if i == length(file_list)+1 % Comparison of reference file to itself
        data_col = ref_data;
        [p,pval] = corr(data_col, ref_data, 'type', 'Spearman');
        fprintf('Comparison of %s to %s:\n', ref_file_name, ref_file_name);
        fprintf('p-value = %f, h = %d\n', p, pval);
    else % Comparison of each TXT file to reference file
        file_name = fullfile(folder_path, file_list(i).name);
        datacomp = readmatrix(file_name, 'Delimiter', ';', 'DecimalSeparator', ',');
        for j=2:6
            data_col = datacomp(:,j);
            data_col = zscore(data_col);
            
            [p,pval] = corr(data_col, ref_data, 'type', 'Spearman');
            if(p >= 0.80)
            fprintf('Comparison of %s to %s:\n', file_list(i).name, ref_file_name);
            fprintf('p-value = %f, h = %d\n', p, pval);
            end
            p_values(i,j-1) = p;
        end
    end
end

% Bar plot of the results
filename = {file_list.name};
figure;
bar(p_values)
xticks(1:length(filename));
xtickangle(0)
xticklabels(filename)
ylabel('Spearman correlation coefficient');
title('Comparison of A, C, O, Z, U');
