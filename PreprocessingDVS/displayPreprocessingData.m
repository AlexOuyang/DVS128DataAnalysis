%% Examples

%% Load and display data
clear
% Load the data 
[allAddr, allTs] = loadaerdat('test_data/cam255_right_clamp_test1.aedat');
% parse the address x, y and polarity
[allAddr_x, allAddr_y, allAddr_pol] = extractRetina128EventsFromAddr(allAddr);
% Display video stream
displayDVSdata(allAddr_x, allAddr_y, allAddr_pol, allTs);



%% Save rotated video stream to another file
clear
[allAddr, allTs] = loadaerdat('test_data/cam255_neal_standing_up2.aedat');
[allAddr_x, allAddr_y, allAddr_pol] = extractRetina128EventsFromAddr(allAddr);
% Rotate video by 180
[allAddr_x, allAddr_y] = rotateCoordinates(allAddr_x, allAddr_y, 1);
% Convert x, y and pol back to 32 bit 
allAddr = getTmpdiff128Addr(allAddr_x, allAddr_y, allAddr_pol);
% Save the rotated data to file
% train(:,1) are the int32 timestamps with 1us tick, 
% train(:,2) are the int32 addresses.
train(:,1) = allTs;
train(:,2) = allAddr;
% saveaerdat(train,'/Users/chenxingouyang/Documents/Github/DVS128DataAnalysis/test_data/test1.aedat');
saveaerdat(train,'test_data/rotated_cam255_neal_standing_up2.aedat');
% Load the data again
[allAddr, allTs] = loadaerdat('test_data/rotated_cam255_neal_standing_up2.aedat');
% parse the address x, y and polarity
[allAddr_x, allAddr_y, allAddr_pol] = extractRetina128EventsFromAddr(allAddr);
% Display video stream
displayDVSdata(allAddr_x, allAddr_y, allAddr_pol, allTs);




%% Standing Up 12 times + leg kicking
clear
% Load the data 
[allAddr, allTs] = loadaerdat('test_data/cam255_alex_standing_up.aedat');
% parse the address x, y and polarity
[allAddr_x, allAddr_y, allAddr_pol] = extractRetina128EventsFromAddr(allAddr);
% Rotate video by 180
[allAddr_x, allAddr_y] = rotateCoordinates(allAddr_x, allAddr_y, 1);
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
displayDVSdata(allAddr_x, allAddr_y, allAddr_pol, allTs);




