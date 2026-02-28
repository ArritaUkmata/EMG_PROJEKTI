%% GENERATE FINAL SUMMARY & EXCEL EXPORT
load('all_subjects_rms.mat');

% 1. MARRIM EMRA E LËVIZJEVE NGA STRUKTURA (Zgjidhja e Error-it)
levizjet = fieldnames(summary_table.sub1); 

% 2. FILTRIMI I SUB2 (KORRIGJIMI I 2101 -> MESATARE)
for i = 1:length(levizjet)
    v_aktuale = summary_table.sub2.(levizjet{i});
    if v_aktuale > 1200
        v_sub1 = summary_table.sub1.(levizjet{i});
        v_sub3 = summary_table.sub3.(levizjet{i});
        v_sub4 = summary_table.sub4.(levizjet{i});
        summary_table.sub2.(levizjet{i}) = (v_sub1 + v_sub3 + v_sub4) / 3;
    end
end

% 3. KRIJIMI I TABELËS PËR EXCEL
% Përdorim metodën manuale për të shmangur gabimet e përmasave
final_table = table(struct2array(summary_table.sub1)', ...
                    struct2array(summary_table.sub2)', ...
                    struct2array(summary_table.sub3)', ...
                    struct2array(summary_table.sub4)', ...
                    'VariableNames', {'Sub1','Sub2','Sub3','Sub4'}, ...
                    'RowNames', levizjet);

% 4. RUAJTJA FINALE
if ~exist('results', 'dir'), mkdir('results'); end
writetable(final_table, fullfile('results', 'Rezultatet_EMG_Final_Clean.xlsx'), 'WriteRowNames', true);

disp('--- Pastrimi u krye dhe Excel-i i ri u ruajt te folderi RESULTS! ---');