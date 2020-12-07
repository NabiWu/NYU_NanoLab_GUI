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

% Last Modified by GUIDE v2.5 02-Feb-2020 09:59:22

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

thirdTab = uitab(tg,'Title', 'Data Analysis');
 axes('Parent',thirdTab);
 tmp=subplot(2,3,1); 

    title("",'Color', 'b','FontSize', 18) 
    xlabel('','FontSize', 14) 
    ylabel('','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,2);

    title("",'Color', 'b','FontSize', 18) 
    xlabel('','FontSize', 14) 
    ylabel('','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
    
 tmp=subplot(2,3,3); 

    title("",'Color', 'b','FontSize', 18) 
    xlabel('','FontSize', 14) 
    ylabel('','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
    
 tmp=subplot(2,3,4); 

    title("",'Color', 'b','FontSize', 18) 
    xlabel('','FontSize', 14) 
    ylabel('','FontSize', 14)
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
    
 tmp=subplot(2,3,5); 

    title("",'Color', 'b','FontSize', 18) 
    xlabel('','FontSize', 14) 
    ylabel('','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,6); 

    title("",'Color', 'b','FontSize', 18) 
    xlabel('','FontSize', 14) 
    ylabel('','FontSize', 14)
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
            
%             handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize, Unit_length, pv_A0);
%             epvalue_A0 = get(pv_A0, 'value');
%             handles.BTpipeOut_A1=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A1'), blocksize, Unit_length, pv_A1);
%             epvalue_A1 = get(pv_A1, 'value');

            handles.BTpipeOut_A2=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A2'), blocksize, Unit_length, pv_A2);
            epvalue_A2 = get(pv_A2, 'value');
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

%                 plot(handles.axes_total(5),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L1*(10^9));
%                 axis(handles.axes_total(5),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
%                 title(handles.axes_total(5),'t vs i (TIA L1)','Color', 'b')
%                 xlabel(handles.axes_total(5),'time (s)')
%                 ylabel(handles.axes_total(5),'current (nA)')
%                 hold(handles.axes_total(5),'on')
% 
%                 plot(handles.axes_total(7),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R1*(10^9))
%                 axis(handles.axes_total(7),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
%                 title(handles.axes_total(7),'t vs i (TIA R1)','Color', 'b')
%                 xlabel(handles.axes_total(7),'time (s)')
%                 ylabel(handles.axes_total(7),'current (nA)')
%                 hold(handles.axes_total(7),'on')
% 
%                 plot(handles.axes_total(13),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
%                 axis(handles.axes_total(13),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
%                 title(handles.axes_total(13),'t vs v (TIA L2)','Color', 'b') 
%                 xlabel(handles.axes_total(13),'time (s)')
%                 ylabel(handles.axes_total(13),'voltage (v)')
%                 hold(handles.axes_total(13),'on')
%             
%                 plot(handles.axes_total(18),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
%                 axis(handles.axes_total(18),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
%                 title(handles.axes_total(18),'t vs v (TIA R2)','Color', 'b')
%                 xlabel(handles.axes_total(18),'time (s)')
%                 ylabel(handles.axes_total(18),'voltage (v)')
%                 hold(handles.axes_total(18),'on')
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
                
%                 handles.current_L=[handles.current_L; imp_L];
%                 handles.current_R=[handles.current_R; imp_R];
%                 Xaxes_L1=[(((0:(N_L1-1))*((Vr_H-Vr_L)/N_L1))+Vr_L) Vr_H ((((N_L1-1):(-1):0)*((Vr_H-Vr_L)/N_L1))+Vr_L)];
%                 Xaxes_R1=[(((0:(N_R1-1))*((Vr_H-Vr_L)/N_R1))+Vr_L) Vr_H ((((N_R1-1):(-1):0)*((Vr_H-Vr_L)/N_R1))+Vr_L)];

                Xaxes_L2=[(((0:(N_L2-1))*((Vr_H-Vr_L)/N_L2))+Vr_L) Vr_H ((((N_L2-1):(-1):0)*((Vr_H-Vr_L)/N_L2))+Vr_L)];
                Xaxes_R2=[(((0:(N_R2-1))*((Vr_H-Vr_L)/N_R2))+Vr_L) Vr_H ((((N_R2-1):(-1):0)*((Vr_H-Vr_L)/N_R2))+Vr_L)];
        
                if (get(handles.stop,'Value')==0)
           
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
%             tmp(i) = t;
            
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
        
        
        
        
         if(get(handles.SaveData,'Value')==1)
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
        
        end
        
        
%         L2Cur = 10e9*(handles.current_L2_save);
%         arrayname = 'L2Cur';
%         fid = fopen(handles.name3Cur, 'w'); 
%         fclose(fid)
%         save(handles.name3Cur, arrayname,'-ascii', '-double', '-append');
        
        
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
handles.dname = uigetdir('C:\');

disp(dname);
set(handles.myFolder,'String',handles.dname);

guidata(hObject, handles);








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
    disp('CHR1-1')
    
elseif (strcmp(popChoice,'Current'))
    %In this case, PGA gain is 01
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),0,hex2dec('01'));
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

if (strcmp(popChoice,'Voltage'))
    %In this case, PGA gain is 00
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    
    
elseif (strcmp(popChoice,'Current'))
    %In this case, PGA gain is 01
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    disp('CHR0-1')
    
end
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


% --- Executes on button press in dataAnalysisNshape.
function dataAnalysisNshape_Callback(hObject, eventdata, handles)
% Created by Ting Wu on 04/09/2016
% Modified by Ting Wu on 05/13/2016 (now could read multi sheet of the tdms file and do averaging)
% Need to change file name, Sensitivity, Sampling name and saveas file name


disp('Code begins running...')

%% Define folder path and file name


directoryName = handles.dname;
dataFolderPath=directoryName;
%File_name_I ='CM_N5A_9_C3260319_190906200nA_vern100p_1uM_400Vs_10Hz_ne_0p4_to_1p3_V2.tdms';
ch3DataFileName = handles.name3Vol;
fileName_I = ch3DataFileName;
ch4DataFileName = handles.name4Vol;
fileName_V = ch4DataFileName;
cd (dataFolderPath)
fileID_I = fopen(fileName_I);
data_I0 = fscanf(fileID_I,'%f\n');
vcom = -0.063;
data_I=(data_I0-vcom)/4.1e6;

% Parasitic_200 = csvread('Parasitic_200.csv');

fclose(fileID_I);
fileID_V = fopen(fileName_V);
data_V = fscanf(fileID_V,'%f\n');
data_V = data_V-0;
fclose(fileID_V);

%Device=File_name1(1:end-5)
%Device=File_name1(1:end-5)

%% Define parameters
%Max_sensitivity=200e-9;
%Percent=100e-2;
%Sensitivity=Max_sensitivity/Percent;

Sampling_rate=2500000/250;
Voltage_High=0.6;
Voltage_Low=-0.2;
% Voltage_hold=-0.02;
Voltage_hold=-0.05;
% Voltage_hold=-0.0;
Ramp_rate=200;
FSCV_frequency=10;
%Duration=((Voltage_High-Voltage_hold)+(-Voltage_Low-Voltage_hold)+(Voltage_High-Voltage_Low-8*Voltage_hold))/Ramp_rate;
Duration=(Voltage_High-Voltage_Low)/Ramp_rate*2;
First_cycle_PBS=80;  %first background cycle for current subtraction 
N_cycle_PBS=30;

First_cycle_DA=400;  %first DA cycle for current subtraction
N_cycle_DA=10;

%% Read data from tdms file
% cd (Datafolder)
% [Data_cell1]=ReadFile4(Datafolder, File_name1);
% [Data_cell2]=ReadFile4(Datafolder, File_name2);

% FSCV_PBS_data1=Data_cell1{1,1};
% FSCV_DA_data1=Data_cell1{1,1};
% 
% 
% FSCV_current_PBS=smooth(FSCV_PBS_data1(:,1))*Sensitivity;
% FSCV_voltage_PBS=smooth(FSCV_PBS_data1(:,2));
% 
% 
% FSCV_current_Dopamine=smooth(FSCV_DA_data1(:,1))*Sensitivity;
% FSCV_voltage_Dopamine=smooth(FSCV_DA_data1(:,2));


% FSCV_current_Dopamine=smooth(data_I);
% FSCV_voltage_Dopamine=smooth(data_V);
% 
% FSCV_current_PBS=smooth(data_I);
% FSCV_voltage_PBS=smooth(data_V);
% 
FSCV_current_PBS=(data_I);
FSCV_voltage_PBS=(data_V);

FSCV_current_Dopamine=(data_I);
FSCV_voltage_Dopamine=(data_V);



%% Find the averaging for the first PBS measurement

%Find all the peak 
%[Peak, Peak_index]=findpeaks(FSCV_voltage_PBS, 'MinPeakHeight', 0.7, 'MinPeakDistance', round(1/FSCV_frequency*Sampling_rate)-100);
[Peak, Peak_index]=findpeaks((FSCV_voltage_PBS), 'MinPeakHeight', 0.3, 'MinPeakDistance', round(1/FSCV_frequency*Sampling_rate)-100);


% Generate a matrix of all the cycles
NumOfCycle=length(Peak_index);
Last_Cycle_Index=Peak_index(end-1)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index(end-1)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
Voltage_single_cycle_PBS=FSCV_voltage_PBS(Last_Cycle_Index);

M=4;

N_PBS=NumOfCycle-5;
M_PBS=NumOfCycle-1;

Current_Matrix_PBS=[];
Voltage_Matrix_PBS=[];

    
for i=First_cycle_PBS:(First_cycle_PBS+N_cycle_PBS) %N_PBS: M_PBS    
   
    One_Cycle_Index=Peak_index(i)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index(i)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
    Current_single_cycle=FSCV_current_PBS(One_Cycle_Index)';
    Voltage_single_cycle=FSCV_voltage_PBS(One_Cycle_Index)';
    
    Current_Matrix_PBS=[Current_Matrix_PBS;Current_single_cycle];
    Voltage_Matrix_PBS=[Voltage_Matrix_PBS;Voltage_single_cycle];
    
   
    Current_Matrix_PBS_Plot=reshape(Current_Matrix_PBS', numel(Current_Matrix_PBS),1);
    Voltage_Matrix_PBS_Plot=reshape(Voltage_Matrix_PBS', numel(Voltage_Matrix_PBS),1);
end
    Average_current_PBS=mean(Current_Matrix_PBS);
    
    
 %% Find the averaging for the dopamine measurement    
%Find all the peak 
%[Peak_DA, Peak_index_DA]=findpeaks(FSCV_voltage_Dopamine, 'MinPeakHeight', 0.6, 'MinPeakDistance', 1/FSCV_frequency*Sampling_rate-100);

[Peak_DA, Peak_index_DA]=findpeaks((FSCV_voltage_Dopamine), 'MinPeakHeight', 0.3, 'MinPeakDistance', 1/FSCV_frequency*Sampling_rate-100);

% Generate a matrix of all the cycles
NumOfCycle_DA=length(Peak_index_DA);
Last_Cycle_Index_DA=Peak_index_DA(end-1)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index_DA(end-1)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
Voltage_single_cycle_Dopamine=FSCV_voltage_Dopamine(Last_Cycle_Index_DA);


N_DA=NumOfCycle_DA-5;
M_DA=NumOfCycle_DA-1;

Current_Matrix_Dopamine=[];
Voltage_Matrix_Dopamine=[];



for i = First_cycle_DA:(First_cycle_DA+N_cycle_DA) %N_DA:M_DA

    One_Cycle_Index_DA=Peak_index_DA(i)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index_DA(i)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
    Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
    Voltage_single_cycle_DA=FSCV_voltage_Dopamine(One_Cycle_Index_DA)';

    Current_Matrix_Dopamine=[Current_Matrix_Dopamine;Current_single_cycle_DA];
    Voltage_Matrix_Dopamine=[Voltage_Matrix_Dopamine;Voltage_single_cycle_DA];

    Current_Matrix_Dopamine_Plot=reshape(Current_Matrix_Dopamine', numel(Current_Matrix_Dopamine),1);
    Voltage_Matrix_Dopamine_Plot=reshape(Voltage_Matrix_Dopamine', numel(Voltage_Matrix_Dopamine),1);
end
    Average_current_Dopamine=mean(Current_Matrix_Dopamine);

   
%% Calculate the substracted current    
    Substrated_current=Average_current_Dopamine-Average_current_PBS;
%%
    
    %%Find peak positions
Peak_current_matrix_ox=[]; %oxidation peak
Peak_current_matrix_r1=[]; %first reduction peak
Peak_current_matrix_r2=[]; %second reduction peak 
Voltage_matrix=[];
Subtracted_current_matrix=[];
sub_matrix=[];

for j=1:1:NumOfCycle_DA-1    
    
    One_Cycle_Index_DA=Peak_index_DA(j)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index_DA(j)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
    Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
    Voltage_single_cycle_DA=FSCV_voltage_Dopamine(One_Cycle_Index_DA)';

    Subtracted_current_single_cycle=Current_single_cycle_DA-Current_single_cycle;
    sub_matrix=[sub_matrix;Subtracted_current_single_cycle];
    
    %%Index_low=find (Voltage_single_cycle_DA>0.34 & Voltage_single_cycle_DA<0.5);
    Index_low_ox=find (Voltage_single_cycle_DA>0.2 & Voltage_single_cycle_DA<0.45);
    Index_low_r1=find (Voltage_single_cycle_DA>-0.1 & Voltage_single_cycle_DA<0.1);
    Index_low_r2=find (Voltage_single_cycle_DA>0.1 & Voltage_single_cycle_DA<0.3);
    
    Subtracted_current_local_ox=Subtracted_current_single_cycle(Index_low_ox)*1e9;
    Subtracted_current_local_r1=Subtracted_current_single_cycle(Index_low_r1)*1e9*-1;
    Subtracted_current_local_r2=Subtracted_current_single_cycle(Index_low_r2)*1e9*-1;
    
   Peak_current_ox=max(Subtracted_current_local_ox);
   Peak_current_r1=max(Subtracted_current_local_r1);
   Peak_current_r2=max(Subtracted_current_local_r2);
   
    Peak_current_matrix_ox=[Peak_current_matrix_ox;Peak_current_ox];
    Peak_current_matrix_r1=[Peak_current_matrix_r1;Peak_current_r1];
    Peak_current_matrix_r2=[Peak_current_matrix_r2;Peak_current_r2];
    
    Subtracted_current_matrix=[Subtracted_current_matrix;Subtracted_current_single_cycle'];
    Subtracted_current_matrix_Plot=reshape(Subtracted_current_matrix', numel(Subtracted_current_matrix),1);
    
    Voltage_matrix=[Voltage_matrix;Voltage_single_cycle_DA'];
    Voltage_matrix_Plot=reshape(Voltage_matrix', numel(Voltage_matrix),1);

end

%%


figure('color','w','position',[66 107 1750 857]);
subplot(2,3,1)
%figure(1)
plot(Voltage_Matrix_Dopamine_Plot, Current_Matrix_Dopamine_Plot*10^9,'r-',Voltage_Matrix_PBS_Plot, Current_Matrix_PBS_Plot*10^9, 'b-','LineWidth',2 )
xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
    
    
    
%figure(2)    
subplot(2,3,2)
plot(Voltage_single_cycle_Dopamine', Average_current_Dopamine*10^9,'r',Voltage_single_cycle_PBS, Average_current_PBS*10^9, 'b','LineWidth',2 )
xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
Average=(Average_current_Dopamine*10^9)';
AveragePBS=(Average_current_PBS*10^9)';
D=diff(Average);
DPBS=diff(AveragePBS);
D2=diff(D);
DPBS2=(diff(DPBS));

%figure(3)
subplot(2,3,3)
plot(Voltage_single_cycle_Dopamine', Substrated_current*10^9,'r','LineWidth',2 )
xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
Sub=(Substrated_current*10^9)';


%figure(4)
subplot(2,3,4)
plot(Peak_current_matrix_ox,'r','LineWidth',2)
%ylim([0 100]);
xlabel('Number of samples','FontSize',15,'FontWeight','bold')
ylabel('Peak ox (nA)','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')

grid minor;

%figure(5)
subplot(2,3,5)
plot(Peak_current_matrix_r1,'r','LineWidth',2)
%ylim([0 100]);
xlabel('Number of samples','FontSize',15,'FontWeight','bold')
ylabel('Peak R1 (nA)','FontSize',15,'FontWeight','bold')

grid minor;


%figure(6)
subplot(2,3,6)

plot(Peak_current_matrix_r2,'r','LineWidth',2)
%ylim([0 100]);
xlabel('Number of samples','FontSize',15,'FontWeight','bold')
ylabel('Peak R2 (nA)','FontSize',15,'FontWeight','bold')

grid minor;


%%
figure('color','w','position',[66 107 1750 857]);
subplot(2,3,1)
%figure(1)
length_sub=length(Substrated_current);
Time=(1:length_sub)/length_sub*(Voltage_High-Voltage_Low)/Ramp_rate*2*1e3;
for i=1:N_cycle_DA
plot(Time, Current_Matrix_Dopamine(i,:)*10^9,'r','LineWidth',2)
hold on
end
for i=1:N_cycle_PBS
plot(Time, Current_Matrix_PBS(i,:)*10^9, 'b-','LineWidth',2)
hold on
end
xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
    
    
    
%figure(2)    
subplot(2,3,2)
plot(Time, Average_current_Dopamine*10^9,'r',Time, Average_current_PBS*10^9, 'b','LineWidth',2 )
xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
Average=(Average_current_Dopamine*10^9)';
AveragePBS=(Average_current_PBS*10^9)';
D=diff(Average);
DPBS=diff(AveragePBS);
D2=diff(D);
DPBS2=(diff(DPBS));

%figure(3)
subplot(2,3,3)
plot(Time, Substrated_current*10^9,'r','LineWidth',2 )
xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
Sub=(Substrated_current*10^9)';

%figure(4)
subplot(2,3,4)
plot(Voltage_single_cycle_PBS ,Time,'r','LineWidth',2 )
xlabel('FSCV voltage (V))','FontSize',15,'FontWeight','bold')
ylabel('Time (ms','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')

grid minor;
Sub=(Substrated_current*10^9)';

%-------------------------- heat map 
% %figure(4)
% subplot(2,2,4)
% Total_length=length(Peak_current_matrix_ox);
% Time_1=(1:Total_length)*1/FSCV_frequency;
% Current=sub_matrix'*10^9;
% [X,Y] = meshgrid(Time_1,Time);
% contourf(X,Y,Current,100,'lineStyle','none')
% colorbar
% c.Label.String = 'Label Text Goes Here';
% xlabel('Time (s)','FontSize',15,'FontWeight','bold')
% ylabel('Time single cycle (mS)','FontSize',15,'FontWeight','bold')
% zlabel('Electrochemical_current(na)','FontSize',15,'FontWeight','bold')

%-------------------------- 



% %figure(5)
% subplot(2,3,5)
% plot(Peak_current_matrix_r1,'r','LineWidth',2)
% %ylim([0 100]);
% xlabel('Number of samples','FontSize',15,'FontWeight','bold')
% ylabel('Peak R1 (nA)','FontSize',15,'FontWeight','bold')
% 
% grid minor;

%peak current versus time

%plot(Time_peak_current,Peak_current_matrix*10^9,'r','LineWidth',2)
% xlabel('Time (sec)','FontSize',15,'FontWeight','bold')
% ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
% grid minor;

% %figure(6)
% subplot(2,3,6)
% 
% plot(Peak_current_matrix_r2,'r','LineWidth',2)
% %ylim([0 100]);
% xlabel('Number of samples','FontSize',15,'FontWeight','bold')
% ylabel('Peak R2 (nA)','FontSize',15,'FontWeight','bold')
% 
% grid minor;
%% redox current versus time
% length_sub=length(Substrated_current);
% Time=(1:length_sub)/length_sub*(Voltage_High-Voltage_Low)/Ramp_rate*2*1e3;
% plot(Time, Substrated_current*10^9, 'r')
% %title(Device,'FontSize',15,'FontWeight','bold')
% xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
% ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')


%% making contour plot of the background subtracted current 
% 
% Time_Matrix=[];
% for i = 1:NumOfCycle-1  
% %  
%        One_Cycle_Index_sub=Peak_index(i)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index(i)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
%        Time_single_cycle=One_Cycle_Index_sub*length(One_Cycle_Index_sub)/20000;
%        Time_Matrix=[Time_Matrix; Time_single_cycle'];
%        Time_Matrix_Plot=reshape(Time_Matrix', numel(Time_Matrix),1);
% 
% end

% [X,Y,Z]=meshgrid(Time_Matrix_Plot,Voltage_matrix_Plot,Subtracted_current_matrix_Plot); 
% contourf(X,Y,Z,100,'lineStyle','none');

%%

summary=[Voltage_matrix,Subtracted_current_matrix];
fid=fopen('current_matrix1.txt','w');
fprintf(fid, 'Voltage\tPeak current\t\r\n');
[m,n]=size(summary);
for i=1:m
    fprintf(fid, '%f\t%f\t\r\n',summary(i,:));
end
fclose(fid);
%T=(Time)';


% dlmwrite('Voltage_Matrix_Dopamine_Plot_D4.csv',Voltage_Matrix_Dopamine_Plot);
% dlmwrite(' Current_Matrix_Dopamine_Plot_D4.csv', Current_Matrix_Dopamine_Plot*10^9);
% 
% dlmwrite('Voltage_Matrix_PBS_Plot_D4.csv',Voltage_Matrix_PBS_Plot);
% dlmwrite('Current_Matrix_PBS_Plot_D4.csv',Current_Matrix_PBS_Plot*10^9);
% 
% 
% dlmwrite('Voltage_single_cycle_Dopamine_D4.csv',Voltage_single_cycle_Dopamine');
% dlmwrite('Average_current_Dopamine_D4.csv',Average_current_Dopamine*10^9);
% dlmwrite('Voltage_single_cycle_PBS_D4.csv',Voltage_single_cycle_PBS);
% dlmwrite(' Average_current_PBS_D4.csv', Average_current_PBS*10^9);
% 
% dlmwrite('Time_peak_current_D4.csv',Time_peak_current);
% dlmwrite('Peak_current_matrix_D4.csv',Peak_current_matrix*10^9);
% 
%  dlmwrite('time_D4.csv',Time);
% dlmwrite('Substrated_current_D4.csv',Substrated_current);

    
