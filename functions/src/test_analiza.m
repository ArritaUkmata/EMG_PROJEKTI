clear all; close all; clc;

% 1. Ngarkimi i të dhënave të tua
data = readmatrix('Elbowing.txt'); 
F = 1000; % Frekuenca jote është 1000Hz
T = 1/F;
K = length(data(:,1));
t = (0:K-1)*T;

% 2. Përzgjedhja e kanalit (psh. Kanali 1)
emg1 = data(:,1);
emg1 = emg1 - mean(emg1); % Hiq DC offset

% 3. Filtri Notch (Heq zhurmën 50Hz të prizave)
d = designfilt('bandstopiir','FilterOrder',2, ...
    'HalfPowerFrequency1',48,'HalfPowerFrequency2',52, ...
    'DesignMethod','butter','SampleRate',F);
filtered = filtfilt(d, emg1);

% 4. Krijimi i "Zarfit" (Envelope) - RMS
NMittel = 100; % Dritarja për lëmuar sinjalin
aMittel = ones(1, NMittel)/NMittel;
emg1envelop = sqrt(conv(filtered.^2, aMittel, 'same'));

% 5. Vizualizimi (Interpretimi)
figure;
plot(t, filtered, 'b'); hold on;
plot(t, emg1envelop, 'r', 'LineWidth', 2);
plot(t, -emg1envelop, 'r', 'LineWidth', 2);
title('Sinjali i Filtruar dhe Zarfi RMS (Elbowing)');
xlabel('Koha (s)'); ylabel('Amplituda (mV)');
legend('EMG e Filtruar', 'RMS Envelope');