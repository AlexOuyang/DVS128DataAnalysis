function [ y_intensity ] = eventIntensityOverTime( allTs, sampling_rate )
    % eventIntensityOverTime takes input allTs and sampling_rate and
    % outputs a plot of the event intensity of x amount of seconds
    %
    % INPUT allTs: vector that holds the time stamps of events
    %       sampling_rate: number of points to obtain in a second,
    %       preferred numbers are 1, 1e1 1e2.
    %       
    %
    % OUTPUT y_intensity: holds vectors of event intensities per unit time
    %
    %        
    %
    % REMARKS
    %
    % SEE ALSO
    
    
    
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

