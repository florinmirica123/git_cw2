function read_temperature_function()

%This function reads the temperature 

a = arduino('COM5', 'Uno');
maxDataPoints = 300; 
temperatureArray = NaN(1,maxDataPoints);

for i = 1:maxDataPoints
    voltage = readVoltage(a, 'A0');
    temperature = (voltage - 0.5) * 100.0;
    pause(1)
    temperatureArray(i) = temperature;
    disp(temperature)
end

