%============= Example 2 - Standing Up 12 times + leg kicking ==============%

%% Display event intensity over time plot

clear
Fs = 1e1;
[allAddr, allTs] = loadaerdat('test_data/rotated_cam255_neal_standing_up2.aedat');
% Moving Average Filter
intensityOverTime = eventIntensityOverTime(allTs, Fs);
figure
plot (intensityOverTime);
axis tight;
ylabel('Event Intensity');
xlabel('Time elapsed in 1e-1 seconds');
title('Sit Stand Test Event Intensty Over Time');
% figure;

%% Calculate total-time elaspsed
flag1=1; % Flag so that once the start time index is found, it no longer enters the loop
flag2=1; % Flag so that once the end time index is found, it no longer enters the loop
threshold=100; % Difference threshold, once the difference between two consecutive insensities is above/below this number, consider it the start/end index
for i=1:length(intensityOverTime)-1; % Loop through vector intensityOverTime - 1 to avoid accessing past the vector
    difference=abs(intensityOverTime(i+1)-intensityOverTime(i)); % calculate difference between neighboring intensities
    if difference > threshold && flag1 % If statement to determine start time index
        start_index=i;
        flag1=flag1-1;
    else difference< threshold && flag2 % Else statment to determine end time index
        stop_index=i;
        flag2=flag2-1;
    end
end
    total_time= (stop_index-start_index)*0.1 % Calculate total time
    average_time=total_time/5 % Calculate average time per cycle
    stop_index % Show end index
    start_index % Show start index
%% Apply a window to the time-series data and then FFT
m=0:1023;
%freq_H_1024=((m*2*pi/1024)-(pi))/(2*pi); % Define normalized frequency
FFT_Intensity=fftshift(fft(intensityOverTime,1024)); % Take 1024 point DFT and center at 0
plot(abs(FFT_Intensity)); % Plot magintude response
title('FFT Plot of Intensity over time signal');
xlabel('Normalized Frequency (cycles/sample)');
ylabel('Magnitude');
figure;

intensityOverTime_2=[intensityOverTime, zeros(1,816)]; % Pad IntensityOverTime with zeros to make same length as window
hann_win=transpose(hann(1024)); % Create 1024-point hanning window
intensityOverTime_win=intensityOverTime_2.*hann_win; % Window the time-series signal to get rid of spectral leakage
FFT_windowed_signal=fftshift(fft(intensityOverTime_win,1024));
plot(abs(FFT_windowed_signal)); % Plot magintude response
title('FFT Plot of windowed Intensity over time signal');
xlabel('Normalized Frequency (cycles/sample)');
ylabel('Magnitude');


