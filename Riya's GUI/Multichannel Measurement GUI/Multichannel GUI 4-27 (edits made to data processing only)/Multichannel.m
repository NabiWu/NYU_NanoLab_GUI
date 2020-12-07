function varargout = Multichannel(varargin)
% MULTICHANNEL MATLAB code for Multichannel.fig
%      MULTICHANNEL, by itself, creates a new MULTICHANNEL or raises the existing
%      singleton*.
%
%      H = MULTICHANNEL returns the handle to a new MULTICHANNEL or the handle to
%      the existing singleton*.
%
%      MULTICHANNEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTICHANNEL.M with the given input arguments.
%
%      MULTICHANNEL('Property','Value',...) creates a new MULTICHANNEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Multichannel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Multichannel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Multichannel

% Last Modified by GUIDE v2.5 20-Apr-2018 16:47:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Multichannel_OpeningFcn, ...
                   'gui_OutputFcn',  @Multichannel_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Multichannel is made visible.
function Multichannel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Multichannel (see VARARGIN)

% Choose default command line output for Multichannel
handles.output = hObject;
handles.select_mode.Value =1;
handles.mode = 1; 
% make all the panels invisible 
set(handles.DAQandVariables,'visible','off');
set(handles.RampPlot,'visible','off');
set(handles.Experiment_Calibration,'visible','off');
set(handles.SaveDataFile,'visible','off');
set(handles.FourChannelData,'visible','off');
set(handles.EightChannelData,'visible','off');
set(handles.SixteenChannelData,'visible','off');
set(handles.FourVr,'visible','off');
set(handles.EightVr,'visible','off');
set(handles.SixteenVr,'visible','off');
set(handles.FourSub,'visible','off');
set(handles.EightSub,'visible','off');
set(handles.SixteenSub,'visible','off');
set(handles.Data,'visible','off');
set(handles.V_vs_Vr,'visible','off');
set(handles.SubCurrent,'visible','off');
set(handles.includeCalib,'visible','off');

String1 = 'Dev#';
d = daq.getDevices;
for i = 1:length(d)
    String1 = [String1; d(i).ID];
end
handles.Device.String = String1; 

handles.FSCV_Freq.String = 10; %
handles.Freq = 10;
handles.Ramp_Rate.String = 400;
handles.ramprate = 400;
handles.Sampling_Rate.String = 20000;
handles.samprate = 20000; 
handles.Generation_Rate.String = 1000000;
handles.genrate = 1000000;
handles.Volt_High.String = 1.3;
handles.volthigh = 1.3;
handles.Volt_Low.String = -0.4;
handles.voltlow = -0.4;
handles.numSamp.String = 5;
handles.samples = 5; 
handles.numChan.Value = 2;
handles.channels = 2;
handles.Gain.String = 2e6;
handles.gain = 2e6;
handles.Time.String = 60;
handles.max_run_time = 60;
handles.CalibrationDataFile.String = 'Select Calibration File';
handles.InputMax.String = 5;
handles.inputmax = 5;
handles.OutputMax.String = 5;
handles.outputmax = 5;
handles.InputMin.String = -5;
handles.inputmin = -5;
handles.OutputMin.String = -5;
handles.outputmin = -5;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Multichannel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in select_mode.
function select_mode_Callback(hObject, eventdata, handles)
% hObject    handle to select_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% determine which mode GUI is to run in
handles.mode = get(hObject,'Value');
% update hObject 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function select_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in GO.
function GO_Callback(hObject, eventdata, handles)
% hObject    handle to GO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.mode == 2 % calibration Mode 
    set(handles.DAQandVariables,'visible','on');
    set(handles.includeCalib,'visible','off');
    set(handles.Experiment_Calibration,'visible','off');
    set(handles.SaveDataFile,'visible','on');
    set(handles.RemoveBias,'visible','on');
    handles.SaveData.Value = 1;
    handles.savedata = 1;
    handles.Filename.Style = 'edit'; 
    handles.Filename.String = 'CalibrationData.csv';
    handles.filename = 'CalibrationData.csv';
    handles.VVr_Current.String = 'Current';
    handles.Background_AvgCurrent.String = 'Avg Current';
    handles.bias.Value = 1;
    handles.biasRemove = 1;  
elseif handles.mode == 3 % Experiment run 
    set(handles.DAQandVariables,'visible','on');
    set(handles.includeCalib,'visible','on');
    set(handles.Experiment_Calibration,'visible','off');
    set(handles.SaveDataFile,'visible','off'); 
    set(handles.RemoveBias,'visible','off');
    handles.Filename.Style = 'edit'; 
    handles.Filename.String = 'Data.csv';
    handles.filename = 'Data.csv';
    handles.SaveData.Value = 0;
    handles.savedata = 0;    
    handles.VVr_Current.String = 'Current vs Vr';
    handles.Background_AvgCurrent.String = 'Background Subtract';
elseif handles.mode == 4 % data processing mode 
    run Multichannel_Data_Processing.m
else 
    set(handles.DAQandVariables,'visible','off');
    set(handles.Experiment_Calibration,'visible','off');
    set(handles.SaveDataFile,'visible','off');
end
handles.numChannels = 4;
    handles.plots1 = [handles.DataCH1,handles.DataCH2,handles.DataCH3,handles.DataCH4];
    handles.plots2 = [handles.Vr4CH1,handles.Vr4CH2,handles.Vr4CH3,handles.Vr4CH4];
    handles.plots3 = [handles.Sub4CH1,handles.Sub4CH2,handles.Sub4CH3,handles.Sub4CH4];
    for i = 1:handles.numChannels
        cla(handles.plots1(i),'reset')
        cla(handles.plots2(i),'reset')
        cla(handles.plots3(i),'reset')
        handles.plots1(i).FontSize = 8;
        handles.plots2(i).FontSize = 8;
        handles.plots3(i).FontSize = 8;
    end
    set(handles.RampPlot,'visible','on');
    set(handles.Experiment_Calibration,'visible','on');
    set(handles.SaveDataFile,'visible','on');
    set(handles.Data,'visible','on');
    set(handles.FourChannelData,'visible','on');
    set(handles.FourVr,'visible','on');
    set(handles.FourSub,'visible','on');
    
if handles.mode==2 % calibration mode 
    for i = 1:handles.numChannels
        axes(handles.plots1(i))
        xlabel('Time (s) ','FontSize',8)
        ylabel('Voltage (V)','FontSize',8)
        axes(handles.plots2(i))
        xlabel('FSCV voltage (V)','FontSize',8)
        ylabel('Total current(nA)','FontSize',8)
        axes(handles.plots3(i))
        xlabel('FSCV voltage (V)','FontSize',8)
        ylabel('Total current(nA)','FontSize',8)
    end
elseif handles.mode ==3 % experiment mode 
    for i = 1:handles.numChannels
        axes(handles.plots1(i))
        xlabel('Time (s) ','FontSize',8)
        ylabel('Voltage (V)','FontSize',8)
        axes(handles.plots2(i))
        xlabel('FSCV voltage (V)','FontSize',8)
        ylabel('Total current(nA)','FontSize',8)
        axes(handles.plots3(i))
        xlabel('Time (s)','FontSize',8)
        ylabel('Current(nA)','FontSize',8)
    end
end    
% update hObject 
guidata(hObject, handles);

% --- Executes on button press in SaveData.
function SaveData_Callback(hObject, eventdata, handles)
% hObject    handle to SaveData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.savedata = get(hObject,'Value');
guidata(hObject,handles);


% --- Executes on button press in ViewData.
function ViewData_Callback(hObject, eventdata, handles)
% hObject    handle to ViewData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Data,'visible','on');
set(handles.V_vs_Vr,'visible','off');
set(handles.SubCurrent,'visible','off');

guidata(hObject,handles);

% --- Executes on button press in STOP.
function STOP_Callback(hObject, eventdata, handles)
% hObject    handle to STOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.stop = get(hObject,'Value');
if handles.mode == 2 % calibration code
    handles.daqInputSession.stop();
    handles.daqOutputSession.stop();
    delete(handles.lh)
    handles.daqInputSession.release();
    handles.daqOutputSession.release();
    delete(handles.daqInputSession);
    delete(handles.daqOutputSession);
    fclose(handles.fid1);
    daqreset;    
 % processing data from saved file:    
    Data_cell1 = csvread(handles.filename);
    Time_measurement = Data_cell1(:,1);     
    FSCV_current_PBS = Data_cell1(:,3:end)/handles.gain;
    FSCV_current_DA = Data_cell1(:,3:end)/handles.gain;    
    FSCV_voltage_PBS = Data_cell1(:,2);
    FSCV_voltage_DA = Data_cell1(:,2);
 % Find the averaging for the PBS measurements
    % Find all the peak
    [Peak,Peak_index] = findpeaks(FSCV_voltage_PBS, 'MinPeakHeight', 1.15, 'MinPeakDistance', round(1/handles.Freq*handles.samprate)-100);
    % Generate a matrix of all the cycles
    NumOfCycle=length(Peak_index);
    Last_Cycle_Index=Peak_index(end-1)-round(handles.Duration/2*handles.samprate):1:Peak_index(end-1)+round(handles.Duration/2*handles.samprate);
    Voltage_single_cycle_PBS=FSCV_voltage_PBS(Last_Cycle_Index);
    % Remove the bias current 
    if handles.biasRemove==1
        NumOfCycle_bias=Peak_index(end-1)-round(handles.Duration/2*handles.samprate)-800:Peak_index(end-1)-round(handles.Duration/2*handles.samprate)-300;
        for i = 1:handles.numChannels
            Bias_current=mean(FSCV_current_PBS(NumOfCycle_bias,i));
            FSCV_current_PBS(:,i)=FSCV_current_PBS(:,i)-Bias_current;
        end
    end
    
    N_PBS=NumOfCycle-6;
    M_PBS=NumOfCycle-1;
    
    CurrentMatrixPBScell = cell(1,handles.numChannels);
    AverageCurrentPBScell = cell(1,handles.numChannels);
    
    for k = 1:handles.numChannels        
        Current_Matrix_PBS=[];
        Voltage_Matrix_PBS=[];
        
        for i= N_PBS:M_PBS 
            
            One_Cycle_Index=Peak_index(i)-round(handles.Duration/2*handles.samprate):1:Peak_index(i)+round(handles.Duration/2*handles.samprate);
            Current_single_cycle=FSCV_current_PBS(One_Cycle_Index,k)';
            Voltage_single_cycle=FSCV_voltage_PBS(One_Cycle_Index)';
            
            Current_Matrix_PBS=[Current_Matrix_PBS;Current_single_cycle];
            Voltage_Matrix_PBS=[Voltage_Matrix_PBS;Voltage_single_cycle];
            
            Current_Matrix_PBS_Plot=reshape(Current_Matrix_PBS', numel(Current_Matrix_PBS),1);
            Voltage_Matrix_PBS_Plot=reshape(Voltage_Matrix_PBS', numel(Voltage_Matrix_PBS),1);
        end
        
        Average_current_PBS=mean(Current_Matrix_PBS);        
        CurrentMatrixPBScell{k} = Current_Matrix_PBS_Plot;
        AverageCurrentPBScell{k} = Average_current_PBS;
        AverageCurrentPlot(:,k) = Average_current_PBS;
        
    end
    
    % plotting results 
    for i = 1:handles.numChannels
        axes(handles.plots2(i))
        plot(Voltage_Matrix_PBS_Plot, CurrentMatrixPBScell{i}*10^9, 'b-')
        xlabel('FSCV voltage (V)','FontSize',8)
        ylabel('Total current(nA)','FontSize',8)
        grid minor;
        axes(handles.plots3(i))
        plot(Voltage_single_cycle_PBS, AverageCurrentPBScell{i}*10^9, 'b')
        xlabel('FSCV voltage (V)','FontSize',8)
        ylabel('Total current(nA)','FontSize',8)
        grid minor;
    end    
    % Saving the results
    CalibrationSaved = [Voltage_single_cycle' AverageCurrentPlot];
    csvwrite(handles.filename,CalibrationSaved);
    
elseif handles.mode == 3 % experiment mode
    handles.daqInputSession.stop();
    handles.daqOutputSession.stop();
    delete(handles.lh)
    handles.daqInputSession.release();
    handles.daqOutputSession.release();
    delete(handles.daqInputSession);
    delete(handles.daqOutputSession);
    fclose(handles.fid1);
    daqreset;    
end
guidata(hObject,handles)

% --- Executes on button press in START.
function START_Callback(hObject, eventdata, handles)
% hObject    handle to START (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    %% Start Daq Session
    handles.daqInputSession.startBackground();
    handles.daqOutputSession.startBackground();
    pause(handles.max_run_time*15); 
    cla(handles.Output_Data_Queued,'reset');
    
if handles.mode == 2 % calibration code
    handles.daqInputSession.stop();
    handles.daqOutputSession.stop();
    delete(handles.lh)
    handles.daqInputSession.release();
    handles.daqOutputSession.release();
    delete(handles.daqInputSession);
    delete(handles.daqOutputSession);
    fclose(handles.fid1);
    daqreset;    
 % processing data from saved file:    
    Data_cell1 = csvread(handles.filename);
    Time_measurement = Data_cell1(:,1);     
    FSCV_current_PBS = Data_cell1(:,3:end)/handles.gain;
    FSCV_current_DA = Data_cell1(:,3:end)/handles.gain;    
    FSCV_voltage_PBS = Data_cell1(:,2);
    FSCV_voltage_DA = Data_cell1(:,2);
 % Find the averaging for the PBS measurements
    % Find all the peak
    [Peak,Peak_index] = findpeaks(FSCV_voltage_PBS, 'MinPeakHeight', 1.15, 'MinPeakDistance', round(1/handles.Freq*handles.samprate)-100);
    % Generate a matrix of all the cycles
    NumOfCycle=length(Peak_index);
    Last_Cycle_Index=Peak_index(end-1)-round(handles.Duration/2*handles.samprate):1:Peak_index(end-1)+round(handles.Duration/2*handles.samprate);
    Voltage_single_cycle_PBS=FSCV_voltage_PBS(Last_Cycle_Index);
    % Remove the bias current 
    if handles.biasRemove==1
        NumOfCycle_bias=Peak_index(end-1)-round(handles.Duration/2*handles.samprate)-800:Peak_index(end-1)-round(handles.Duration/2*handles.samprate)-300;
        for i = 1:handles.numChannels
            Bias_current=mean(FSCV_current_PBS(NumOfCycle_bias,i));
            FSCV_current_PBS(:,i)=FSCV_current_PBS(:,i)-Bias_current;
        end
    end
    
    N_PBS=NumOfCycle-6;
    M_PBS=NumOfCycle-1;
    
    CurrentMatrixPBScell = cell(1,handles.numChannels);
    AverageCurrentPBScell = cell(1,handles.numChannels);
    
    for k = 1:handles.numChannels        
        Current_Matrix_PBS=[];
        Voltage_Matrix_PBS=[];
        
        for i= N_PBS:M_PBS 
            
            One_Cycle_Index=Peak_index(i)-round(handles.Duration/2*handles.samprate):1:Peak_index(i)+round(handles.Duration/2*handles.samprate);
            Current_single_cycle=FSCV_current_PBS(One_Cycle_Index,k)';
            Voltage_single_cycle=FSCV_voltage_PBS(One_Cycle_Index)';
            
            Current_Matrix_PBS=[Current_Matrix_PBS;Current_single_cycle];
            Voltage_Matrix_PBS=[Voltage_Matrix_PBS;Voltage_single_cycle];
            
            Current_Matrix_PBS_Plot=reshape(Current_Matrix_PBS', numel(Current_Matrix_PBS),1);
            Voltage_Matrix_PBS_Plot=reshape(Voltage_Matrix_PBS', numel(Voltage_Matrix_PBS),1);
        end
        
        Average_current_PBS=mean(Current_Matrix_PBS);        
        CurrentMatrixPBScell{k} = Current_Matrix_PBS_Plot;
        AverageCurrentPBScell{k} = Average_current_PBS;
        AverageCurrentPlot(:,k) = Average_current_PBS;
        
    end
    
    % plotting results 
    for i = 1:handles.numChannels
        axes(handles.plots2(i))
        plot(Voltage_Matrix_PBS_Plot, CurrentMatrixPBScell{i}*10^9, 'b-')
        xlabel('FSCV voltage (V)','FontSize',8)
        ylabel('Total current(nA)','FontSize',8)
        grid minor;
        axes(handles.plots3(i))
        plot(Voltage_single_cycle_PBS, AverageCurrentPBScell{i}*10^9, 'b')
        xlabel('FSCV voltage (V)','FontSize',8)
        ylabel('Total current(nA)','FontSize',8)
        grid minor;
    end    
    % Saving the results
    CalibrationSaved = [Voltage_single_cycle' AverageCurrentPlot];
    csvwrite(handles.filename,CalibrationSaved);
    
elseif handles.mode == 3 % experiment mode
    handles.daqInputSession.stop();
    handles.daqOutputSession.stop();
    delete(handles.lh)
    handles.daqInputSession.release();
    handles.daqOutputSession.release();
    delete(handles.daqInputSession);
    delete(handles.daqOutputSession);
    fclose(handles.fid1);
    daqreset;    
end

    
guidata(hObject,handles)
 
% --- Executes on selection change in Device.
function Device_Callback(hObject, eventdata, handles)
% hObject    handle to Device (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(hObject,'String'));
handles.DeviceName = contents{get(hObject,'Value')};
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Device_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Device (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in VVr_Current.
function VVr_Current_Callback(hObject, eventdata, handles)
% hObject    handle to VVr_Current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Data,'visible','off');
set(handles.V_vs_Vr,'visible','on');
set(handles.SubCurrent,'visible','off');

guidata(hObject,handles);

% --- Executes on button press in Background_AvgCurrent.
function Background_AvgCurrent_Callback(hObject, eventdata, handles)
% hObject    handle to Background_AvgCurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Data,'visible','off');
set(handles.V_vs_Vr,'visible','off');
set(handles.SubCurrent,'visible','on');

guidata(hObject,handles);

function Sampling_Rate_Callback(hObject, eventdata, handles)
% hObject    handle to Sampling_Rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.samprate = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Sampling_Rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sampling_Rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Generation_Rate_Callback(hObject, eventdata, handles)
% hObject    handle to Generation_Rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.genrate = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Generation_Rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Generation_Rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Volt_High_Callback(hObject, eventdata, handles)
% hObject    handle to Volt_High (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.volthigh = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Volt_High_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Volt_High (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Volt_Low_Callback(hObject, eventdata, handles)
% hObject    handle to Volt_Low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.voltlow = str2double(get(hObject,'String'));
guidata(hObject,handle);

% --- Executes during object creation, after setting all properties.
function Volt_Low_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Volt_Low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Ramp_Rate_Callback(hObject, eventdata, handles)
% hObject    handle to Ramp_Rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.ramprate = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Ramp_Rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ramp_Rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FSCV_Freq_Callback(hObject, eventdata, handles)
% hObject    handle to FSCV_Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Freq = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function FSCV_Freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FSCV_Freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function numSamp_Callback(hObject, eventdata, handles)
% hObject    handle to numSamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.samples = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function numSamp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numSamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function InputMin_Callback(hObject, eventdata, handles)
% hObject    handle to InputMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.inputmin = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function InputMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function OutputMin_Callback(hObject, eventdata, handles)
% hObject    handle to OutputMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.outputmin = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function OutputMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function InputMax_Callback(hObject, eventdata, handles)
% hObject    handle to InputMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.inputmax = str2double(get(hObject,'String'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function InputMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function OutputMax_Callback(hObject, eventdata, handles)
% hObject    handle to OutputMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.outputmax = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function OutputMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in directory.
function directory_Callback(hObject, eventdata, handles)
% hObject    handle to directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Directory = uigetdir; 
handles.directory.String = handles.Directory;
guidata(hObject, handles);

function Filename_Callback(hObject, eventdata, handles)
% hObject    handle to Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.filename = get(hObject,'String');
if handles.savedata==1
    if isequal(exist(handles.filename,'file'),2)
        prompt = 'Error: This file exists. Please enter a new filename. Remember to include the .csv extension.';
        h=errordlg(prompt,'Error');
        set(h, 'WindowStyle', 'modal');
         uiwait(h)
    end
    handles.filename = strcat(handles.Directory,'\',handles.filename);
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in numChan.
function numChan_Callback(hObject, eventdata, handles)
% hObject    handle to numChan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.channels = get(hObject,'Value');
cla(handles.Output_Data_Queued,'reset');
if handles.channels == 2 % 4 channels
    handles.numChannels = 4;
    handles.plots1 = [handles.DataCH1,handles.DataCH2,handles.DataCH3,handles.DataCH4];
    handles.plots2 = [handles.Vr4CH1,handles.Vr4CH2,handles.Vr4CH3,handles.Vr4CH4];
    handles.plots3 = [handles.Sub4CH1,handles.Sub4CH2,handles.Sub4CH3,handles.Sub4CH4];
    for i = 1:handles.numChannels
        cla(handles.plots1(i),'reset')
        cla(handles.plots2(i),'reset')
        cla(handles.plots3(i),'reset')
        handles.plots1(i).FontSize = 8;
        handles.plots2(i).FontSize = 8;
        handles.plots3(i).FontSize = 8;
    end
    set(handles.RampPlot,'visible','on');
    set(handles.Experiment_Calibration,'visible','on');
    set(handles.SaveDataFile,'visible','on');
    set(handles.Data,'visible','on');
    set(handles.FourChannelData,'visible','on');
    set(handles.EightChannelData,'visible','off');
    set(handles.SixteenChannelData,'visible','off');
    set(handles.FourVr,'visible','on');
    set(handles.EightVr,'visible','off');
    set(handles.SixteenVr,'visible','off');
    set(handles.FourSub,'visible','on');
    set(handles.EightSub,'visible','off');
    set(handles.SixteenSub,'visible','off');
    
elseif handles.channels == 3 % 8 channels
    handles.numChannels = 8;
    handles.plots1 = [handles.Data8CH1,handles.Data8CH2,handles.Data8CH3,handles.Data8CH4,handles.Data8CH5,handles.Data8CH6,handles.Data8CH7,handles.Data8CH8];
    handles.plots2 = [handles.Vr8CH1,handles.Vr8CH2,handles.Vr8CH3,handles.Vr8CH4,handles.Vr8CH5,handles.Vr8CH6,handles.Vr8CH7,handles.Vr8CH8];
    handles.plots3 = [handles.Sub8CH1,handles.Sub8CH2,handles.Sub8CH3,handles.Sub8CH4,handles.Sub8CH5,handles.Sub8CH6,handles.Sub8CH7,handles.Sub8CH8];
    for i = 1:handles.numChannels
        cla(handles.plots1(i),'reset')
        cla(handles.plots2(i),'reset')
        cla(handles.plots3(i),'reset')
        handles.plots1(i).FontSize = 8;
        handles.plots2(i).FontSize = 8;
        handles.plots3(i).FontSize = 8;
    end
    set(handles.RampPlot,'visible','on');
    set(handles.Experiment_Calibration,'visible','on');
    set(handles.SaveDataFile,'visible','on');
    set(handles.Data,'visible','on');
    set(handles.FourChannelData,'visible','off');
    set(handles.EightChannelData,'visible','on');
    set(handles.SixteenChannelData,'visible','off');
    set(handles.FourVr,'visible','off');
    set(handles.EightVr,'visible','on');
    set(handles.SixteenVr,'visible','off');
    set(handles.FourSub,'visible','off');
    set(handles.EightSub,'visible','on');
    set(handles.SixteenSub,'visible','off');

elseif handles.channels == 4 % 16 channels
    handles.numChannels = 16;
    handles.plots1 = [handles.Data16CH1,handles.Data16CH2,handles.Data16CH3,handles.Data16CH4,handles.Data16CH5,handles.Data16CH6,handles.Data16CH7,handles.Data16CH8,handles.Data16CH9,handles.Data16CH10,handles.Data16CH11,handles.Data16CH12,handles.Data16CH13,handles.Data16CH14,handles.Data16CH15,handles.Data16CH16];
    handles.plots2 = [handles.Vr16CH1,handles.Vr16CH2,handles.Vr16CH3,handles.Vr16CH4,handles.Vr16CH5,handles.Vr16CH6,handles.Vr16CH7,handles.Vr16CH8,handles.Vr16CH9,handles.Vr16CH10,handles.Vr16CH11,handles.Vr16CH12,handles.Vr16CH13,handles.Vr16CH14,handles.Vr16CH15,handles.Vr16CH16];
    handles.plots3 = [handles.Sub16CH1,handles.Sub16CH2,handles.Sub16CH3,handles.Sub16CH4,handles.Sub16CH5,handles.Sub16CH6,handles.Sub16CH7,handles.Sub16CH8,handles.Sub16CH9,handles.Sub16CH10,handles.Sub16CH11,handles.Sub16CH12,handles.Sub16CH13,handles.Sub16CH14,handles.Sub16CH15,handles.Sub16CH16];
    for i = 1:handles.numChannels
        cla(handles.plots1(i),'reset')
        cla(handles.plots2(i),'reset')
        cla(handles.plots3(i),'reset')
        handles.plots1(i).FontSize = 8;
        handles.plots2(i).FontSize = 8;
        handles.plots3(i).FontSize = 8;
    end   
    set(handles.RampPlot,'visible','on');
    set(handles.Experiment_Calibration,'visible','on');
    set(handles.SaveDataFile,'visible','on');
    set(handles.Data,'visible','on');
    set(handles.FourChannelData,'visible','off');
    set(handles.EightChannelData,'visible','off');
    set(handles.SixteenChannelData,'visible','on');
    set(handles.FourVr,'visible','off');
    set(handles.EightVr,'visible','off');
    set(handles.SixteenVr,'visible','on');
    set(handles.FourSub,'visible','off');
    set(handles.EightSub,'visible','off');
    set(handles.SixteenSub,'visible','on');
end

if handles.mode==2 % calibration mode 
    for i = 1:handles.numChannels
        axes(handles.plots1(i))
        xlabel('Time (s) ','FontSize',8)
        ylabel('Voltage (V)','FontSize',8)
        axes(handles.plots2(i))
        xlabel('FSCV voltage (V)','FontSize',8)
        ylabel('Total current(nA)','FontSize',8)
        axes(handles.plots3(i))
        xlabel('FSCV voltage (V)','FontSize',8)
        ylabel('Total current(nA)','FontSize',8)
    end
elseif handles.mode ==3 % experiment mode 
    for i = 1:handles.numChannels
        axes(handles.plots1(i))
        xlabel('Time (s) ','FontSize',8)
        ylabel('Voltage (V)','FontSize',8)
        axes(handles.plots2(i))
        xlabel('FSCV voltage (V)','FontSize',8)
        ylabel('Total current(nA)','FontSize',8)
        axes(handles.plots3(i))
        xlabel('Time (s)','FontSize',8)
        ylabel('Current(nA)','FontSize',8)
    end
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function numChan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numChan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in includeCalibData.
function includeCalibData_Callback(hObject, eventdata, handles)
% hObject    handle to includeCalibData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.includeCalib = get(hObject,'Value');
guidata(hObject,handles)

% --- Executes on button press in CalibrationDataFile.
function CalibrationDataFile_Callback(hObject, eventdata, handles)
% hObject    handle to CalibrationDataFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.Calibfilename, handles.Calibpathname] = uigetfile;
handles.CalibrationDataFile.String = strcat(handles.Calibpathname,handles.Calibfilename);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function CalibrationDataFile_CreateFcn(hObject, eventdata, handles)
 % hObject    handle to CalibrationDataFile (see GCBO)
 % eventdata  reserved - to be defined in a future version of MATLAB
 % handles    empty - handles not created until after all CreateFcns called

function Gain_Callback(hObject, eventdata, handles)
% hObject    handle to Gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.gain = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Gain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in run_setup.
function run_setup_Callback(hObject, eventdata, handles)
% hObject    handle to run_setup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
        cla(handles.plots1(i),'reset')
        cla(handles.plots2(i),'reset')
        cla(handles.plots3(i),'reset')
        handles.plots1(i).FontSize = 8;
        handles.plots2(i).FontSize = 8;
        handles.plots3(i).FontSize = 8;
end
    
if handles.savedata==1
    if isequal(exist(handles.filename,'file'),2)
        prompt = 'Error: This file exists. Please enter a new filename. Remember to include the .csv extension.';
        h=errordlg(prompt,'Error');
        set(h, 'WindowStyle', 'modal');
         uiwait(h)
    end
end
    handles.fid1 = fopen(handles.filename,'w+');
    handles.Duration = (handles.volthigh-handles.voltlow)/handles.ramprate*2;% width of the pulse in seconds
    handles.downsamplerate = handles.genrate/handles.samprate;
    %% Creating Input Singal to DAQ
    % generate Vr and 2Vr: 
    amplitude = handles.volthigh-handles.voltlow; % 1. Set amplitude
    t1 = -1/handles.Freq:1/handles.genrate:1/handles.Freq; % 2. set duration of ramp
    VrRamp = tripuls(t1-handles.Duration/2,handles.Duration)*amplitude+handles.voltlow; %3. create ramp using matlab builtin tripuls function
    VrRamp_diff = diff(VrRamp); %4. Find time where ramp starts
    RampStart = find(VrRamp_diff,1);
    t1 = t1(RampStart:end-1);% 5. Start the ramp array and time array from the position where ramp starts
    VrRamp = VrRamp(RampStart:end-1);
    if handles.mode == 2 % calibration mode: 
        VrRamp_2 = 2*VrRamp; % 6. double Vr to get 2Vr
    elseif handles.mode == 3 % experiment mode: 
        if handles.includeCalib ==1
            % Read Background Current
            Data_cell1 = csvread(strcat(handles.Calibpathname,handles.Calibfilename));
            BG_measurement = Data_cell1(:,2);
            BG_current=[BG_measurement',zeros(1,(length(VrRamp)-length(BG_measurement)))];
            VrRamp_2 = 2*VrRamp+BG_current*handles.gain; % gain is the value of the resistor % 6. double Vr and remove BG to get 2Vr
        else
            VrRamp_2 = 2*VrRamp; % 6. double Vr to get 2Vr
        end
    end
    
    % generate ground signal
    ground=zeros(length(VrRamp),1);
    % Creating Signal to be sent out to DAQ
    handles.X = [VrRamp' VrRamp_2' ground];
    fprintf('"Ramp setup complete');
    guidata(hObject,handles)
    
    %% DAQ SETUP
    daqreset; % reset daq to default settings
    handles.daqInputSession = daq.createSession('ni');
    handles.daqOutputSession = daq.createSession('ni');
    
    %% Creating Input Channels: 
    % 4 channels: 
    if handles.channels == 2||handles.channels==3|| handles.channels ==4
        handles.AOread = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,'_ao0_vs_aognd','Voltage');
       
        handles.ch1 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,0,'Voltage'); % add the analog input channels to be used
        handles.ch2 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,1,'Voltage');
        handles.ch3 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,2,'Voltage');
        handles.ch4 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,3,'Voltage');
        
        handles.ch1.TerminalConfig = 'SingleEnded'; % set the terminal configuration of the channel to 'SingleEnded'
        handles.ch2.TerminalConfig = 'SingleEnded';
        handles.ch3.TerminalConfig = 'SingleEnded';
        handles.ch4.TerminalConfig = 'SingleEnded';
        
        %InputRange
        handles.ch1.Range = [handles.inputmin,handles.inputmax];
        handles.ch2.Range = [handles.inputmin,handles.inputmax];
        handles.ch3.Range = [handles.inputmin,handles.inputmax];
        handles.ch4.Range = [handles.inputmin,handles.inputmax];
    end
 
    %8 Channels:
    if handles.channels==3|| handles.channels ==4
        handles.ch5 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,4,'Voltage'); % add the analog input channels to be used
        handles.ch6 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,5,'Voltage');
        handles.ch7 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,6,'Voltage');
        handles.ch8 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,7,'Voltage');
       
        handles.ch5.TerminalConfig = 'SingleEnded'; % set the terminal configuration of the channel to 'SingleEnded'
        handles.ch6.TerminalConfig = 'SingleEnded';
        handles.ch7.TerminalConfig = 'SingleEnded';
        handles.ch8.TerminalConfig = 'SingleEnded';
        
        %InputRange
        handles.ch5.Range = [handles.inputmin,handles.inputmax];
        handles.ch6.Range = [handles.inputmin,handles.inputmax];
        handles.ch7.Range = [handles.inputmin,handles.inputmax];
        handles.ch8.Range = [handles.inputmin,handles.inputmax];
    end    
    
    %16 channels:
    if handles.channels == 4
        handles.ch9 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,16,'Voltage'); % add the analog input channels to be used
        handles.ch10 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,17,'Voltage');
        handles.ch11 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,18,'Voltage');
        handles.ch12 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,19,'Voltage');
        handles.ch13 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,20,'Voltage'); % add the analog input channels to be used
        handles.ch14 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,21,'Voltage');
        handles.ch15 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,22,'Voltage');
        handles.ch16 = addAnalogInputChannel(handles.daqInputSession,handles.DeviceName,23,'Voltage');
               
        handles.ch9.TerminalConfig = 'SingleEnded'; % set the terminal configuration of the channel to 'SingleEnded'
        handles.ch10.TerminalConfig = 'SingleEnded';
        handles.ch11.TerminalConfig = 'SingleEnded';
        handles.ch12.TerminalConfig = 'SingleEnded';
        handles.ch13.TerminalConfig = 'SingleEnded'; % set the terminal configuration of the channel to 'SingleEnded'
        handles.ch14.TerminalConfig = 'SingleEnded';
        handles.ch15.TerminalConfig = 'SingleEnded';
        handles.ch16.TerminalConfig = 'SingleEnded';
        
        %InputRange
        handles.ch9.Range = [handles.inputmin,handles.inputmax];
        handles.ch10.Range = [handles.inputmin,handles.inputmax];
        handles.ch11.Range = [handles.inputmin,handles.inputmax];
        handles.ch12.Range = [handles.inputmin,handles.inputmax];
        handles.ch13.Range = [handles.inputmin,handles.inputmax];
        handles.ch14.Range = [handles.inputmin,handles.inputmax];
        handles.ch15.Range = [handles.inputmin,handles.inputmax];
        handles.ch16.Range = [handles.inputmin,handles.inputmax];
     end
    
    %% Creating Output Channels
    handles.ao0 = addAnalogOutputChannel(handles.daqOutputSession,handles.DeviceName,0,'Voltage');
    handles.ao1 = addAnalogOutputChannel(handles.daqOutputSession,handles.DeviceName,1,'Voltage');
    handles.ao2 = addAnalogOutputChannel(handles.daqOutputSession,handles.DeviceName,2,'Voltage');

    %Output Range
    handles.ao0.Range = [handles.outputmin, handles.outputmax];
    handles.ao1.Range = [handles.outputmin, handles.outputmax];
    handles.ao2.Range = [handles.outputmin, handles.outputmax];
    
    %% Set Properties
    handles.daqInputSession.Rate = handles.samprate;
    handles.daqOutputSession.Rate = handles.genrate;
    handles.daqInputSession.DurationInSeconds = handles.max_run_time;
    
    %% Queue data
    num_Samples = handles.daqOutputSession.Rate * handles.max_run_time;  % total number of output samples that will be required based on the maximum possible time for run.
    CV_Ramp_Samples = length(handles.X); % number of samples in one ramp cycle (from where we created the ramp)
    num_repeats = round(num_Samples/CV_Ramp_Samples); % number of times CV ramp must repeat to satisfy the max number of samples for the run. 
    handles.output_data = repmat(handles.X,num_repeats,1); % final output data array taking into account the total number of repeats of the CV ramp needed to satisfy the max number of samples a run will require
    queueOutputData(handles.daqOutputSession,handles.output_data); % queue the output data to be used by the output channels of the daq
    
    %% Configure Trigger Connection
    handles.trigConn = handles.daqInputSession.addTriggerConnection('External',strcat(handles.DeviceName,'/PFI0'),'StartTrigger');
    handles.trigConn.TriggerCondition = 'RisingEdge';
    handles.daqInputSession.ExternalTriggerTimeout = 100; % Seconds
    handles.daqOutputSession.ExternalTriggerTimeout = 100;
    handles.trigConn = handles.daqOutputSession.addTriggerConnection(strcat(handles.DeviceName,'/PFI0'),'External','StartTrigger');

    guidata(hObject,handles)
    
    %% Create Listeners: 
    if handles.mode==2 %calibration mode
        
        handles.lh = handles.daqInputSession.addlistener('DataAvailable',...
            @(src, event)multiGUI_saveData_calibration(src,event,handles.fid1,handles.filename,handles.plots1)); 
        
    elseif handles.mode ==3 % experiment
        if handles.realTime ==1
            handles.Cycle_Length = (handles.samples)*(1/handles.Freq);
            handles.One_Cycle_Samples = fix(handles.Duration*handles.samprate+1);  % fix rounds the elements of X to the nearest integer towards zero
            handles.SingleRun = handles.samprate/handles.Freq; %total number of samples in one run;
            handles.subtracted = zeros(length(VrRamp),handles.numChannels);
        
            handles.lh = handles.daqInputSession.addlistener('DataAvailable',...
                @(src, event)multiGUI_saveData_experiment(src,event,handles.fid1,handles.filename,handles.One_Cycle_Samples,handles.Cycle_Length,handles.subtracted, handles.SingleRun, handles.samples,handles.gain, handles.plots1,handles.plots2,handles.plots3)); 
        elseif handles.realTime == 0
            handles.lh = handles.daqInputSession.addlistener('DataAvailable',...
                @(src, event)multiGUI_saveData_calibration(src,event,handles.fid1,handles.filename,handles.plots1)); 
        end
                
    end
    guidata(hObject,handles)
    
    fprintf('DAQ setup complete\n');
    %% Plot one cycle output data  
    set(handles.RampPlot,'visible','on');
    axes(handles.Output_Data_Queued);
    plot(t1,handles.X);
    
guidata(hObject,handles);

function Time_Callback(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.max_run_time = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in bias.
function bias_Callback(hObject, eventdata, handles)
% hObject    handle to bias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.biasRemove = get(hObject,'Value');
guidata(hObject,handles);


% --- Executes on button press in realTimeProcessing.
function realTimeProcessing_Callback(hObject, eventdata, handles)
% hObject    handle to realTimeProcessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of realTimeProcessing
handles.realTime = get(hObject,'Value');
guidata(hObject,handles);