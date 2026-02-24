function [data_filtered, data_rectified, data_rms, t] = preprocess_emg(file_path, fs)
    % Lexon të dhënat
    data = readmatrix(file_path);
    
    % DC removal (Heqja e vlerës mesatare)
    data_demeaned = data - mean(data);
    
    % Band-pass filter 20-450 Hz
    [b,a] = butter(4, [20 450]/(fs/2), 'bandpass');
    data_filtered = filtfilt(b,a,data_demeaned);
    
    % Rectification (Kthimi në vlera pozitive)
    data_rectified = abs(data_filtered);
    
    % RMS envelope (Zarfi i fuqisë)
    window = round(0.1*fs);
    data_rms = sqrt(movmean(data_rectified.^2, window));
    
    % Vektori i kohës
    t = (0:size(data,1)-1)/fs;
end
