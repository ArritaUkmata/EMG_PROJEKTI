%% Krahasimi Final - Subjekti 4
clear; clc;

% Rruga ku ndodhen sinjalet e procesuara për Subjektin 4
path = fullfile('results', 'sub4', 'signals');

% 1. Merr listën e skedarëve Agresivë dhe Normalë
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

% 5. Shfaq rezultatet në Command Window
fprintf('--- REZULTATET PËR SUBJEKTIN 4 ---\n');
fprintf('Mesatarja RMS Agresive: %.4f\n', mean_aggr);
fprintf('Mesatarja RMS Normale: %.4f\n', mean_norm);
fprintf('Raporti (Agresiv/Normal): %.2f fish\n', ratio);

% 6. Krijo Grafikun Krahasues
figure;
b = bar([mean_aggr, mean_norm], 'FaceColor', 'flat');
b.CData(1,:) = [1 0 0]; % E kuqe për Agresive
b.CData(2,:) = [0 1 0]; % E gjelbër për Normale

set(gca, 'XTickLabel', {'Agresive', 'Normale'});
title(['Krahasimi RMS - Subjekti 4 (Raporti: ', num2str(ratio, '%.2f'), ')']);
ylabel('Vlera RMS');
grid on;

% 7. Ruaj grafikun te folderi comparisons
saveas(gcf, fullfile('results', 'sub4', 'comparisons', 'Krahasimi_Final_Sub4.png'));