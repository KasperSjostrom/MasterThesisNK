clear;
clc;
close all;

% Setting up folder path
folder_path = 'C:\Users\nmc\OneDrive\Dokument\MATLAB\AmplitudeW';

% Define the file groups to plot in subplots based on the file name endings
file_groups = {'A.txt', 'Z.txt', 'U.txt', 'O.txt', 'C.txt'};

% Preallocating arrays
avg_col2 = cell(length(file_groups), 1);
filename = cell(length(file_groups), 1);

%datacomp_all = zeros(length(group_files), 1); % New array to store datacomp values
% Loop over each file group
for j = 1:length(file_groups)
    
    % Filter the file list to include only files with the current ending
    group_files = dir(fullfile(folder_path, ['*' file_groups{j}]));
    
    % Preallocate arrays for the current group
    avg_col2{j} = zeros(length(group_files), 1);
    filename{j} = cell(length(group_files), 1);
    

    % Calculate the average for each file in the group and store the filename
    for i = 1:length(group_files)
        file_name = fullfile(folder_path, group_files(i).name);% 
        datacomp = readmatrix(file_name, 'Delimiter', ';', 'DecimalSeparator', ',');
        datacomp = datacomp(:, 2:end); % remove the first column
        datacomp = mean(datacomp, 'all');
        avg_col2{j}(i) = datacomp;
        %datacomp_all(i) = datacomp_all(i)+ datacomp; % Store datacomp value in the new array
        % Store the filename
        [~, filename{j}{i}, ~] = fileparts(group_files(i).name);
       % Concatenate the new values to avg_all
       
       
    end
    
   
   
    % Create a new figure for the current group
    figure;
     subplot(2,1,1); % Plotting the bar plot
    bar(avg_col2{j});
    xticks(1:length(filename{j}));
    xtickangle(0);
    xticklabels(filename{j});
    ylabel('dBuV');
    title(sprintf('Comparison of avarage EM-radiation "%s"', file_groups{j}));
    
    % Interpolation plot of the results for the current group
    subplot(2,1,2); % Plotting the interpolation plot
    x = [25,48,50,52,65]; % Custom x-axis values
    xi = linspace(25, 70, 100); % Define the interpolated x values from 0.5 to 5 with 60 points
    yi = interp1(x, avg_col2{j}, xi, 'makima'); % Perform spline interpolation
    plot(x, avg_col2{j}, 'o', xi, yi, '-'); % Plot the original points and the interpolated curve
    xlabel('Gap distance (mm)'); % Update x-axis label
    ylabel('dBuV');
    title(sprintf('Interpolation of average EM-radiation "%s"', file_groups{j}));
    legend('Original Data', 'Interpolated Curve');
   
    % Bar plot of the results for the current group
 
    
    
end
figure;
avg_cell = cell(5, 1);

for l = 1:length(group_files)
    for k = 1:length(group_files)
        % Calculate the average and store it in the cell array
        avg_cell{l}(k) = mean(avg_col2{k}(l));
    end
end
avg_all = cellfun(@mean, avg_cell);
subplot(2,1,1); % Plotting the bar plot
bar(avg_all);
    xticks(1:length(filename{j}));
    xtickangle(0);
    xticklabels({ 'Imp 25', 'Imp 48', 'Imp 50','Imp 52','Imp 65'});
    ylabel('dBuV');
    title(sprintf('Comparison of average EM-radiation of impedance designs'));
 
    subplot(2,1,2); % Plotting the interpolation plot
    x = [25,48,50,52,65]; % Custom x-axis values
    xi = linspace(25, 70, 60); % Define the interpolated x values from 0.5 to 5 with 60 points
    yi = interp1(x, avg_all, xi, 'makima'); % Perform spline interpolation
    plot(x, avg_all, 'o', xi, yi, '-'); % Plot the original points and the interpolated curve
    xlabel('Characteristic impedance (Ω)'); % Update x-axis label
    ylabel('dBuV');
    title(sprintf('Interpolation of average EM-radiation of impedance designs'));
    legend('Original Data', 'Interpolated Curve');
   
    
