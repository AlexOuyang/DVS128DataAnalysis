%% Calculate total-time elaspsed based on sit stand exercise starting and ending time

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
