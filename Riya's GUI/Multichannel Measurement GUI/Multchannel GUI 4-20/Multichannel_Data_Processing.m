function varargout = Multichannel_Data_Processing(varargin)
% MULTICHANNEL_DATA_PROCESSING MATLAB code for Multichannel_Data_Processing.fig
%      MULTICHANNEL_DATA_PROCESSING, by itself, creates a new MULTICHANNEL_DATA_PROCESSING or raises the existing
%      singleton*.
%
%      H = MULTICHANNEL_DATA_PROCESSING returns the handle to a new MULTICHANNEL_DATA_PROCESSING or the handle to
%      the existing singleton*.
%
%      MULTICHANNEL_DATA_PROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTICHANNEL_DATA_PROCESSING.M with the given input arguments.
%
%      MULTICHANNEL_DATA_PROCESSING('Property','Value',...) creates a new MULTICHANNEL_DATA_PROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Multichannel_Data_Processing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Multichannel_Data_Processing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Multichannel_Data_Processing

% Last Modified by GUIDE v2.5 22-Jul-2019 13:03:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Multichannel_Data_Processing_OpeningFcn, ...
                   'gui_OutputFcn',  @Multichannel_Data_Processing_OutputFcn, ...
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


% --- Executes just before Multichannel_Data_Processing is made visible.
function Multichannel_Data_Processing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Multichannel_Data_Processing (see VARARGIN)

% Choose default command line output for Multichannel_Data_Processing
handles.output = hObject;
set(handles.Channels16,'visible','off');
set(handles.Channels8,'visible','off');
set(handles.Channels4,'visible','on');

handles.FSCV_Freq.String = 10; %
handles.Freq = 10;
handles.Ramp_Rate.String = 400;
handles.ramprate = 400;
handles.Sampling_Rate.String = 20000;
handles.samprate = 20000; 
handles.Voltage_High.String = 1.3;
handles.volthigh = 1.3;
handles.Voltage_Low.String = -0.4;
handles.voltlow = -0.4;
handles.numChan.Value = 2;
handles.Gain.String = 2e6;
handles.gain = 2e6;
handles.includeCalibration.Value = 1;
handles.includeCalib = 1;
handles.removeBiasCurrent.Value = 1;
handles.removeBias = 1;
handles.saveData.Value = 0; 
handles.save = 0;
handles.calibFilename.String= 'Select Calibration File'; 
handles.selectFilename.String = 'Select File';
handles.VrCol = 2;
handles.TimeCol = 1;
handles.Ch1Col = 3;
handles.peakV_low = 0.45;
handles.peakV_high = 0.5; 
handles.N_PBS = 5;
handles.M_PBS = 10;
handles.N_DA = 10;
handles.M_DA = 15;

handles.numChannels = 4; 
handles.plots = [handles.Ch1_4,handles.Ch2_4,handles.Ch3_4,handles.Ch4_4];
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end   

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Multichannel_Data_Processing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in START.
function START_Callback(hObject, eventdata, handles)
% hObject    handle to START (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end 

handles.Duration=(handles.volthigh-handles.voltlow)/handles.ramprate*2;
%% Read data from file 
Data_cell1 = csvread(strcat(handles.Selectpathname,handles.Selectfilename));

FSCV_PBS_data1=Data_cell1;
FSCV_DA_data1=Data_cell1;

Time_measurement=FSCV_PBS_data1(:,handles.TimeCol);

FSCV_current_PBS=FSCV_PBS_data1(:,handles.Ch1Col:handles.Ch1Col+handles.numChannels-1)/handles.gain;
FSCV_voltage_PBS=FSCV_PBS_data1(:,handles.VrCol);

FSCV_current_Dopamine=FSCV_DA_data1(:,handles.Ch1Col:handles.Ch1Col+handles.numChannels-1)/handles.gain;
FSCV_voltage_Dopamine=FSCV_DA_data1(:,handles.VrCol);

if handles.includeCalib == 1
    Calib_cell1= csvread(strcat(handles.Calibpathname,handles.Calibfilename));
    handles.CH_calib_current=Calib_cell1(:,2:end);
end


%% Find the averaging for the first PBS measurement
%Find all the peak 
[Peak, Peak_index]=findpeaks(FSCV_voltage_PBS, 'MinPeakHeight', 1.15, 'MinPeakDistance', round(1/handles.Freq*handles.samprate)-100);
% Generate a matrix of all the cycles
NumOfCycle=length(Peak_index);
Last_Cycle_Index=Peak_index(end-1)-round(handles.Duration/2*handles.samprate):1:Peak_index(end-1)+round(handles.Duration/2*handles.samprate);
Voltage_single_cycle_PBS=FSCV_voltage_PBS(Last_Cycle_Index);

%% Remove the bias current 
if handles.removeBias == 1
    NumOfCycle_bias=Peak_index(end-1)-round(handles.Duration/2*handles.samprate)-800:Peak_index(end-1)-round(handles.Duration/2*handles.samprate)-300;
    for i = 1:handles.numChannels
        Bias_current=mean(FSCV_current_PBS(NumOfCycle_bias,i));
        FSCV_current_PBS(:,i)=FSCV_current_PBS(:,i)-Bias_current;
        FSCV_current_Dopamine(:,i)=FSCV_current_Dopamine(:,i)-Bias_current;
    end    
end

%% Find the PBS cycles
CurrentMatrixPBScell = cell(1,handles.numChannels);
AverageCurrentPBScell = cell(1,handles.numChannels);

for k = 1:handles.numChannels
   Current_Matrix_PBS=[];
   Voltage_Matrix_PBS=[];
   
  for i= handles.N_PBS:handles.M_PBS  
    
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
end

%% Find the averaging for the dopamine measurement
%Find all the peak
[Peak_DA, Peak_index_DA]=findpeaks(FSCV_voltage_Dopamine, 'MinPeakHeight', 1.15, 'MinPeakDistance', 1/handles.Freq*handles.samprate-100);
% Generate a matrix of all the cycles
NumOfCycle_DA=length(Peak_index_DA);
Last_Cycle_Index_DA=Peak_index_DA(end-1)-round(handles.Duration/2*handles.samprate):1:Peak_index_DA(end-1)+round(handles.Duration/2*handles.samprate);
Voltage_single_cycle_Dopamine=FSCV_voltage_Dopamine(Last_Cycle_Index_DA);

CurrentMatrixDAcell = cell(1,handles.numChannels);
AverageCurrentDAcell = cell(1,handles.numChannels);

for k = 1:handles.numChannels
    Current_Matrix_Dopamine=[];
    Voltage_Matrix_Dopamine=[];
    
    for i =  handles.N_DA:handles.M_DA
        
        One_Cycle_Index_DA=Peak_index_DA(i)-round(handles.Duration/2*handles.samprate):1:Peak_index_DA(i)+round(handles.Duration/2*handles.samprate);
        Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA,k)';
        Voltage_single_cycle_DA=FSCV_voltage_Dopamine(One_Cycle_Index_DA)';
        
        Current_Matrix_Dopamine=[Current_Matrix_Dopamine;Current_single_cycle_DA];
        Voltage_Matrix_Dopamine=[Voltage_Matrix_Dopamine;Voltage_single_cycle_DA];
        
        Current_Matrix_Dopamine_Plot=reshape(Current_Matrix_Dopamine', numel(Current_Matrix_Dopamine),1);
        Voltage_Matrix_Dopamine_Plot=reshape(Voltage_Matrix_Dopamine', numel(Voltage_Matrix_Dopamine),1);
    end
    Average_current_Dopamine=mean(Current_Matrix_Dopamine);
    CurrentMatrixDAcell{k} = Current_Matrix_Dopamine_Plot;
    AverageCurrentDAcell{k} = Average_current_Dopamine;   
end
%% Calculate the substracted current
PeakCurrentMatrixCell = cell(1,handles.numChannels);
VoltageMatrixCell = cell(1,handles.numChannels);
SubtractedCurrentMatrixCell = cell(1,handles.numChannels);
Substrated_current = cell(1,handles.numChannels);

for i = 1:handles.numChannels
    
    Substrated_current{i}=AverageCurrentDAcell{i}-AverageCurrentPBScell{i};    
    Peak_current_matrix=[];
    Voltage_matrix=[];
    Subtracted_current_matrix=[];
    
    for j=1:1:NumOfCycle_DA-1
        
        One_Cycle_Index_DA=Peak_index_DA(j)-round(handles.Duration/2*handles.samprate):1:Peak_index_DA(j)+round(handles.Duration/2*handles.samprate);
        Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA,i)';
        Voltage_single_cycle_DA=FSCV_voltage_Dopamine(One_Cycle_Index_DA)';
        One_Cycle_Index_PBS = Peak_index(j)-round(handles.Duration/2*handles.samprate):1:Peak_index(j)+round(handles.Duration/2*handles.samprate);
        Current_single_cycle=FSCV_current_PBS(One_Cycle_Index_PBS,i)';
        
        Subtracted_current_single_cycle=Current_single_cycle_DA-Current_single_cycle;        
        Index_low=find (Voltage_single_cycle_DA>handles.peakV_low & Voltage_single_cycle_DA<handles.peakV_high);
        Subtracted_current_local=Subtracted_current_single_cycle(Index_low);        
        Peak_current=max(Subtracted_current_local);
        
        Peak_current_matrix=[Peak_current_matrix Peak_current];
        Subtracted_current_matrix=[Subtracted_current_matrix Subtracted_current_single_cycle'];
        Voltage_matrix=[Voltage_matrix Voltage_single_cycle_DA'];
        
    end
    
    PeakCurrentMatrixCell{i} = Peak_current_matrix;
    VoltageMatrixCell{i} = Voltage_matrix;
    SubtractedCurrentMatrixCell{i} = Subtracted_current_matrix;    
end

%% Variables for Plotting: 
handles.SubtractedCurrentMatrixCell = SubtractedCurrentMatrixCell;
handles.PeakCurrentMatrixCell = PeakCurrentMatrixCell;
handles.Voltage_Matrix_Dopamine_Plot= Voltage_Matrix_Dopamine_Plot ; 
handles.CurrentMatrixDAcell =CurrentMatrixDAcell;
handles.Voltage_Matrix_PBS_Plot = Voltage_Matrix_PBS_Plot;
handles.CurrentMatrixPBScell = CurrentMatrixPBScell;
handles.Voltage_single_cycle_Dopamine=Voltage_single_cycle_Dopamine;
handles.AverageCurrentDAcell=AverageCurrentDAcell;
handles.Voltage_single_cycle_PBS=Voltage_single_cycle_PBS;
handles.AverageCurrentPBScell=AverageCurrentPBScell;
handles.Substrated_current=Substrated_current;
handles.Time_measurement = Time_measurement;
handles.FSCV_voltage_PBS=FSCV_voltage_PBS;
handles.FSCV_current_PBS=FSCV_current_PBS;

%% Saving Summary 
if handles.save ==1
        fig1 = [Voltage_Matrix_Dopamine_Plot, Voltage_Matrix_PBS_Plot];
        fig2 = [Voltage_single_cycle_Dopamine,Voltage_single_cycle_PBS];
        fig3 = [Voltage_single_cycle_Dopamine,Substrated_current ];
        fig5 = [];
        fig6 = [];
        fig8 = [FSCV_voltage_PBS];
        fig9 = [FSCV_current_PBS];
    for i = 1:handles.numChannels
        fig1 = [fig1, CurrentMatrixDAcell{i}, CurrentMatrixPBScell{i}];
        fig2 = [fig2,AverageCurrentDAcell{i},AverageCurrentPBScell{i}];
        fig5 = [fig5,SubtractedCurrentMatrixCell{i}];
        fig6 = [fig6,PeakCurrentMatrixCell{i}];       
    end
    
    xlswrite(handles.savefile,fig1,1)
    xlswrite(handles.savefile,fig1,2)
    xlswrite(handles.savefile,fig1,3)
    xlswrite(handles.savefile,fig1,5)
    xlswrite(handles.savefile,fig1,6)
    xlswrite(handles.savefile,fig1,8)
    xlswrite(handles.savefile,fig1,9)
end 

guidata(hObject,handles);

% --- Executes on button press in Heatmap.
function Heatmap_Callback(hObject, eventdata, handles)
% hObject    handle to Heatmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end

for i = 1:handles.numChannels
    axes(handles.plots(i));
    imagesc(handles.SubtractedCurrentMatrixCell{i});
    set(gca, 'YDir', 'normal');
    colormap('jet');
    colorbar;
    
    ylim = get(gca,'YLim');
    set(gca,'YTick',linspace(ylim(1),ylim(2),3));
    set(gca,'YTickLabel',[handles.voltlow, handles.volthigh, handles.voltlow]);
    ylabel('Potential (V)','FontSize',8,'FontWeight','bold')
    handles.PeakCurrentMatrixCell{i};
    Total_length=length(handles.PeakCurrentMatrixCell{i});
    Time_peak_current=(1:Total_length)*1/handles.Freq;
    xlim = get(gca,'XLim');
    set(gca, 'XTick', linspace(xlim(1),xlim(2),3))
    set(gca,'XTickLabel', linspace(round(Time_peak_current(1)),round(Time_peak_current(end)),3))
    
    xlabel('Time (seconds)','FontSize',8,'FontWeight','bold');
end

guidata(hObject,handles);

% --- Executes on button press in IvsVr.
function IvsVr_Callback(hObject, eventdata, handles)
% hObject    handle to IvsVr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end

for i = 1:handles.numChannels
    axes(handles.plots(i));
    plot(handles.Voltage_Matrix_Dopamine_Plot, handles.CurrentMatrixDAcell{i}*10^9,'r-',handles.Voltage_Matrix_PBS_Plot, handles.CurrentMatrixPBScell{i}*10^9, 'b-','LineWidth',2 )
    xlabel('FSCV voltage (V)','FontSize',8,'FontWeight','bold')
    ylabel('Total current(nA)','FontSize',8,'FontWeight','bold')
    legend('Dopamine','PBS')
    grid minor;
end

guidata(hObject,handles);

% --- Executes on button press in AvgIvsVr.
function AvgIvsVr_Callback(hObject, eventdata, handles)
% hObject    handle to AvgIvsVr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end

if handles.includeCalib == 1
    for i = 1:handles.numChannels
        axes(handles.plots(i));
        plot(handles.Voltage_single_cycle_Dopamine', (handles.AverageCurrentDAcell{i}-handles.CH_calib_current(1:length(handles.AverageCurrentDAcell{i}),i)')*10^9,'r',handles.Voltage_single_cycle_PBS, (handles.AverageCurrentPBScell{i}-handles.CH_calib_current(:,i)')*10^9, 'b','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',8,'FontWeight','bold')
        ylabel('Total current(nA)','FontSize',8,'FontWeight','bold')
        legend('Dopamine','PBS')
        grid minor;        
    end
else
    for i = 1:handles.numChannels
        axes(handles.plots(i));
        plot(handles.Voltage_single_cycle_Dopamine', (handles.AverageCurrentDAcell{i})*10^9,'r',handles.Voltage_single_cycle_PBS, (handles.AverageCurrentPBScell{i})*10^9, 'b','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',8,'FontWeight','bold')
        ylabel('Total current(nA)','FontSize',8,'FontWeight','bold')
        legend('Dopamine','PBS')
        grid minor;
    end
end

guidata(hObject,handles);

% --- Executes on button press in SubIvsVr.
function SubIvsVr_Callback(hObject, eventdata, handles)
% hObject    handle to SubIvsVr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end

for i = 1:handles.numChannels
    axes(handles.plots(i));
    plot(handles.Voltage_single_cycle_Dopamine', handles.Substrated_current{i}*10^9,'r','LineWidth',2 )
    xlabel('FSCV voltage (V)','FontSize',8,'FontWeight','bold')
    ylabel('Electrochemical current(nA)','FontSize',8,'FontWeight','bold')
    legend('Dopamine')
    grid minor;
end

guidata(hObject,handles);

% --- Executes on button press in PeakIvsSamp.
function PeakIvsSamp_Callback(hObject, eventdata, handles)
% hObject    handle to PeakIvsSamp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end

for i = 1:handles.numChannels
    axes(handles.plots(i));
    plot(handles.PeakCurrentMatrixCell{i}*10^9,'r','LineWidth',2)
    xlabel('Number of samples','FontSize',8,'FontWeight','bold')
    ylabel('Electrochemical Current (nA)','FontSize',8,'FontWeight','bold')
    grid minor;
end
guidata(hObject,handles);

% --- Executes on button press in PeakIvsT.
function PeakIvsT_Callback(hObject, eventdata, handles)
% hObject    handle to PeakIvsT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end

for i = 1:handles.numChannels
    axes(handles.plots(i));
    Total_length=length(handles.PeakCurrentMatrixCell{i});
    Time_peak_current=(1:Total_length)*1/handles.Freq;
    plot(Time_peak_current,handles.PeakCurrentMatrixCell{i}*10^9,'r','LineWidth',2)
    xlabel('Time (sec)','FontSize',8,'FontWeight','bold')
    ylabel('Electrochemical Current (nA)','FontSize',8,'FontWeight','bold')
    grid minor;    
end
guidata(hObject,handles);

% --- Executes on button press in SubIvsT.
function SubIvsT_Callback(hObject, eventdata, handles)
% hObject    handle to SubIvsT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end

for i = 1:handles.numChannels
    axes(handles.plots(i));
    length_sub=length(handles.Substrated_current{i});
    Time=(1:length_sub)/length_sub*(handles.volthigh-handles.voltlow)/handles.ramprate*2*1e3;
    plot(Time, handles.Substrated_current{i}*10^9, 'r')
    xlabel('Time (ms)','FontSize',8,'FontWeight','bold')
    ylabel('Electrochemical Current (nA)','FontSize',8,'FontWeight','bold')
    grid minor;    
end
guidata(hObject,handles);

% --- Executes on button press in IvsT.
function IvsT_Callback(hObject, eventdata, handles)
% hObject    handle to IvsT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end

for i = 1:handles.numChannels
    axes(handles.plots(i));
    plot(handles.Time_measurement, handles.FSCV_current_PBS(:,i)*1e9);
    xlabel('Time (s)','FontSize',8,'FontWeight','bold')
    ylabel('FSCV current (nA)','FontSize',8,'FontWeight','bold')
    grid minor;
end

guidata(hObject,handles);

% --- Executes on button press in VrvsT.
function VrvsT_Callback(hObject, eventdata, handles)
% hObject    handle to VrvsT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:handles.numChannels
    cla(handles.plots(i),'reset')
    handles.plots(i).FontSize = 8;
end

for i = 1:handles.numChannels
    axes(handles.plots(i));
    length_vol=length(handles.FSCV_voltage_PBS);
    Time=(1:length_vol)*1/handles.samprate;
    plot(Time,handles.FSCV_voltage_PBS, 'r')
    xlabel('Time (s)','FontSize',8,'FontWeight','bold')
    ylabel('FSCV voltage (V)','FontSize',8,'FontWeight','bold')
    grid minor;     
end
guidata(hObject,handles);

% --- Executes on button press in Return.
function Return_Callback(hObject, eventdata, handles)
% hObject    handle to Return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run Multichannel.m
guidata(hObject,handles);

% --- Executes on button press in includeCalibration.
function includeCalibration_Callback(hObject, eventdata, handles)
% hObject    handle to includeCalibration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.includeCalib = get(hObject,'Value');
guidata(hObject,handles); 

% --- Executes on button press in calibFilename.
function calibFilename_Callback(hObject, eventdata, handles)
% hObject    handle to calibFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.Calibfilename, handles.Calibpathname] = uigetfile;
handles.calibFilename.String = strcat(handles.Calibpathname,handles.Calibfilename);
guidata(hObject, handles);

% --- Executes on button press in selectFilename.
function selectFilename_Callback(hObject, eventdata, handles)
% hObject    handle to selectFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.Selectfilename, handles.Selectpathname] = uigetfile;
handles.selectFilename.String = strcat(handles.Selectpathname,handles.Selectfilename);
guidata(hObject,handles);

% --- Executes on selection change in numChan.
function numChan_Callback(hObject, eventdata, handles)
% hObject    handle to numChan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.channels = get(hObject,'Value');
if handles.channels == 2
    handles.numChannels = 4; 
    handles.plots = [handles.Ch1_4,handles.Ch2_4,handles.Ch3_4,handles.Ch4_4];
    set(handles.Channels16,'visible','off');
    set(handles.Channels8,'visible','off');
    set(handles.Channels4,'visible','on');
    
    for i = 1:handles.numChannels
        cla(handles.plots(i),'reset')
        handles.plots(i).FontSize = 8;
    end   
    
elseif handles.channels == 3
    handles.numChannels = 8; 
    handles.plots = [handles.Ch1_8,handles.Ch2_8,handles.Ch3_8,handles.Ch4_8,handles.Ch5_8,handles.Ch6_8,handles.Ch7_8,handles.Ch8_8];
    set(handles.Channels16,'visible','off');
    set(handles.Channels8,'visible','on');
    set(handles.Channels4,'visible','off');
    
    for i = 1:handles.numChannels
        cla(handles.plots(i),'reset')
        handles.plots(i).FontSize = 8;
    end 
    
elseif handles.channels == 4
    handles.numChannels = 16; 
    handles.plots = [handles.Ch1_16,handles.Ch2_16,handles.Ch3_16,handles.Ch4_16,handles.Ch5_16,handles.Ch6_16,handles.Ch7_16,handles.Ch8_16,handles.Ch9_16,handles.Ch10_16,handles.Ch11_16,handles.Ch12_16,handles.Ch13_16,handles.Ch14_16,handles.Ch15_16,handles.Ch16_16];
    set(handles.Channels16,'visible','on');
    set(handles.Channels8,'visible','off');
    set(handles.Channels4,'visible','off');
    
    for i = 1:handles.numChannels
        cla(handles.plots(i),'reset')
        handles.plots(i).FontSize = 8;
    end 
else
    set(handles.Channels16,'visible','off');
    set(handles.Channels8,'visible','off');
    set(handles.Channels4,'visible','off');
end

guidata(hObject,handles)
% --- Executes during object creation, after setting all properties.
function numChan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numChan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in removeBiasCurrent.
function removeBiasCurrent_Callback(hObject, eventdata, handles)
% hObject    handle to removeBiasCurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.removeBias = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in saveData.
function saveData_Callback(hObject, eventdata, handles)
% hObject    handle to saveData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.save = get(hObject,'Value');
guidata(hObject,handles); 

function saveFilename_Callback(hObject, eventdata, handles)
% hObject    handle to saveFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.savefile = get(hObject,'String');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function saveFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saveFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function maxDA_Callback(hObject, eventdata, handles)
% hObject    handle to maxDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.M_DA = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function maxDA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function maxPBS_Callback(hObject, eventdata, handles)
% hObject    handle to maxPBS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.M_PBS = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function maxPBS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxPBS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function minDA_Callback(hObject, eventdata, handles)
% hObject    handle to minDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.N_DA = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function minDA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function minPBS_Callback(hObject, eventdata, handles)
% hObject    handle to minPBS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.N_PBS = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function minPBS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minPBS (see GCBO)
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

function Voltage_Low_Callback(hObject, eventdata, handles)
% hObject    handle to Voltage_Low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.voltlow = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Voltage_Low_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Voltage_Low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Voltage_High_Callback(hObject, eventdata, handles)
% hObject    handle to Voltage_High (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.volthigh=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Voltage_High_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Voltage_High (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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

function VrColumn_Callback(hObject, eventdata, handles)
% hObject    handle to VrColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.VrCol = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function VrColumn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VrColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Ch1Column_Callback(hObject, eventdata, handles)
% hObject    handle to Ch1Column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Ch1Col = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Ch1Column_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch1Column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function TimeColumn_Callback(hObject, eventdata, handles)
% hObject    handle to TimeColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.TimeCol = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function TimeColumn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeColumn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function peakVoltageHigh_Callback(hObject, eventdata, handles)
% hObject    handle to peakVoltageHigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.peakV_high = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function peakVoltageHigh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peakVoltageHigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function peakVoltageLow_Callback(hObject, eventdata, handles)
% hObject    handle to peakVoltageLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.peakV_low = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function peakVoltageLow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peakVoltageLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
