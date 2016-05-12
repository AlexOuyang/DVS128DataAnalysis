%============= Example 2 - Standing Up 12 times + leg kicking ==============%

clear
% Load the data 
[allAddr, allTs] = loadaerdat('test_data/cam255_alex_standing_up.aedat');
% parse the address x, y and polarity
[allAddr_x, allAddr_y, allAddr_pol] = extractRetina128EventsFromAddr(allAddr);
% Rotate video by 180
[allAddr_x, allAddr_y] = rotateCoordinates(allAddr_x, allAddr_y, 1);
% Display video stream
% displayDVSdata(allAddr_x, allAddr_y, allAddr_pol, allTs);
% Convert x, y and pol back to 32 bit 
allAddr = getTmpdiff128Addr(allAddr_x, allAddr_y, allAddr_pol);
% Save the rotated data to file
% train(:,1) are the int32 timestamps with 1us tick, 
% train(:,2) are the int32 addresses.
train(:,1) = allTs;
train(:,2) = allAddr;
% saveaerdat(train,'/Users/chenxingouyang/Documents/Github/DVS128DataAnalysis/test_data/test1.aedat');
saveaerdat(train,'test_data/rotated_cam255_alex_standing_up.aedat');
% Load the data again
[allAddr, allTs] = loadaerdat('test_data/rotated_cam255_alex_standing_up.aedat');
% parse the address x, y and polarity
[allAddr_x, allAddr_y, allAddr_pol] = extractRetina128EventsFromAddr(allAddr);
% Display video stream
% displayDVSdata(allAddr_x, allAddr_y, allAddr_pol, allTs);
% Plot event intensity over time
plot(eventIntensityOverTime(allTs, 1e2));
