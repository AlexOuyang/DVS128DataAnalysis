%============= Example 2 - Standing Up 12 times + leg kicking ==============%

%% Display event intensity over time plot
clear
[allAddr, allTs] = loadaerdat('test_data/rotated_cam255_alex_standing_up.aedat');
% parse the address x, y and polarity
[allAddr_x, allAddr_y, allAddr_pol] = extractRetina128EventsFromAddr(allAddr);
% Display video stream
% displayDVSdata(allAddr_x, allAddr_y, allAddr_pol, allTs);
% Plot event intensity over time
plot(eventIntensityOverTime(allTs, 1e2));
