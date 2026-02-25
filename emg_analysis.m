% emg_analysis.m
clc; clear; close all;

%% 1. Përzgjedhja e Skedarit (Pa kufizime folderi)
[skedari, rruga_e_plote] = uigetfile('*.txt', 'Zgjidh skedarin EMG nga folderi i subjektit');

if isequal(skedari, 0)
    disp('Përzgjedhja u anulua.'); return;
end

% Kthejmë rrugën në një listë folderash për të gjetur emrat
% Ne kërkojmë strukturën: ... > subX > Aggressive/Normal > txt > file.txt
ndarja = strsplit(rruga_e_plote, filesep);

% Gjejmë pozicionin e folderit "sub" për të qenë dinamikë
idx_sub = find(contains(ndarja, 'sub'), 1, 'last');

if ~isempty(idx_sub)
    subjekti = ndarja{idx_sub};      % psh. sub2
    kategoria = ndarja{idx_sub + 1}; % psh. Aggressive ose Normal
else
    % Backup nëse struktura nuk është fiks ashtu
    subjekti = 'unknown_sub';
    kategoria = 'unknown_cat';
end

%% 2. Procesimi (Si më parë)
raw_data = load(fullfile(rruga_e_plote, skedari));
emg = raw_data(:, 1); 
[filtered, emg_rms] = process_emg(emg); 

%% 3. Arkivimi Automatik (Organizimi që kërkove)
path_signale = fullfile('results', subjekti, 'signals');
path_krahasime = fullfile('results', subjekti, 'comparisons');

if ~exist(path_signale, 'dir'), mkdir(path_signale); end
if ~exist(path_krahasime, 'dir'), mkdir(path_krahasime); end

% Ruajtja me emër që tregon Kategorinë dhe Lëvizjen
emri_final = [kategoria, '_', skedari(1:end-4)];
save(fullfile(path_signale, [emri_final, '.mat']), 'emg', 'filtered', 'emg_rms');

% Ruajmë grafikun për verifikim vizual
figure(1);
subplot(2,1,1); plot(emg); title(['Raw: ', subjekti, ' - ', kategoria]);
subplot(2,1,2); plot(filtered, 'r'); title(['RMS: ', num2str(emg_rms)]);
saveas(gcf, fullfile(path_signale, [emri_final, '.png']));

fprintf('U procesua: %s | Subjekti: %s | Kategoria: %s\n', skedari, subjekti, kategoria);

