% Code for Ting Wu's PCB for multichannel FSCV measurements
% Modified on 07/22/2019

% clear all;
% close all;
% clc;
%
%
% time_of_run = 10; %time in seconds
% Save_Data = 0;
%
% if (Save_Data)
% save_file_name = 'TEST3.csv'; % file to which the data will be changed.
%
%     if isequal(exist(save_file_name,'file'),2)
%         prompt = 'Error: This file exists. PLease enter a new filename. Include the .csv : \n';
%         save_file_name = input(prompt,'s');
%     end
% else
%     save_file_name = 'test.csv';
% end



classdef FSCV < handle
    
    properties
        
        Sampling_Rate
        Generation_Rate
        Voltage_High
        Voltage_Low
        Ramp_Rate
        Repetition_Rate
        FSCV_Ramp
        NIDeviceName = 'Dev2';
        NumChannel_Input = 4;
        Input_Port = [0,1,2,3];
        NumChannel_Output = 3;
        Output_Port = [1,0,3];
        daqInputSession;
        daqOutputSession;
        Input_Channel
        Output_Channel
        Input_Range = 2;
        Output_Range = 10;
        %       max_run_time = 10;
        trigConn
        lh_Output
        lh_Input
        FSCV_Control
        fid1
        InputTrigConn
        OutputTrigConn
        Ramp
        FSCV_Control_Duration = 40;
        A2Dthreshold = 0.2
        Capture_Scan = 5;
        Event_timing
        FSCV_Control_On = false;
        uStimuli_On
        Measurement_Status
        Padding_Time = 200e-3; % Padding time from voltage low to ground or vice versa
        trial
        trial_data
        start_t
        trial_num
        Idle_Ground
        Padding_HL
        Padding_LH
        Trial_Is_Done
        SaveFile = 1;
        BeginningOfTrial
        abort_key
        aborted
        
        
        
    end
    
    
    
    methods (Static)
        function resetDAQ
            daqreset; % reset DAQ to default setting to prevent bugs
        end
    end
    
    methods
        %         Constructor for class FSCV
        %                 function F = FSCV
        %                 end
        %             F.Sampling_Rate = 10000; % Number of samples per second
        %             F.Generation_Rate = 1.25e5; % Maximum update rate for 4 channel output is 1.25e6 MS/s
        %             F.Voltage_High = 1.3; % V
        %             F.Voltage_Low = -0.4; % V
        %             F.Ramp_Rate = 400; % V per second
        %             F.Repetition_Rate = 10; % Hz
        %             F.trial.Sampling_Rate = F.Sampling_Rate;
        %             F.trial.Generation_Rate = F.Generation_Rate;
        %             F.trial.SampleID = 'NP-N2A-2';
        %             F.trial.DeviceID = '-EC1';
        %             F.trial.Area = 600; % unit: um^2
        %             % loop through all the trials
        %             F.trial_num = 1;
        %             F.trial.logging =0;
        %             % Allocate memory for the data of all trials
        %             F. trial_data = cell(10000,1);
        %             % Get the experiment start time
        % %             F.start_t = GetSecs;
        %
        % %             F.run();
        %             if (~F.FSCV_Control_On && F.trial.logging ==1)
        %             F.trial_data{F.trial_num} = F.trial;
        %             save (F.trial_data, [F.trial.SampleID F.trial.DeviceID '-Trial' num2str(F.trial_num) datestr(now,'-yyyymmdd-HHMMSS')], 'mat')
        %             F.trial_num = F.trial_num +1;
        %             F.trial.logging = 0;
        %             end
        %         end
        %
        %         function run(F)
        %             clearvars
        %             close all
        %             clc
        % %
        % %             F.Sampling_Rate = 10000; % Number of samples per second
        % %             F.Generation_Rate = 1.25e5; % Maximum update rate for 4 channel output is 1.25e6 MS/s
        % %             F.Voltage_High = 1.3; % V
        % %             F.Voltage_Low = -0.4; % V
        % %             F.Ramp_Rate = 400; % V per second
        % %             F.Repetition_Rate = 10; % Hz
        % %
        %             % resetDAQ;
        %             daqreset;
        %             % F = CreateOutputSession;
        %
        %             % F = CreateInputSession;
        %
        %             CreateInputSession (FSCV);
        %             % CreateOutputSession;
        %         end
        %
        
        function CreateInputSession (F)
            %Create the input session
            F.daqInputSession = daq.createSession ('ni');
            
            % Add the input channel for FSCV_control
            Input_Channel_Trigger = F.daqInputSession.addAnalogInputChannel(F.NIDeviceName,'ai16','Voltage');
            Input_Channel_Trigger.TerminalConfig = 'SingleEnded'; % set the terminal configuration of the channel to 'SingleEnded'
            Input_Channel_Trigger.Range = [-F.Input_Range F.Input_Range];
            
            % Add the input channel for uStimuli
            Input_Channel_uStimuli = F.daqInputSession.addAnalogInputChannel(F.NIDeviceName,'ai7','Voltage');
            Input_Channel_uStimuli.TerminalConfig = 'SingleEnded'; % set the terminal configuration of the channel to 'SingleEnded'
            Input_Channel_uStimuli.Range = [-F.Input_Range F.Input_Range];
            
            
            %Record the FSCV ramp from the output port of the NI DAQ
            F.FSCV_Ramp = F.daqInputSession.addAnalogInputChannel(F.NIDeviceName,'_ao1_vs_aognd','Voltage');
            %             % Add the analog input channels
            %             InputCh1 = [];
            %             InputCh2 = [];
            %             InputCh3 = [];
            %             InputCh4 = [];
            %             F.Input_Channel = {InputCh1, InputCh2, InputCh3, InputCh4};
            
            for i =1:F.NumChannel_Input
                F.Input_Channel{i} = F.daqInputSession.addAnalogInputChannel(F.NIDeviceName,strcat('ai',num2str(F.Input_Port(i))),'Voltage');
                F.Input_Channel{i}.TerminalConfig = 'SingleEnded'; % set the terminal configuration of the channel to 'SingleEnded'
                F.Input_Channel{i}.Range = [-F.Input_Range F.Input_Range];
            end
            
            
            
            %           F.FSCV_Control = F.daqInputSession.addDigitalChannel(F.NIDeviceName,'PFIO','InputOnly');
            
            %           F.Input_Channel{1,1} = F.daqInputSession.addAnalogInputChannel(F.NIDeviceName,'ai0','Voltage');
            
            % Set the input session rate
            F.daqInputSession.Rate = F.Sampling_Rate;
            
            % Add trigger for the input session
            %             F.InputTrigConn = F.daqInputSession.addTriggerConnection('External',strcat(F.NIDeviceName,'/PFI0'),'StartTrigger');
            %             F.InputTrigConn.TriggerCondition = 'RisingEdge';
            %             F.daqInputSession.ExternalTriggerTimeout = 600; % Maximum time wait for an trigger
            %             F.daqInputSession.TriggersPerRun = 10; % 100 triggers per second, with a resolution of 10 ms
            
            % The 'DataAvailable' event will be fired every 5 cycles of the
            % FSCV scan
            F.daqInputSession.NotifyWhenDataAvailableExceeds = 1/F.Repetition_Rate*F.Capture_Scan*F.daqInputSession.Rate;
            
            % create listener to plot and savedata
            %           save_file_name = 'test1.csv';
            %           F.fid1 = fopen(save_file_name,'w');
            %           F.daqInputSession.IsContinuous = true;
            %           F.daqInputSession.startBackground();
            
            
            %             [data,timeStamps,triggerTime] = F.daqInputSession.startForeground();
            %             figure(1)
            %             plot(timeStamps, data(:,1))
            %             F.daqInputSession.addlistener('DataAvailable',@(src, event)save_data_multi(src,event,F.fid1,save_file_name));
            
            
        end
        
        
        
        function CreateOutputSession (F)
            
            % Create the output session
            F.daqOutputSession = daq.createSession ('ni');
            
            % Add the analog output channels
            OutputCh1 = []; % Channel 1 is the FSCV Ramp
            OutputCh2 = []; % Channel 2 is 2 times FSCV Ramp
            OutputCh3 = []; % Channel 3 is ground
            F.Output_Channel = {OutputCh1, OutputCh2, OutputCh3};
            
            % Add the ananlog channel
            for i = 1:F.NumChannel_Output
                F.Output_Channel{i} = F.daqOutputSession.addAnalogOutputChannel(F.NIDeviceName,strcat('ao',num2str(F.Output_Port(i))),'Voltage');
                F.Output_Channel{i}.Range = [-F.Output_Range F.Output_Range];
            end
            
            
            %Update rate of the output data
            F.daqOutputSession.Rate = F.Generation_Rate;
            
            %By default, the scans queued is 0.5s. Here we set it to one
            %cycle only. For 10Hz signal, it is 0.1s.
            F.daqOutputSession.NotifyWhenScansQueuedBelow = F.daqOutputSession.Rate*1/F.Repetition_Rate;
            
            
            % Generate the Ramp, padding and ground
            VRamp = generateRamp(F);
            V2Ramp = 2*VRamp;
            Ground = zeros(length(VRamp),1);
            F.Ramp = [VRamp' V2Ramp' Ground];
            F.Idle_Ground = [Ground Ground Ground];
            Length_Padding = F.Padding_Time * F.daqOutputSession.Rate;
            Padding_HL_SingleCH = linspace (0, F.Voltage_Low, Length_Padding)';
            Padding_LH_SingleCH = linspace (F.Voltage_Low, 0, Length_Padding)';
            Padding_Ground = zeros(Length_Padding,1);
            F.Padding_LH = [Padding_LH_SingleCH 2*Padding_LH_SingleCH, Padding_Ground];
            F.Padding_HL = [Padding_HL_SingleCH 2*Padding_HL_SingleCH, Padding_Ground];
            
            
        end
        
        function Run(F)
            
            
            F.Trial_Is_Done = 0;
            F.trial_num = 0;
            
            
            
            F.trial.Sampling_Rate = F.Sampling_Rate;
            F.trial.Generation_Rate = F.Generation_Rate;
            F.trial.SampleID = 'NP-N2A-2';
            F.trial.DeviceID = '-EC1';
            F.trial.Area = 600; % unit: um^2
            
            
            F.daqInputSession.addlistener('DataAvailable',@(src, event)FSCV_Control_Event_Capture(src,event,F));
            F.daqInputSession.addlistener('DataAvailable',@(src, event)uStimuli_Event_Capture(src,event,F));
            F.daqInputSession.addlistener('DataAvailable',@(src, event)Capture_and_Plot(src,event,F));
            F.daqInputSession.addlistener('DataAvailable',@(src, event)SaveToStruct(src,event,F));
            F.daqInputSession.IsContinuous = true;
            F.daqInputSession.startBackground();
            
            queueOutputData(F.daqOutputSession,F.Idle_Ground); % queue the output data to be used by the output channels of the daq
            
            F.daqOutputSession.startForeground();
            F.Measurement_Status = 'Measurement Off';
            %             [ret, func_ret] = WaitUntil(@idleWait, {}, inf);
            
            
            while(1)
                F.trial_num = F.trial_num + 1;
                F.Trial_Is_Done = 0;
                
                
                
                while ~F.Trial_Is_Done
                    
                    
                    switch F.Measurement_Status
                        
                        
                        case 'Measurement Off'
                            fprintf ('trial %d - Measurement is off\n', 1);
                            while (~F.FSCV_Control_On)
                                pause(0.1)
                                queueOutputData(F.daqOutputSession,F.Idle_Ground); % queue the output data to be used by the output channels of the daq
                                F.daqOutputSession.startForeground();
                                
                                %                                 [ret, func_ret] = WaitUntil(@F.idleWait, {}, inf);
                                
                            end
                            F.Measurement_Status = 'Padding_HL';
                            
                        case 'Padding_HL'
                            disp ('Padding between Ground and FSCV low voltage');
                            queueOutputData(F.daqOutputSession, F.Padding_HL)
                            F.daqOutputSession.startForeground();
                            F.Measurement_Status = 'Measurement On';
                            %                             [ret, func_ret] = WaitUntil(@r.idleWait, {}, inf);
                        case 'Measurement On'
                            disp ('Measurement is on')
                            F.BeginningOfTrial = 1;
                            while (F.FSCV_Control_On)
                                queueOutputData(F.daqOutputSession,F.Ramp); % queue the output data to be used by the output channels of the daq
                                F.daqOutputSession.startForeground();
                                %                                 [ret, func_ret] = WaitUntil(@r.idleWait, {}, inf);
                                %                             F.daqInputSession.startBackground();
                                
                                %                             F.Measurement_Status = 'Measurement Off';
                            end
                            
                            F.Measurement_Status = 'Padding_LH';
                            
                            
                        case 'Padding_LH'
                            disp ('Padding between FSCV low voltage to Ground')
                            queueOutputData(F.daqOutputSession, F.Padding_LH)
                            F.daqOutputSession.startForeground();
                            F.Measurement_Status = 'Measurement Off';
                            %                             [ret, func_ret] = WaitUntil(@r.idleWait, {}, inf);
                            F.Trial_Is_Done = 1;
                            
                            if (F.Trial_Is_Done ==1 && F.SaveFile == 1)
                                disp('save file')
                                F.trial_data{F.trial_num}= F.trial;
                                trial_data = F.trial_data{F.trial_num};
                                save (strcat([F.trial.SampleID F.trial.DeviceID '-Trial' num2str(F.trial_num) datestr(now,'-yyyymmdd-HHMMSS'),'.mat']), '-struct', 'trial_data')
                            end
                            %
                            
                            
                    end
                end
            end
        end
        
        
        
        
        function F = initilizedDAQ (F)
        end
        
        function F = stopDAQ (F)
            F.daqInputSession.stop();
            F.daqOutputSession.stop();
            %             delete(F.lh_Output);
            %             delete(F.lh_Input);
            
            F.daqInputSession.release();
            F.daqOutputSession.release();
            delete(F.daqInputSession);
            delete(F.daqOutputSession);
            %             fclose(F.fid1);
        end
        
    end
end


%% idleWait
% returns 0, ABORT
function ret = idleWait(F)
ret = 0;


%check if aborted is set. must be present in all functions called by
%WaitUntil and its equivalents.
if F.aborted
    ret = 'ABORT';
    return;
end


%check keyboard for abort key
[keyIsDown, ~, keyCode] = KbCheck;
if keyIsDown
    %check for the abort key
    if prod(double(keyCode(F.abort_key))) == 1
        ret = 'ABORT';
        return;
    end
end
%             if r.monitor_touch
%                 r.getTouch;   %this is here just to send updated touch position to clients
%             end
%             if r.monitor_eye
%                 r.getEye;     %this is here just to send updated eye position to clients
%             end
%             if r.monitor_lever
%                 r.getLever;
%             end
end






% generate the ground signal
% ViRamp=zeros(length(ViRamp),1);
%
% % generate the 2VR
% ViRamp_2 = 2*ViRamp;
%
% % generate the ground signal
% ground=zeros(length(ViRamp),1);
%
% length(ViRamp)
% figure(1)
% plot(ViRamp)

%% Creating Signal to be sent out on DAQ
% single channel output
% X = ViRamp'; % note each output daq channel takes in values that are a column vector. Each output channel needs a column vector associated with it
% double channel output
% X = [ViRamp' ViRamp_2' ground];

% X = [ViRamp ViRamp_2 ground];


% We will add this signal to the CSV file with the saved data at the end

% %% %%%%%%%%%%%% START DAQ SETUP %%%%%%%%%%%%%%%%%%%%%%
% daqreset; % reset the daq to default settings
%
% daqSession = daq.createSession('ni'); % create a daq Session
%
% % Creating Input Channels
% ch1 = addAnalogInputChannel(daqSession,'Dev2',0,'voltage'); % add the analog input channels to be used
% ch2 = addAnalogInputChannel(daqSession,'Dev2',1,'voltage');
% ch3 = addAnalogInputChannel(daqSession,'Dev2',2,'voltage');
% ch4 = addAnalogInputChannel(daqSession,'Dev2',3,'voltage');
% ch1.TerminalConfig = 'SingleEnded'; % set the terminal configuration of the channel to 'SingleEnded'
% ch2.TerminalConfig = 'SingleEnded';
% ch3.TerminalConfig = 'SingleEnded';
% ch4.TerminalConfig = 'SingleEnded';
%
% %% Input range of NI card
% Input_range= 5;
% ch1.Range = [-Input_range Input_range];
% ch2.Range = [-Input_range Input_range];
% ch3.Range = [-Input_range Input_range];
% ch4.Range = [-Input_range Input_range];
%
% % NOTE: Default setting of the Terminal Configuration was differential.
% % This is why the output was showing an exponential property when a 1V
% % signal was sent through and output was connected to the input.
%
% % Create Log file to write data into during continous run
% fid1 = fopen(save_file_name,'w');
%
% % Creating Output Channels
% addAnalogOutputChannel(daqSession,'Dev2',1,'Voltage');
% addAnalogOutputChannel(daqSession,'Dev2',0,'Voltage');
% addAnalogOutputChannel(daqSession,'Dev2',3,'Voltage');
% % Set properties
% daqSession.Rate = Sampling_rate; % number of samples per second
% % Continuous data collection
% daqSession.IsContinuous = 1; % we want data to be collected and outputted continuously
%
% % Queue data
% num_Samples = daqSession.Rate * time_of_run;  % total number of output samples that will be required based on the maximum possible time for run.
% CV_Ramp_Samples = length(X); % number of samples in one ramp cycle (from where we created the ramp)
% num_repeats = round(num_Samples/CV_Ramp_Samples); % number of times CV ramp must repeat to satisfy the max number of samples for the run.
% output_data = repmat(X,num_repeats,1); % final output data array taking into account the total number of repeats of the CV ramp needed to satisfy the max number of samples a run will require
% queueOutputData(daqSession,output_data); % queue the output data to be used by the output channels of the daq
%
% % Plot data to be outputted from the daq output channel
% figure(1)
% hold on
% plot(output_data);
% title('Output Data Queued')
% ylabel('Voltage')
% xlabel('Seconds')
%
%
% % create a plot for the daq measurments to be displayed on
% figure(2)
%
% title('Data being read')
% ylabel('Voltage')
% xlabel('Seconds')
%
% % create listener to plot and savedata
% lh2 = daqSession.addlistener('DataAvailable',@(src, event)save_data_multi(src,event,fid1,save_file_name));
%
% % start daqSession
% daqSession.startBackground();
%
% %This line sets the length for how long the data collection runs:
% pause(time_of_run);
%
% figure(2)
% legend('Ch1','Ch2','Ch3','Ch4');
%
% daqSession.stop();
%
%
% %% PLotting data from saved file
% % obtain data from saved csv file
%
% data_read = csvread(save_file_name); %load data file
% time_vector_2 = data_read(:,1); %time vector
% data = data_read(:,[2:5]); %data matrix
%
% % % create time vector as data is saved in samples
% % % time_of_run_2 = length(data)/Sampling_rate;
% % % time_vector = linspace(0,time_of_run_2, length(data));
%
% % plot the saved data
% figure(3)
% plot(time_vector_2,data)
% title('data plotted from saved data file')
% xlabel('Time (s)')
% ylabel('Voltage')
%  legend('Ch1','Ch2','Ch3','Ch4')
% % legend('Ch1','Ch2')
%
%
% % figure(4)
% % plot(time_vector,data*Sensitivity)
% % title('Current vs Time')
% % xlabel('Time (s)')
% % ylabel('Voltage')
% % legend('Ch1','Ch2','Ch3','Ch4')
%
% %% Clean up and release hardware
% % delete and clear all listenrs and daq sessions. close the saved data file
% delete(lh2);
% daqSession.release();
% delete(daqSession);
% fclose(fid1);
%
%
% % save data into one file (both ramp values and measured data)
%
% if (Save_Data)
% saveData = [output_data(1:length(data),:), data_read]; % first two columns are Vr and 2Vr, then the time vector, then the data read from the channel
%
% % overwrite the original file
% csvwrite(save_file_name,saveData);
% end
%
%
% clear daqSession;
% clear lh;
% clear lh2;

