%============= Example ==============%

% Load the data 
[allAddr, allTs] = loadaerdat('/../test_data/cam255_alex_standing_up.aedat');
% parse the address x, y and polarity
[allAddr_x, allAddr_y, allAddr_pol] = extractRetina128EventsFromAddr(allAddr);
% Rotate video by 180
[allAddr_x, allAddr_y] = rotateCoordinates(allAddr_x, allAddr_y, 2);
% Display video stream
displayDVSdata(allAddr_x, allAddr_y, allAddr_pol, allTs);













