function [ y_intensity ] = eventIntensityOverTime( allTs, sampling_rate )
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    
    
    
    % Because time stamps from dvs128 is in microseconds, so we need offest it
    res = 1e6/sampling_rate;
    num_of_seconds = allTs(size(allTs,1))/res - allTs(1)/res;
    x_time = 0:num_of_seconds;
    second_counter = allTs(1)/res;
    y_intensity = zeros(0,num_of_seconds);
    intensity = 0;
    counter = 1;
    for i = 1:size(allTs)
        if allTs(i)/res == second_counter
            intensity = intensity + 1;
        else
            y_intensity(counter) = intensity;
            second_counter = second_counter + 1;
            counter = counter + 1;
            intensity = 0;
        end
    end
    
end

