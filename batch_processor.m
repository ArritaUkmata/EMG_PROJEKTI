%% Automatizimi i Procesimit me Emërtim Inteligjent
clear; clc;

% 1. Përcakto rrugën e folderit (NDRYSHO KËTË SIPAS NEVOJËS)
% Për raundin e parë: 'data/sub1/Aggressive/txt/'
% Për raundin e dytë: 'data/sub1/Normal/txt/'
inputFolder = 'data/sub1/Normal/txt/'; 
outputFolder = 'results/sub1/signals/';

% 2. Përcakto automatikisht prefiksin bazuar te rruga
if contains(inputFolder, 'Aggressive')
    prefix = 'Aggressive_';
else
    prefix = 'Normal_';
end

% 3. Merr listën e skedarëve
files = dir(fullfile(inputFolder, '*.txt'));
fprintf('Duke procesuar %d skedarë me prefiksin: %s\n', length(files), prefix);

for i = 1:length(files)
    fileName = files(i).name;
    fullPath = fullfile(inputFolder, fileName);
    
    % Leximi i të dhënave
    data = load(fullPath);
    emg_signal = data(:, 1); 
    
    % Llogaritjet
    rect_signal = abs(emg_signal);
    rms_value = rms(emg_signal);
    
    % --- EMRI I RI I SKEDARIT ---
    cleanName = strrep(fileName, '.txt', ''); % Heq prapashtesën .txt
    finalBaseName = [prefix, cleanName];      % Rezultati: Aggressive_Punching
    
    % Ruajtja .mat
    save(fullfile(outputFolder, [finalBaseName, '.mat']), 'emg_signal', 'rect_signal', 'rms_value');
    
    % Ruajtja .png (Grafiku)
    fig = figure('Visible', 'off'); 
    plot(emg_signal);
    title(['Sinjali: ', finalBaseName, ' | RMS: ', num2str(rms_value)]);
    saveas(fig, fullfile(outputFolder, [finalBaseName, '.png']));
    close(fig);
    
    fprintf('U ruajt: %s\n', finalBaseName);
end

fprintf('--- PËRFUNDOI! Kontrollo folderin: %s ---\n', outputFolder);