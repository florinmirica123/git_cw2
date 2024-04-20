clear 
clc

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
a=arduino('COM5','Uno');

duration = 120; %aquisition time in seconds
TC = 0.01; %temperature coefficient from sensor documentation
V0 = 0.5; %zero-degree voltage

analogPin = 'A0'; %specifying the analog used on the arduino 


time = linspace(0,120,120); %arrays that will contain the data
voltageValues = zeros(1, duration);
temperatureData = zeros(1,duration);


for i = 1:duration
    % Read the voltage from the analog pin
    voltage = readVoltage(a, 'A0');  
    % Save the data to arrays
    voltageValues(i) = voltage;
    temperatureData(i) = (voltageValues(i) - V0) / TC;%Convert voltage to temperature using the formula: temperature = (voltage - V0) / TC
    pause(1); %takes reading every 1 second
    

end

minValue = min(temperatureData); %finds lowest value of temperature from the data
maxValue = max(temperatureData); %finds the highest values of temperature from the data
averageValue = mean(temperatureData); %finds the average value of temperature from the data
fprintf('Lowest temperature: %2f\n',minValue);
fprintf('Highest temperature: %2f\n',maxValue);
fprintf('Average temperature: %2f\n',averageValue);

plot(time,temperatureData, 'b-', 'LineWidth', 1.5);
xlabel('Time (seconds)');
ylabel('Temperature (\circC)'); 
title('Temperature Readings from Thermistor');
grid on;

%% Output to screen formatting example
date = input('What is the date today?', 's');
d = sprintf('Data logging initiated - %s', date);
location = input('What location are you taking the temperature recordings from? ', 's');
l = sprintf('Location - %s', location);

for t = 1:59
    fsprintf('Minute \t0 \nTemperature %2f C', temperatureData);
end
    



