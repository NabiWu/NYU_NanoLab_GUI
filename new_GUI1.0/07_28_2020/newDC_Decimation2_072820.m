function varargout = newDC_Decimation2_072820(varargin)
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

% Last Modified by GUIDE v2.5 28-Jul-2019 15:36:33

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

guidata(hObject, handles);

% --- Executes on button press in ConfirmDaqSetup.
function ConfirmDaqSetup_Callback(hObject, eventdata, handles)
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1A'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1A'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end


% if(get(hObject,'Value') == 1)
%     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'), 1,hex2dec('01'));
%     calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 1,hex2dec('01'));
%     calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%     editPGAL_Callback(handles.editPGAL, eventdata, handles)
%     editPGAR_Callback(handles.editPGAR, eventdata, handles)
%     editClockEnable_Callback(handles.editClockEnable, eventdata, handles)
%     editADCEnable_Callback(handles.editADCEnable, eventdata, handles)
%     editTIAEnable_Callback(handles.editTIAEnable, eventdata, handles)
%     editBiasEnable_Callback(handles.editBiasEnable, eventdata, handles)
%     editTIAorADC_Callback(handles.editTIAorADC, eventdata, handles)
% else
%     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'), 0,hex2dec('01'));
%     calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 0,hex2dec('01'));
%     calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
% end

guidata(hObject, handles);



% --- Executes on button press in confirmInputSignal.
function confirmInputSignal_Callback(hObject, eventdata, handles)
if(get(hObject,'Value') == 1)  
    Period=str2num(get(handles.editPeriod,'String'));
    ScanRate=str2num(get(handles.editScanRate,'String'));
    PeakVol=str2num(get(handles.editPeakVoltage,'String'));
    BottomVol=str2num(get(handles.editBottomVoltage,'String'));
    Vcom=str2num(get(handles.editVcom,'String'));
%     dataSave_FSCV(4.1,4.1,1,10,ScanRate,Vcom,PeakVol,BottomVol,100000,Period)
end
guidata(hObject, handles);



% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
%Get the plotting choice and convert it to string
pc = get(handles.plottingChoice,'SelectedObject');
pcstr = get(pc,'String');

%Get the plotting mode and convert it to string
pm = get(handles.plotModeChoice,'SelectedObject');
pmstr = get(pm,'String');
disp(pmstr);


handles.axes_total=[]; 
f = figure('Name','FSCV GUI','NumberTitle','off','Color','w','Position',[350 50 1550 935]); 
tg = uitabgroup(f);
for ii = 1:2
    if (ii==1) s = "First Two Channels";
    else s= "Second Two Chnnels";
    end
    thistab = uitab(tg,'Title', s); % build iith tab
    
    axes('Parent',thistab);
    
    tmp=subplot(4,3,1); 
    title("t vs v (AinL"+ii+")",'Color', 'b','FontSize', 14) 
    xlabel('time (s)','FontSize', 12) 
    ylabel('voltage (V)','FontSize', 12) 
    grid on;
    grid minor;
      

    tmp=subplot(4,3,4); 
    title("t vs code (AinL"+ii+")",'Color', 'b','FontSize', 14) 
    xlabel('time (s)','FontSize', 12) 
    ylabel('Code Value (quarter bit)','FontSize', 12) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp]; 

    tmp=subplot(4,3,2); 
    title("t vs v (TIA L"+ii+")",'Color', 'b','FontSize', 14) 
    xlabel('time (s)','FontSize', 12) 
    ylabel('voltage (V)','FontSize', 12) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp]; 

    tmp=subplot(4,3,5); 
    title("t vs i (TIA L"+ii+")",'Color', 'b','FontSize', 14) 
    xlabel('time (s)','FontSize', 12) 
    ylabel('Current (nA)','FontSize', 12)
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp]; 

    tmp=subplot(4,3,[3 6]); 
    title("v vs i (TIA L"+ii+")",'Color', 'b','FontSize', 14) 
    %xlabel('Vcm voltage (v)','FontSize', 12) 
    ylabel('Current (nA)','FontSize', 12) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp]; 

    tmp=subplot(4,3,7); 
    title("t vs v (AinR"+ii+")",'Color', 'b','FontSize', 14) 
    xlabel('time (s)','FontSize', 12) 
    ylabel('voltage (V)','FontSize', 12) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp]; 

    tmp=subplot(4,3,10); 
    title("t vs code (AinR"+ii+")",'Color', 'b','FontSize', 14) 
    xlabel('time (s)','FontSize', 12) 
    ylabel('Code Value (quarter bit)','FontSize', 12) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp]; 

    tmp=subplot(4,3,8); 
    title("t vs v (TIA R"+ii+")",'Color', 'b','FontSize', 14) 
    xlabel('time (s)','FontSize', 12) 
    ylabel('voltage (V)','FontSize', 12) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp]; 

    tmp=subplot(4,3,11); 
    title("t vs i (TIA R"+ii+")",'Color', 'b','FontSize', 14) 
    xlabel('time (s)','FontSize', 12) 
    ylabel('Current (nA)','FontSize', 12) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp]; 

    tmp=subplot(4,3,[9 12]); 
    title("v vs i (TIA R"+ii+")",'Color', 'b','FontSize', 14) 
    xlabel('Vcm voltage (v)','FontSize', 12) 
    ylabel('Current (nA)','FontSize', 12) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
    
    
    
end
% handles.p_Left=[-240.055296;1422.064503];
% handles.p_Right=[-237.927868;1419.302437];
 thirdTab = uitab(tg,'Title', 'Vcm');
 axes('Parent',thirdTab);
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




switch pcstr
    case 'Realtime V vs I'
        % str=inputdlg({'FSCV Period','FSCV ScanRate','FSCV Peak Voltage','FSCV Buttom Voltage','FSCV Vcom'},'Input dialog');
        % Period=str2num(str{1});
        % ScanRate=str2num(str{2});
        % Vr_H=str2num(str{3});
        % Vr_L=str2num(str{4});
        % Vcom=str2num(str{5});
        Period=str2num(get(handles.editPeriod,'String'));
        ScanRate=str2num(get(handles.editScanRate,'String'));
        Vr_H=str2num(get(handles.editPeakVoltage,'String'));
        Vr_L=str2num(get(handles.editBottomVoltage,'String'));
        Vcom=str2num(get(handles.editVcom,'String'));
        RfeedBack=[handles.RfeedBack_TIA2L1 handles.RfeedBack_TIA2R1 handles.RfeedBack_TIA2L2 handles.RfeedBack_TIA2R2];
        
        %BTPIPEOUT
        tolerance_range=0.9;
        N_ok=5; 
        cycle=234; 
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
            pause(delay-t);
            tic
        %     handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize, Unit_length, pv_A0);
        %     epvalue_A0 = get(pv_A0, 'value');
        %     handles.BTpipeOut_A1=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A1'), blocksize, Unit_length, pv_A1);
        %     epvalue_A1 = get(pv_A1, 'value');

            handles.BTpipeOut_A2=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A2'), blocksize, Unit_length, pv_A2);
            epvalue_A2 = get(pv_A2, 'value');
            disp(epvalue_A2);
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
%                 handles.current_L1_save=[handles.current_L1_save; current_tmp_L1_save];
%             end
    
        %     data_tmp_R1 = quantizer_one_forth((double(epvalue_A1(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A1(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
        %     data_tmp_R1 = (data_tmp_R1-handles.p_Right1(2))/(handles.p_Right1(1));
        %     handles.data_R1=[handles.data_R1; data_tmp_R1];
        %     current_tmp_R1=(data_tmp_R1-Vcom)/(RfeedBack(2));
        %     handles.current_R1=[handles.current_R1; current_tmp_R1];
        %     data_cycle_R1=[data_cycle_R1; data_tmp_R1];
%             if (get(handles.SaveData,'Value')==1)
%                 handles.data_R1_save=[handles.data_R1_save; data_tmp_R1];
%                 handles.current_R1_save=[handles.current_R1_save; current_tmp_R1_save];
%             end

            data_tmp_L2 = quantizer_one_forth((double(epvalue_A2(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A2(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
            data_tmp_L2 = (data_tmp_L2-handles.p_Left2(2))/(handles.p_Left2(1));
            handles.data_L2=[handles.data_L2; data_tmp_L2];
            current_tmp_L2=(data_tmp_L2-Vcom)/(RfeedBack(3));
            handles.current_L2=[handles.current_L2; current_tmp_L2];
            data_cycle_L2=[data_cycle_L2; data_tmp_L2];
            if (get(handles.SaveData,'Value')==1)
                handles.data_L2_save=[handles.data_L2_save; data_tmp_L2];
                handles.current_L2_save=[handles.current_L2_save; current_tmp_L2_save];
            end
    
            data_tmp_R2 = quantizer_one_forth((double(epvalue_A3(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A3(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
            data_tmp_R2 = (data_tmp_R2-handles.p_Right2(2))/(handles.p_Right2(1));
            handles.data_R2=[handles.data_R2; data_tmp_R2];
            current_tmp_R2=(data_tmp_R2-Vcom)/(RfeedBack(4));
            handles.current_R2=[handles.current_R2; current_tmp_R2];
            data_cycle_R2=[data_cycle_R2; data_tmp_R2];
            if (get(handles.SaveData,'Value')==1)
                handles.data_R2_save=[handles.data_R2_save; data_tmp_R2];
                handles.current_R2_save=[handles.current_R2_save; current_tmp_R2_save];
            end
            

            tmp0 = round(((i-1)-mod((i-1),N_window))/N_window)+1;

            
               
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
    
        %     plot(handles.axes_total(4),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L1*(10^9))
        %     axis(handles.axes_total(4),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
        %     title(handles.axes_total(4),'t vs i (TIA L1)','Color', 'b')
        %     xlabel(handles.axes_total(4),'time (s)')
        %     ylabel(handles.axes_total(4),'current (nA)')
        %     hold(handles.axes_total(4),'on')

        %     plot(handles.axes_total(9),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R1*(10^9))
        %     axis(handles.axes_total(9),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
        %     title(handles.axes_total(9),'t vs i (TIA R1)','Color', 'b')
        %     xlabel(handles.axes_total(9),'time (s)')
        %     ylabel(handles.axes_total(9),'current (nA)')
        %     hold(handles.axes_total(9),'on')

        if (get(handles.stop,'Value')==0)
            plot(handles.axes_total(13),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
            axis(handles.axes_total(13),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
            title(handles.axes_total(13),'t vs v (TIA L2)','Color', 'b') 
            xlabel(handles.axes_total(13),'time (s)')
            ylabel(handles.axes_total(13),'voltage (v)')
            hold(handles.axes_total(13),'on')
        
            plot(handles.axes_total(18),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
            axis(handles.axes_total(18),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
            title(handles.axes_total(18),'t vs v (TIA R2)','Color', 'b')
            xlabel(handles.axes_total(18),'time (s)')
            ylabel(handles.axes_total(18),'voltage (v)')
            hold(handles.axes_total(18),'on')
        
            plot(handles.axes_total(14),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L2*(10^9))
            axis(handles.axes_total(14),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
            title(handles.axes_total(14),'t vs i (TIA L2)','Color', 'b')
            xlabel(handles.axes_total(14),'time (s)')
            ylabel(handles.axes_total(14),'current (nA)')
            hold(handles.axes_total(14),'on')
        
            plot(handles.axes_total(19),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R2*(10^9))
            axis(handles.axes_total(19),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
            title(handles.axes_total(19),'t vs i (TIA R2)','Color', 'b')
            xlabel(handles.axes_total(19),'time (s)')
            ylabel(handles.axes_total(19),'current (nA)')
            hold(handles.axes_total(19),'on')
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
        
        %         plot(handles.axes_total(5),Xaxes_L1,imp_L1*(10^9))
        %        axis(handles.axes_total(5),[Vr_L Vr_H -inf inf])
        %         title(handles.axes_total(5),'v vs i (TIA L1)','Color', 'b')
        %         xlabel(handles.axes_total(5),'FSCV VCM (V)')
        %         ylabel(handles.axes_total(5),'Input Current (nA)')
                %legend(handles.axes_total(5),'')
        %         plot(handles.axes_total(10),Xaxes_R1,imp_R1*(10^9))
        %         axis(handles.axes_total(10),[Vr_L Vr_H -inf inf])
        %         title(handles.axes_total(10),'v vs i (TIA R1)','Color', 'b')
        %         xlabel(handles.axes_total(10),'FSCV VCM (V)')
        %         ylabel(handles.axes_total(10),'Input Current (nA)')
            if (get(handles.stop,'Value')==0)
                plot(handles.axes_total(15),Xaxes_L2,imp_L2*(10^9))
                axis(handles.axes_total(15),[Vr_L Vr_H -inf inf])
                title(handles.axes_total(15),'v vs i (TIA L2)','Color', 'b')
                xlabel(handles.axes_total(15),'FSCV VCM (V)')
                ylabel(handles.axes_total(15),'Input Current (nA)')
                legend(handles.axes_total(5),'')
                plot(handles.axes_total(20),Xaxes_R2,imp_R2*(10^9))
                axis(handles.axes_total(20),[Vr_L Vr_H -inf inf])
                title(handles.axes_total(20),'v vs i (TIA R2)','Color', 'b')
                xlabel(handles.axes_total(20),'FSCV VCM (V)')
                ylabel(handles.axes_total(20),'Input Current (nA)')
            end     
                data_cycle_L1=[];
                data_cycle_R1=[];
                data_cycle_L2=[];
                data_cycle_R2=[];
            end
            
%             if (get(handles.stop,'Value')==0)
%                 if (pmstr == 'V-t')
%                     axis(handles.channel1,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
%                     plot(handles.channel1,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L1)
%                     title(handles.channel1,'t vs v (TIA L1)','Color', 'b') 
%                     xlabel(handles.channel1,'time (s)')
%                     ylabel(handles.channel1,'voltage (v)')
%                     hold(handles.channel1,'on')

%                     axis(handles.channel2,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
%                     plot(handles.channel2,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R1)
%                     title(handles.channel2,'t vs v (TIA R1)','Color', 'b')
%                     xlabel(handles.channel2,'time (s)')
%                     ylabel(handles.channel2,'voltage (v)')
%                     hold(handles.channel2,'on')

%                     axis(handles.channel3,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
%                     plot(handles.channel3,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
%                     title(handles.channel3,'t vs v (TIA L2)','Color', 'b') 
%                     xlabel(handles.channel3,'time (s)')
%                     ylabel(handles.channel3,'voltage (v)')
%                     hold(handles.channel3,'on')
% 
%                     axis(handles.channel4,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
%                     plot(handles.channel4,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
%                     title(handles.channel4,'t vs v (TIA R2)','Color', 'b')
%                     xlabel(handles.channel4,'time (s)')
%                     ylabel(handles.channel4,'voltage (v)')
%                     hold(handles.channel4,'on')
        
            
%                 elseif (pmstr == 'I-t')
%                     axis(handles.channel1,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
%                     plot(handles.channel1,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L1*(10^9))
%                     title(handles.channel1,'t vs i (TIA L1)','Color', 'b')
%                     xlabel(handles.channel1,'time (s)')
%                     ylabel(handles.channel1,'current (nA)')
%                     hold(handles.channel1,'on')
% 
%                     axis(handles.channel2,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
%                     plot(handles.channel2,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R1*(10^9))
%                     title(handles.channel2,'t vs i (TIA R1)','Color', 'b')
%                     xlabel(handles.channel2,'time (s)')
%                     ylabel(handles.channel2,'current (nA)')
%                     hold(handles.channel2,'on')

%                     axis(handles.channel3,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
%                     plot(handles.channel3,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L2*(10^9))
%                     title(handles.channel3,'t vs i (TIA L2)','Color', 'b')
%                     xlabel(handles.channel3,'time (s)')
%                     ylabel(handles.channel3,'current (nA)')
%                     hold(handles.channel3,'on')
% 
%                     axis(handles.channel4,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
%                     plot(handles.channel4,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R2*(10^9))
%                     title(handles.channel4,'t vs i (TIA R2)','Color', 'b')
%                     xlabel(handles.channel4,'time (s)')
%                     ylabel(handles.channel4,'current (nA)')
%                     hold(handles.channel4,'on')
                
                
%                 elseif (pmstr == 'V-I') 
%                     axis(handles.channel1,[Vr_L Vr_H -inf inf])
%                     plot(handles.channel1,Xaxes_L1,imp_L1*(10^9))
%                     title(handles.channel1,'v vs i (TIA L1)','Color', 'b')
%                     xlabel(handles.channel1,'FSCV VCM (V)')
%                     ylabel(handles.channel1,'Input Current (nA)')
% 
%                     %legend(handles.axes_total(5),'')
%                     axis(handles.channel2,[Vr_L Vr_H -inf inf])
%                     plot(handles.channel2,Xaxes_R1,imp_R1*(10^9))               
%                     title(handles.channel2,'v vs i (TIA R1)','Color', 'b')
%                     xlabel(handles.channel2,'FSCV VCM (V)')
%                     ylabel(handles.channel2,'Input Current (nA)')

%                     axis(handles.channel3,[Vr_L Vr_H -inf inf])
%                     plot(handles.channel3,Xaxes_L2,imp_L2*(10^9))
%                     title(handles.channel3,'v vs i (TIA L2)','Color', 'b')
%                     xlabel(handles.channel3,'FSCV VCM (V)')
%                     ylabel(handles.channel3,'Input Current (nA)')
%                     
%                     %legend(handles.axes_total(5),'')
%                     axis(handles.channel4,[Vr_L Vr_H -inf inf])
%                     plot(handles.channel4,Xaxes_R2,imp_R2*(10^9))
%                     title(handles.channel4,'v vs i (TIA R2)','Color', 'b')
%                     xlabel(handles.channel4,'FSCV VCM (V)')
%                     ylabel(handles.channel4,'Input Current (nA)')
%                 end
%             end
            t = toc;
            %tmp(i) = t;
        end

        hold(handles.axes_total(3),'off')
        hold(handles.axes_total(8),'off')
        hold(handles.axes_total(4),'off')
        hold(handles.axes_total(9),'off')
        hold(handles.axes_total(13),'off')
        hold(handles.axes_total(18),'off')
        hold(handles.axes_total(14),'off')
        hold(handles.axes_total(19),'off')
        
        
       case 'ADC Input (voltage)'
        cycle=234; 
        FIFO_size=4096;%16bit 
        blocksize=1024;%byte
        Unit_length= (2*FIFO_size);
        %data((cycle*(FIFO_size-1)),1)=uint16(0);
        handles.data_L1=[];
        handles.data_R1=[];
        handles.data_L2=[];
        handles.data_R2=[];

        handles.data_L1_vol=[];
        handles.data_R1_vol=[];
        handles.data_L2_vol=[];
        handles.data_R2_vol=[];
        
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
        %handles.ENOB=11;
        ENOB=handles.ENOB;
        N_window=2;
        Plot_Ylimit=3.3;
        %tmp0 = 0;
        %tmp(cycle,1) = 0;
        data_tmp_L1((FIFO_size-1),1) = 0;
        data_tmp_R1((FIFO_size-1),1) = 0;
        data_tmp_L2((FIFO_size-1),1) = 0;
        data_tmp_R2((FIFO_size-1),1) = 0;

        success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'), 1,hex2dec('01')); 
        calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem); 
        pause(1/handles.Fout); 
        success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'), 0,hex2dec('01')); 
        calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
        pause(20/handles.Fout);  
        %pause(((FIFO_size-500)/(handles.freq_out1*1000000))); 
        for i= 1:cycle
            
            
                pause(delay-t);
                tic
%                 handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize, Unit_length, pv_A0);
%                 epvalue_A0 = get(pv_A0, 'value');
%                 handles.BTpipeOut_A1=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A1'), blocksize, Unit_length, pv_A1);
%                 epvalue_A1 = get(pv_A1, 'value');
                handles.BTpipeOut_A2=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A2'), blocksize, Unit_length, pv_A2);
                epvalue_A2 = get(pv_A2, 'value');
                handles.BTpipeOut_A3=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A3'), blocksize, Unit_length, pv_A3);
                epvalue_A3 = get(pv_A3, 'value');

    
    
    
                %data(((i-1)*(FIFO_size-1)+1):(i*(FIFO_size-1)))=double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))));
                %data=[data; double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))))];
            
%                 data_tmp_L1 = quantizer_one_forth((double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
%                 data_tmp_L1=(data_tmp_L1-handles.p_Left1(2))/handles.p_Left1(1);
%                 handles.data_L1=[handles.data_L1; data_tmp_L1];
%                 if (get(handles.SaveData,'Value')==1)
%                     handles.data_L1_vol=[handles.data_L1_vol; data_tmp_L1];
%                 end


%                 data_tmp_R1 = quantizer_one_forth((double(epvalue_A1(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A1(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
%                 data_tmp_R1=(data_tmp_R1-handles.p_Right1(2))/handles.p_Right1(1);
%                 handles.data_R1=[handles.data_R1; data_tmp_R1];
%                 if (get(handles.SaveData,'Value')==1)
%                     handles.data_R1_vol=[handles.data_R1_vol; data_tmp_R1];
%                 end

                data_tmp_L2 = quantizer_one_forth((double(epvalue_A2(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A2(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
                data_tmp_L2=(data_tmp_L2-handles.p_Left2(2))/handles.p_Left2(1);
                handles.data_L2=[handles.data_L2; data_tmp_L2];
                if (get(handles.SaveData,'Value')==1)
                    handles.data_L2_vol=[handles.data_L2_vol; data_tmp_L2];
                end
                
                data_tmp_R2 = quantizer_one_forth((double(epvalue_A3(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A3(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
                data_tmp_R2=(data_tmp_R2-handles.p_Right2(2))/handles.p_Right2(1);
                handles.data_R2=[handles.data_R2; data_tmp_R2];
                if (get(handles.SaveData,'Value')==1)
                    handles.data_R2_vol=[handles.data_R2_vol; data_tmp_R2];
                end


    
                tmp0 = round(((i-1)-mod((i-1),N_window))/N_window)+1;
            
            
            
            if (get(handles.stop,'Value')==0)
%                 axis(handles.channel1,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
%                 plot(handles.channel1,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L1)
%                 title(handles.channel1,'t vs v (AinL1)','Color', 'b') 
%                 xlabel(handles.channel1,'time (s)')
%                 ylabel(handles.channel1,'voltage (v)')
%                 hold(handles.channel1,'on')
%     
%     
%                 plot(handles.channel2,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R1)
%                 axis(handles.channel2,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
%                 title(handles.channel2,'t vs v (AinR1)','Color', 'b') 
%                 xlabel(handles.channel2,'time (s)')
%                 ylabel(handles.channel2,'voltage (v)')
%                 %axis([handles.tab1_axes handles.tab2_axes],[((tmp0-1)*(4*(FIFO_size-1))) (tmp0*(4*(FIFO_size-1))-1) 0 inf])
%                 hold(handles.channel2,'on')

                plot(handles.channel3,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
                axis(handles.channel3,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
                title(handles.channel3,'t vs v (AinL2)','Color', 'b') 
                xlabel(handles.channel3,'time (s)')
                ylabel(handles.channel3,'voltage (v)')
                hold(handles.channel3,'on')
    
                plot(handles.channel4,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
                axis(handles.channel4,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
                title(handles.channel4,'t vs v (AinR2)','Color', 'b') 
                xlabel(handles.channel4,'time (s)')
                ylabel(handles.channel4,'voltage (v)')
                %axis([handles.tab1_axes handles.tab2_axes],[((tmp0-1)*(4*(FIFO_size-1))) (tmp0*(4*(FIFO_size-1))-1) 0 inf])
                hold(handles.channel4,'on') 
            end
            %hold on
            t = toc;
            %tmp(i) = t;
        end
 
      
        
        
        case 'ADC Output (Code)'
        cycle=234; 
        FIFO_size=4096;%16bit 
        blocksize=1024;%byte
        Unit_length= (2*FIFO_size);
        %data((cycle*(FIFO_size-1)),1)=uint16(0);
        handles.data_L1=[];
        handles.data_R1=[];
        handles.data_L2=[];
        handles.data_R2=[];
        
        handles.data_L1_code=[];
        handles.data_R1_code=[];
        handles.data_L2_code=[];
        handles.data_R2_code=[];

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
        Plot_Ylimit=2^ENOB;
        %tmp0 = 0;
        %tmp(cycle,1) = 0;
        data_tmp_L1((FIFO_size-1),1) = 0;
        data_tmp_R1((FIFO_size-1),1) = 0;
        data_tmp_L2((FIFO_size-1),1) = 0;
        data_tmp_R2((FIFO_size-1),1) = 0;

        success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'), 1,hex2dec('01')); 
        calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem); 
        pause(1/handles.Fout); 
        success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'), 0,hex2dec('01')); 
        calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
        pause(20/handles.Fout);  
        %pause(((FIFO_size-500)/(handles.freq_out1*1000000))); 
        for i= 1:cycle
            
            
                pause(delay-t);
                tic
%                 handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize, Unit_length, pv_A0);
%                 epvalue_A0 = get(pv_A0, 'value');
%                 handles.BTpipeOut_A1=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A1'), blocksize, Unit_length, pv_A1);
%                 epvalue_A1 = get(pv_A1, 'value');

                handles.BTpipeOut_A2=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A2'), blocksize, Unit_length, pv_A2);
                epvalue_A2 = get(pv_A2, 'value');
                handles.BTpipeOut_A3=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A3'), blocksize, Unit_length, pv_A3);
                epvalue_A3 = get(pv_A3, 'value');
                %data(((i-1)*(FIFO_size-1)+1):(i*(FIFO_size-1)))=double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))));
                %data=[data; double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))))];


%                 data_tmp_L1 = quantizer_one_forth((double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
%                 %data_tmp_L=(data_tmp_L-handles.p_Left(2))/handles.p_Left(1);
%                 handles.data_L1=[handles.data_L1; data_tmp_L1];
%                 if (get(handles.SaveData,'Value')==1)
%                     handles.data_L1_code=[handles.data_L1_code; data_tmp_L1];
%                 end
%                 
%                 data_tmp_R1 = quantizer_one_forth((double(epvalue_A1(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A1(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
%                 %data_tmp_R=(data_tmp_R-handles.p_Right(2))/handles.p_Right(1);
%                 handles.data_R1=[handles.data_R1; data_tmp_R1];
%                 if (get(handles.SaveData,'Value')==1)
%                     handles.data_R1_code=[handles.data_R1_code; data_tmp_R1];
%                 end
                
                data_tmp_L2 = quantizer_one_forth((double(epvalue_A2(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A2(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
                %data_tmp_L=(data_tmp_L-handles.p_Left(2))/handles.p_Left(1);
                handles.data_L2=[handles.data_L2; data_tmp_L2];
                if (get(handles.SaveData,'Value')==1)
                    handles.data_L2_code=[handles.data_L2_code; data_tmp_L2];
                end
                
                data_tmp_R2 = quantizer_one_forth((double(epvalue_A3(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A3(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
                %data_tmp_R=(data_tmp_R-handles.p_Right(2))/handles.p_Right(1);
                handles.data_R2=[handles.data_R2; data_tmp_R2];
                if (get(handles.SaveData,'Value')==1)
                    handles.data_R2_code=[handles.data_R2_code; data_tmp_R2];
                end
    
    
    
                tmp0 = floor(((i-1)-mod((i-1),N_window))/N_window)+1;
            
            
           if (get(handles.stop,'Value')==0)
%                 axis(handles.channel1,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
%                 plot(handles.channel1,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L1)
%                 title(handles.channel1,'t vs code (AinL1)','Color', 'b')
%                 xlabel(handles.channel1,'time (s)')
%                 ylabel(handles.channel1,'Code Value')
%                 hold(handles.channel1,'on')
%             
%                 axis(handles.channel2,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
%                 plot(handles.channel2,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R1)
%                 title(handles.channel2,'t vs code (AinR1)','Color', 'b')
%                 xlabel(handles.channel2,'time (s)')
%                 ylabel(handles.channel2,'Code Value')
%                 %axis([handles.tab4_axes handles.tab2_axes],[((tmp0-1)*(4*(FIFO_size-1))) (tmp0*(4*(FIFO_size-1))-1) 0 inf])
%                 hold(handles.channel2,'on')

                axis(handles.channel3,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
                plot(handles.channel3,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
                title(handles.channel3,'t vs code (AinL2)','Color', 'b')
                xlabel(handles.channel3,'time (s)')
                ylabel(handles.channel3,'Code Value')
                hold(handles.channel3,'on')
            
                axis(handles.channel4,[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
                plot(handles.channel4,((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
                title(handles.channel4,'t vs code (AinR2)','Color', 'b')
                xlabel(handles.channel4,'time (s)')
                ylabel(handles.channel4,'Code Value')
                %axis([handles.tab4_axes handles.tab2_axes],[((tmp0-1)*(4*(FIFO_size-1))) (tmp0*(4*(FIFO_size-1))-1) 0 inf])
                hold(handles.channel4,'on')

            end
    
            %hold on
            t = toc;
            %tmp(i) = t;
        end
        
        
        
        
        
end      
       

guidata(hObject, handles);

        
% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)

% --- Executes on button press in SaveData.
function SaveData_Callback(hObject, eventdata, handles)








% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)




function editPeriod_Callback(hObject, eventdata, handles)

handles.Period = str2double(get(hObject,'String'));
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function editPeriod_CreateFcn(hObject, eventdata, handles)
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
prompt = {'Period (s)','ScanRate','Peak Voltage (V)','Bottom Voltage (V)','Vcom (V)'};
dlgtitle ='Reset Variable Default';
dims = [1 50];
definput = {'0.1','200', '1.3', '-0.4','0'};
answer = inputdlg(prompt, dlgtitle,dims,definput);
Period=answer{1};
ScanRate=answer{2};
PeakVoltage=answer{3};
BottomVoltage=answer{4};
Vcom=answer{5};
set(handles.editPeriod, 'String',Period);
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
wcstr = get(pc,'String');

switch wcstr
    case 'Save V to I Plot'
        fileID=fopen('FSCV_VOLTAGE_CHL1.txt','w');
        fprintf(fileID,'%f\n', handles.data_L1_save);
        fclose(fileID);

        fileID=fopen('FSCV_VOLTAGE_CHR1.txt','w');
        fprintf(fileID,'%f\n', handles.data_R1_save);
        fclose(fileID);

        fileID=fopen('FSCV_CURRENT_CHL1.txt','w');
        fprintf(fileID,'%f\n', 10e9*(handles.current_L1_save));
        fclose(fileID);

        fileID=fopen('FSCV_CURRENT_CHR1.txt','w');
        fprintf(fileID,'%f\n', 10e9*(handles.current_R1_save));
        fclose(fileID);

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
