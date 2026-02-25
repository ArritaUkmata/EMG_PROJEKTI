% krahasimi_sub2.m
clc; clear; close all;

% Rruga drejt rezultateve të Sub2
path = fullfile('results', 'sub2', 'signals');

% Listojmë të gjithë skedarët .mat
files = dir(fullfile(path, '*.mat'));

rms_normal = [];
rms_aggressive = [];

for i = 1:length(files)
    load(fullfile(path, files(i).name));
    
    % Kontrollojmë nëse emri fillon me "Normal" apo "Aggressive"
    if contains(files(i).name, 'Normal')
        rms_normal = [rms_normal, emg_rms];
    elseif contains(files(i).name, 'Aggressive')
        rms_aggressive = [rms_aggressive, emg_rms];
    end
end

% Llogaritja e mesatareve
mean_norm = mean(rms_normal);
mean_aggr = mean(rms_aggressive);

% Krijimi i grafikut Bar Chart
figure('Color', 'w', 'Name', 'Rezultati Final - Sub2');
bar([mean_norm, mean_aggr], 0.6, 'FaceColor', 'flat');
ax = gca;
ax.XTickLabel = {'Levizje Normale', 'Levizje Agresive'};
ylabel('Vlera Mesatare RMS');
title('Krahasimi i Intensitetit EMG: Subjekti 2');

% Shtimi i vlerave mbi shtylla
text(1, mean_norm, num2str(mean_norm, '%.2f'), 'Horiz','center', 'Vert','bottom');
text(2, mean_aggr, num2str(mean_aggr, '%.2f'), 'Horiz','center', 'Vert','bottom');

grid on;
fprintf('Analiza u krye! Raporti Agresiv/Normal: %.2f fish\n', mean_aggr/mean_norm);