%============= Example 2 - Standing Up 12 times + leg kicking ==============%

%% Display extrema on event intensity over time plot (10 samples/s)

clear
Fs = 1e1;
[allAddr, allTs] = loadaerdat('test_data/rotated_cam255_neal_standing_up.aedat');
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


%% Display extrema on event intensity over time plot (100 samples/s)

clear
Fs = 8 * 1e1;
[allAddr, allTs] = loadaerdat('test_data/rotated_cam255_neal_standing_up.aedat');
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


%% Calculate total-time elaspsed based on sit stand exercise starting and ending time

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



%% Moving Average Filter

clear
% Define Sampling frequency to be 1e2 samples/s
Fs = 1e2;
% Load data
[allAddr, allTs] = loadaerdat('test_data/rotated_cam255_neal_standing_up2.aedat');
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
