%============= Sit stand Test ==============%


clear
file_name = 'test_data/rotated_cam255_right_clamp_test1.aedat';
Fs = 1e1;
[allAddr, allTs] = loadaerdat(file_name);
intensityOverTime = eventIntensityOverTime(allTs, Fs);

figure
x = 1:size(intensityOverTime, 2);
plot (x, intensityOverTime);
axis tight;
ylabel('Event Intensity');
xlabel('Time elapsed in 1e-1 seconds');
title('Gait Speed Test Event Intensty Over Time');


%% Calculate total-time elaspsed based on sit stand exercise starting and ending time

clear

file_name = 'test_data/rotated_cam255_neal_standing_up2.aedat';
Fs = 1e1;
[allAddr, allTs] = loadaerdat(file_name);
intensityOverTime = eventIntensityOverTime(allTs, Fs);

threshold=100; % Difference threshold, once the difference between two consecutive insensities is above/below this number, consider it the start/end index

% Calculate start time for sit stand test based on threshold
flag1=1; % Flag so that once the start time index is found, it no longer enters the loop
for i=1:length(intensityOverTime)-1; % Loop through vector intensityOverTime - 1 to avoid accessing past the vector
    difference=abs(intensityOverTime(i+1)-intensityOverTime(i)); % calculate difference between neighboring intensities
    if difference > threshold && flag1 % If statement to determine start time index
        start_index=i;
        flag1=flag1-1;
    end
end


intensityOverTime_reverse = fliplr(intensityOverTime);
% Calculate start time for sit stand test based on threshold
flag1=1; % Flag so that once the start time index is found, it no longer enters the loop
for i=1:length(intensityOverTime_reverse)-1; % Loop through vector intensityOverTime - 1 to avoid accessing past the vector
    difference=abs(intensityOverTime_reverse(i+1)-intensityOverTime_reverse(i)); % calculate difference between neighboring intensities
    if difference > threshold && flag1 % If statement to determine start time index
        stop_index=i;
        flag1=flag1-1;
    end
end
stop_index = size(intensityOverTime,2) - stop_index;

total_time= (stop_index-start_index) * 1.0/Fs % Calculate total time
average_time=total_time/5 % Calculate average time per cycle

figure
x = 1:size(intensityOverTime, 2);
plot (x, intensityOverTime);
hold on;
plot ([start_index, stop_index], [intensityOverTime(start_index), intensityOverTime(stop_index)],'r^');
hold off;
axis tight;
ylabel('Event Intensity');
xlabel('Time elapsed in 1e-1 seconds');
title('Sit Stand Test Event Intensty Over Time');



%% Display extrema on event intensity over time plot (10 samples/s)

clear
file_name = 'test_data/rotated_cam255_neal_standing_up2.aedat';
Fs = 1e1;
[allAddr, allTs] = loadaerdat(file_name);
% Moving Average Filter
intensityOverTime = eventIntensityOverTime(allTs, Fs);


[Maxima, MaxIdx] = findpeaks(intensityOverTime);
intensityOverTime_inverse = 1.01 * max(intensityOverTime) - intensityOverTime;
[Maxima, MinIdx] = findpeaks(intensityOverTime_inverse);
% True minima
% Minima = intensityOverTime(MinIdx);

Minima = 1.01 * max(Maxima) - Maxima;


figure
x = 1:size(intensityOverTime, 2);
plot (x, intensityOverTime);
hold on;
plot (MinIdx, Minima,'r^');
hold off;
axis tight;
ylabel('Event Intensity');
xlabel('Time elapsed in 1e-2 seconds');
title('Sit Stand Test Event Intensty Over Time');


% 
% y2 = smooth(intensityOverTime,20);
% figure
% plot (x, intensityOverTime);
% hold on;
% plot(x,y2, 'r')
% [ymax2,imax2,ymin2,imin2] = extrema(y2);
% hold on
% plot(x(imax2),ymax2,'r*',x(imin2),ymin2,'g*')
% hold off


%% Display extrema on event intensity over time plot (80 samples/s)

clear
file_name = 'test_data/rotated_cam255_neal_standing_up.aedat';
Fs = 8 * 1e1;
[allAddr, allTs] = loadaerdat(file_name);
% Moving Average Filter
intensityOverTime = eventIntensityOverTime(allTs, Fs);


[Maxima, MaxIdx] = findpeaks(intensityOverTime);
intensityOverTime_inverse = 1.01 * max(intensityOverTime) - intensityOverTime;
[Maxima, MinIdx] = findpeaks(intensityOverTime_inverse);
% True minima
% Minima = intensityOverTime(MinIdx);

Minima = 1.01 * max(Maxima) - Maxima;


% figure
% x = 1:size(intensityOverTime, 2);
% plot (x, intensityOverTime);
% hold on;
% plot (MinIdx, Minima,'r^');
% hold off;
% axis tight;
% ylabel('Event Intensity');
% xlabel('Time elapsed in 1e-2 seconds');
% title('Sit Stand Test Event Intensty Over Time');


x = 1:size(intensityOverTime, 2);
y2 = smooth(intensityOverTime,20);
figure
plot (x, intensityOverTime);
hold on;
plot(x,y2, 'r')
[ymax2,imax2,ymin2,imin2] = extrema(y2);
hold on
plot(x(imax2),ymax2,'r*',x(imin2),ymin2,'g*')
hold off




%% Moving Average Filter

clear
file_name = 'test_data/rotated_cam255_neal_standing_up.aedat';
% Define Sampling frequency to be 1e2 samples/s
Fs = 1e2;
% Load data
[allAddr, allTs] = loadaerdat(file_name);
% parse the address x, y and polarity
[allAddr_x, allAddr_y, allAddr_pol] = extractRetina128EventsFromAddr(allAddr);
% Moving Average Filter
intensityOverTime = eventIntensityOverTime(allTs, Fs);
% Set window size to be 100 samples
windowSize = 100;
coeff = ones(1, windowSize)/windowSize;
averagedIntensityOverTime = filter(coeff, 1, intensityOverTime);
% Calculate filter delay
fDelay = (length(coeff)-1)/2;
% Graph both filtered out signal and original signal
x = 1:size(intensityOverTime, 2);
figure
plot (x, intensityOverTime);
hold on;
plot (x - fDelay, averagedIntensityOverTime);
hold off;
axis tight;
legend('Intensity','100 1e-2 seconds average (delayed)','location','best');
ylabel('Event Intensity');
xlabel('Time elapsed in 1e-2 seconds');
title('Sit Stand Test Event Intensty Over Time');


%% FFT
Y = fft(intensityOverTime);
L = size(intensityOverTime, 2); % even-valued signal length L.
P2 = abs(Y/L); % two-sided spectrum P2
% compute the single-sided spectrum P1 based on P2
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
% Define the frequency domain f and plot the single-sided amplitude spectrum P1.
f = Fs*(0:(L/2))/L;
figure;
plot(f,P1);
title('Single-Sided Amplitude Spectrum of EventIntensity(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');


%% Savitzky Golay Filter
