function [addr_x, addr_y] = rotateCoordinates(x, y, orientation)
    %ROTATECOORDINATES Rotate aerdat address x and y coordinates based on orientation
    %
    % INPUT x: column holds aerdat address x coordinate
    %       y: column holds aerdat address y coordinate
    %       orientation: 1-rotate 90, 2-rotate 180, 3-rotate 270
    %
    % OUTPUT addr_x: column of rotated x coordinate
    %        addr_y: column of rotated y coordinate
    %
    % REMARKS
    %
    % SEE ALSO
    
    frame_dim = 128/2; % DVS frame is 128 by 128
    coordinates = [x'; y']';
    
    if orientation == 1 || orientation == 2 || orientation == 3
        
        % zero mean the data to center the frame
        coordinates = coordinates - frame_dim;
        
        if orientation == 2        % rotate 180
            coordinates(:,2) = -coordinates(:,2);
        elseif orientation == 1    % rotate 90
            % theta = pi/2;
            % rot_mat = [cos(theta) -sin(theta); sin(theta) cos(theta)];
            rot_90_mat = [0, -1; 1, 0];
            for n = 1:size(coordinates, 1)
                coordinates(n,:) =  coordinates(n,:) * rot_90_mat; % rotate each coordinate
            end
        elseif orientation == 3    % rotate 270
            rot_270_mat = [0, 1; -1, 0];
            for n = 1:size(coordinates, 1)
                coordinates(n,:) =  coordinates(n,:) * rot_270_mat; % rotate each coordinate
            end
        end
        
        % translate the frame back to original position
        coordinates = coordinates + frame_dim;
    end
    
    addr_x = coordinates(:,1);
    addr_y = coordinates(:,2);
end

