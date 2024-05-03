% Florin Mirica 
% efyfm5@nottingham.ac.uk

clear 
clc
%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]
a=arduino('COM5','Uno'); %assigning a variable a to Arduino function
% Defines the digital pin for the LED
greenPin = 'D2';

% Sets pin mode to output
configurePin(a, greenPin, 'DigitalOutput');

% Blinks the LED
for i = 1:1000
    writeDigitalPin(a,greenPin,1) %turn LED on
    pause(1) %wait 0.5 seconds
    writeDigitalPin(a,greenPin,0) %turn LED off
    pause(1)
end

clear a;
%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
arduino_variable()
analogPin = 'A0'; %specifying the analog used on the arduino 

file_id = ("cabin_temperature.txt"); %defines file name
fopen("cabin_temperature.txt",'w'); %creates a text file to write results in

d = 600; %aquisition time in seconds
TC = 0.01; %temperature coefficient from sensor documentation
V0 = 0.5; %zero-degree voltage

time = 1:600; %arrays that will contain the data
voltageValues = zeros(1, d);
temperatureData = zeros(1,d);

for i = 1:d
    % Read the voltage from the analog pin
    voltage = readVoltage(a, 'A0');  
    % Save the data to arrays
    voltageValues(i) = voltage; %saves the voltage readings to the array 
    temperatureData(i) = (voltageValues(i) - V0) / TC; %Convert voltage to temperature using the formula: temperature = (voltage - V0) / TC
    pause(1); %takes reading every 1 second
    

end

minValue = min(temperatureData); %finds lowest value of temperature from the data
maxValue = max(temperatureData); %finds the highest values of temperature from the data
averageValue = mean(temperatureData); %finds the average value of temperature from the data
fprintf('Lowest temperature: %2f\n',minValue);
fprintf('Highest temperature: %2f\n',maxValue);
fprintf('Average temperature: %2f\n',averageValue);

plot(time,temperatureData, 'b-', 'LineWidth', 1.5); %plots the temperatures against time with a blue line
xlabel('Time (seconds)'); %labels x axis
ylabel('Temperature (\circC)'); %labels y axis
title('Temperature Readings from Thermistor'); %gives title to plot
grid on; 
%% Output to screen formatting example
date = input('What is the date today?', 's'); %allows the user to input values for date and location
location = input('\nWhat location are you taking the temperature recordings from? ', 's'); 

d = fprintf('\nData logging initiated - %s', date); %outputs to the user the date entered as a string 
l = fprintf('Location - %s', location); %outputs to the user the location entered as a string 

for i = 1:1 %for loop used so that when the timer starts it outputs to the user the minute and temperature at that time
    fprintf('\n\nMinute \t0 \nTemperature %2f C', temperatureData(1)); %temperatureData(1) is the first value recorded for the temperature
end

for i = 60:60
    fprintf('\n\nMinute \t1 \nTemperature %2f C', temperatureData(60));
end

for i = 120:120
    fprintf('\n\nMinute \t2 \nTemperature %2f C', temperatureData(120));
end

for i = 180:180
    fprintf('\n\nMinute \t3 \nTemperature %2f C', temperatureData(180));
end

for i = 240:240
    fprintf('\n\nMinute \t4 \nTemperature %2f C', temperatureData(240));
end

for i = 300:300
    fprintf('\n\nMinute \t5 \nTemperature %2f C', temperatureData(300));
end

for i = 360:360
    fprintf('\n\nMinute \t6 \nTemperature %2f C', temperatureData(360));
end

for i = 420:420
    fprintf('\n\nMinute \t7 \nTemperature %2f C', temperatureData(420));
end

for i = 480:480
    fprintf('\n\nMinute \t8 \nTemperature %2f C', temperatureData(480));
end

for i = 540:540
    fprintf('\n\nMinute \t9 \nTemperature %2f C', temperatureData(540));
end

for i = 600:600
    fprintf('\n\nMinute \t10 \nTemperature %2f C', temperatureData(600));
end

%Display maximum, minimum and average vaklue of temperature to the user
ma = fprintf('\nMax temp \t %2f C', maxValue);
mi = fprintf('\nMin temp \t %2f C', minValue);
avg = fprintf('\nAverage temp \t %2f C', averageValue);

o = fprintf('\n\nData logging terminated'); 

clear a;
%% TASK 2 – LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]
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
writeDigitalPin(a, greenLED, 0); % Turn off green LED.
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


%% TASK 3 – ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]
clear 
clc

a = arduino('COM5', 'Uno'); 
maxDataPoints = 300;
temperatureArray = NaN(1,maxDataPoints);

for i = 1:maxDataPoints
    voltage = readVoltage(a, 'A0');
    pause(1)
    temperature = (voltage - 0.5) * 100.0;
    temperatureArray(i) = temperature;

% Calculate rate of temperature change C/s (derivative)
dt = 1; % Time interval between samples
dTemperature_dt = diff(temperatureArray, dt);
fprintf('\nRate of Change of Temperature (C/s) is %2f :', dTemperature_dt);

%I tried to calculate the rate of change per minute and then x by 5 to
%predict the tenmperature in 5 minutes time
% for j = 60:60
%     dTemperature_dt = diff(temperatureArray, 60);
%     fprintf('\nRate of Change of Temperature (C/min) is %2f:', dTemperature_dt());
% end

end

%% TASK 4 – REFLECTIVE STATEMENT [5 MARKS]
%Some challenges that I have faced are not being able to fully utilise the
%functions which could make my life easier by not having to repeat code.
%Not every task had similar values and therefore I got confused reusing
%functions as I did not know how to change the input values. I also struggled with the live plot and I watched a lot of videos of different uses. 
% My strengths were being organised and saving my code after every session in the git
%repository. This ensured that I did not lose my code. Doing the flowchart
%was also a strength as it allowed me to problem solve more efficiently. Building the circuit using the breadboard and arduino was also a strength of mine 
% as the LEDS and thermistor were working well.
% A limitation for this project was that I was not able to reuse my code and
%having to copy and paste it which makes it more cluttered that it should
%be. Suggested future improvements, learning how to use the differential
%command when using the values in an array and using specific values from
%that array, learning how to use functions so I don't have to reuse code.

