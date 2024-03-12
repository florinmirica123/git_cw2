% Florin Mirica 
% efyfm5@nottingham.ac.uk

clear 
clc
%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]
a=arduino('COM5','Uno');

% Defines the digital pin for the LED
greenPin = 'D2';

% Sets pin mode to output
configurePin(a, greenPin, 'DigitalOutput');

% Number of times that the LED will blink
blinks = 10;

% Blinks the LED
for i = 1:blinks
    writeDigitalPin(a,greenPin,1) %turn LED on
    pause(0.5) %wait 0.5 seconds
    writeDigitalPin(a,greenPin,0) %turn LED off
    pause(0.5)
end

