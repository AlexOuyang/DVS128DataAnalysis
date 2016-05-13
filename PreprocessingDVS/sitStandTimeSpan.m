%============= Example 2 - Standing Up 12 times + leg kicking ==============%

%% Display event intensity over time plot

clear
Fs = 1e2;
[allAddr, allTs] = loadaerdat('test_data/rotated_cam255_alex_standing_up.aedat');
% Moving Average Filter
intensityOverTime = eventIntensityOverTime(allTs, Fs);
figure
plot (intensityOverTime);
axis tight;
ylabel('Event Intensity');
xlabel('Time elapsed in 1e-2 seconds');
title('Sit Stand Test Event Intensty Over Time');


%% Moving Average Filter

clear
% Define Sampling frequency to be 1e2 samples/s
Fs = 1e2;
% Load data
[allAddr, allTs] = loadaerdat('test_data/rotated_cam255_alex_standing_up.aedat');
% parse the address x, y and polarity
[allAddr_x, allAddr_y, allAddr_pol] = extractRetina128EventsFromAddr(allAddr);
% Moving Average Filter
intensityOverTime = eventIntensityOverTime(allTs, 1e2);
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



%% Savitzky Golay Filter
