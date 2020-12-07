%% This function generate the output signals, FSCV ramp ViRamp, 2 times FSCV ramp ViRamp_2, and ground

function VRamp = generateRamp (f) 


% 1. set the amplitude of the ramp function
Amplitude = f.Voltage_High-f.Voltage_Low; 
Duration=(f.Voltage_High-f.Voltage_Low)/f.Ramp_Rate*2; % Seconds ( will be the width of the pulse)
% 2. set duration of ramp ( time, T values where ramp exists) 
T1 = -1/f.Repetition_Rate:1/f.Generation_Rate:1/f.Repetition_Rate;
% 3. create the ramp using the triplus built-in matlab function to create
% trianglular pulses
VRamp = tripuls(T1-Duration/2, Duration)*Amplitude + f.Voltage_Low;
% 4. Find where the time is 0 seconds
% RampStart = find(T1==0);  % commented out by Ting
VRamp_diff = diff(VRamp);
RampStart = find(VRamp_diff,1);
% 5. Start the ramp array and time array from the position where time is 0
%T1 = T1(RampStart:end-1);
VRamp = VRamp(RampStart:end-1);
VRamp = VRamp(end:-1:1);

end