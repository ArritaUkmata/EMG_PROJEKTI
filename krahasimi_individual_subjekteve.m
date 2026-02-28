%% KRAHASIMI I LËVIZJEVE DHE KORRIGJIMI I SATURIMIT
load('all_subjects_rms.mat'); % Ngarkon të dhënat

subjekte = fieldnames(summary_table);
levizjet = fieldnames(summary_table.sub1);

for s = 1:length(subjekte)
    vlerat_rms = struct2array(summary_table.(subjekte{s}));
    
  % --- KORRIGJIMI GLOBAL PËR SUBJEKTIN 2 ---
if strcmp(subjekte{s}, 'sub2')
    disp('Po pastrohet i gjithë Subjekti 2 nga zhurma elektrike...');
    
    % Kontrollojmë çdo lëvizje (kolonë) të sub2
    for i = 1:length(vlerat_rms)
        % Nëse një vlerë kalon 1200 (limit i arsyeshëm për këtë dataset)
        if vlerat_rms(i) > 1200
            % E zëvendësojmë me një vlerë më reale (mesataren e lëvizjeve të pastra)
            vlerat_rms(i) = mean(vlerat_rms(vlerat_rms < 1200));
        end
    end
end
% -----------------------------------------

    figure('Name', ['Analiza ' subjekte{s}]);
    bar(vlerat_rms);
    set(gca, 'XTick', 1:length(levizjet), 'XTickLabel', levizjet, 'TickLabelInterpreter', 'none');
    xtickangle(45);
    title(['Vlerat RMS për ' subjekte{s} ' (KORRIGJUAR)']);
    grid on;

    % Ruajtja e fotos së pastër
    saveas(gcf, fullfile('results', subjekte{s}, ['analiza_rms_' subjekte{s} '_pastruar.png']));
end
disp('--- Grafikët u korrigjuan dhe u ruajtën te folderi RESULTS ---');