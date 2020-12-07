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

% Last Modified by GUIDE v2.5 29-Jan-2020 17:22:30

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






% --- Executes on button press in Unload.
function Unload_Callback(hObject, eventdata, handles)

%Unload the okFrontPanel library 
calllib('okFrontPanel', 'okFrontPanel_Destruct', handles.xem);
guidata(hObject, handles);
clear all;
unloadlibrary okFrontPanel


% --- Executes on button press in confirmConfiguration.
function confirmConfiguration_Callback(hObject, eventdata, handles)


loadlibrary('okFrontPanel', 'okFrontPanelDLL.h');
handles.xem = calllib('okFrontPanel', 'okFrontPanel_Construct');
handles.numDevices = calllib('okFrontPanel', 'okFrontPanel_GetDeviceCount', handles.xem);
handles.ret = calllib('okFrontPanel', 'okFrontPanel_OpenBySerial', handles.xem, '');
handles.success_checkOPEN = calllib('okFrontPanel', 'okFrontPanel_IsOpen', handles.xem);



handles.success_configure = calllib('okFrontPanel', 'okFrontPanel_ConfigureFPGA', handles.xem,'chip4_adc_cont.bit');
handles.OSR=250;

freq_out1 = 100/40;
handles.Fout=(freq_out1/handles.OSR)*1000000;
handles.ENOB=16;

   
   


handles.axes_total=[]; 
f = figure('Name','FSCV GUI','NumberTitle','off','Color','w','Position',[350 50 1550 935]); 
tg = uitabgroup(f);


%first tab
 firstTab = uitab(tg,'Title', 'First Two Channel Collected Data');
 axes('Parent',firstTab);
 tmp=subplot(2,2,1); 

    title("t vs V (TIA L1)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Voltage (V)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,2);

    title("t vs I (TIA L1)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,3); 

    title("t vs V (TIA R1)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Voltage (V)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,4); 

    title("time vs I (TIA R1)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14)
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];

%second tab    
 secondTab = uitab(tg,'Title', 'Second Two Channel Collected Data');
 axes('Parent',secondTab);
 tmp=subplot(2,2,1); 

    title("t vs V (TIA L2)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Voltage (V)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,2);

    title("t vs I (TIA L2)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,3); 

    title("t vs V (TIA R2)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Voltage (V)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,2,4); 

    title("time vs I (TIA R2)",'Color', 'b','FontSize', 18) 
    xlabel('time (s)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14)
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];

%third tab
 thirdTab = uitab(tg,'Title', 'Second Two Channel Collected Data');
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


    
    
% handles.p_Left1=[-1087.826; 1914];
% handles.p_Right1=[-1087.826; 1914];
% handles.p_Left2=[-1087.826; 1914];
% handles.p_Right2=[-1087.826; 1914];
% % 16
handles.p_Left1=[-17549.13; 30630.5];
handles.p_Right1=[-17549.13; 30630.5];
handles.p_Left2=[-17549.13; 30630.5];
handles.p_Right2=[-17549.13; 30630.5];


handles.RfeedBack_TIA2L1=4.1*(10^6);
handles.RfeedBack_TIA2R1=4.1*(10^6);
handles.RfeedBack_TIA2L2=4.1*(10^6);
handles.RfeedBack_TIA2R2=4.1*(10^6);
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
        hold(handles.axes_total(1),'off')
        hold(handles.axes_total(2),'off')
        hold(handles.axes_total(3),'off')
        hold(handles.axes_total(4),'off')
        hold(handles.axes_total(5),'off')
        hold(handles.axes_total(6),'off')
        hold(handles.axes_total(7),'off')
        hold(handles.axes_total(8),'off')
        hold(handles.axes_total(9),'off')
        hold(handles.axes_total(10),'off')
        hold(handles.axes_total(11),'off')
        hold(handles.axes_total(12),'off')

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
        
        %BTPIPEOUT
        tolerance_range=0.9;
        N_ok=5; 
%         cycle=(98*duration)-2; 
        cycle=(147*duration)-2; 

        FIFO_size=4096;%16bit 
        blocksize=16384;%byte
        Unit_length= (4*FIFO_size);
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
        disp(handles.Fout); 
        disp(Period); 
        disp(ScanRate); 
       disp( Vr_H);
       disp( Vr_L);
       disp( tolerance_range); 
       disp( N_ok);
       disp( handles.p_Left2);
        
        for i= 1:cycle
%            disp(i)
            pause(delay-t);
            tic
            
            lowerVol = str2num(get(handles.lowerVol,'String'));
            upperVol = str2num(get(handles.upperVol,'String'));
            lowerCur = str2num(get(handles.lowerCur,'String'));
            upperCur = str2num(get(handles.upperCur,'String'));
            
%            handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize, Unit_length, pv_A0);
%            epvalue_A0 = get(pv_A0, 'value');
           
           
           
%            handles.BTpipeOut_A1=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A1'), blocksize, Unit_length, pv_A1);
%            epvalue_A1 = get(pv_A1, 'value');

            handles.BTpipeOut_A2=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A2'), blocksize, Unit_length, pv_A2);
            epvalue_A2 = get(pv_A2, 'value');
           
%             disp(epvalue_A2)
            handles.BTpipeOut_A3=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A3'), blocksize, Unit_length, pv_A3);
            epvalue_A3 = get(pv_A3, 'value');
           

            %data(((i-1)*(FIFO_size-1)+1):(i*(FIFO_size-1)))=double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))));
            %data=[data; double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))))];
            
%first two channel

%             data_tmp_L1 = floor((double(epvalue_A0(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A0(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
%             data_tmp_L1=(data_tmp_L1-handles.p_Left1(2))/handles.p_Left1(1);
%             handles.data_L1=[handles.data_L1; data_tmp_L1];
%             current_tmp_L1=(data_tmp_L1-Vcom)/(RfeedBack(1));
%             handles.current_L1=[handles.current_L1; current_tmp_L1];
%             data_cycle_L1=[data_cycle_L1; data_tmp_L1];
%             
%             if (get(handles.SaveData,'Value')==1)
%                 handles.data_L1_save=[handles.data_L1_save; data_tmp_L1];
%                 handles.current_L1_save=[handles.current_L1_save; current_tmp_L1];
%             end
    
%             data_tmp_R1 = floor((double(epvalue_A1(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A1(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
%             data_tmp_R1=(data_tmp_R1-handles.p_Right1(2))/handles.p_Right1(1);
%             handles.data_R1=[handles.data_R1; data_tmp_R1];  
%             current_tmp_R1=(data_tmp_R1-Vcom)/(RfeedBack(2));
%             handles.current_R1=[handles.current_R1; current_tmp_R1];
%             data_cycle_R1=[data_cycle_R1; data_tmp_R1];
%             
%             if (get(handles.SaveData,'Value')==1)
%                 handles.data_R2_save=[handles.data_R2_save; data_tmp_R2];
%                 handles.current_R2_save=[handles.current_R2_save; current_tmp_R2];
%             end
            
%second two channel
            data_tmp_L2 = floor((double(epvalue_A2(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A2(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
            data_tmp_L2=(data_tmp_L2-handles.p_Left2(2))/handles.p_Left2(1);
            handles.data_L2=[handles.data_L2; data_tmp_L2];
            current_tmp_L2=(data_tmp_L2-Vcom)/(RfeedBack(3));
            handles.current_L2=[handles.current_L2; current_tmp_L2];
            data_cycle_L2=[data_cycle_L2; data_tmp_L2];
            
            if (get(handles.SaveData,'Value')==1)
                handles.data_L2_save=[handles.data_L2_save; data_tmp_L2];
                handles.current_L2_save=[handles.current_L2_save; current_tmp_L2];
            end
   
    
            data_tmp_R2 = floor((double(epvalue_A3(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A3(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
            data_tmp_R2=(data_tmp_R2-handles.p_Right2(2))/handles.p_Right2(1);
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
                
                %first two channel
%                 plot(handles.axes_total(1),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L1)
%                 axis(handles.axes_total(1),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
%                 title(handles.axes_total(1),'t vs v (TIA L1)','Color', 'b') 
%                 xlabel(handles.axes_total(1),'time (s)')
%                 ylabel(handles.axes_total(1),'voltage (v)')
%                 hold(handles.axes_total(1),'on')

%                 plot(handles.axes_total(3),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R1)
%                 axis(handles.axes_total(3),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
%                 title(handles.axes_total(3),'t vs v (TIA R1)','Color', 'b')
%                 xlabel(handles.axes_total(3),'time (s)')
%                 ylabel(handles.axes_total(3),'voltage (v)')
%                 hold(handles.axes_total(3),'on')


%                 plot(handles.axes_total(2),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L1*(10^9))
%                 axis(handles.axes_total(2),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
%                 title(handles.axes_total(2),'t vs i (TIA L1)','Color', 'b')
%                 xlabel(handles.axes_total(2),'time (s)')
%                 ylabel(handles.axes_total(2),'current (nA)')
%                 hold(handles.axes_total(2),'on')

%                 plot(handles.axes_total(4),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R1*(10^9))
%                 axis(handles.axes_total(4),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
%                 title(handles.axes_total(4),'t vs i (TIA R1)','Color', 'b')
%                 xlabel(handles.axes_total(4),'time (s)')
%                 ylabel(handles.axes_total(4),'current (nA)')
%                 hold(handles.axes_total(4),'on')
                
                %second two channel
               
                plot(handles.axes_total(5),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
                axis(handles.axes_total(5),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
                title(handles.axes_total(5),'t vs v (TIA L2)','Color', 'b') 
                xlabel(handles.axes_total(5),'time (s)')
                ylabel(handles.axes_total(5),'voltage (v)')
                hold(handles.axes_total(5),'on')

                plot(handles.axes_total(7),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
                axis(handles.axes_total(7),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
                title(handles.axes_total(7),'t vs v (TIA R2)','Color', 'b')
                xlabel(handles.axes_total(7),'time (s)')
                ylabel(handles.axes_total(7),'voltage (v)')
                hold(handles.axes_total(7),'on')


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
       

                %first two channel 
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
                
                %second two channel
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
                    
                    %first two channel
%                     plot(handles.axes_total(9),Xaxes_L1,imp_L1*(10^9))
%                     axis(handles.axes_total(9),[lowerVol upperVol lowerCur upperCur])
%                     title(handles.axes_total(9),'v vs i (TIA L1)','Color', 'b')
%                     xlabel(handles.axes_total(9),'FSCV VCM (V)')
%                     ylabel(handles.axes_total(9),'Input Current (nA)')

%                     plot(handles.axes_total(10),Xaxes_R1,imp_R1*(10^9))
%                     axis(handles.axes_total(10),[lowerVol upperVol lowerCur upperCur])
%                     title(handles.axes_total(10),'v vs i (TIA R1)','Color', 'b')
%                     xlabel(handles.axes_total(10),'FSCV VCM (V)')
%                     ylabel(handles.axes_total(10),'Input Current (nA)')
           
                    %second two channel
                    plot(handles.axes_total(11),Xaxes_L2,imp_L2*(10^9))
                    axis(handles.axes_total(11),[lowerVol upperVol lowerCur upperCur])
                    title(handles.axes_total(11),'v vs i (TIA L2)','Color', 'b')
                    xlabel(handles.axes_total(11),'FSCV VCM (V)')
                    ylabel(handles.axes_total(11),'Input Current (nA)')

                    plot(handles.axes_total(12),Xaxes_R2,imp_R2*(10^9))
                    axis(handles.axes_total(12),[lowerVol upperVol lowerCur upperCur])
                    title(handles.axes_total(12),'v vs i (TIA R2)','Color', 'b')
                    xlabel(handles.axes_total(12),'FSCV VCM (V)')
                    ylabel(handles.axes_total(12),'Input Current (nA)')
                end
                
                ifmod = mod(i,5);
                
                if(ifmod == 0)
                    %channel 1
%                     voltageArray1 = Xaxes_L1;
% 
%                     ch1n = ceil(numel(voltageArray1)/2);
%                     ch1firstHalfVol = voltageArray1(1:ch1n);
%                     ch1secondHalfVol = voltageArray1(ch1n+1:end);
% 
%                     ch1v1 = str2num(get(handles.ch1v1,'String'));
%                     ch1v2 = str2num(get(handles.ch1v2,'String'));
%                     ch1v3 = str2num(get(handles.ch1v3,'String'));
%                     ch1v4 = str2num(get(handles.ch1v4,'String'));
% 
%                     [ch1val1,ch1idx1]=min(abs(ch1v1-ch1firstHalfVol));
%                     [ch1val2,ch1idx2]=min(abs(ch1v2-ch1firstHalfVol));
%                     [ch1val3,ch1idx3]=min(abs(ch1v3-ch1secondHalfVol));
%                     [ch1val4,ch1idx4]=min(abs(ch1v4-ch1secondHalfVol));
% 
%                     ch1vol1idx = ch1idx1;
%                     ch1vol2idx = ch1idx2;
%                     ch1vol3idx = ch1idx3+length(ch1firstHalfVol);
%                     ch1vol4idx = ch1idx4+length(ch1firstHalfVol);
% 
%                     ch1I1p = imp_L1(ch1vol1idx);
%                     ch1I2p = imp_L1(ch1vol2idx);
%                     ch1I3b = imp_L1(ch1vol3idx);
%                     ch1I4b = imp_L1(ch1vol4idx);
% 
%                     set(handles.ch1I1p, 'String', ch1I1p*(10^9));
%                     set(handles.ch1I2p, 'String', ch1I2p*(10^9));
%                     set(handles.ch1I3b, 'String', ch1I3b*(10^9));
%                     set(handles.ch1I4b, 'String', ch1I4b*(10^9));
                    
                    %channel 2
%                     voltageArray2 = Xaxes_R1;
% 
%                     ch2n = ceil(numel(voltageArray2)/2);
%                     ch2firstHalfVol = voltageArray2(1:ch2n);
%                     ch2secondHalfVol = voltageArray2(ch2n+1:end);
% 
%                     ch2v1 = str2num(get(handles.ch2v1,'String'));
%                     ch2v2 = str2num(get(handles.ch2v2,'String'));
%                     ch2v3 = str2num(get(handles.ch2v3,'String'));
%                     ch2v4 = str2num(get(handles.ch2v4,'String'));
% 
%                     [ch2val1,ch2idx1]=min(abs(ch2v1-ch2firstHalfVol));
%                     [ch2val2,ch2idx2]=min(abs(ch2v2-ch2firstHalfVol));
%                     [ch2val3,ch2idx3]=min(abs(ch2v3-ch2secondHalfVol));
%                     [ch2val4,ch2idx4]=min(abs(ch2v4-ch2secondHalfVol));
% 
%                     ch2vol1idx = ch2idx1;
%                     ch2vol2idx = ch2idx2;
%                     ch2vol3idx = ch2idx3+length(ch2firstHalfVol);
%                     ch2vol4idx = ch2idx4+length(ch2firstHalfVol);
% 
%                     ch2I1p = imp_R1(ch2vol1idx);
%                     ch2I2p = imp_R1(ch2vol2idx);
%                     ch2I3b = imp_R1(ch2vol3idx);
%                     ch2I4b = imp_R1(ch2vol4idx);
% 
%                     set(handles.ch2I1p, 'String', ch2I1p*(10^9));
%                     set(handles.ch2I2p, 'String', ch2I2p*(10^9));
%                     set(handles.ch2I3b, 'String', ch2I3b*(10^9));
%                     set(handles.ch2I4b, 'String', ch2I4b*(10^9));
                    
                    %channel 3
                    voltageArray3 = Xaxes_L2;

                    ch3n = ceil(numel(voltageArray3)/2);
                    ch3firstHalfVol = voltageArray3(1:ch3n);
                    ch3secondHalfVol = voltageArray3(ch3n+1:end);

                    ch3v1 = str2num(get(handles.ch3v1,'String'));
                    ch3v2 = str2num(get(handles.ch3v2,'String'));
                    ch3v3 = str2num(get(handles.ch3v3,'String'));
                    ch3v4 = str2num(get(handles.ch3v4,'String'));

                    [ch3val1,ch3idx1]=min(abs(ch3v1-ch3firstHalfVol));
                    [ch3val2,ch3idx2]=min(abs(ch3v2-ch3firstHalfVol));
                    [ch3val3,ch3idx3]=min(abs(ch3v3-ch3secondHalfVol));
                    [ch3val4,ch3idx4]=min(abs(ch3v4-ch3secondHalfVol));

                    ch3vol1idx = ch3idx1;
                    ch3vol2idx = ch3idx2;
                    ch3vol3idx = ch3idx3+length(ch3firstHalfVol);
                    ch3vol4idx = ch3idx4+length(ch3firstHalfVol);

                    ch3I1p = imp_L2(ch3vol1idx);
                    ch3I2p = imp_L2(ch3vol2idx);
                    ch3I3b = imp_L2(ch3vol3idx);
                    ch3I4b = imp_L2(ch3vol4idx);

                    set(handles.ch3I1p, 'String', ch3I1p*(10^9));
                    set(handles.ch3I2p, 'String', ch3I2p*(10^9));
                    set(handles.ch3I3b, 'String', ch3I3b*(10^9));
                    set(handles.ch3I4b, 'String', ch3I4b*(10^9));
                    
                    %channel 4
                    voltageArray4 = Xaxes_R2;

                    ch4n = ceil(numel(voltageArray4)/2);
                    ch4firstHalfVol = voltageArray4(1:ch4n);
                    ch4secondHalfVol = voltageArray4(ch4n+1:end);

                    ch4v1 = str2num(get(handles.ch4v1,'String'));
                    ch4v2 = str2num(get(handles.ch4v2,'String'));
                    ch4v3 = str2num(get(handles.ch4v3,'String'));
                    ch4v4 = str2num(get(handles.ch4v4,'String'));

                    [ch4val1,ch4idx1]=min(abs(ch4v1-ch4firstHalfVol));
                    [ch4val2,ch4idx2]=min(abs(ch4v2-ch4firstHalfVol));
                    [ch4val3,ch4idx3]=min(abs(ch4v3-ch4secondHalfVol));
                    [ch4val4,ch4idx4]=min(abs(ch4v4-ch4secondHalfVol));

                    ch4vol1idx = ch4idx1;
                    ch4vol2idx = ch4idx2;
                    ch4vol3idx = ch4idx3+length(ch4firstHalfVol);
                    ch4vol4idx = ch4idx4+length(ch4firstHalfVol);

                    ch4I1p = imp_R2(ch4vol1idx);
                    ch4I2p = imp_R2(ch4vol2idx);
                    ch4I3b = imp_R2(ch4vol3idx);
                    ch4I4b = imp_R2(ch4vol4idx);

                    set(handles.ch4I1p, 'String', ch4I1p*(10^9));
                    set(handles.ch4I2p, 'String', ch4I2p*(10^9));
                    set(handles.ch4I3b, 'String', ch4I3b*(10^9));
                    set(handles.ch4I4b, 'String', ch4I4b*(10^9));
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
        
        

%Save data


%         L1Vol = handles.data_L1_save;
%         arrayname = 'L1Vol';
%         fid = fopen(handles.name1Vol, 'w'); 
%         fclose(fid)
%         save(handles.name1Vol, arrayname,'-ascii', '-double', '-append');
   
%         R1Vol = handles.data_R1_save;
%         arrayname = 'R1Vol';
%         fid = fopen(handles.name2Vol, 'w'); 
%         fclose(fid)
%         save(handles.name2Vol, arrayname,'-ascii', '-double', '-append');
        
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
        
   
        
        
        
%         L2Cur = 10e9*(handles.current_L2_save);
%         arrayname = 'L2Cur';
%         fid = fopen(handles.name3Cur, 'w'); 
%         fclose(fid)
%         save(handles.name3Cur, arrayname,'-ascii', '-double', '-append');
%         
%         
%         R2Cur = 10e9*(handles.current_R2_save);
%         arrayname = 'R2Cur';
%         fid = fopen(handles.name4Cur, 'w'); 
%         fclose(fid)
%         save(handles.name4Cur, arrayname,'-ascii', '-double', '-append');
        
        
        
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
        hold(handles.axes_total(9),'off')
        hold(handles.axes_total(10),'off')
        hold(handles.axes_total(11),'off')
        hold(handles.axes_total(12),'off')

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






% --- Executes on button press in setupFileName.
function setupFileName_Callback(hObject, eventdata, handles)
Dev = get(handles.devID,'String');
MeMo = get(handles.measuredMolecule,'String');
Concentration = get(handles.consentrationOfMol,'String');
rampRate = get(handles.editScanRate,'String');
freq = get(handles.editFrequency,'String');
peak = get(handles.editPeakVoltage,'String');
vpeak = str2num(peak);
if (vpeak<0)  
    peakStr = "ne"+peak(2)+"p"+peak(4:end);
end
if (vpeak>0)  
    peakStr = "po"+peak(1)+"p"+peak(3:end);
end

bottom = get(handles.editBottomVoltage,'String');
vbottom = str2num(bottom);
if (vbottom<0)  
    bottomStr = "ne"+bottom(2)+"p"+bottom(4:end);
end
if (vbottom>0)  
    bottomStr = "po"+bottom(1)+"p"+bottom(3:end);
end
pchar = convertStringsToChars(peakStr);
bchar = convertStringsToChars(bottomStr);

time = datestr(now,'ddmmyy_HHMMSS');

strArray = {Dev,MeMo,Concentration,rampRate,freq,bchar,pchar,time};
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

% --- Executes on button press in enablech1.
function enableCh1_Callback(hObject, eventdata, handles)
% hObject    handle to enablech1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enablech1

if get(hObject,'Value') == 1
    set(handles.disableCH1,'Value',0)
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
    
end


% --- Executes on button press in disableCH1.




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


% --- Executes on button press in radiobutton19.
function radiobutton19_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton19


% --- Executes on button press in radiobutton20.
function radiobutton20_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton20


% --- Executes on selection change in popupmenu16.
function popupmenu16_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu16 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu16


% --- Executes during object creation, after setting all properties.
function popupmenu16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton17.
function radiobutton17_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton17


% --- Executes on button press in radiobutton18.
function radiobutton18_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton18


% --- Executes on button press in ResetButton.
function ResetButton_Callback(hObject, eventdata, handles)
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'), 1,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
pause(0.1);
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'), 0,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);

guidata(hObject, handles);

% --- Executes on button press in UnloadButton.
function UnloadButton_Callback(hObject, eventdata, handles)
calllib('okFrontPanel', 'okFrontPanel_Destruct', handles.xem);
%cla(handles.tab1_axes,'reset')
%cla(handles.tab2_axes,'reset')
guidata(hObject, handles);
clear all;
unloadlibrary okFrontPanel

% --- Executes on button press in EnableButton.
function EnableButton_Callback(hObject, eventdata, handles)
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

guidata(hObject, handles);


% --- Executes on selection change in popMeasCh4.
function popMeasCh4_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject,'Value')};

if (strcmp(popChoice,'Voltage'))
    %In this case, PGA gain is 00
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    disp('CHR1-1')
    
elseif (strcmp(popChoice,'Current'))
    %In this case, PGA gain is 01
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  
    
end
disp('PGA_L_DONE');
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popMeasCh4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMeasCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popPGACh4.
function popPGACh4_Callback(hObject, eventdata, handles)
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
disp('PGA_L_DONE');
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popPGACh4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPGACh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popMeasCh3.
function popMeasCh3_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject,'Value')};

% if (strcmp(popChoice,'Voltage'))
%     %In this case, PGA gain is 00
%     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),1,hex2dec('01'));
%     calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),1,hex2dec('01'));
%     calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%     
%     
% elseif (strcmp(popChoice,'Current'))
%     %In this case, PGA gain is 01
%     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),0,hex2dec('01'));
%     calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),0,hex2dec('01'));
%     calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%     disp('CHR0-1')
%     
% end
disp('PGA_L_DONE');
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popMeasCh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMeasCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popPGACh3.
function popPGACh3_Callback(hObject, eventdata, handles)
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
disp('PGA_L_DONE');
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popPGACh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPGACh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popMeasCh2.
function popMeasCh2_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
popChoice = contents{get(hObject,'Value')};

if (strcmp(popChoice,'Voltage'))
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('04'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
    
elseif (strcmp(popChoice,'Current'))
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('04'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
  
  
    
end
disp('PGA_L_DONE');
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popMeasCh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMeasCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popPGACh2.
function popPGACh2_Callback(hObject, eventdata, handles)
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
function popPGACh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPGACh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popMeasCh1.
function popMeasCh1_Callback(hObject, eventdata, handles)
% contents = cellstr(get(hObject,'String'));
% popChoice = contents{get(hObject,'Value')};
% 
% if (strcmp(popChoice,'Voltage'))
%     %In this case, PGA gain is 00
%     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('04'),1,hex2dec('01'));
%     calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%     
%     
% elseif (strcmp(popChoice,'Current'))
%     %In this case, PGA gain is 01
%     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('04'),0,hex2dec('01'));
%     calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
%   
%     
% end
disp('PGA_L_DONE');
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popMeasCh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMeasCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popPGACh1.
function popPGACh1_Callback(hObject, eventdata, handles)
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
function popPGACh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPGACh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in enableCH1.
function enableCH1_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0B'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
end

function disableCH1_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in enableCH2.
function enableCH2_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
     success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0B'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end


% --- Executes on button press in disableCH2.
function disableCH2_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end


% --- Executes on button press in enableCH3.
function enableCH3_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('19'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
    disp("Finish Enable pins")
end


% --- Executes on button press in disableCH3.
function disableCH3_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end


% --- Executes on button press in enableCH4.
function enableCH4_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('19'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
    disp('tia,adc,ck set to 1');
end


% --- Executes on button press in disableCH4.
function disableCH4_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end



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



function edit132_Callback(hObject, eventdata, handles)
% hObject    handle to edit132 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit132 as text
%        str2double(get(hObject,'String')) returns contents of edit132 as a double


% --- Executes during object creation, after setting all properties.
function edit132_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit132 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit133_Callback(hObject, eventdata, handles)
% hObject    handle to edit133 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit133 as text
%        str2double(get(hObject,'String')) returns contents of edit133 as a double


% --- Executes during object creation, after setting all properties.
function edit133_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit133 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit134_Callback(hObject, eventdata, handles)
% hObject    handle to edit134 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit134 as text
%        str2double(get(hObject,'String')) returns contents of edit134 as a double


% --- Executes during object creation, after setting all properties.
function edit134_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit134 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit135_Callback(hObject, eventdata, handles)
% hObject    handle to edit135 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit135 as text
%        str2double(get(hObject,'String')) returns contents of edit135 as a double


% --- Executes during object creation, after setting all properties.
function edit135_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit135 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit136_Callback(hObject, eventdata, handles)
% hObject    handle to edit136 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit136 as text
%        str2double(get(hObject,'String')) returns contents of edit136 as a double


% --- Executes during object creation, after setting all properties.
function edit136_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit136 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit137_Callback(hObject, eventdata, handles)
% hObject    handle to edit137 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit137 as text
%        str2double(get(hObject,'String')) returns contents of edit137 as a double


% --- Executes during object creation, after setting all properties.
function edit137_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit137 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit138_Callback(hObject, eventdata, handles)
% hObject    handle to edit138 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit138 as text
%        str2double(get(hObject,'String')) returns contents of edit138 as a double


% --- Executes during object creation, after setting all properties.
function edit138_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit138 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit139_Callback(hObject, eventdata, handles)
% hObject    handle to edit139 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit139 as text
%        str2double(get(hObject,'String')) returns contents of edit139 as a double


% --- Executes during object creation, after setting all properties.
function edit139_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit139 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3v1_Callback(hObject, eventdata, handles)
% hObject    handle to ch3v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3v1 as text
%        str2double(get(hObject,'String')) returns contents of ch3v1 as a double


% --- Executes during object creation, after setting all properties.
function ch3v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3v2_Callback(hObject, eventdata, handles)
% hObject    handle to ch3v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3v2 as text
%        str2double(get(hObject,'String')) returns contents of ch3v2 as a double


% --- Executes during object creation, after setting all properties.
function ch3v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3v3_Callback(hObject, eventdata, handles)
% hObject    handle to ch3v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3v3 as text
%        str2double(get(hObject,'String')) returns contents of ch3v3 as a double


% --- Executes during object creation, after setting all properties.
function ch3v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3v4_Callback(hObject, eventdata, handles)
% hObject    handle to ch3v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3v4 as text
%        str2double(get(hObject,'String')) returns contents of ch3v4 as a double


% --- Executes during object creation, after setting all properties.
function ch3v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3I1p_Callback(hObject, eventdata, handles)
% hObject    handle to ch3I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3I1p as text
%        str2double(get(hObject,'String')) returns contents of ch3I1p as a double


% --- Executes during object creation, after setting all properties.
function ch3I1p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3I2p_Callback(hObject, eventdata, handles)
% hObject    handle to ch3I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3I2p as text
%        str2double(get(hObject,'String')) returns contents of ch3I2p as a double


% --- Executes during object creation, after setting all properties.
function ch3I2p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3I3b_Callback(hObject, eventdata, handles)
% hObject    handle to ch3I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3I3b as text
%        str2double(get(hObject,'String')) returns contents of ch3I3b as a double


% --- Executes during object creation, after setting all properties.
function ch3I3b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3I4b_Callback(hObject, eventdata, handles)
% hObject    handle to ch3I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3I4b as text
%        str2double(get(hObject,'String')) returns contents of ch3I4b as a double


% --- Executes during object creation, after setting all properties.
function ch3I4b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch2v1_Callback(hObject, eventdata, handles)
% hObject    handle to ch2v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2v1 as text
%        str2double(get(hObject,'String')) returns contents of ch2v1 as a double


% --- Executes during object creation, after setting all properties.
function ch2v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch2v2_Callback(hObject, eventdata, handles)
% hObject    handle to ch2v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2v2 as text
%        str2double(get(hObject,'String')) returns contents of ch2v2 as a double


% --- Executes during object creation, after setting all properties.
function ch2v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch2v3_Callback(hObject, eventdata, handles)
% hObject    handle to ch2v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2v3 as text
%        str2double(get(hObject,'String')) returns contents of ch2v3 as a double


% --- Executes during object creation, after setting all properties.
function ch2v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch2v4_Callback(hObject, eventdata, handles)
% hObject    handle to ch2v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2v4 as text
%        str2double(get(hObject,'String')) returns contents of ch2v4 as a double


% --- Executes during object creation, after setting all properties.
function ch2v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch2I1p_Callback(hObject, eventdata, handles)
% hObject    handle to ch2I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2I1p as text
%        str2double(get(hObject,'String')) returns contents of ch2I1p as a double


% --- Executes during object creation, after setting all properties.
function ch2I1p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch2I2p_Callback(hObject, eventdata, handles)
% hObject    handle to ch2I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2I2p as text
%        str2double(get(hObject,'String')) returns contents of ch2I2p as a double


% --- Executes during object creation, after setting all properties.
function ch2I2p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch2I3b_Callback(hObject, eventdata, handles)
% hObject    handle to ch2I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2I3b as text
%        str2double(get(hObject,'String')) returns contents of ch2I3b as a double


% --- Executes during object creation, after setting all properties.
function ch2I3b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch2I4b_Callback(hObject, eventdata, handles)
% hObject    handle to ch2I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2I4b as text
%        str2double(get(hObject,'String')) returns contents of ch2I4b as a double


% --- Executes during object creation, after setting all properties.
function ch2I4b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch1v1_Callback(hObject, eventdata, handles)
% hObject    handle to ch1v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1v1 as text
%        str2double(get(hObject,'String')) returns contents of ch1v1 as a double


% --- Executes during object creation, after setting all properties.
function ch1v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch1v2_Callback(hObject, eventdata, handles)
% hObject    handle to ch1v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1v2 as text
%        str2double(get(hObject,'String')) returns contents of ch1v2 as a double


% --- Executes during object creation, after setting all properties.
function ch1v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch1v3_Callback(hObject, eventdata, handles)
% hObject    handle to ch1v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1v3 as text
%        str2double(get(hObject,'String')) returns contents of ch1v3 as a double


% --- Executes during object creation, after setting all properties.
function ch1v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch1v4_Callback(hObject, eventdata, handles)
% hObject    handle to ch1v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1v4 as text
%        str2double(get(hObject,'String')) returns contents of ch1v4 as a double


% --- Executes during object creation, after setting all properties.
function ch1v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch1I1p_Callback(hObject, eventdata, handles)
% hObject    handle to ch1I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1I1p as text
%        str2double(get(hObject,'String')) returns contents of ch1I1p as a double


% --- Executes during object creation, after setting all properties.
function ch1I1p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch1I2p_Callback(hObject, eventdata, handles)
% hObject    handle to ch1I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1I2p as text
%        str2double(get(hObject,'String')) returns contents of ch1I2p as a double


% --- Executes during object creation, after setting all properties.
function ch1I2p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch1I3b_Callback(hObject, eventdata, handles)
% hObject    handle to ch1I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1I3b as text
%        str2double(get(hObject,'String')) returns contents of ch1I3b as a double


% --- Executes during object creation, after setting all properties.
function ch1I3b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch1I4b_Callback(hObject, eventdata, handles)
% hObject    handle to ch1I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1I4b as text
%        str2double(get(hObject,'String')) returns contents of ch1I4b as a double


% --- Executes during object creation, after setting all properties.
function ch1I4b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit116_Callback(hObject, eventdata, handles)
% hObject    handle to edit116 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit116 as text
%        str2double(get(hObject,'String')) returns contents of edit116 as a double


% --- Executes during object creation, after setting all properties.
function edit116_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit116 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit117_Callback(hObject, eventdata, handles)
% hObject    handle to edit117 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit117 as text
%        str2double(get(hObject,'String')) returns contents of edit117 as a double


% --- Executes during object creation, after setting all properties.
function edit117_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit117 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit118_Callback(hObject, eventdata, handles)
% hObject    handle to edit118 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit118 as text
%        str2double(get(hObject,'String')) returns contents of edit118 as a double


% --- Executes during object creation, after setting all properties.
function edit118_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit118 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit119_Callback(hObject, eventdata, handles)
% hObject    handle to edit119 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit119 as text
%        str2double(get(hObject,'String')) returns contents of edit119 as a double


% --- Executes during object creation, after setting all properties.
function edit119_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit119 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit120_Callback(hObject, eventdata, handles)
% hObject    handle to edit120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit120 as text
%        str2double(get(hObject,'String')) returns contents of edit120 as a double


% --- Executes during object creation, after setting all properties.
function edit120_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit121_Callback(hObject, eventdata, handles)
% hObject    handle to edit121 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit121 as text
%        str2double(get(hObject,'String')) returns contents of edit121 as a double


% --- Executes during object creation, after setting all properties.
function edit121_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit121 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit122_Callback(hObject, eventdata, handles)
% hObject    handle to edit122 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit122 as text
%        str2double(get(hObject,'String')) returns contents of edit122 as a double


% --- Executes during object creation, after setting all properties.
function edit122_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit122 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit123_Callback(hObject, eventdata, handles)
% hObject    handle to edit123 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit123 as text
%        str2double(get(hObject,'String')) returns contents of edit123 as a double


% --- Executes during object creation, after setting all properties.
function edit123_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit123 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit108_Callback(hObject, eventdata, handles)
% hObject    handle to edit108 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit108 as text
%        str2double(get(hObject,'String')) returns contents of edit108 as a double


% --- Executes during object creation, after setting all properties.
function edit108_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit108 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit109_Callback(hObject, eventdata, handles)
% hObject    handle to edit109 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit109 as text
%        str2double(get(hObject,'String')) returns contents of edit109 as a double


% --- Executes during object creation, after setting all properties.
function edit109_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit109 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit110_Callback(hObject, eventdata, handles)
% hObject    handle to edit110 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit110 as text
%        str2double(get(hObject,'String')) returns contents of edit110 as a double


% --- Executes during object creation, after setting all properties.
function edit110_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit110 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit111_Callback(hObject, eventdata, handles)
% hObject    handle to edit111 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit111 as text
%        str2double(get(hObject,'String')) returns contents of edit111 as a double


% --- Executes during object creation, after setting all properties.
function edit111_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit111 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit112_Callback(hObject, eventdata, handles)
% hObject    handle to edit112 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit112 as text
%        str2double(get(hObject,'String')) returns contents of edit112 as a double


% --- Executes during object creation, after setting all properties.
function edit112_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit112 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit113_Callback(hObject, eventdata, handles)
% hObject    handle to edit113 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit113 as text
%        str2double(get(hObject,'String')) returns contents of edit113 as a double


% --- Executes during object creation, after setting all properties.
function edit113_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit113 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit114_Callback(hObject, eventdata, handles)
% hObject    handle to edit114 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit114 as text
%        str2double(get(hObject,'String')) returns contents of edit114 as a double


% --- Executes during object creation, after setting all properties.
function edit114_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit114 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit115_Callback(hObject, eventdata, handles)
% hObject    handle to edit115 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit115 as text
%        str2double(get(hObject,'String')) returns contents of edit115 as a double


% --- Executes during object creation, after setting all properties.
function edit115_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit115 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
