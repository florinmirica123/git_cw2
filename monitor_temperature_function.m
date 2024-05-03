function monitor_temperature_function ()
%Summary: This function reads temperature data, plots live graph of temperature against
%time and manipulates LEDs to tell the user what the temperature is
%Detailed explanation: drawnow command was used to update the graph and
%old values of temperature were shifted to the left so that the graph can
%fill the values for as many data points required


% Initialize Arduino connection
a = arduino('COM5', 'Uno'); 

% Initialize variables for plotting
maxDataPoints = 1000; % Number of data points to display
temperatureArray = NaN(1,maxDataPoints); %creating an array of a certain size before filling it with temperature data
x = 1:maxDataPoints; %sets limits in the x-axis
y = zeros(1, maxDataPoints); %sets limits in the y-axis

% Create a live plot
figure;
h = plot(x, y); %creates an animated line
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('Live Temperature Plot');
grid on;


% Read and update data
for i = 1:maxDataPoints
    voltage = readVoltage(a, 'A0');
    temperature = (voltage - 0.5) * 100.0;
    
    % Shift data to the left (remove oldest value)
    y(1:end-1) = y(2:end);
    y(end) = temperature;
    temperatureArray(i) = temperature; %update temperatures in the array with the new values
    set(h, 'YData', y); % Update plot
    drawnow; % Refresh plot
    pause(1); % Wait for 1 second

% Define LED pins 
yellowLED = 'D2';
greenLED = 'D3';
redLED = 'D4';

% Initialize LEDs
writeDigitalPin(a, yellowLED, 0); % Turn off yellow LED.
writeDigitalPin(a, greenLED, 0); % Turn off blue LED.
writeDigitalPin(a, redLED, 0); % Turn off red LED.

% Control LEDs based on temperature
    if temperature >= 18 && temperature <= 24 %if temperature is in between the range green LED should be constant
        writeDigitalPin(a, greenLED, 1); % Turn on green LED.
    elseif temperature < 18
        writeDigitalPin(a, yellowLED, 1); % Blink yellow LED.
        pause(0.5); % Wait 0.5 seconds.
        writeDigitalPin(a, yellowLED, 0); % Turn off yellow LED.
    elseif temperature > 24
        writeDigitalPin(a, yellowLED, 0); % Turn off yellow LED.
        writeDigitalPin(a, greenLED, 0); % Turn off green LED.
        writeDigitalPin(a, redLED, 1); % Blink red LED.
        pause(0.25); % Wait 0.25 seconds.
        writeDigitalPin(a, redLED, 0); % Turn off red LED.
    end
end

end




