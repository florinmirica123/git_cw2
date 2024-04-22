clear 
clc

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]
a=arduino('COM5','Uno');
analogPin = 'A0'; %specifying the analog used on the arduino 


duration = 600; %aquisition time in seconds
TC = 0.01; %temperature coefficient from sensor documentation
V0 = 0.5; %zero-degree voltage

time = 1:600; %arrays that will contain the data
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
location = input('\nWhat location are you taking the temperature recordings from? ', 's');

d = fprintf('\nData logging initiated - %s', date);
l = fprintf('Location - %s', location);

for i = 1:1
    fprintf('\n\nMinute \t0 \nTemperature %2f C', temperatureData(1));
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

ma = fprintf('\nMax temp \t %2f C', maxValue);
mi = fprintf('\nMin temp \t %2f C', minValue);
avg = fprintf('\nAverage temp \t %2f C', averageValue);

o = fprintf('\n\nData logging terminated');


    



