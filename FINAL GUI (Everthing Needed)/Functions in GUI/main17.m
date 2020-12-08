
% Update:
%   1. Modified Gaussian fit display. Uses std to allow nicely display of the
%       whole Gaussian fit.
%   2. Modified according to Ting's code, behaviors of this code would
%       largely be same as Ting's code


% To do:
%   13. reduce artifact while select consequtive cycles


%% Clear -- clear all texts in commend window, all figures and workspace

clc; fclose all; close all; clear; tic;


%% PARAMETERS


% Variables that are usually changed from one experiment to another are
% listed here. One structure named expInfo is created to store general
% parameters that are constant througout one experiment and variables that
% are common to both PBS and DA. Structures PBSinfo and DAinfo are to store values
% that are different for PBS and for DA.


% REQUIRED INPUTS -- Location of this MATLAB file in the system
expInfo.dataFolderPath = '/Users/apple/Desktop/NYU Nanolab/GUI/new_GUI3.0/0206/FSCV';
    expInfo.fileName_I = 'CM_N5A_68_C1_DA_0_200_10_ne0p2_po0p6_061219_140446_ch3Vol.txt'; % delta ibg file
    expInfo.fileName_V = 'CM_N5A_68_C1_DA_0_200_10_ne0p2_po0p6_061219_140446_ch4Vol.txt'; % voltage file


% PART OF EXPERIMENT INFORMATION AND RELAVANT PARAMETERS

% Note that 12 k = ((1.024 / OSR) * clockRate) * k
      expInfo.concentration  = 2;          % uM
   expInfo.neurotransmitter  = 'Dopamine';
           expInfo.sensorId  = 'C3';
           expInfo.rampRate  = 400;        % Ramp rate, V/s
            expInfo.lowVolt  = -0.2;       % low voltage, V
           expInfo.highVolt  = 0.6;        % high voltage, V
expInfo.interpolationFactor  = .1;

                expInfo.OSR  = 250;
%                 expInfo.OSR  = 256;
          expInfo.clockRate  = 100/40;
%           expInfo.clockRate  = 1.5;
%           expInfo.clockRate  = 1.536;

               expInfo.comV  = 0.078;      % common mode voltage
                expInfo.fbR  = 4.1e6;
         expInfo.FSCVfrqncy  = 10;         % FSCV frequency
              expInfo.error  = 0.003;

        PBSinfo.fstCycleInd  = 126;        % PBS #cycle number
        PBSinfo.cycleNeeded  = 5;
         PBSinfo.condition2  = 0.006;
               PBSinfo.type  = 'PBS';

         DAinfo.fstCycleInd  = 570;        % DA #cycle number
         DAinfo.cycleNeeded  = 2;
          DAinfo.condition2  = 0.01;
                DAinfo.type  = 'DA';


%% CYCLE ANALYSIS

[expInfo,PBSinfo,DAinfo] = cycleAnalysis(expInfo,PBSinfo,DAinfo);



%% CALCULATION


% [expInfo] = calculation(expInfo);























