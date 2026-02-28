%% Procesimi i Plotë i Subjektit 1 (Me Tituj të Rregulluar)
clear; clc; close all;
addpath('functions');

subjekt = 'sub4';
kategorite = {'Normal', 'Aggressive'};

for k = 1:length(kategorite)
    kategoria = kategorite{k};
    inputFolder = fullfile('data', subjekt, kategoria, 'txt');
    outputFolder = fullfile('results', subjekt, 'signals');
    
    if ~exist(outputFolder, 'dir'), mkdir(outputFolder); end
    
    files = dir(fullfile(inputFolder, '*.txt'));
    fprintf('\n--- Duke procesuar %s (%s) ---\n', subjekt, kategoria);

    for i = 1:length(files)
        fileName = files(i).name;
        fullPath = fullfile(inputFolder, fileName);
        
        try
            [emg_signal, rms_envelope, t] = preprocess_emg(fullPath, 1000);
            
            rms_value = mean(rms_envelope);
            cleanName = strrep(fileName, '.txt', ''); 
            finalBaseName = [kategoria, '_', cleanName];      
            
            % --- LLOGARITJA E FFT ---
            L = length(emg_signal);
            Y = fft(emg_signal);
            P2 = abs(Y/L);
            P1 = P2(1:floor(L/2)+1);
            P1(2:end-1) = 2*P1(2:end-1);
            f = 1000*(0:(L/2))/L;

            % --- KRIJIMI I GRAFIKUT (Kohë + Frekuencë) ---
            fig = figure('Visible', 'off'); 
            
            % Lart: Koha
            subplot(2,1,1);
            plot(t, emg_signal, 'Color', [0.7 0.7 0.7]); hold on;
            plot(t, rms_envelope, 'r', 'LineWidth', 1.5);
            
            % RREGULLIMI FINAL I TITULLIT
            titulli_tekst = sprintf('Sinjali: %s | RMS: %.2f', finalBaseName, rms_value);
            title(titulli_tekst, 'Interpreter', 'none'); 
            
            ylabel('Amplituda (mV)'); grid on;

            % Poshtë: Frekuenca (FFT)
            subplot(2,1,2);
            plot(f, P1, 'b');
            title('Spektri i Frekuencave (FFT)');
            xlabel('Frekuenca (Hz)'); ylabel('|P1(f)|');
            xlim([0 500]); grid on;
            
            % Ruajtja e rezultateve (Do të kenë orën e re 4:50 PM+)
            saveas(fig, fullfile(outputFolder, [finalBaseName, '.png']));
            save(fullfile(outputFolder, [finalBaseName, '.mat']), 'emg_signal', 'rms_envelope', 'rms_value', 't', 'f', 'P1');
            close(fig);
            
            fprintf('U rregullua: %s\n', finalBaseName);
            
        catch ME
            fprintf('GABIM te %s: %s\n', fileName, ME.message);
        end
    end
end
fprintf('\n--- 4 U PËRFUNDUA ME SUKSES DHE TITUJ TË RREGULLUAR! ---\n');