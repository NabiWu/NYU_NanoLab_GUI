% Update:
%   1. It accomodates three or four channels
%   2. N-shape voltage


clc; fclose all; close all; clear; tic;

%% Set Up

% File location:
file_location_in_your_system = '/Users/apple/Desktop/NYU Nanolab/GUI/new_GUI3.0/0323/FSCV_V18';
cd(file_location_in_your_system);

% File names:
%       voltage.fileName = 'CM_N7A_82_DA_1_200_10_ne0p2_po0p6_120320_120721_ch2Vol.txt'; % voltage file
current_I1.fileName = 'CM_N7A_82_DA_1_200_10_ne0p2_po0p6_120320_120721_ch1Vol.txt'; % delta ibg file -- channel 1
current_I2.fileName = 'CM_N7A_82_DA_1_200_10_ne0p2_po0p6_120320_120721_ch3Vol.txt'; %                   channel 2
current_I3.fileName = 'CM_N7A_82_DA_1_200_10_ne0p2_po0p6_120320_120721_ch4Vol.txt'; %                   channel 3
current_I4.fileName = 'CM_N7A_82_DA_1_200_10_ne0p2_po0p6_120320_120721_ch4Vol.txt'; %                   channel 4


% Experiment info and parameters   
              expInfo.rampRate  = 200;        % Ramp rate, V/s
               expInfo.lowVolt  = -0.2;       % low voltage, V
              expInfo.highVolt  = .6;        % high voltage, V
   expInfo.interpolationFactor  = 1;
              expInfo.useSmooth = 'no';
                   expInfo.OSR  = 250; % 12 k = ((1.024 / OSR) * clockRate) * k
%                 expInfo.OSR  = 256; 
             expInfo.clockRate  = 100/40;
%           expInfo.clockRate  = 1.5;
%           expInfo.clockRate  = 1.536;
                  expInfo.comV  = -0.05;      % common mode voltage
                   expInfo.fbR  = 4.1e6;
            expInfo.FSCVfrqncy  = 10;         % FSCV frequency
                 expInfo.error  = 0.06;
                 
         expInfo.concentration  = 2;          % uM -- only for plotting
      expInfo.neurotransmitter  = 'Dopamine'; %  -- only for plotting
              expInfo.sensorId  = 'C3'; %  -- only for plotting

              
% Choose parameters for Current_I1:
current_I1.PBSinfo.fstCycleInd  = 40;        % PBS #cycle number
current_I1.PBSinfo.cycleNeeded  = 50;
          
 current_I1.DAinfo.fstCycleInd  = 520;        % DA #cycle number
 current_I1.DAinfo.cycleNeeded  = 20;

                
% Choose parameters for Current_I2:
current_I2.PBSinfo.fstCycleInd  = 50;        
current_I2.PBSinfo.cycleNeeded  = 50;
           
 current_I2.DAinfo.fstCycleInd  = 550;        
 current_I2.DAinfo.cycleNeeded  = 50;

  
% Choose parameters for Current_I3:
current_I3.PBSinfo.fstCycleInd  = 50;        
current_I3.PBSinfo.cycleNeeded  = 50;
              
 current_I3.DAinfo.fstCycleInd  = 550;        
 current_I3.DAinfo.cycleNeeded  = 50;


% Choose parameters for Current_I4:
current_I4.PBSinfo.fstCycleInd  = 50;        
current_I4.PBSinfo.cycleNeeded  = 50;

 current_I4.DAinfo.fstCycleInd  = 550;        
 current_I4.DAinfo.cycleNeeded  = 50;

current_arr = {current_I1, current_I2, current_I3, current_I4};

%% CYCLE ANALYSIS & CALCULATION


[expInfo,current_arr] = cycleAnalysis(expInfo,current_arr);


% [expInfo] = calculation(expInfo);









