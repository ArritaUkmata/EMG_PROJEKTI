function [filtered_signal, rms_value] = process_emg(raw_data)
    % 1. Heqja e Offset-it (DC component)
    detrended = raw_data - mean(raw_data);
    
    % 2. Rektifikimi (Vlera absolute)
    rectified = abs(detrended);
    
    % 3. Filtrimi i thjeshtë (Moving Average për zarfimin e sinjalit)
    window_size = 50; 
    filtered_signal = movmean(rectified, window_size);
    
    % 4. Llogaritja e RMS (Fuqia e sinjalit)
    rms_value = rms(detrended);
end