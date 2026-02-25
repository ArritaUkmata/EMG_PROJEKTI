%% Krahasimi Final - Subjekti 1
clear; clc;

% 1. DUHET NDRYSHUAR KETU:
path = fullfile('results', 'sub1', 'signals'); 

% Merr listën e skedarëve Agresivë dhe Normalë
aggr_files = dir(fullfile(path, 'Aggressive_*.mat'));
norm_files = dir(fullfile(path, 'Normal_*.mat'));

% 2. Llogarit mesataren RMS për lëvizjet Agresive
rms_aggr = [];
for i = 1:length(aggr_files)
    load(fullfile(path, aggr_files(i).name));
    rms_aggr = [rms_aggr, rms_value];
end
mean_aggr = mean(rms_aggr);

% 3. Llogarit mesataren RMS për lëvizjet Normale
rms_norm = [];
for i = 1:length(norm_files)
    load(fullfile(path, norm_files(i).name));
    rms_norm = [rms_norm, rms_value];
end
mean_norm = mean(rms_norm);

% 4. Llogarit raportin
ratio = mean_aggr / mean_norm;

% 5. Shfaq rezultatet
fprintf('--- REZULTATET PËR SUBJEKTIN 1 ---\n');
fprintf('Mesatarja RMS Agresive: %.4f\n', mean_aggr);
fprintf('Mesatarja RMS Normale: %.4f\n', mean_norm);
fprintf('Raporti (Agresiv/Normal): %.2f fish\n', ratio);

% 6. Krijo Grafikun
figure;
b = bar([mean_aggr, mean_norm], 'FaceColor', 'flat');
b.CData(1,:) = [1 0 0]; 
b.CData(2,:) = [0 1 0]; 
set(gca, 'XTickLabel', {'Agresive', 'Normale'});
title(['Krahasimi RMS - Subjekti 1 (Raporti: ', num2str(ratio, '%.2f'), ')']);
ylabel('Vlera RMS');
grid on;

% 7. Ruaj grafikun (Pa slash-in te sub1)
saveas(gcf, fullfile('results', 'sub1', 'comparisons', 'Krahasimi_Final_Sub1.png'));