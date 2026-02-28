% 1. Marrim emrat e lëvizjeve (rreshtat)
emrat_levizjeve = fieldnames(summary_table.sub1);

% 2. Krijojmë tabelën
tabela_per_excel = struct2table(summary_table);

% 3. Sigurohemi që numri i emrave përputhet me rreshtat e tabelës
if height(tabela_per_excel) == length(emrat_levizjeve)
    tabela_per_excel.Properties.RowNames = emrat_levizjeve;
else
    % Nëse ka mosperputhje, e kthejmë në formatin e duhur (transpose)
    tabela_per_excel = table(struct2array(summary_table.sub1)', ...
                             struct2array(summary_table.sub2)', ...
                             struct2array(summary_table.sub3)', ...
                             struct2array(summary_table.sub4)', ...
                             'VariableNames', {'Sub1','Sub2','Sub3','Sub4'}, ...
                             'RowNames', emrat_levizjeve);
end

% 4. Ruajtja finale
if ~exist('results', 'dir'), mkdir('results'); end
writetable(tabela_per_excel, fullfile('results', 'Rezultatet_EMG_Final.xlsx'), 'WriteRowNames', true);

disp('--- SKEDARI EXCEL U KRIJUA ME SUKSES TE FOLDERI RESULTS! ---');