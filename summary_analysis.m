%% ANALIZA PËRMBLEDHËSE E PROJEKTIT (Sub 1 - Sub 4)
clear; clc;

% 1. Të dhënat e nxjerra nga analizat paraprake
subjekte = {'Subjekti 1', 'Subjekti 2', 'Subjekti 3', 'Subjekti 4'};
raportet = [5.45, 1.49, 2.91, 3.22]; % Raportet Agresiv/Normal

% 2. Krijimi i grafikut përmbledhës
figure('Name', 'Analiza Krahasuese EMG - Të gjithë Subjektet', 'NumberTitle', 'off');
b = bar(raportet, 'FaceColor', 'flat');

% Ngjyrosja e shtyllave për dizajn profesional
b.CData(1,:) = [0.2 0.2 0.6]; % Blu e errët
b.CData(2,:) = [0.4 0.4 0.8]; % Blu mesatare
b.CData(3,:) = [0.6 0.6 1.0]; % Blu e hapur
b.CData(4,:) = [0.8 0.8 1.0]; % Blu shumë e hapur

% 3. Dekorimi i grafikut
grid on;
set(gca, 'XTickLabel', subjekte);
ylabel('Raporti i Intenzitetit (Agresiv / Normal)');
title('Krahasimi i Raportit të Aktivitetit EMG sipas Subjekteve');

% Shto vlerat mbi çdo shtyllë për qartësi
text(1:length(raportet), raportet, num2str(raportet'), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontWeight', 'bold');

% 4. Ruajtja e rezultatit final
if ~exist('results/final_summary', 'dir')
    mkdir('results/final_summary');
end
saveas(gcf, 'results/final_summary/Krahasimi_Global_Projektit.png');

fprintf('--- ANALIZA GLOBALE U KRYE --- \n');
fprintf('Grafiku u ruajt te results/final_summary/\n');