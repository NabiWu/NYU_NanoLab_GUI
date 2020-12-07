function varargout = newDC_Decimation2(varargin)
% NEWDC_DECIMATION2 MATLAB code for newDC_Decimation2.fig
%      NEWDC_DECIMATION2, by itself, creates a new NEWDC_DECIMATION2 or raises the existing
%      singleton*.
%
%      H = NEWDC_DECIMATION2 returns the handle to a new NEWDC_DECIMATION2 or the handle to
%      the existing singleton*.
%
%      NEWDC_DECIMATION2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWDC_DECIMATION2.M with the given input arguments.
%
%      NEWDC_DECIMATION2('Property','Value',...) creates a new NEWDC_DECIMATION2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newDC_Decimation2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newDC_Decimation2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help newDC_Decimation2

% Last Modified by GUIDE v2.5 12-Aug-2019 20:12:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newDC_Decimation2_OpeningFcn, ...
                   'gui_OutputFcn',  @newDC_Decimation2_OutputFcn, ...
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


% --- Executes just before newDC_Decimation2 is made visible.
function newDC_Decimation2_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;


guidata(hObject, handles);




% --- Outputs from this function are returned to the command line.
function varargout = newDC_Decimation2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in Unload.
function Unload_Callback(hObject, eventdata, handles)

%Unload the okFrontPanel library 
calllib('okFrontPanel', 'okFrontPanel_Destruct', handles.xem);
guidata(hObject, handles);
clear all;
unloadlibrary okFrontPanel


% --- Executes on button press in confirmConfiguration.
function confirmConfiguration_Callback(hObject, eventdata, handles)

% str=inputdlg({'P','Q','div1(delta_sigma)','div2(DAC)'},'Input dialog');
% P=str2num(str{1});
% Q=str2num(str{2});
% div1=str2num(str{3});
% div2=str2num(str{4});

P=str2num(get(handles.editPValue,'String'));
Q=str2num(get(handles.editQValue,'String'));
div1=str2num(get(handles.editDIV1Value,'String'));
div2=str2num(get(handles.editDIV2Value,'String'));
loadlibrary('okFrontPanel', 'okFrontPanelDLL.h');
handles.xem = calllib('okFrontPanel', 'okFrontPanel_Construct');
handles.numDevices = calllib('okFrontPanel', 'okFrontPanel_GetDeviceCount', handles.xem);
handles.ret = calllib('okFrontPanel', 'okFrontPanel_OpenBySerial', handles.xem, '');
handles.success_checkOPEN = calllib('okFrontPanel', 'okFrontPanel_IsOpen', handles.xem);
handles.pll = calllib('okFrontPanel', 'okPLL22150_Construct');
calllib('okFrontPanel', 'okPLL22150_SetCrystalLoad', handles.pll, 12.0);
calllib('okFrontPanel', 'okPLL22150_SetReference', handles.pll, 48.0, 1);
calllib('okFrontPanel', 'okPLL22150_SetVCOParameters', handles.pll, P, Q);
handles.VCO_freq = calllib('okFrontPanel', 'okPLL22150_GetVCOFrequency', handles.pll);
calllib('okFrontPanel', 'okPLL22150_SetDiv1', handles.pll, 1, div1);
calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 4, 1);
%calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 0, 1);
handles.freq_out1 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 4);
%handles.freq_out1 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 0);
calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 1, 0);
handles.freq_out2 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 1);
calllib('okFrontPanel', 'okPLL22150_SetDiv2', handles.pll, 1, div2);
calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 0, 4);
handles.freq_out3 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 0);
calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 4, 1);
%calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 0, 1);
calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 1, 1);
%calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 4, 1);
calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 0, 1);
calllib('okFrontPanel', 'okFrontPanel_SetPLL22150Configuration', handles.xem, handles.pll);
handles.success_configure = calllib('okFrontPanel', 'okFrontPanel_ConfigureFPGA', handles.xem,'chip4_adc_cont.bit');
handles.OSR=128;
handles.Fout=(handles.freq_out1/handles.OSR)*1000000;
handles.ENOB=11;

assignin('base','VCO_MHz',handles.VCO_freq);
assignin('base','delta_sigma_clk_MHz',handles.freq_out1);
assignin('base','USB_clk_MHz',handles.freq_out2);
assignin('base','DAC_clk_MHz',handles.freq_out3);
assignin('base','OSR',handles.OSR);
assignin('base','Fout_Hz',handles.Fout);


   
   
handles.p_Left1=[-583.913; 1030.5];
handles.p_Right1=[-583.913; 1030.5];
handles.p_Left2=[-583.913; 1030.5];
handles.p_Right2=[-583.913; 1030.5];


% handles.p_Left=[-580.935439; 1984.094664];
% handles.p_Right=[-574.775140; 1974.650152];

handles.RfeedBack_TIA2L1=4.1*(10^6);
handles.RfeedBack_TIA2R1=4.1*(10^6);
handles.RfeedBack_TIA2L2=4.1*(10^6);
handles.RfeedBack_TIA2R2=4.1*(10^6);

handles.axes_total=[]; 
f = figure('Name','FSCV GUI','NumberTitle','off','Color','w','Position',[350 50 1550 935]); 
tg = uitabgroup(f);


 firstTab = uitab(tg,'Title', 'Four Channel Vcm-I Plotting');
 axes('Parent',firstTab);
 tmp=subplot(2,2,1); 

    title("v vs i (TIA L1)",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,2); 

    title("v vs i (TIA L2)",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,3); 

    title("v vs i (TIA R1)",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,4); 

    title("v vs i (TIA R2)",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14)
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
  
    
 secondTab = uitab(tg,'Title', 'Four Channel I-t Plotting');
 axes('Parent',secondTab);
 tmp=subplot(2,2,1); 

    title("t vs i (TIA L1)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,2);

    title("t vs i (TIA L2)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,3); 

    title("t vs i (TIA R1)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,4); 

    title("time vs i (TIA R2)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14)
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];

guidata(hObject, handles);

% --- Executes on button press in ConfirmDaqSetup.
function ConfirmDaqSetup_Callback(hObject, eventdata, handles)
% if(get(hObject,'Value') == 1)
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 1,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),1,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),1,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),1,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1A'),1,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
% else
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 0,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),0,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),0,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),0,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),0,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),0,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),0,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1A'),0,hex2dec('01'));
%   calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
% end


if(get(hObject,'Value') == 1)
  
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    editPGAL_Callback(handles.editPGAL, eventdata, handles)
    editPGAR_Callback(handles.editPGAR, eventdata, handles)
%     editClockEnable_Callback(handles.editClockEnable, eventdata, handles)
%     editADCEnable_Callback(handles.editADCEnable, eventdata, handles)
%     editTIAEnable_Callback(handles.editTIAEnable, eventdata, handles)
%     editBiasEnable_Callback(handles.editBiasEnable, eventdata, handles)
%     editTIAorADC_Callback(handles.editTIAorADC, eventdata, handles)
else

    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

guidata(hObject, handles);



% --- Executes on button press in confirmInputSignal.
function confirmInputSignal_Callback(hObject, eventdata, handles)
if(get(hObject,'Value') == 1) 
    Frequency=str2num(get(handles.editFrequency,'String'));
    Period=1/Frequency;
    ScanRate=str2num(get(handles.editScanRate,'String'));
    PeakVol=str2num(get(handles.editPeakVoltage,'String'));
    BottomVol=str2num(get(handles.editBottomVoltage,'String'));
    Vcom=str2num(get(handles.editVcom,'String'));
    cycle_org = str2num(get(handles.editDuration,'String')) * 650;
    %dataSave_FSCV(handles.VDAC,cycle_org,Period);
%     dataSave_FSCV(4.1,4.1,1,10,200,-0.00,1.3,-0.4,1300,0.1)
%     cycle_org = 1300;
%     period = 0.1;
    VDAC = handles.VDAC;
    
    daqreset;
    daqSession = daq.createSession('ni');
    daqSession.IsContinuous = true;
    addAnalogOutputChannel(daqSession,'Dev1',0:3,'Voltage');
    addAnalogInputChannel(daqSession,'Dev1',0,'voltage');
    addAnalogInputChannel(daqSession,'Dev1',1,'voltage');
    daqSession.Rate=18250;
    h = daqSession.addlistener('DataAvailable', @(src,event) src.queueOutputData(VDAC));
    %ch0.TerminalConfig = 'SingleEnded';
    Sampling_rate=50000;
    disp('ok');
    queueOutputData(daqSession,VDAC);
    daqSession.startBackground();
    pause;
end
guidata(hObject, handles);



% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)

        duration = str2num(get(handles.editDuration,'String'));
        % str=inputdlg({'FSCV Period','FSCV ScanRate','FSCV Peak Voltage','FSCV Buttom Voltage','FSCV Vcom'},'Input dialog');
        % Period=str2num(str{1});
        % ScanRate=str2num(str{2});
        % Vr_H=str2num(str{3});
        % Vr_L=str2num(str{4});
        % Vcom=str2num(str{5});
        Frequency = str2num(get(handles.editFrequency,'String'));
        Period= 1/Frequency;
        ScanRate=str2num(get(handles.editScanRate,'String'));
        Vr_H=str2num(get(handles.editPeakVoltage,'String'));
        Vr_L=str2num(get(handles.editBottomVoltage,'String'));
        Vcom=str2num(get(handles.editVcom,'String'));
        RfeedBack=[handles.RfeedBack_TIA2L1 handles.RfeedBack_TIA2R1 handles.RfeedBack_TIA2L2 handles.RfeedBack_TIA2R2];
        lowerVol = str2num(get(handles.lowerVol,'String'));
        upperVol = str2num(get(handles.upperVol,'String'));
        lowerCur = str2num(get(handles.lowerCur,'String'));
        upperCur = str2num(get(handles.upperCur,'String'));
        %BTPIPEOUT
        tolerance_range=0.9;
        N_ok=5; 
        cycle=(118*duration)-2; 
        FIFO_size=4096;%16bit 
        blocksize=1024;%byte
        Unit_length= (2*FIFO_size);
        %data((cycle*(FIFO_size-1)),1)=uint16(0);
        handles.data_L1=[];
        handles.data_R1=[];
        handles.current_L1=[];
        handles.current_R1=[];
        
        handles.data_L2=[];
        handles.data_R2=[];
        handles.current_L2=[];
        handles.current_R2=[];
        
        handles.data_L1_save=[];
        handles.data_R1_save=[];
        handles.current_L1_save=[];
        handles.current_R1_save=[];
        
        handles.data_L2_save=[];
        handles.data_R2_save=[];
        handles.current_L2_save=[];
        handles.current_R2_save=[];
        
        
        
        length_Total=cycle*(2*FIFO_size); 
        buf_A0(Unit_length,1) = uint8(0); 
        epvalue_A0(Unit_length,1) = uint8(0); 
        pv_A0 = libpointer('uint8Ptr', buf_A0);

        buf_A1(Unit_length,1) = uint8(0); 
        epvalue_A1(Unit_length,1) = uint8(0); 
        pv_A1 = libpointer('uint8Ptr', buf_A1);

        buf_A2(Unit_length,1) = uint8(0); 
        epvalue_A2(Unit_length,1) = uint8(0); 
        pv_A2 = libpointer('uint8Ptr', buf_A2);


        buf_A3(Unit_length,1) = uint8(0); 
        epvalue_A3(Unit_length,1) = uint8(0); 
        pv_A3 = libpointer('uint8Ptr', buf_A3);
        
        delay = FIFO_size/handles.Fout;
        t = 0;
        %ENOB=11;
        ENOB=handles.ENOB;
        N_window=2;
        Plot_Ylimit=2;
        %tmp0 = 0;
        %tmp(cycle,1) = 0;
        data_tmp_L1((FIFO_size-1),1) = 0;
        data_tmp_R1((FIFO_size-1),1) = 0;
        current_tmp_L1((FIFO_size-1),1) = 0;
        current_tmp_R1((FIFO_size-1),1) = 0;

        data_tmp_L2((FIFO_size-1),1) = 0;
        data_tmp_R2((FIFO_size-1),1) = 0;
        current_tmp_L2((FIFO_size-1),1) = 0;
        current_tmp_R2((FIFO_size-1),1) = 0;
        
        data_cycle_L1=[];
        data_cycle_R1=[];
        data_cycle_L2=[];
        data_cycle_R2=[];

        success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'), 1,hex2dec('01')); 
        calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem); 
        pause(1/handles.Fout); 
        success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'), 0,hex2dec('01')); 
        calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
        pause(20/handles.Fout);  
        %pause(((FIFO_size-500)/(handles.freq_out1*1000000))); 
        
        for i= 1:cycle
            disp(i)
            pause(delay-t);
            tic
        %     handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize, Unit_length, pv_A0);
        %     epvalue_A0 = get(pv_A0, 'value');
        %     handles.BTpipeOut_A1=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A1'), blocksize, Unit_length, pv_A1);
        %     epvalue_A1 = get(pv_A1, 'value');

            handles.BTpipeOut_A2=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A2'), blocksize, Unit_length, pv_A2);
            epvalue_A2 = get(pv_A2, 'value');
%             disp(epvalue_A2)
            handles.BTpipeOut_A3=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A3'), blocksize, Unit_length, pv_A3);
            epvalue_A3 = get(pv_A3, 'value');

            %data(((i-1)*(FIFO_size-1)+1):(i*(FIFO_size-1)))=double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))));
            %data=[data; double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))))];

        %     data_tmp_L1 = quantizer_one_forth((double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
        %     data_tmp_L1 = (data_tmp_L1-handles.p_Left1(2))/(handles.p_Left1(1));
        %     handles.data_L1=[handles.data_L1; data_tmp_L1];
        %     current_tmp_L1=(data_tmp_L1-Vcom)/(RfeedBack(1));
        %     handles.current_L1=[handles.current_L1; current_tmp_L1];
        %     data_cycle_L1=[data_cycle_L1; data_tmp_L1];
%             if (get(handles.SaveData,'Value')==1)
%                 handles.data_L1_save=[handles.data_L1_save; data_tmp_L1];
%                 handles.current_L1_save=[handles.current_L1_save; current_tmp_L1];
%             end
    
        %     data_tmp_R1 = quantizer_one_forth((double(epvalue_A1(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A1(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
        %     data_tmp_R1 = (data_tmp_R1-handles.p_Right1(2))/(handles.p_Right1(1));
        %     handles.data_R1=[handles.data_R1; data_tmp_R1];
        %     current_tmp_R1=(data_tmp_R1-Vcom)/(RfeedBack(2));
        %     handles.current_R1=[handles.current_R1; current_tmp_R1];
        %     data_cycle_R1=[data_cycle_R1; data_tmp_R1];
%             if (get(handles.SaveData,'Value')==1)
%                 handles.data_R1_save=[handles.data_R1_save; data_tmp_R1];
%                 handles.current_R1_save=[handles.current_R1_save; current_tmp_R1];
%             end

            data_tmp_L2 = quantizer_one_forth((double(epvalue_A2(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A2(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
            data_tmp_L2 = (data_tmp_L2-handles.p_Left2(2))/(handles.p_Left2(1));
            handles.data_L2=[handles.data_L2; data_tmp_L2];
            current_tmp_L2=(data_tmp_L2-Vcom)/(RfeedBack(3));
            handles.current_L2=[handles.current_L2; current_tmp_L2];
            data_cycle_L2=[data_cycle_L2; data_tmp_L2];
            if (get(handles.SaveData,'Value')==1)
                handles.data_L2_save=[handles.data_L2_save; data_tmp_L2];
                handles.current_L2_save=[handles.current_L2_save; current_tmp_L2];
            end
    
            data_tmp_R2 = quantizer_one_forth((double(epvalue_A3(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A3(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
            data_tmp_R2 = (data_tmp_R2-handles.p_Right2(2))/(handles.p_Right2(1));
            handles.data_R2=[handles.data_R2; data_tmp_R2];
            current_tmp_R2=(data_tmp_R2-Vcom)/(RfeedBack(4));
            handles.current_R2=[handles.current_R2; current_tmp_R2];
            data_cycle_R2=[data_cycle_R2; data_tmp_R2];
            if (get(handles.SaveData,'Value')==1)
                handles.data_R2_save=[handles.data_R2_save; data_tmp_R2];
                handles.current_R2_save=[handles.current_R2_save; current_tmp_R2];
            end
            guidata(hObject, handles);

            tmp0 = round(((i-1)-mod((i-1),N_window))/N_window)+1;

            
            if (get(handles.stop,'Value')==0)
               
            %     plot(handles.axes_total(3),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L1)
            %     axis(handles.axes_total(3),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
            %     title(handles.axes_total(3),'t vs v (TIA L1)','Color', 'b') 
            %     xlabel(handles.axes_total(3),'time (s)')
            %     ylabel(handles.axes_total(3),'voltage (v)')
            %     hold(handles.axes_total(3),'on')

            %     plot(handles.axes_total(8),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R1)
            %     axis(handles.axes_total(8),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
            %     title(handles.axes_total(8),'t vs v (TIA R1)','Color', 'b')
            %     xlabel(handles.axes_total(8),'time (s)')
            %     ylabel(handles.axes_total(8),'voltage (v)')
            %     hold(handles.axes_total(8),'on')

                plot(handles.axes_total(5),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L1*(10^9));
                axis(handles.axes_total(5),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
                title(handles.axes_total(5),'t vs i (TIA L1)','Color', 'b')
                xlabel(handles.axes_total(5),'time (s)')
                ylabel(handles.axes_total(5),'current (nA)')
                hold(handles.axes_total(5),'on')

                plot(handles.axes_total(7),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R1*(10^9))
                axis(handles.axes_total(7),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
                title(handles.axes_total(7),'t vs i (TIA R1)','Color', 'b')
                xlabel(handles.axes_total(7),'time (s)')
                ylabel(handles.axes_total(7),'current (nA)')
                hold(handles.axes_total(7),'on')


            %     plot(handles.axes_total(13),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
            %     axis(handles.axes_total(13),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
            %     title(handles.axes_total(13),'t vs v (TIA L2)','Color', 'b') 
            %     xlabel(handles.axes_total(13),'time (s)')
            %     ylabel(handles.axes_total(13),'voltage (v)')
            %     hold(handles.axes_total(13),'on')
            % 
            %     plot(handles.axes_total(18),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
            %     axis(handles.axes_total(18),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
            %     title(handles.axes_total(18),'t vs v (TIA R2)','Color', 'b')
            %     xlabel(handles.axes_total(18),'time (s)')
            %     ylabel(handles.axes_total(18),'voltage (v)')
            %     hold(handles.axes_total(18),'on')
            % 
                plot(handles.axes_total(6),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L2*(10^9))
                axis(handles.axes_total(6),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
                title(handles.axes_total(6),'t vs i (TIA L2)','Color', 'b')
                xlabel(handles.axes_total(6),'time (s)')
                ylabel(handles.axes_total(6),'current (nA)')
                hold(handles.axes_total(6),'on')

                plot(handles.axes_total(8),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R2*(10^9))
                axis(handles.axes_total(8),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
                title(handles.axes_total(8),'t vs i (TIA R2)','Color', 'b')
                xlabel(handles.axes_total(8),'time (s)')
                ylabel(handles.axes_total(8),'current (nA)')
                hold(handles.axes_total(8),'on')
            
            end
            
            
            if mod(i,N_window)==0
%                 [data_FSCV_L1, N_L1]=FSCV_cycle_v2(data_cycle_L1, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Left1);
%                 [data_FSCV_R1, N_R1]=FSCV_cycle_v2(data_cycle_R1, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Right1);
                [data_FSCV_L2, N_L2]=FSCV_cycle_v2(data_cycle_L2, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Left2);
                [data_FSCV_R2, N_R2]=FSCV_cycle_v2(data_cycle_R2, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Right2);


%                 if length(data_FSCV_L1)==0
%                     imp_L1=zeros(1,(2*N_L1+1));
%                 else
%                     imp_L1=(((mean(data_FSCV_L1')-0)/(1))-Vcom)/(RfeedBack(1));
%                 end
%                 if length(data_FSCV_R1)==0
%                     imp_R1=zeros(1,(2*N_R1+1));
%                 else
%                     imp_R1=(((mean(data_FSCV_R1')-0)/(1))-Vcom)/(RfeedBack(2));
%                 end

                if length(data_FSCV_L2)==0
                    imp_L2=zeros(1,(2*N_L2+1));
                else
                    imp_L2=(((mean(data_FSCV_L2')-0)/(1))-Vcom)/(RfeedBack(1));
                end
                if length(data_FSCV_R2)==0
                    imp_R2=zeros(1,(2*N_R2+1));
                else
                    imp_R2=(((mean(data_FSCV_R2')-0)/(1))-Vcom)/(RfeedBack(2));
                end
                %handles.current_L=[handles.current_L; imp_L];
                %handles.current_R=[handles.current_R; imp_R];
%                 Xaxes_L1=[(((0:(N_L1-1))*((Vr_H-Vr_L)/N_L1))+Vr_L) Vr_H ((((N_L1-1):(-1):0)*((Vr_H-Vr_L)/N_L1))+Vr_L)];
%                 Xaxes_R1=[(((0:(N_R1-1))*((Vr_H-Vr_L)/N_R1))+Vr_L) Vr_H ((((N_R1-1):(-1):0)*((Vr_H-Vr_L)/N_R1))+Vr_L)];

                Xaxes_L2=[(((0:(N_L2-1))*((Vr_H-Vr_L)/N_L2))+Vr_L) Vr_H ((((N_L2-1):(-1):0)*((Vr_H-Vr_L)/N_L2))+Vr_L)];
                Xaxes_R2=[(((0:(N_R2-1))*((Vr_H-Vr_L)/N_R2))+Vr_L) Vr_H ((((N_R2-1):(-1):0)*((Vr_H-Vr_L)/N_R2))+Vr_L)];
        
                if (get(handles.stop,'Value')==0)
           
%                     plot(handles.axes_total(1),Xaxes_L1,imp_L1*(10^9))
%                     axis(handles.axes_total(1),[Vr_L Vr_H -inf inf])
%                     title(handles.axes_total(1),'v vs i (TIA L1)','Color', 'b')
%                     xlabel(handles.axes_total(1),'FSCV VCM (V)')
%                     ylabel(handles.axes_total(1),'Input Current (nA)')
% %                     legend(handles.axes_total(1),'')
%                     plot(handles.axes_total(3),Xaxes_R1,imp_R1*(10^9))
%                     axis(handles.axes_total(3),[Vr_L Vr_H -inf inf])
%                     title(handles.axes_total(3),'v vs i (TIA R1)','Color', 'b')
%                     xlabel(handles.axes_total(3),'FSCV VCM (V)')
%                     ylabel(handles.axes_total(3),'Input Current (nA)')
                
                    plot(handles.axes_total(2),Xaxes_L2,imp_L2*(10^9))
                    axis(handles.axes_total(2),[lowerVol upperVol lowerCur upperCur])
                    title(handles.axes_total(2),'v vs i (TIA L2)','Color', 'b')
                    xlabel(handles.axes_total(2),'FSCV VCM (V)')
                    ylabel(handles.axes_total(2),'Input Current (nA)')
%                     legend(handles.axes_total(2),'')
                    plot(handles.axes_total(4),Xaxes_R2,imp_R2*(10^9))
                    axis(handles.axes_total(4),[lowerVol upperVol lowerCur upperCur])
                    title(handles.axes_total(4),'v vs i (TIA R2)','Color', 'b')
                    xlabel(handles.axes_total(4),'FSCV VCM (V)')
                    ylabel(handles.axes_total(4),'Input Current (nA)')
                end
                
                ifmod = mod(i,5);
                
                if(ifmod == 0)
                    voltageArray = Xaxes_L2;

                    n = ceil(numel(voltageArray)/2);
                    firstHalfVol = voltageArray(1:n);
                    secondHalfVol = voltageArray(n+1:end);

                    v1 = str2num(get(handles.v1,'String'));
                    v2 = str2num(get(handles.v2,'String'));
                    v3 = str2num(get(handles.v3,'String'));
                    v4 = str2num(get(handles.v4,'String'));

                    [val1,idx1]=min(abs(v1-firstHalfVol));
                    [val2,idx2]=min(abs(v2-firstHalfVol));
                    [val3,idx3]=min(abs(v3-secondHalfVol));
                    [val4,idx4]=min(abs(v4-secondHalfVol));

                    vol1idx = idx1;
                    vol2idx = idx2;
                    vol3idx = idx3+length(firstHalfVol);
                    vol4idx = idx4+length(firstHalfVol);


                    I1p = imp_L2(vol1idx);
                    disp(I1p);
                    I2p = imp_L2(vol2idx);

                    I3b = imp_L2(vol3idx);

                    I4b = imp_L2(vol4idx);

                    set(handles.I1p, 'String', I1p*(10^9));

                    set(handles.I2p, 'String', I2p*(10^9));

                    set(handles.I3b, 'String', I3b*(10^9));

                    set(handles.I4b, 'String', I4b*(10^9));
                end
                
                data_cycle_L1=[];
                data_cycle_R1=[];
                data_cycle_L2=[];
                data_cycle_R2=[];
            end
                      
            t = toc;
            %tmp(i) = t;
            
        end
        if(get(handles.plotOverall,'Value')==1)
%             p1 = plot(handles.axes_total(5),((1:length(handles.data_L1))/handles.Fout),handles.current_L1*(10^9))
%             % cursorbar(p1)
%             title(handles.axes_total(5),'t vs i (TIA L1)','Color', 'b')
%             xlabel(handles.axes_total(5),'time (s)')
%             ylabel(handles.axes_total(5),'current (nA)')
%             grid minor
%             p2 = plot(handles.axes_total(7),((1:length(handles.data_R1))/handles.Fout),handles.current_R1*(10^9))
%             % cursorbar(p2)
%             title(handles.axes_total(7),'t vs i (TIA R1)','Color', 'b')
%             xlabel(handles.axes_total(7),'time (s)')
%             ylabel(handles.axes_total(7),'current (nA)')
%             grid minor

            hold(handles.axes_total(5),'off')
            hold(handles.axes_total(6),'off')
            hold(handles.axes_total(7),'off')
            hold(handles.axes_total(8),'off')

            plot(handles.axes_total(6),((1:length(handles.data_L2))/handles.Fout),handles.current_L2*(10^9));
            % cursorbar(p3)
            title(handles.axes_total(6),'t vs i (TIA L2)','Color', 'b')
            xlabel(handles.axes_total(6),'time (s)')
            ylabel(handles.axes_total(6),'current (nA)')
            grid minor
            plot(handles.axes_total(8),((1:length(handles.data_R2))/handles.Fout),handles.current_R2*(10^9));
            % cursorbar(p4)
            title(handles.axes_total(8),'t vs i (TIA R2)','Color', 'b')
            xlabel(handles.axes_total(8),'time (s)')
            ylabel(handles.axes_total(8),'current (nA)')
            grid minor
        end
%         if(get(handles.writeInfile,'Value')==1)
%             fileID=fopen('FSCV_VOLTAGE_CHL2.txt','w');
%             fprintf(fileID,'%f\n', handles.data_L2_save);
%             fclose(fileID);
% 
%             fileID=fopen('FSCV_VOLTAGE_CHR2.txt','w');
%             fprintf(fileID,'%f\n', handles.data_R2_save);
%             fclose(fileID);
% 
%             fileID=fopen('FSCV_CURRENT_CHL2.txt','w');
%             fprintf(fileID,'%f\n', 10e9*(handles.current_L2_save));
%             fclose(fileID);
% 
%             fileID=fopen('FSCV_CURRENT_CHR2.txt','w');
%             fprintf(fileID,'%f\n', 10e9*(handles.current_R2_save));
%             fclose(fileID);
%         end


%         My_matrix = linspace(-5,5).';
% 
%         arrayname = 'My_matrix';
%         fid = fopen(filename, 'w'); 
%         fclose(fid)
%         save(filename, arrayname,'-ascii', '-double', '-append');
        
        
        
        
        L2Vol = handles.data_L2_save;
        arrayname = 'L2Vol';
        fid = fopen(handles.name3Vol, 'w'); 
        fclose(fid)
        save(handles.name3Vol, arrayname,'-ascii', '-double', '-append');

        
        R2Vol = handles.data_R2_save;
        arrayname = 'R2Vol';
        fid = fopen(handles.name4Vol, 'w'); 
        fclose(fid)
        save(handles.name4Vol, arrayname,'-ascii', '-double', '-append');
        
        
        L2Cur = 10e9*(handles.current_L2_save);
        arrayname = 'L2Cur';
        fid = fopen(handles.name3Cur, 'w'); 
        fclose(fid)
        save(handles.name3Cur, arrayname,'-ascii', '-double', '-append');
        
        
        R2Cur = 10e9*(handles.current_R2_save);
        arrayname = 'R2Cur';
        fid = fopen(handles.name4Cur, 'w'); 
        fclose(fid)
        save(handles.name4Cur, arrayname,'-ascii', '-double', '-append');
        
        
        
%         handles.name1Vol = strcat(fileName,'_ch1Vol.txt');
%         handles.name2Vol = strcat(fileName,'_ch2Vol.txt');
%         handles.name3Vol = strcat(fileName,'_ch3Vol.txt');
%         handles.name4Vol = strcat(fileName,'_ch4Vol.txt');
%         handles.name1Cur = strcat(fileName,'_ch1Cur.txt');
%         handles.name2Cur = strcat(fileName,'_ch2Cur.txt');
%         handles.name3Cur = strcat(fileName,'_ch3Cur.txt');
%         handles.name4Cur = strcat(fileName,'_ch4Cur.txt');

        hold(handles.axes_total(1),'off')
        hold(handles.axes_total(2),'off')
        hold(handles.axes_total(3),'off')
        hold(handles.axes_total(4),'off')
        hold(handles.axes_total(5),'off')
        hold(handles.axes_total(6),'off')
        hold(handles.axes_total(7),'off')
        hold(handles.axes_total(8),'off')

guidata(hObject, handles);

        
% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)

% --- Executes on button press in SaveData.
function SaveData_Callback(hObject, eventdata, handles)








% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)




function editFrequency_Callback(hObject, eventdata, handles)

handles.Frequency = str2double(get(hObject,'String'));
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function editFrequency_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editScanRate_Callback(hObject, eventdata, handles)

handles.ScanRate = str2double(get(hObject,'String'));
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function editScanRate_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPeakVoltage_Callback(hObject, eventdata, handles)

handles.PeakVoltage = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editPeakVoltage_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBottomVoltage_Callback(hObject, eventdata, handles)

handles.BottomVoltage = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editBottomVoltage_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVcom_Callback(hObject, eventdata, handles)

handles.Vcom = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editVcom_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in editPGAL.
function editPGAL_Callback(hObject, eventdata, handles)
% hObject    handle to editPGAL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns editPGAL contents as cell array
%        contents{get(hObject,'Value')} returns selected item from editPGAL
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject,'Value')};

if (strcmp(popChoice,'-3dB'))
    %In this case, PGA gain is 00
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0C'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0B'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
elseif (strcmp(popChoice,'0dB'))
    %In this case, PGA gain is 01
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0C'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0B'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
elseif (strcmp(popChoice,'+6dB'))
    %In this case, PGA gain is 10
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0C'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0B'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
elseif (strcmp(popChoice,'+12dB'))
    %In this case, PGA gain is 11
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0C'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0B'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
disp('PGA_L_DONE');
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editPGAL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPGAL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in editPGAR.
function editPGAR_Callback(hObject, eventdata, handles)
% hObject    handle to editPGAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns editPGAR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from editPGAR
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject,'Value')};

if (strcmp(popChoice,'-3dB'))
    %In this case, PGA gain is 00
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1A'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('19'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'0dB'))
     %In this case, PGA gain is 01
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1A'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('19'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'+6dB'))
     %In this case, PGA gain is 10
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1A'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('19'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'+12dB'))
     %In this case, PGA gain is 11
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1A'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('19'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
disp('PGA_R_DONE')
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editPGAR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPGAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in editClockEnable.
function editClockEnable_Callback(hObject, eventdata, handles)
% hObject    handle to editClockEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns editClockEnable contents as cell array
%        contents{get(hObject,'Value')} returns selected item from editClockEnable
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject,'Value')};

if (strcmp(popChoice,'RL'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'R'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'L'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'None'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
disp('CK_DONE');
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editClockEnable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editClockEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in editADCEnable.
function editADCEnable_Callback(hObject, eventdata, handles)
% hObject    handle to editADCEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns editADCEnable contents as cell array
%        contents{get(hObject,'Value')} returns selected item from editADCEnable
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject,'Value')};

if (strcmp(popChoice,'RL'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'R'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0C'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'L'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'None'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
disp('ADC_DONE');
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editADCEnable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editADCEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in editTIAEnable.
function editTIAEnable_Callback(hObject, eventdata, handles)
% hObject    handle to editTIAEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns editTIAEnable contents as cell array
%        contents{get(hObject,'Value')} returns selected item from editTIAEnable
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject,'Value')};

if (strcmp(popChoice,'RL'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'R'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'L'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'None'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
disp('TIA_DONE');
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editTIAEnable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTIAEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in editBiasEnable.
function editBiasEnable_Callback(hObject, eventdata, handles)
% hObject    handle to editBiasEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns editBiasEnable contents as cell array
%        contents{get(hObject,'Value')} returns selected item from editBiasEnable
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject,'Value')};

if (strcmp(popChoice,'RL'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('10'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'R'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('10'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'L'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('10'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'None'))
    %1D is right channel, 0F is left channel
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('10'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
disp('BIAS_DONE');
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editBiasEnable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBiasEnable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in editTIAorADC.
function editTIAorADC_Callback(hObject, eventdata, handles)
% hObject    handle to editTIAorADC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns editTIAorADC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from editTIAorADC
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject,'Value')};

if (strcmp(popChoice,'TIA'))
    %Code 10 associated with TIA
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif (strcmp(popChoice,'ADC'))
    %Code 11 associated with ADC
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);

end
disp('CHSEL_DONE')
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editTIAorADC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTIAorADC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPValue_Callback(hObject, eventdata, handles)
% hObject    handle to editPValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPValue as text
%        str2double(get(hObject,'String')) returns contents of editPValue as a double

handles.PValue = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editPValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editQValue_Callback(hObject, eventdata, handles)
% hObject    handle to editQValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQValue as text
%        str2double(get(hObject,'String')) returns contents of editQValue as a double
handles.QValue = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editQValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDIV1Value_Callback(hObject, eventdata, handles)
% hObject    handle to editDIV1Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDIV1Value as text
%        str2double(get(hObject,'String')) returns contents of editDIV1Value as a double
handles.DIV1Value = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editDIV1Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDIV1Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDIV2Value_Callback(hObject, eventdata, handles)
% hObject    handle to editDIV2Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDIV2Value as text
%        str2double(get(hObject,'String')) returns contents of editDIV2Value as a double
handles.DIV2Value = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editDIV2Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDIV2Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in resetConfig.
function resetConfig_Callback(hObject, eventdata, handles)

prompt = {'P','Q','DIV1(δ_σ)','DIV2(DAC)'};
dlgtitle ='Reset Config Default';
dims = [1 50];
definput = {'128','48', '125', '5'};
answer = inputdlg(prompt, dlgtitle,dims,definput);
P=answer{1};
Q=answer{2};
div1=answer{3};
div2=answer{4};
set(handles.editPValue, 'String',P);
set(handles.editQValue, 'String',Q);
set(handles.editDIV1Value, 'String',div1);
set(handles.editDIV2Value, 'String',div2);



% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)







    





% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes during object creation, after setting all properties.
function resetConfig_CreateFcn(hObject, eventdata, handles)






% --- Executes on button press in resetVariables.
function resetVariables_Callback(hObject, eventdata, handles)
% hObject    handle to resetVariables (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Frequency (Hz)','ScanRate','Peak Voltage (V)','Bottom Voltage (V)','Vcom (V)'};
dlgtitle ='Reset Variable Default';
dims = [1 50];
definput = {'10','200', '1.3', '-0.4','0'};
answer = inputdlg(prompt, dlgtitle,dims,definput);
Frequency=answer{1};
ScanRate=answer{2};
PeakVoltage=answer{3};
BottomVoltage=answer{4};
Vcom=answer{5};
set(handles.editFrequency, 'String',Frequency);
set(handles.editScanRate, 'String',ScanRate);
set(handles.editPeakVoltage, 'String',PeakVoltage);
set(handles.editBottomVoltage, 'String',BottomVoltage);
set(handles.editVcom, 'String',Vcom);


guidata(hObject, handles);

% --- Executes on button press in unload.
function unload_Callback(hObject, eventdata, handles)
% hObject    handle to unload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
calllib('okFrontPanel', 'okFrontPanel_Destruct', handles.xem);
guidata(hObject, handles);
clear all;
unloadlibrary okFrontPanel


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in comfirmPlotMode.
function comfirmPlotMode_Callback(hObject, eventdata, handles)
pc = get(handles.plottingChoice,'SelectedObject');
pcstr = get(pc,'String');

switch pcstr
    case 'Realtime V vs I'
        set(handles.chkCode2t, 'Enable','Off')
        set(handles.chkCode2t, 'Value',0)
        set(handles.chkV2I, 'Enable','On')
        set(handles.chkV2I, 'Value',1)
        set(handles.chkI2t, 'Enable','On')
        set(handles.chkI2t, 'Value',0)
        set(handles.chkV2t, 'Enable','On')
        set(handles.chkV2t, 'Value',0)
    case 'ADC Input (voltage)'
        set(handles.chkCode2t, 'Enable','Off')
        set(handles.chkCode2t, 'Value',0)
        set(handles.chkV2I, 'Enable','Off')
        set(handles.chkV2I, 'Value',0)
        set(handles.chkI2t, 'Enable','Off')
        set(handles.chkI2t, 'Value',0)
        set(handles.chkV2t, 'Enable','On')
        set(handles.chkV2t, 'Value',0)
    case 'ADC Output (Code)'
        set(handles.chkCode2t, 'Enable','On')
        set(handles.chkCode2t, 'Value',0)
        set(handles.chkV2I, 'Enable','Off')
        set(handles.chkI2t, 'Enable','Off')
        set(handles.chkV2t, 'Enable','Off')
        set(handles.chkV2I, 'Value',0)
        set(handles.chkI2t, 'Value',0)
        set(handles.chkV2t, 'Value',0)
end


guidata(hObject, handles);

% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.channel1,'reset')
cla(handles.channel2,'reset')
cla(handles.channel3,'reset')
cla(handles.channel4,'reset')
guidata(hObject, handles);





% --- Executes on button press in confirmWriteInFile.
function confirmWriteInFile_Callback(hObject, eventdata, handles)
wc = get(handles.writeInFileChoice,'SelectedObject');
wcstr = get(wc,'String');

switch wcstr
    case 'Save V to I Plot'
%         fileID=fopen('FSCV_VOLTAGE_CHL1.txt','w');
%         fprintf(fileID,'%f\n', handles.data_L1_save);
%         fclose(fileID);
% 
%         fileID=fopen('FSCV_VOLTAGE_CHR1.txt','w');
%         fprintf(fileID,'%f\n', handles.data_R1_save);
%         fclose(fileID);
% 
%         fileID=fopen('FSCV_CURRENT_CHL1.txt','w');
%         fprintf(fileID,'%f\n', 10e9*(handles.current_L1_save));
%         fclose(fileID);
% 
%         fileID=fopen('FSCV_CURRENT_CHR1.txt','w');
%         fprintf(fileID,'%f\n', 10e9*(handles.current_R1_save));
%         fclose(fileID);

        fileID=fopen('FSCV_VOLTAGE_CHL2.txt','w');
        fprintf(fileID,'%f\n', handles.data_L2_save);
        fclose(fileID);

        fileID=fopen('FSCV_VOLTAGE_CHR2.txt','w');
        fprintf(fileID,'%f\n', handles.data_R2_save);
        fclose(fileID);

        fileID=fopen('FSCV_CURRENT_CHL2.txt','w');
        fprintf(fileID,'%f\n', 10e9*(handles.current_L2_save));
        fclose(fileID);

        fileID=fopen('FSCV_CURRENT_CHR2.txt','w');
        fprintf(fileID,'%f\n', 10e9*(handles.current_R2_save));
        fclose(fileID);

    case 'Save DC Plot'
        
    case 'Save FSCV Plot'
       
end
guidata(hObject, handles);


% --- Executes on button press in chkI2t.
function chkI2t_Callback(hObject, eventdata, handles)
% hObject    handle to chkI2t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkI2t


% --- Executes on button press in chkV2t.
function chkV2t_Callback(hObject, eventdata, handles)
% hObject    handle to chkV2t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkV2t


% --- Executes on button press in chkV2I.
function chkV2I_Callback(hObject, eventdata, handles)
% hObject    handle to chkV2I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkV2I


% --- Executes on button press in chkCode2t.
function chkCode2t_Callback(hObject, eventdata, handles)
% hObject    handle to chkCode2t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkCode2t


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton8


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10


% --- Executes on selection change in popupmenu15.
function popupmenu15_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu15 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu15


% --- Executes during object creation, after setting all properties.
function popupmenu15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit31 as text
%        str2double(get(hObject,'String')) returns contents of edit31 as a double


% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in plotOverall.
function plotOverall_Callback(hObject, eventdata, handles)
% figure('Name','Measured Data')
% plot(((1:length(handles.data_L1))/handles.Fout),handles.current_L1*(10^9))
% 
% title(handles.axes_total(5),'t vs i (TIA L1)','Color', 'b')
% xlabel(handles.axes_total(5),'time (s)')
% ylabel(handles.axes_total(5),'current (nA)')
% grid minor



guidata(hObject, handles);



function v1_Callback(hObject, eventdata, handles)
% hObject    handle to v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v1 as text
%        str2double(get(hObject,'String')) returns contents of v1 as a double


% --- Executes during object creation, after setting all properties.
function v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v2_Callback(hObject, eventdata, handles)
% hObject    handle to v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v2 as text
%        str2double(get(hObject,'String')) returns contents of v2 as a double


% --- Executes during object creation, after setting all properties.
function v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v3_Callback(hObject, eventdata, handles)
% hObject    handle to v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v3 as text
%        str2double(get(hObject,'String')) returns contents of v3 as a double


% --- Executes during object creation, after setting all properties.
function v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v4_Callback(hObject, eventdata, handles)
% hObject    handle to v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v4 as text
%        str2double(get(hObject,'String')) returns contents of v4 as a double


% --- Executes during object creation, after setting all properties.
function v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function I1p_Callback(hObject, eventdata, handles)
% hObject    handle to I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of I1p as text
%        str2double(get(hObject,'String')) returns contents of I1p as a double


% --- Executes during object creation, after setting all properties.
function I1p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function I2p_Callback(hObject, eventdata, handles)
% hObject    handle to I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of I2p as text
%        str2double(get(hObject,'String')) returns contents of I2p as a double


% --- Executes during object creation, after setting all properties.
function I2p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function I3b_Callback(hObject, eventdata, handles)
% hObject    handle to I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of I3b as text
%        str2double(get(hObject,'String')) returns contents of I3b as a double


% --- Executes during object creation, after setting all properties.
function I3b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function I4b_Callback(hObject, eventdata, handles)
% hObject    handle to I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of I4b as text
%        str2double(get(hObject,'String')) returns contents of I4b as a double


% --- Executes during object creation, after setting all properties.
function I4b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editDuration_Callback(hObject, eventdata, handles)
% hObject    handle to editDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDuration as text
%        str2double(get(hObject,'String')) returns contents of editDuration as a double


% --- Executes during object creation, after setting all properties.
function editDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in generateWave.
function generateWave_Callback(hObject, eventdata, handles)
color = get(hObject,'BackgroundColor');

if (color==[0.94,0.94,0.94])
    Frequency = str2num(get(handles.editFrequency,'String'));
    period = 1/Frequency;
    ScanRate = str2num(get(handles.editScanRate,'String'));
    Vr_H = str2num(get(handles.editPeakVoltage,'String'));
    Vr_L = str2num(get(handles.editBottomVoltage,'String'));
    Vcom = str2num(get(handles.editVcom,'String'));
    cycle_org = str2num(get(handles.editDuration,'String')) * 650;
    Sampling_rate=18000;
    Iref = 10;
    Rfeedback_L = 4.1;
    Rfeedback_L = 4.1;
    ReducedRate = 1;

    Vr=[Vr_L Vr_H];
    Ramp_duration=((Vr(2)-Vr(1))/ScanRate)*1000;
    ramp1_s=Vr(1)+Vcom;
    ramp1_t=Vr(2)+Vcom;
    ramp2_s=2*Vr(1)+Vcom;
    ramp2_t=2*Vr(2)+Vcom;
    N      =round((Ramp_duration/1000)*Sampling_rate);
    N_dc   =round(((1000*period-2*Ramp_duration)/1000)*Sampling_rate);
    step1  =(ramp1_t-ramp1_s)/N;
    step2  =(ramp2_t-ramp2_s)/N;
    V_sub  =(Iref/(10^9))*(Rfeedback_L*(10^6))*(1-1/ReducedRate);
    ramp1=[linspace(ramp1_s,ramp1_t,(N+1)) linspace((ramp1_t-step1),ramp1_s,N) (Vcom+Vr(1))*ones(1,N_dc)]';
    ramp2=[(linspace(ramp2_s,ramp2_t,(N+1))+V_sub) (linspace((ramp2_t-step2),ramp2_s,N)-V_sub) (Vcom+2*Vr(1))*ones(1,N_dc)]';
    %VDAC = zeros(1,(Sampling_rate/0.1))';
    ramp1tmp=ramp1;
    ramp2tmp=ramp2;
    cycle=cycle_org+2;
    for(k1=1:15)
        ramp1tmp=[ramp1tmp;ramp1];
        ramp2tmp=[ramp2tmp;ramp2];
    end
    Out1=ramp1tmp;
    Out2=ramp2tmp;
    Out3=Vcom*(linspace(1,1,length(Out1))');

    Out4=ramp1tmp;
    handles.VDAC = [Out1 Out2 Out3 Out4];
    

    %disp(Out3);
    disp('Okay')


    set(handles.generateWave,'BackgroundColor',[0,1,0]);
    
else
    set(handles.generateWave,'BackgroundColor',[0.94,0.94,0.94]);
end

guidata(hObject, handles);


% --- Executes on button press in writeInfile.
function writeInfile_Callback(hObject, eventdata, handles)
% hObject    handle to writeInfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of writeInfile


% --- Executes on button press in pauseRampSignal.
function pauseRampSignal_Callback(hObject, eventdata, handles)

cycle_org = 1300;
period = 0.1;
eachCh = linspace(0,0,5000)';
VDAC = [eachCh eachCh eachCh eachCh];
daqreset;
daqSession = daq.createSession('ni');
daqSession.IsContinuous = true;
addAnalogOutputChannel(daqSession,'Dev1',0:3,'Voltage');
addAnalogInputChannel(daqSession,'Dev1',0,'voltage');
addAnalogInputChannel(daqSession,'Dev1',1,'voltage');
daqSession.Rate=5000;
h = daqSession.addlistener('DataAvailable', @(src,event) src.queueOutputData(VDAC));
%ch0.TerminalConfig = 'SingleEnded';
Sampling_rate=50000;
disp('ok');
queueOutputData(daqSession,VDAC);
daqSession.startBackground();
% pause;
% if (get(handles.togglebutton1,'Value')==1)
%     pause on;
% else
%     pause off;
% end
% 
daqSession.stop(); 
delete(h);
daqSession.release();
delete(daqSession);
clear daqSession;


% --- Executes on button press in chooseFolder.
function chooseFolder_Callback(hObject, eventdata, handles)
dname = uigetdir('C:\');

disp(dname);
set(handles.myFolder,'String',dname);



function myFolder_Callback(hObject, eventdata, handles)
% hObject    handle to myFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of myFolder as text
%        str2double(get(hObject,'String')) returns contents of myFolder as a double


% --- Executes during object creation, after setting all properties.
function myFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to myFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in setupFileName.
function setupFileName_Callback(hObject, eventdata, handles)
Dev = get(handles.devID,'String');
MeMo = get(handles.measuredMolecule,'String');
Concentration = get(handles.consentrationOfMol,'String');
rampRate = get(handles.editScanRate,'String');
freq = get(handles.editFrequency,'String');
peak = get(handles.editPeakVoltage,'String');
bottom = get(handles.editBottomVoltage,'String');
strArray = {Dev,MeMo,Concentration,rampRate,freq,bottom,peak};
dir = get(handles.myFolder,'String');
fileName = strjoin(strArray,'_');
set(handles.myFileName,'String',fileName);
handles.name1Vol = strcat(dir,'\',fileName,'_ch1Vol.txt');
handles.name2Vol = strcat(dir,'\',fileName,'_ch2Vol.txt');
handles.name3Vol = strcat(dir,'\',fileName,'_ch3Vol.txt');
handles.name4Vol = strcat(dir,'\',fileName,'_ch4Vol.txt');
handles.name1Cur = strcat(dir,'\',fileName,'_ch1Cur.txt');
handles.name2Cur = strcat(dir,'\',fileName,'_ch2Cur.txt');
handles.name3Cur = strcat(dir,'\',fileName,'_ch3Cur.txt');
handles.name4Cur = strcat(dir,'\',fileName,'_ch4Cur.txt');

disp(handles.name4Cur)

guidata(hObject, handles);


function myFileName_Callback(hObject, eventdata, handles)
% hObject    handle to myFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of myFileName as text
%        str2double(get(hObject,'String')) returns contents of myFileName as a double


% --- Executes during object creation, after setting all properties.
function myFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to myFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function devID_Callback(hObject, eventdata, handles)
% hObject    handle to devID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of devID as text
%        str2double(get(hObject,'String')) returns contents of devID as a double


% --- Executes during object creation, after setting all properties.
function devID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to devID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function measuredMolecule_Callback(hObject, eventdata, handles)
% hObject    handle to measuredMolecule (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of measuredMolecule as text
%        str2double(get(hObject,'String')) returns contents of measuredMolecule as a double


% --- Executes during object creation, after setting all properties.
function measuredMolecule_CreateFcn(hObject, eventdata, handles)
% hObject    handle to measuredMolecule (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function consentrationOfMol_Callback(hObject, eventdata, handles)
% hObject    handle to consentrationOfMol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of consentrationOfMol as text
%        str2double(get(hObject,'String')) returns contents of consentrationOfMol as a double


% --- Executes during object creation, after setting all properties.
function consentrationOfMol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consentrationOfMol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in measureVoltage.
function measureVoltage_Callback(hObject, eventdata, handles)
% hObject    handle to measureVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of measureVoltage
if get(hObject,'Value') == 1
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in measureCurrent.
function measureCurrent_Callback(hObject, eventdata, handles)
% hObject    handle to measureCurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of measureCurrent
if get(hObject,'Value') == 1
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
end

% --- Executes on button press in enableCh2.
function enableCh2_Callback(hObject, eventdata, handles)
% hObject    handle to enableCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enableCh2
if get(hObject,'Value') == 1
    set(handles.disableCh2,'Value',0)
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('10'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in disableCh2.
function disableCh2_Callback(hObject, eventdata, handles)
% hObject    handle to disableCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of disableCh2
if get(hObject,'Value') == 1
    set(handles.enableCh2,'Value',0)
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('10'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in enableCh1.
function enableCh1_Callback(hObject, eventdata, handles)
% hObject    handle to enableCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enableCh1

if get(hObject,'Value') == 1
    set(handles.disableCh1,'Value',0)
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
    
end


% --- Executes on button press in disableCh1.
function disableCh1_Callback(hObject, eventdata, handles)
% hObject    handle to disableCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of disableCh1
if get(hObject,'Value') == 1
    set(handles.enableCh1,'Value',0)
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end



function lowerVol_Callback(hObject, eventdata, handles)
% hObject    handle to lowerVol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerVol as text
%        str2double(get(hObject,'String')) returns contents of lowerVol as a double


% --- Executes during object creation, after setting all properties.
function lowerVol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerVol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerCur_Callback(hObject, eventdata, handles)
% hObject    handle to lowerCur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerCur as text
%        str2double(get(hObject,'String')) returns contents of lowerCur as a double


% --- Executes during object creation, after setting all properties.
function lowerCur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerCur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperVol_Callback(hObject, eventdata, handles)
% hObject    handle to upperVol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperVol as text
%        str2double(get(hObject,'String')) returns contents of upperVol as a double


% --- Executes during object creation, after setting all properties.
function upperVol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperVol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperCur_Callback(hObject, eventdata, handles)
% hObject    handle to upperCur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperCur as text
%        str2double(get(hObject,'String')) returns contents of upperCur as a double


% --- Executes during object creation, after setting all properties.
function upperCur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperCur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
