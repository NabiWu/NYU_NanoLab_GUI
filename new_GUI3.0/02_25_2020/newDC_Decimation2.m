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

% Last Modified by GUIDE v2.5 21-Feb-2020 18:39:09

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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newDC_Decimation2 (see VARARGIN)

% Choose default command line output for newDC_Decimation2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes newDC_Decimation2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = newDC_Decimation2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function OSR_Callback(hObject, eventdata, handles)
% hObject    handle to OSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OSR as text
%        str2double(get(hObject,'String')) returns contents of OSR as a double


% --- Executes during object creation, after setting all properties.
function OSR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OSR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fOut_Callback(hObject, eventdata, handles)
% hObject    handle to fOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fOut as text
%        str2double(get(hObject,'String')) returns contents of fOut as a double


% --- Executes during object creation, after setting all properties.
function fOut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ENOB_Callback(hObject, eventdata, handles)
% hObject    handle to ENOB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ENOB as text
%        str2double(get(hObject,'String')) returns contents of ENOB as a double


% --- Executes during object creation, after setting all properties.
function ENOB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ENOB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in Calibration.
function Calibration_Callback(hObject, eventdata, handles)
% hObject    handle to Calibration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


 firstTab = uitab(tg,'Title', 'Ch1 & Ch2 Prestreatment');
 axes('Parent',firstTab);
 tmp=subplot(2,3,1); 

    title("Ch1 V-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,2); 

    title("CH1 I-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Current (nA)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,3); 

    title("CH1 V-I Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,4); 

    title("Ch2 V-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,5); 

    title("CH2 I-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Current (nA)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,6); 

    title("CH2 V-I Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
  
    
 secondTab = uitab(tg,'Title', 'Ch3 & Ch4 Pretreatment');
 axes('Parent',secondTab);
tmp=subplot(2,3,1); 

    title("Ch3 V-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,2); 

    title("CH3 I-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Current (nA)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,3); 

    title("CH3 V-I Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,4); 

    title("Ch4 V-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,5); 

    title("CH4 I-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Current (nA)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,6); 

    title("CH4 V-I Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];

thirdTab = uitab(tg,'Title', 'Ch1 & Ch2 Realtime Measurement');
 axes('Parent',thirdTab);
 tmp=subplot(2,3,1); 

    title("Ch1 V-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,2); 

    title("CH1 I-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Current (nA)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,3); 

    title("CH1 V-I Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,4); 

    title("Ch2 V-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,5); 

    title("CH2 I-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Current (nA)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,6); 

    title("CH2 V-I Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];    
 
 fourthTab = uitab(tg,'Title', 'Ch3 & Ch4 Realtime Measurement');
 axes('Parent',fourthTab);
 tmp=subplot(2,3,1); 

    title("Ch3 V-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,2); 

    title("CH3 I-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Current (nA)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,3); 

    title("CH3 V-I Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,4); 

    title("Ch4 V-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,5); 

    title("CH4 I-t Plot",'Color', 'b','FontSize', 18) 
    xlabel('Current (nA)','FontSize', 14) 
    ylabel('t (s)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];
 tmp=subplot(2,3,6); 

    title("CH4 V-I Plot",'Color', 'b','FontSize', 18) 
    xlabel('Vcm voltage (v)','FontSize', 14) 
    ylabel('Current (nA)','FontSize', 14) 
    grid on;
    grid minor;
    handles.axes_total=[handles.axes_total tmp];

    
handles.p_Left1=[-17549.13; 30630.5];
handles.p_Right1=[-17549.13; 30630.5];
handles.p_Left2=[-17549.13; 30630.5];
handles.p_Right2=[-17549.13; 30630.5];


handles.RfeedBack_TIA2L1=4.1*(10^6);
handles.RfeedBack_TIA2R1=4.1*(10^6);
handles.RfeedBack_TIA2L2=4.1*(10^6);
handles.RfeedBack_TIA2R2=4.1*(10^6);
guidata(hObject, handles);


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


% --- Executes on button press in enableCH4.
function enableCH4_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif get(hObject,'Value') == 0
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
guidata(hObject,handles)


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


% --- Executes on button press in enableCH3.
function enableCH3_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif get(hObject,'Value') == 0
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
guidata(hObject,handles)


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


% --- Executes on button press in enableCH2.
function enableCH2_Callback(hObject, eventdata, handles)
if get(hObject,'Value') == 1
    
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),1,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
elseif get(hObject,'Value') == 0
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
guidata(hObject,handles)


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
elseif get(hObject,'Value') == 0
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
    success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),0,hex2dec('01'));
    calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
guidata(hObject,handles)



function editPeakVoltageCh4_Callback(hObject, eventdata, handles)
% hObject    handle to editPeakVoltageCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPeakVoltageCh4 as text
%        str2double(get(hObject,'String')) returns contents of editPeakVoltageCh4 as a double


% --- Executes during object creation, after setting all properties.
function editPeakVoltageCh4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPeakVoltageCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBottomVoltageCh4_Callback(hObject, eventdata, handles)
% hObject    handle to editBottomVoltageCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBottomVoltageCh4 as text
%        str2double(get(hObject,'String')) returns contents of editBottomVoltageCh4 as a double


% --- Executes during object creation, after setting all properties.
function editBottomVoltageCh4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBottomVoltageCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVcomCh4_Callback(hObject, eventdata, handles)
% hObject    handle to editVcomCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVcomCh4 as text
%        str2double(get(hObject,'String')) returns contents of editVcomCh4 as a double


% --- Executes during object creation, after setting all properties.
function editVcomCh4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVcomCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPeakVoltageCh3_Callback(hObject, eventdata, handles)
% hObject    handle to editPeakVoltageCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPeakVoltageCh3 as text
%        str2double(get(hObject,'String')) returns contents of editPeakVoltageCh3 as a double


% --- Executes during object creation, after setting all properties.
function editPeakVoltageCh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPeakVoltageCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBottomVoltageCh3_Callback(hObject, eventdata, handles)
% hObject    handle to editBottomVoltageCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBottomVoltageCh3 as text
%        str2double(get(hObject,'String')) returns contents of editBottomVoltageCh3 as a double


% --- Executes during object creation, after setting all properties.
function editBottomVoltageCh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBottomVoltageCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVcomCh3_Callback(hObject, eventdata, handles)
% hObject    handle to editVcomCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVcomCh3 as text
%        str2double(get(hObject,'String')) returns contents of editVcomCh3 as a double


% --- Executes during object creation, after setting all properties.
function editVcomCh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVcomCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPeakVoltageCh2_Callback(hObject, eventdata, handles)
% hObject    handle to editPeakVoltageCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPeakVoltageCh2 as text
%        str2double(get(hObject,'String')) returns contents of editPeakVoltageCh2 as a double


% --- Executes during object creation, after setting all properties.
function editPeakVoltageCh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPeakVoltageCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBottomVoltageCh2_Callback(hObject, eventdata, handles)
% hObject    handle to editBottomVoltageCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBottomVoltageCh2 as text
%        str2double(get(hObject,'String')) returns contents of editBottomVoltageCh2 as a double


% --- Executes during object creation, after setting all properties.
function editBottomVoltageCh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBottomVoltageCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVcomCh2_Callback(hObject, eventdata, handles)
% hObject    handle to editVcomCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVcomCh2 as text
%        str2double(get(hObject,'String')) returns contents of editVcomCh2 as a double


% --- Executes during object creation, after setting all properties.
function editVcomCh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVcomCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPeakVoltageCh1_Callback(hObject, eventdata, handles)
% hObject    handle to editPeakVoltageCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPeakVoltageCh1 as text
%        str2double(get(hObject,'String')) returns contents of editPeakVoltageCh1 as a double


% --- Executes during object creation, after setting all properties.
function editPeakVoltageCh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPeakVoltageCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBottomVoltageCh1_Callback(hObject, eventdata, handles)
% hObject    handle to editBottomVoltageCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBottomVoltageCh1 as text
%        str2double(get(hObject,'String')) returns contents of editBottomVoltageCh1 as a double


% --- Executes during object creation, after setting all properties.
function editBottomVoltageCh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBottomVoltageCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVcomCh1_Callback(hObject, eventdata, handles)
% hObject    handle to editVcomCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVcomCh1 as text
%        str2double(get(hObject,'String')) returns contents of editVcomCh1 as a double


% --- Executes during object creation, after setting all properties.
function editVcomCh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVcomCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFrequency_Callback(hObject, eventdata, handles)
% hObject    handle to editFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrequency as text
%        str2double(get(hObject,'String')) returns contents of editFrequency as a double


% --- Executes during object creation, after setting all properties.
function editFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editScanRate_Callback(hObject, eventdata, handles)
% hObject    handle to editScanRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editScanRate as text
%        str2double(get(hObject,'String')) returns contents of editScanRate as a double


% --- Executes during object creation, after setting all properties.
function editScanRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editScanRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MeasureStart.
function MeasureStart_Callback(hObject, eventdata, handles)
% hObject    handle to MeasureStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes_total(13),'reset')
cla(handles.axes_total(14),'reset')
cla(handles.axes_total(15),'reset')
cla(handles.axes_total(16),'reset')
cla(handles.axes_total(17),'reset')
cla(handles.axes_total(18),'reset')
cla(handles.axes_total(19),'reset')
cla(handles.axes_total(20),'reset')
cla(handles.axes_total(21),'reset')
cla(handles.axes_total(22),'reset')
cla(handles.axes_total(23),'reset')
cla(handles.axes_total(24),'reset')

Frequency = str2num(get(handles.editFrequency,'String'));
Period= 1/Frequency;
ScanRate=str2num(get(handles.editScanRate,'String'));
ch1Vr_H=str2num(get(handles.editPeakVoltageCh1,'String'));
ch1Vr_L=str2num(get(handles.editBottomVoltageCh1,'String'));
ch1Vcom=str2num(get(handles.editVcomCh1,'String'));

ch2Vr_H=str2num(get(handles.editPeakVoltageCh2,'String'));
ch2Vr_L=str2num(get(handles.editBottomVoltageCh2,'String'));
ch2Vcom=str2num(get(handles.editVcomCh2,'String'));

ch3Vr_H=str2num(get(handles.editPeakVoltageCh3,'String'));
ch3Vr_L=str2num(get(handles.editBottomVoltageCh3,'String'));
ch3Vcom=str2num(get(handles.editVcomCh3,'String'));

ch4Vr_H=str2num(get(handles.editPeakVoltageCh4,'String'));
ch4Vr_L=str2num(get(handles.editBottomVoltageCh4,'String'));
ch4Vcom=str2num(get(handles.editVcomCh4,'String'));

measDuration = str2num(get(handles.measDuration,'String'));
RfeedBack=[handles.RfeedBack_TIA2L1 handles.RfeedBack_TIA2R1 handles.RfeedBack_TIA2L2 handles.RfeedBack_TIA2R2];

%BTPIPEOUT

tolerance_range=0.9;
N_ok=5; 
 
cycle=147*measDuration;


FIFO_size=4096;%32bit 
blocksize=16384;%byte
Unit_length= (4*FIFO_size);

handles.data_L1=[];
handles.data_R1=[];
handles.current_L1=[];
handles.current_R1=[];

handles.data_L2=[];
handles.data_R2=[];
handles.current_L2=[];
handles.current_R2=[];

length_Total=cycle*Unit_length; 
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
ENOB=handles.ENOB;
N_window=2;
Plot_Ylimit=2;

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

success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'), 1,hex2dec('01')); 
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem); 
pause(1/handles.Fout); 
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'), 0,hex2dec('01')); 
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
pause(20/handles.Fout);  

disp("initialize done");

for i= 1:cycle
    pause(delay-t);
    tic
    
    ch1lowerVol = str2num(get(handles.lowerVolch1meas,'String'));
    ch1upperVol = str2num(get(handles.upperVolch1meas,'String'));
    ch1lowerCur = str2num(get(handles.lowerCurch1meas,'String'));
    ch1upperCur = str2num(get(handles.upperCurch1meas,'String'));
    
    ch2lowerVol = str2num(get(handles.lowerVolch2meas,'String'));
    ch2upperVol = str2num(get(handles.upperVolch2meas,'String'));
    ch2lowerCur = str2num(get(handles.lowerCurch2meas,'String'));
    ch2upperCur = str2num(get(handles.upperCurch2meas,'String'));
    
    ch3lowerVol = str2num(get(handles.lowerVolch3meas,'String'));
    ch3upperVol = str2num(get(handles.upperVolch3meas,'String'));
    ch3lowerCur = str2num(get(handles.lowerCurch3meas,'String'));
    ch3upperCur = str2num(get(handles.upperCurch3meas,'String'));
    
    ch4lowerVol = str2num(get(handles.lowerVolch4meas,'String'));
    ch4upperVol = str2num(get(handles.upperVolch4meas,'String'));
    ch4lowerCur = str2num(get(handles.lowerCurch4meas,'String'));
    ch4upperCur = str2num(get(handles.upperCurch4meas,'String'));
    
    ifmod2 = mod(i,50);
    if(ifmod2 == 0)
        cla(handles.axes_total(13),'reset')
        cla(handles.axes_total(14),'reset')
        cla(handles.axes_total(15),'reset')
        cla(handles.axes_total(16),'reset')
        cla(handles.axes_total(17),'reset')
        cla(handles.axes_total(18),'reset')
        cla(handles.axes_total(19),'reset')
        cla(handles.axes_total(20),'reset')
        cla(handles.axes_total(21),'reset')
        cla(handles.axes_total(22),'reset')
        cla(handles.axes_total(23),'reset')
        cla(handles.axes_total(24),'reset')
    end
    
    handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize, Unit_length, pv_A0);
    epvalue_A0 = get(pv_A0, 'value');
    
    handles.BTpipeOut_A1=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A1'), blocksize, Unit_length, pv_A1);
    epvalue_A1 = get(pv_A1, 'value');
    
    handles.BTpipeOut_A2=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A2'), blocksize, Unit_length, pv_A2);
    epvalue_A2 = get(pv_A2, 'value');
    tmp_A2 = get(pv_A2, 'value');

    handles.BTpipeOut_A3=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A3'), blocksize, Unit_length, pv_A3);
    epvalue_A3 = get(pv_A3, 'value');
    tmp_A3 = get(pv_A3, 'value');

    
   
    
    data_tmp_L1 = floor((double(epvalue_A0(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A0(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
    data_tmp_L1 = (data_tmp_L1-handles.p_Left1(2))/(handles.p_Left1(1));
    handles.data_L1=[handles.data_L1; data_tmp_L1];
    current_tmp_L1=(data_tmp_L1-ch1Vcom)/(RfeedBack(1));
    handles.current_L1=[handles.current_L1; current_tmp_L1];
    data_cycle_L1=[data_cycle_L1; data_tmp_L1];

    
    data_tmp_R1 = floor((double(epvalue_A1(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A1(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
    data_tmp_R1 = (data_tmp_R1-handles.p_Right1(2))/(handles.p_Right1(1));
    handles.data_R1=[handles.data_R1; data_tmp_R1];
    current_tmp_R1=(data_tmp_R2-ch2Vcom)/(RfeedBack(2));
    handles.current_R1=[handles.current_R1; current_tmp_R1];
    data_cycle_R1=[data_cycle_R1; data_tmp_R1];
                                                            
    data_tmp_L2 = floor((double(epvalue_A2(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A2(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
    data_tmp_L2 = (data_tmp_L2-handles.p_Left2(2))/(handles.p_Left2(1));
    handles.data_L2=[handles.data_L2; data_tmp_L2];
    current_tmp_L2=(data_tmp_L2-ch3Vcom)/(RfeedBack(3));
    handles.current_L2=[handles.current_L2; current_tmp_L2];
    data_cycle_L2=[data_cycle_L2; data_tmp_L2];
    
    
    data_tmp_R2 = floor((double(epvalue_A3(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A3(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
    data_tmp_R2 = (data_tmp_R2-handles.p_Right2(2))/(handles.p_Right2(1));
    handles.data_R2=[handles.data_R2; data_tmp_R2];
    current_tmp_R2=(data_tmp_R2-ch4Vcom)/(RfeedBack(4));
    handles.current_R2=[handles.current_R2; current_tmp_R2];
    data_cycle_R2=[data_cycle_R2; data_tmp_R2];


    tmp0 = round(((i-1)-mod((i-1),N_window))/N_window)+1;
    
    
    plot(handles.axes_total(13),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L1)
    axis(handles.axes_total(13),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
    title(handles.axes_total(13),'t vs v (Ch1)','Color', 'b') 
    xlabel(handles.axes_total(13),'time (s)')
    ylabel(handles.axes_total(13),'voltage (v)')
    hold(handles.axes_total(13),'on')
    
    plot(handles.axes_total(16),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R1)
    axis(handles.axes_total(16),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
    title(handles.axes_total(16),'t vs v (Ch2)','Color', 'b')
    xlabel(handles.axes_total(16),'time (s)')
    ylabel(handles.axes_total(16),'voltage (v)')
    hold(handles.axes_total(16),'on')
    
    plot(handles.axes_total(14),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L1*(10^9))
    axis(handles.axes_total(14),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
    title(handles.axes_total(14),'t vs i (Ch1)','Color', 'b')
    xlabel(handles.axes_total(14),'time (s)')
    ylabel(handles.axes_total(14),'current (nA)')
    hold(handles.axes_total(14),'on')
    
    plot(handles.axes_total(17),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R1*(10^9))
    axis(handles.axes_total(17),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
    title(handles.axes_total(17),'t vs i (Ch2)','Color', 'b')
    xlabel(handles.axes_total(17),'time (s)')
    ylabel(handles.axes_total(17),'current (nA)')
    hold(handles.axes_total(17),'on')
    
    
    plot(handles.axes_total(19),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
    axis(handles.axes_total(19),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
    title(handles.axes_total(19),'t vs v (Ch3)','Color', 'b') 
    xlabel(handles.axes_total(19),'time (s)')
    ylabel(handles.axes_total(19),'voltage (v)')
    hold(handles.axes_total(19),'on')
    
    plot(handles.axes_total(22),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
    axis(handles.axes_total(22),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
    title(handles.axes_total(22),'t vs v (Ch4)','Color', 'b')
    xlabel(handles.axes_total(22),'time (s)')
    ylabel(handles.axes_total(22),'voltage (v)')
    hold(handles.axes_total(22),'on')
    
    plot(handles.axes_total(20),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L2*(10^9))
    axis(handles.axes_total(20),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
    title(handles.axes_total(20),'t vs i (Ch3)','Color', 'b')
    xlabel(handles.axes_total(20),'time (s)')
    ylabel(handles.axes_total(20),'current (nA)')
    hold(handles.axes_total(20),'on')
    
    plot(handles.axes_total(23),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R2*(10^9))
    axis(handles.axes_total(23),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
    title(handles.axes_total(23),'t vs i (Ch4)','Color', 'b')
    xlabel(handles.axes_total(23),'time (s)')
    ylabel(handles.axes_total(23),'current (nA)')
    hold(handles.axes_total(23),'on')
   
    
    ifmod = mod(i,15);
    if(ifmod == 0)
        [data_FSCV_L1, N_L1]=FSCV_cycle_v2(data_cycle_L1, handles.Fout, Period, ScanRate, ch1Vr_H, ch1Vr_L, tolerance_range, N_ok, handles.p_Left1);
        [data_FSCV_R1, N_R1]=FSCV_cycle_v2(data_cycle_R1, handles.Fout, Period, ScanRate, ch2Vr_H, ch2Vr_L, tolerance_range, N_ok, handles.p_Right1);
        [data_FSCV_L2, N_L2]=FSCV_cycle_v2(data_cycle_L2, handles.Fout, Period, ScanRate, ch3Vr_H, ch3Vr_L, tolerance_range, N_ok, handles.p_Left2);
        [data_FSCV_R2, N_R2]=FSCV_cycle_v2(data_cycle_R2, handles.Fout, Period, ScanRate, ch4Vr_H, ch4Vr_L, tolerance_range, N_ok, handles.p_Right2);
        
        
        if length(data_FSCV_L1)==0
            imp_L1=zeros(1,(2*N_L1+1));
        else
            imp_L1=(((mean(data_FSCV_L1')-0)/(1))-ch1Vcom)/(RfeedBack(1));
        end
        if length(data_FSCV_R1)==0
            imp_R1=zeros(1,(2*N_R1+1));
        else
            imp_R1=(((mean(data_FSCV_R1')-0)/(1))-ch2Vcom)/(RfeedBack(2));
        end
        
        if length(data_FSCV_L2)==0
            imp_L2=zeros(1,(2*N_L2+1));
        else
            imp_L2=(((mean(data_FSCV_L2')-0)/(1))-ch3Vcom)/(RfeedBack(1));
        end
        if length(data_FSCV_R2)==0
            imp_R2=zeros(1,(2*N_R2+1));
        else
            imp_R2=(((mean(data_FSCV_R2')-0)/(1))-ch4Vcom)/(RfeedBack(2));
        end


        Xaxes_L1=[(((0:(N_L1-1))*((ch1Vr_H-ch1Vr_L)/N_L1))+ch1Vr_L) ch1Vr_H ((((N_L1-1):(-1):0)*((ch1Vr_H-ch1Vr_L)/N_L1))+ch1Vr_L)];
        Xaxes_R1=[(((0:(N_R1-1))*((ch2Vr_H-ch2Vr_L)/N_R1))+ch2Vr_L) ch2Vr_H ((((N_R1-1):(-1):0)*((ch2Vr_H-ch2Vr_L)/N_R1))+ch2Vr_L)];
        Xaxes_L2=[(((0:(N_L2-1))*((ch3Vr_H-ch3Vr_L)/N_L2))+ch3Vr_L) ch3Vr_H ((((N_L2-1):(-1):0)*((ch3Vr_H-ch3Vr_L)/N_L2))+ch3Vr_L)];
        Xaxes_R2=[(((0:(N_R2-1))*((ch4Vr_H-ch4Vr_L)/N_R2))+ch4Vr_L) ch4Vr_H ((((N_R2-1):(-1):0)*((ch4Vr_H-ch4Vr_L)/N_R2))+ch4Vr_L)];
        
        
        plot(handles.axes_total(15),Xaxes_L1,imp_L1*(10^9))
        axis(handles.axes_total(15),[ch1lowerVol ch1upperVol ch1lowerCur ch1upperCur])
        title(handles.axes_total(15),'v vs i (Ch1)','Color', 'b')
        xlabel(handles.axes_total(15),'FSCV VCM (V)')
        ylabel(handles.axes_total(15),'Input Current (nA)')

        plot(handles.axes_total(18),Xaxes_R1,imp_R1*(10^9))
        axis(handles.axes_total(18),[ch1lowerVol ch1upperVol ch1lowerCur ch1upperCur])
        title(handles.axes_total(18),'v vs i (Ch2)','Color', 'b')
        xlabel(handles.axes_total(18),'FSCV VCM (V)')
        ylabel(handles.axes_total(18),'Input Current (nA)')
        
        plot(handles.axes_total(21),Xaxes_L2,imp_L2*(10^9))
        axis(handles.axes_total(21),[ch1lowerVol ch1upperVol ch1lowerCur ch1upperCur])
        title(handles.axes_total(21),'v vs i (Ch3)','Color', 'b')
        xlabel(handles.axes_total(21),'FSCV VCM (V)')
        ylabel(handles.axes_total(21),'Input Current (nA)')

        plot(handles.axes_total(24),Xaxes_R2,imp_R2*(10^9))
        axis(handles.axes_total(24),[ch1lowerVol ch1upperVol ch1lowerCur ch1upperCur])
        title(handles.axes_total(24),'v vs i (Ch4)','Color', 'b')
        xlabel(handles.axes_total(24),'FSCV VCM (V)')
        ylabel(handles.axes_total(24),'Input Current (nA)')
        
        
        ch1voltageArray = Xaxes_L1;
        ch2voltageArray = Xaxes_R1;
        ch3voltageArray = Xaxes_L2;
        ch4voltageArray = Xaxes_R2;

        ch1n = ceil(numel(ch1voltageArray)/2);
        ch1firstHalfVol = ch1voltageArray(1:ch1n);
        ch1secondHalfVol = ch1voltageArray(ch1n+1:end);
        ch2n = ceil(numel(ch2voltageArray)/2);
        ch2firstHalfVol = ch2voltageArray(1:ch2n);
        ch2secondHalfVol = ch2voltageArray(ch2n+1:end);
        ch3n = ceil(numel(ch3voltageArray)/2);
        ch3firstHalfVol = ch3voltageArray(1:ch3n);
        ch3secondHalfVol = ch3voltageArray(ch3n+1:end);
        ch4n = ceil(numel(ch4voltageArray)/2);
        ch4firstHalfVol = ch4voltageArray(1:ch4n);
        ch4secondHalfVol = ch4voltageArray(ch4n+1:end);
        

        preCh1v1 = str2num(get(handles.Ch1v1,'String'));
        preCh1v2 = str2num(get(handles.Ch1v2,'String'));
        preCh1v3 = str2num(get(handles.Ch1v3,'String'));
        preCh1v4 = str2num(get(handles.Ch1v4,'String'));
        preCh2v1 = str2num(get(handles.Ch2v1,'String'));
        preCh2v2 = str2num(get(handles.Ch2v2,'String'));
        preCh2v3 = str2num(get(handles.Ch2v3,'String'));
        preCh2v4 = str2num(get(handles.Ch2v4,'String'));
        preCh3v1 = str2num(get(handles.Ch3v1,'String'));
        preCh3v2 = str2num(get(handles.Ch3v2,'String'));
        preCh3v3 = str2num(get(handles.Ch3v3,'String'));
        preCh3v4 = str2num(get(handles.Ch3v4,'String'));
        preCh4v1 = str2num(get(handles.Ch4v1,'String'));
        preCh4v2 = str2num(get(handles.Ch4v2,'String'));
        preCh4v3 = str2num(get(handles.Ch4v3,'String'));
        preCh4v4 = str2num(get(handles.Ch4v4,'String'));
        
        

        [ch1val1,ch1idx1]=min(abs(preCh1v1-ch1firstHalfVol));
        [ch1val2,ch1idx2]=min(abs(preCh1v2-ch1firstHalfVol));
        [ch1val3,ch1idx3]=min(abs(preCh1v3-ch1secondHalfVol));
        [ch1val4,ch1idx4]=min(abs(preCh1v4-ch1secondHalfVol));
        [ch2val1,ch2idx1]=min(abs(preCh2v1-ch2firstHalfVol));
        [ch2val2,ch2idx2]=min(abs(preCh2v2-ch2firstHalfVol));
        [ch2val3,ch2idx3]=min(abs(preCh2v3-ch2secondHalfVol));
        [ch2val4,ch2idx4]=min(abs(preCh2v4-ch2secondHalfVol));
        [ch3val1,ch3idx1]=min(abs(preCh3v1-ch3firstHalfVol));
        [ch3val2,ch3idx2]=min(abs(preCh3v2-ch3firstHalfVol));
        [ch3val3,ch3idx3]=min(abs(preCh3v3-ch3secondHalfVol));
        [ch3val4,ch3idx4]=min(abs(preCh3v4-ch3secondHalfVol));
        [ch4val1,ch4idx1]=min(abs(preCh4v1-ch4firstHalfVol));
        [ch4val2,ch4idx2]=min(abs(preCh4v2-ch4firstHalfVol));
        [ch4val3,ch4idx3]=min(abs(preCh4v3-ch4secondHalfVol));
        [ch4val4,ch4idx4]=min(abs(preCh4v4-ch4secondHalfVol));

        ch1vol1idx = ch1idx1;
        ch1vol2idx = ch1idx2;
        ch1vol3idx = ch1idx3+length(ch1firstHalfVol);
        ch1vol4idx = ch1idx4+length(ch1firstHalfVol);
        ch2vol1idx = ch2idx1;
        ch2vol2idx = ch2idx2;
        ch2vol3idx = ch2idx3+length(ch2firstHalfVol);
        ch2vol4idx = ch2idx4+length(ch2firstHalfVol);
        ch3vol1idx = ch3idx1;
        ch3vol2idx = ch3idx2;
        ch3vol3idx = ch3idx3+length(ch3firstHalfVol);
        ch3vol4idx = ch3idx4+length(ch3firstHalfVol);
        ch4vol1idx = ch4idx1;
        ch4vol2idx = ch4idx2;
        ch4vol3idx = ch4idx3+length(ch4firstHalfVol);
        ch4vol4idx = ch4idx4+length(ch4firstHalfVol);


        ch1I1p = imp_L1(ch1vol1idx);
        ch1I2p = imp_L1(ch1vol2idx);
        ch1I3b = imp_L1(ch1vol3idx);
        ch1I4b = imp_L1(ch1vol4idx);
        ch2I1p = imp_R1(ch2vol1idx);
        ch2I2p = imp_R1(ch2vol2idx);
        ch2I3b = imp_R1(ch2vol3idx);
        ch2I4b = imp_R1(ch2vol4idx);
        ch3I1p = imp_L2(ch3vol1idx);
        ch3I2p = imp_L2(ch3vol2idx);
        ch3I3b = imp_L2(ch3vol3idx);
        ch3I4b = imp_L2(ch3vol4idx);
        ch4I1p = imp_R2(ch4vol1idx);
        ch4I2p = imp_R2(ch4vol2idx);
        ch4I3b = imp_R2(ch4vol3idx);
        ch4I4b = imp_R2(ch4vol4idx);
        

        set(handles.mch1I1p, 'String', ch1I1p*(10^9));
        set(handles.mch1I2p, 'String', ch1I2p*(10^9));
        set(handles.mch1I3b, 'String', ch1I3b*(10^9));
        set(handles.mch1I4b, 'String', ch1I4b*(10^9));
        set(handles.mch2I1p, 'String', ch2I1p*(10^9));
        set(handles.mch2I2p, 'String', ch2I2p*(10^9));
        set(handles.mch2I3b, 'String', ch2I3b*(10^9));
        set(handles.mch2I4b, 'String', ch2I4b*(10^9));
        set(handles.mch3I1p, 'String', ch3I1p*(10^9));
        set(handles.mch3I2p, 'String', ch3I2p*(10^9));
        set(handles.mch3I3b, 'String', ch3I3b*(10^9));
        set(handles.mch3I4b, 'String', ch3I4b*(10^9));
        set(handles.mch4I1p, 'String', ch4I1p*(10^9));
        set(handles.mch4I2p, 'String', ch4I2p*(10^9));
        set(handles.mch4I3b, 'String', ch4I3b*(10^9));
        set(handles.mch4I4b, 'String', ch4I4b*(10^9));
        
        

    end  
    
    t = toc;
    ifmod3 = mod(i,100);
    if(ifmod3 == 0)
        disp(i)
        disp(toc)
        disp(t)
    end

end
disp('finished loop')
L1Vol = handles.data_L1;
arrayname = 'L1Vol';
fid = fopen(handles.name1Vol, 'w'); 
fclose(fid)
save(handles.name1Vol, arrayname,'-ascii', '-double', '-append');

R1Vol = handles.data_R1;
arrayname = 'R1Vol';
fid = fopen(handles.name1Vol, 'w'); 
fclose(fid)
save(handles.name2Vol, arrayname,'-ascii', '-double', '-append');

L2Vol = handles.data_L2;
arrayname = 'L2Vol';
fid = fopen(handles.name3Vol, 'w'); 
fclose(fid)
save(handles.name3Vol, arrayname,'-ascii', '-double', '-append');

R2Vol = handles.data_R2;
arrayname = 'R2Vol';
fid = fopen(handles.name4Vol, 'w'); 
fclose(fid)
save(handles.name4Vol, arrayname,'-ascii', '-double', '-append');
disp('finish save file')

hold(handles.axes_total(13),'off')
hold(handles.axes_total(14),'off')
hold(handles.axes_total(15),'off')
hold(handles.axes_total(16),'off')
hold(handles.axes_total(17),'off')
hold(handles.axes_total(18),'off')
hold(handles.axes_total(19),'off')
hold(handles.axes_total(20),'off')
hold(handles.axes_total(21),'off')
hold(handles.axes_total(22),'off')
hold(handles.axes_total(23),'off')
hold(handles.axes_total(24),'off')

guidata(hObject, handles);



% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

L1Vol = handles.data_L1;
arrayname = 'L1Vol';
fid = fopen(handles.name1Vol, 'w'); 
fclose(fid)
save(handles.name1Vol, arrayname,'-ascii', '-double', '-append');

R1Vol = handles.data_R1;
arrayname = 'R1Vol';
fid = fopen(handles.name1Vol, 'w'); 
fclose(fid)
save(handles.name2Vol, arrayname,'-ascii', '-double', '-append');

L2Vol = handles.data_L2;
arrayname = 'L2Vol';
fid = fopen(handles.name3Vol, 'w'); 
fclose(fid)
save(handles.name3Vol, arrayname,'-ascii', '-double', '-append');

R2Vol = handles.data_R2;
arrayname = 'R2Vol';
fid = fopen(handles.name4Vol, 'w'); 
fclose(fid)
save(handles.name4Vol, arrayname,'-ascii', '-double', '-append');


function measDuration_Callback(hObject, eventdata, handles)
% hObject    handle to measDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of measDuration as text
%        str2double(get(hObject,'String')) returns contents of measDuration as a double


% --- Executes during object creation, after setting all properties.
function measDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to measDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFrequencyPre_Callback(hObject, eventdata, handles)
% hObject    handle to editFrequencyPre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrequencyPre as text
%        str2double(get(hObject,'String')) returns contents of editFrequencyPre as a double


% --- Executes during object creation, after setting all properties.
function editFrequencyPre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrequencyPre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editScanRatePre_Callback(hObject, eventdata, handles)
% hObject    handle to editScanRatePre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editScanRatePre as text
%        str2double(get(hObject,'String')) returns contents of editScanRatePre as a double


% --- Executes during object creation, after setting all properties.
function editScanRatePre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editScanRatePre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PretreatStart.
function PretreatStart_Callback(hObject, eventdata, handles)
% hObject    handle to PretreatStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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

Frequency = str2num(get(handles.editFrequencyPre,'String'));
Period= 1/Frequency;
ScanRate=str2num(get(handles.editScanRatePre,'String'));
ch1Vr_H=str2num(get(handles.editPeakVoltageCh1,'String'));
ch1Vr_L=str2num(get(handles.editBottomVoltageCh1,'String'));
ch1Vcom=str2num(get(handles.editVcomCh1,'String'));

ch2Vr_H=str2num(get(handles.editPeakVoltageCh2,'String'));
ch2Vr_L=str2num(get(handles.editBottomVoltageCh2,'String'));
ch2Vcom=str2num(get(handles.editVcomCh2,'String'));

ch3Vr_H=str2num(get(handles.editPeakVoltageCh3,'String'));
ch3Vr_L=str2num(get(handles.editBottomVoltageCh3,'String'));
ch3Vcom=str2num(get(handles.editVcomCh3,'String'));

ch4Vr_H=str2num(get(handles.editPeakVoltageCh4,'String'));
ch4Vr_L=str2num(get(handles.editBottomVoltageCh4,'String'));
ch4Vcom=str2num(get(handles.editVcomCh4,'String'));

pretreatDuration = str2num(get(handles.pretreatDuration,'String'));




RfeedBack=[handles.RfeedBack_TIA2L1 handles.RfeedBack_TIA2R1 handles.RfeedBack_TIA2L2 handles.RfeedBack_TIA2R2];

   

%BTPIPEOUT

tolerance_range=0.9;
N_ok=5; 
 
cycle=147*pretreatDuration;


FIFO_size=4096;%32bit 
blocksize=16384;%byte
Unit_length= (4*FIFO_size);

handles.data_L1=[];
handles.data_R1=[];
handles.current_L1=[];
handles.current_R1=[];

handles.data_L2=[];
handles.data_R2=[];
handles.current_L2=[];
handles.current_R2=[];



length_Total=cycle*Unit_length; 
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

ENOB=handles.ENOB;
N_window=2;
Plot_Ylimit=2;

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

ch1cursorCur = [];
ch2cursorCur = [];
ch3cursorCur = [];
ch4cursorCur = [];

ch1CurSlop = [];
ch2CurSlop = [];
ch3CurSlop = [];
ch4CurSlop = [];


success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'), 1,hex2dec('01')); 
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem); 
pause(1/handles.Fout); 
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'), 0,hex2dec('01')); 
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
pause(20/handles.Fout);  

disp("initialize done");


for i= 1:cycle
    pause(delay-t);
    tic
    
    ch1lowerVol = str2num(get(handles.lowerVolch1,'String'));
    ch1upperVol = str2num(get(handles.upperVolch1,'String'));
    ch1lowerCur = str2num(get(handles.lowerCurch1,'String'));
    ch1upperCur = str2num(get(handles.upperCurch1,'String'));
    
    ch2lowerVol = str2num(get(handles.lowerVolch2,'String'));
    ch2upperVol = str2num(get(handles.upperVolch2,'String'));
    ch2lowerCur = str2num(get(handles.lowerCurch2,'String'));
    ch2upperCur = str2num(get(handles.upperCurch2,'String'));
    
    ch3lowerVol = str2num(get(handles.lowerVolch3,'String'));
    ch3upperVol = str2num(get(handles.upperVolch3,'String'));
    ch3lowerCur = str2num(get(handles.lowerCurch3,'String'));
    ch3upperCur = str2num(get(handles.upperCurch3,'String'));
    
    ch4lowerVol = str2num(get(handles.lowerVolch4,'String'));
    ch4upperVol = str2num(get(handles.upperVolch4,'String'));
    ch4lowerCur = str2num(get(handles.lowerCurch4,'String'));
    ch4upperCur = str2num(get(handles.upperCurch4,'String'));
    
    ifmod2 = mod(i,100);
    if(ifmod2 == 0)
        cla(handles.axes_total(1),'reset')
        cla(handles.axes_total(2),'reset')
        cla(handles.axes_total(3),'reset')
        cla(handles.axes_total(4),'reset')
        cla(handles.axes_total(5),'reset')
        cla(handles.axes_total(6),'reset')
        cla(handles.axes_total(7),'reset')
        cla(handles.axes_total(8),'reset')
        cla(handles.axes_total(9),'reset')
        cla(handles.axes_total(10),'reset')
        cla(handles.axes_total(11),'reset')
        cla(handles.axes_total(12),'reset')
    end
    
    handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize, Unit_length, pv_A0);
    epvalue_A0 = get(pv_A0, 'value');
    
    handles.BTpipeOut_A1=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A1'), blocksize, Unit_length, pv_A1);
    epvalue_A1 = get(pv_A1, 'value');
    
    handles.BTpipeOut_A2=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A2'), blocksize, Unit_length, pv_A2);
    epvalue_A2 = get(pv_A2, 'value');
    tmp_A2 = get(pv_A2, 'value');

    handles.BTpipeOut_A3=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A3'), blocksize, Unit_length, pv_A3);
    epvalue_A3 = get(pv_A3, 'value');
    tmp_A3 = get(pv_A3, 'value');

    
   
    
    data_tmp_L1 = floor((double(epvalue_A0(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A0(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
    data_tmp_L1 = (data_tmp_L1-handles.p_Left1(2))/(handles.p_Left1(1));
    handles.data_L1=[handles.data_L1; data_tmp_L1];
    current_tmp_L1=(data_tmp_L1-ch1Vcom)/(RfeedBack(1));
    handles.current_L1=[handles.current_L1; current_tmp_L1];
    data_cycle_L1=[data_cycle_L1; data_tmp_L1];
    
    
    data_tmp_R1 = floor((double(epvalue_A1(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A1(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
    data_tmp_R1 = (data_tmp_R1-handles.p_Right1(2))/(handles.p_Right1(1));
    handles.data_R1=[handles.data_R1; data_tmp_R1];
    current_tmp_R1=(data_tmp_R2-ch2Vcom)/(RfeedBack(2));
    handles.current_R1=[handles.current_R1; current_tmp_R1];
    data_cycle_R1=[data_cycle_R1; data_tmp_R1];
                                                            
    data_tmp_L2 = floor((double(epvalue_A2(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A2(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
    data_tmp_L2 = (data_tmp_L2-handles.p_Left2(2))/(handles.p_Left2(1));
    handles.data_L2=[handles.data_L2; data_tmp_L2];
    current_tmp_L2=(data_tmp_L2-ch3Vcom)/(RfeedBack(3));
    handles.current_L2=[handles.current_L2; current_tmp_L2];
    data_cycle_L2=[data_cycle_L2; data_tmp_L2];
    
    
    data_tmp_R2 = floor((double(epvalue_A3(1:4:(4*(FIFO_size-2)+1)))+256*double(epvalue_A3(2:4:(4*(FIFO_size-2)+2))))/(2^(16-ENOB)));
    data_tmp_R2 = (data_tmp_R2-handles.p_Right2(2))/(handles.p_Right2(1));
    handles.data_R2=[handles.data_R2; data_tmp_R2];
    current_tmp_R2=(data_tmp_R2-ch4Vcom)/(RfeedBack(4));
    handles.current_R2=[handles.current_R2; current_tmp_R2];
    data_cycle_R2=[data_cycle_R2; data_tmp_R2];


    tmp0 = round(((i-1)-mod((i-1),N_window))/N_window)+1;
    
    
    plot(handles.axes_total(1),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L1)
    axis(handles.axes_total(1),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
    title(handles.axes_total(1),'t vs v (Ch1)','Color', 'b') 
    xlabel(handles.axes_total(1),'time (s)')
    ylabel(handles.axes_total(1),'voltage (v)')
    hold(handles.axes_total(1),'on')
    
    plot(handles.axes_total(4),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R1)
    axis(handles.axes_total(4),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
    title(handles.axes_total(4),'t vs v (Ch2)','Color', 'b')
    xlabel(handles.axes_total(4),'time (s)')
    ylabel(handles.axes_total(4),'voltage (v)')
    hold(handles.axes_total(4),'on')
    
    plot(handles.axes_total(2),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L1*(10^9))
    axis(handles.axes_total(2),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
    title(handles.axes_total(2),'t vs i (Ch1)','Color', 'b')
    xlabel(handles.axes_total(2),'time (s)')
    ylabel(handles.axes_total(2),'current (nA)')
    hold(handles.axes_total(2),'on')
    
    plot(handles.axes_total(5),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R1*(10^9))
    axis(handles.axes_total(5),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -inf inf])
    title(handles.axes_total(5),'t vs i (Ch2)','Color', 'b')
    xlabel(handles.axes_total(5),'time (s)')
    ylabel(handles.axes_total(5),'current (nA)')
    hold(handles.axes_total(5),'on')
    
    
    plot(handles.axes_total(7),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
    axis(handles.axes_total(7),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
    title(handles.axes_total(7),'t vs v (Ch3)','Color', 'b') 
    xlabel(handles.axes_total(7),'time (s)')
    ylabel(handles.axes_total(7),'voltage (v)')
    hold(handles.axes_total(7),'on')
    
    plot(handles.axes_total(10),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
    axis(handles.axes_total(10),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
    title(handles.axes_total(10),'t vs v (Ch4)','Color', 'b')
    xlabel(handles.axes_total(10),'time (s)')
    ylabel(handles.axes_total(10),'voltage (v)')
    hold(handles.axes_total(10),'on')
    
    plot(handles.axes_total(8),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_L2*(10^9))
    axis(handles.axes_total(8),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
    title(handles.axes_total(8),'t vs i (Ch3)','Color', 'b')
    xlabel(handles.axes_total(8),'time (s)')
    ylabel(handles.axes_total(8),'current (nA)')
    hold(handles.axes_total(8),'on')
    
    plot(handles.axes_total(11),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),current_tmp_R2*(10^9))
    axis(handles.axes_total(11),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -350 350])
    title(handles.axes_total(11),'t vs i (Ch4)','Color', 'b')
    xlabel(handles.axes_total(11),'time (s)')
    ylabel(handles.axes_total(11),'current (nA)')
    hold(handles.axes_total(11),'on')
   
    
    ifmod = mod(i,15);
    if(ifmod == 0)
        [data_FSCV_L1, N_L1]=FSCV_cycle_v2(data_cycle_L1, handles.Fout, Period, ScanRate, ch1Vr_H, ch1Vr_L, tolerance_range, N_ok, handles.p_Left1);
        [data_FSCV_R1, N_R1]=FSCV_cycle_v2(data_cycle_R1, handles.Fout, Period, ScanRate, ch2Vr_H, ch2Vr_L, tolerance_range, N_ok, handles.p_Right1);
        [data_FSCV_L2, N_L2]=FSCV_cycle_v2(data_cycle_L2, handles.Fout, Period, ScanRate, ch3Vr_H, ch3Vr_L, tolerance_range, N_ok, handles.p_Left2);
        [data_FSCV_R2, N_R2]=FSCV_cycle_v2(data_cycle_R2, handles.Fout, Period, ScanRate, ch4Vr_H, ch4Vr_L, tolerance_range, N_ok, handles.p_Right2);
        
        
        if length(data_FSCV_L1)==0
            imp_L1=zeros(1,(2*N_L1+1));
        else
            imp_L1=(((mean(data_FSCV_L1')-0)/(1))-ch1Vcom)/(RfeedBack(1));
        end
        if length(data_FSCV_R1)==0
            imp_R1=zeros(1,(2*N_R1+1));
        else
            imp_R1=(((mean(data_FSCV_R1')-0)/(1))-ch2Vcom)/(RfeedBack(2));
        end
        
        if length(data_FSCV_L2)==0
            imp_L2=zeros(1,(2*N_L2+1));
        else
            imp_L2=(((mean(data_FSCV_L2')-0)/(1))-ch3Vcom)/(RfeedBack(1));
        end
        if length(data_FSCV_R2)==0
            imp_R2=zeros(1,(2*N_R2+1));
        else
            imp_R2=(((mean(data_FSCV_R2')-0)/(1))-ch4Vcom)/(RfeedBack(2));
        end


        Xaxes_L1=[(((0:(N_L1-1))*((ch1Vr_H-ch1Vr_L)/N_L1))+ch1Vr_L) ch1Vr_H ((((N_L1-1):(-1):0)*((ch1Vr_H-ch1Vr_L)/N_L1))+ch1Vr_L)];
        Xaxes_R1=[(((0:(N_R1-1))*((ch2Vr_H-ch2Vr_L)/N_R1))+ch2Vr_L) ch2Vr_H ((((N_R1-1):(-1):0)*((ch2Vr_H-ch2Vr_L)/N_R1))+ch2Vr_L)];
        Xaxes_L2=[(((0:(N_L2-1))*((ch3Vr_H-ch3Vr_L)/N_L2))+ch3Vr_L) ch3Vr_H ((((N_L2-1):(-1):0)*((ch3Vr_H-ch3Vr_L)/N_L2))+ch3Vr_L)];
        Xaxes_R2=[(((0:(N_R2-1))*((ch4Vr_H-ch4Vr_L)/N_R2))+ch4Vr_L) ch4Vr_H ((((N_R2-1):(-1):0)*((ch4Vr_H-ch4Vr_L)/N_R2))+ch4Vr_L)];
        
        
        plot(handles.axes_total(3),Xaxes_L1,imp_L1*(10^9))
        axis(handles.axes_total(3),[ch1lowerVol ch1upperVol ch1lowerCur ch1upperCur])
        title(handles.axes_total(3),'v vs i (Ch1)','Color', 'b')
        xlabel(handles.axes_total(3),'FSCV VCM (V)')
        ylabel(handles.axes_total(3),'Input Current (nA)')

        plot(handles.axes_total(6),Xaxes_R1,imp_R1*(10^9))
        axis(handles.axes_total(6),[ch1lowerVol ch1upperVol ch1lowerCur ch1upperCur])
        title(handles.axes_total(6),'v vs i (Ch2)','Color', 'b')
        xlabel(handles.axes_total(6),'FSCV VCM (V)')
        ylabel(handles.axes_total(6),'Input Current (nA)')
        
        plot(handles.axes_total(9),Xaxes_L2,imp_L2*(10^9))
        axis(handles.axes_total(9),[ch1lowerVol ch1upperVol ch1lowerCur ch1upperCur])
        title(handles.axes_total(9),'v vs i (Ch3)','Color', 'b')
        xlabel(handles.axes_total(9),'FSCV VCM (V)')
        ylabel(handles.axes_total(9),'Input Current (nA)')

        plot(handles.axes_total(12),Xaxes_R2,imp_R2*(10^9))
        axis(handles.axes_total(12),[ch1lowerVol ch1upperVol ch1lowerCur ch1upperCur])
        title(handles.axes_total(12),'v vs i (Ch4)','Color', 'b')
        xlabel(handles.axes_total(12),'FSCV VCM (V)')
        ylabel(handles.axes_total(12),'Input Current (nA)')
        
        
        ch1voltageArray = Xaxes_L1;
        ch2voltageArray = Xaxes_R1;
        ch3voltageArray = Xaxes_L2;
        ch4voltageArray = Xaxes_R2;

        ch1n = ceil(numel(ch1voltageArray)/2);
        ch1firstHalfVol = ch1voltageArray(1:ch1n);
        ch1secondHalfVol = ch1voltageArray(ch1n+1:end);
        ch2n = ceil(numel(ch2voltageArray)/2);
        ch2firstHalfVol = ch2voltageArray(1:ch2n);
        ch2secondHalfVol = ch2voltageArray(ch2n+1:end);
        ch3n = ceil(numel(ch3voltageArray)/2);
        ch3firstHalfVol = ch3voltageArray(1:ch3n);
        ch3secondHalfVol = ch3voltageArray(ch3n+1:end);
        ch4n = ceil(numel(ch4voltageArray)/2);
        ch4firstHalfVol = ch4voltageArray(1:ch4n);
        ch4secondHalfVol = ch4voltageArray(ch4n+1:end);
        

        preCh1v1 = str2num(get(handles.preCh1v1,'String'));
        preCh1v2 = str2num(get(handles.preCh1v2,'String'));
        preCh1v3 = str2num(get(handles.preCh1v3,'String'));
        preCh1v4 = str2num(get(handles.preCh1v4,'String'));
        preCh2v1 = str2num(get(handles.preCh2v1,'String'));
        preCh2v2 = str2num(get(handles.preCh2v2,'String'));
        preCh2v3 = str2num(get(handles.preCh2v3,'String'));
        preCh2v4 = str2num(get(handles.preCh2v4,'String'));
        preCh3v1 = str2num(get(handles.preCh3v1,'String'));
        preCh3v2 = str2num(get(handles.preCh3v2,'String'));
        preCh3v3 = str2num(get(handles.preCh3v3,'String'));
        preCh3v4 = str2num(get(handles.preCh3v4,'String'));
        preCh4v1 = str2num(get(handles.preCh4v1,'String'));
        preCh4v2 = str2num(get(handles.preCh4v2,'String'));
        preCh4v3 = str2num(get(handles.preCh4v3,'String'));
        preCh4v4 = str2num(get(handles.preCh4v4,'String'));
        
        

        [ch1val1,ch1idx1]=min(abs(preCh1v1-ch1firstHalfVol));
        [ch1val2,ch1idx2]=min(abs(preCh1v2-ch1firstHalfVol));
        [ch1val3,ch1idx3]=min(abs(preCh1v3-ch1secondHalfVol));
        [ch1val4,ch1idx4]=min(abs(preCh1v4-ch1secondHalfVol));
        [ch2val1,ch2idx1]=min(abs(preCh2v1-ch2firstHalfVol));
        [ch2val2,ch2idx2]=min(abs(preCh2v2-ch2firstHalfVol));
        [ch2val3,ch2idx3]=min(abs(preCh2v3-ch2secondHalfVol));
        [ch2val4,ch2idx4]=min(abs(preCh2v4-ch2secondHalfVol));
        [ch3val1,ch3idx1]=min(abs(preCh3v1-ch3firstHalfVol));
        [ch3val2,ch3idx2]=min(abs(preCh3v2-ch3firstHalfVol));
        [ch3val3,ch3idx3]=min(abs(preCh3v3-ch3secondHalfVol));
        [ch3val4,ch3idx4]=min(abs(preCh3v4-ch3secondHalfVol));
        [ch4val1,ch4idx1]=min(abs(preCh4v1-ch4firstHalfVol));
        [ch4val2,ch4idx2]=min(abs(preCh4v2-ch4firstHalfVol));
        [ch4val3,ch4idx3]=min(abs(preCh4v3-ch4secondHalfVol));
        [ch4val4,ch4idx4]=min(abs(preCh4v4-ch4secondHalfVol));

        ch1vol1idx = ch1idx1;
        ch1vol2idx = ch1idx2;
        ch1vol3idx = ch1idx3+length(ch1firstHalfVol);
        ch1vol4idx = ch1idx4+length(ch1firstHalfVol);
        ch2vol1idx = ch2idx1;
        ch2vol2idx = ch2idx2;
        ch2vol3idx = ch2idx3+length(ch2firstHalfVol);
        ch2vol4idx = ch2idx4+length(ch2firstHalfVol);
        ch3vol1idx = ch3idx1;
        ch3vol2idx = ch3idx2;
        ch3vol3idx = ch3idx3+length(ch3firstHalfVol);
        ch3vol4idx = ch3idx4+length(ch3firstHalfVol);
        ch4vol1idx = ch4idx1;
        ch4vol2idx = ch4idx2;
        ch4vol3idx = ch4idx3+length(ch4firstHalfVol);
        ch4vol4idx = ch4idx4+length(ch4firstHalfVol);


        ch1I1p = imp_L1(ch1vol1idx);
        ch1I2p = imp_L1(ch1vol2idx);
        ch1I3b = imp_L1(ch1vol3idx);
        ch1I4b = imp_L1(ch1vol4idx);
        ch2I1p = imp_R1(ch2vol1idx);
        ch2I2p = imp_R1(ch2vol2idx);
        ch2I3b = imp_R1(ch2vol3idx);
        ch2I4b = imp_R1(ch2vol4idx);
        ch3I1p = imp_L2(ch3vol1idx);
        ch3I2p = imp_L2(ch3vol2idx);
        ch3I3b = imp_L2(ch3vol3idx);
        ch3I4b = imp_L2(ch3vol4idx);
        ch4I1p = imp_R2(ch4vol1idx);
        ch4I2p = imp_R2(ch4vol2idx);
        ch4I3b = imp_R2(ch4vol3idx);
        ch4I4b = imp_R2(ch4vol4idx);
        
%         ch1I = [ch1I1p ch1I2p ch1I3b ch1I4b];
%         ch2I = [ch2I1p ch2I2p ch2I3b ch2I4b];
%         ch3I = [ch3I1p ch3I2p ch3I3b ch4I4b];
%         ch4I = [ch4I1p ch4I2p ch4I3b ch4I4b];
        
%         ch1LastRow = ch1cursorCur(end, :);
%         ch2LastRow = ch1cursorCur(end, :);
%         ch3LastRow = ch1cursorCur(end, :);
%         ch4LastRow = ch1cursorCur(end, :);
        
%         ch1CurSlopTem = ch1I ./ ch1LastRow;
%         ch2CurSlopTem = ch2I ./ ch2LastRow;
%         ch3CurSlopTem = ch3I ./ ch3LastRow;
%         ch4CurSlopTem = ch4I ./ ch4LastRow;
        
        %This is what we need to store
%         ch1cursorCur = [ch1cursorCur; ch1I];
%         ch2cursorCur = [ch2cursorCur; ch2I];
%         ch3cursorCur = [ch3cursorCur; ch3I];
%         ch4cursorCur = [ch4cursorCur; ch4I];
        
%         ch1CurSlop = [ch1CurSlop; ch1CurSlopTem];
%         ch2CurSlop = [ch2CurSlop; ch2CurSlopTem];
%         ch3CurSlop = [ch3CurSlop; ch3CurSlopTem];
%         ch4CurSlop = [ch4CurSlop; ch4CurSlopTem];
        
        

        set(handles.ch1I1p, 'String', ch1I1p*(10^9));
        set(handles.ch1I2p, 'String', ch1I2p*(10^9));
        set(handles.ch1I3b, 'String', ch1I3b*(10^9));
        set(handles.ch1I4b, 'String', ch1I4b*(10^9));
        set(handles.ch2I1p, 'String', ch2I1p*(10^9));
        set(handles.ch2I2p, 'String', ch2I2p*(10^9));
        set(handles.ch2I3b, 'String', ch2I3b*(10^9));
        set(handles.ch2I4b, 'String', ch2I4b*(10^9));
        set(handles.ch3I1p, 'String', ch3I1p*(10^9));
        set(handles.ch3I2p, 'String', ch3I2p*(10^9));
        set(handles.ch3I3b, 'String', ch3I3b*(10^9));
        set(handles.ch3I4b, 'String', ch3I4b*(10^9));
        set(handles.ch4I1p, 'String', ch4I1p*(10^9));
        set(handles.ch4I2p, 'String', ch4I2p*(10^9));
        set(handles.ch4I3b, 'String', ch4I3b*(10^9));
        set(handles.ch4I4b, 'String', ch4I4b*(10^9));
        
%         contents = get(handles.slopeChSelect,'String'); 
%         slopeChSelectValue = contents{get(handles.slopeChSelect,'Value')};
%         
%         if (strcmp(slopeChSelectValue,'CH1'))
%             set(handles.I1Slope, 'String', ch1CurSlopTem(1));
%             set(handles.I2Slope, 'String', ch1CurSlopTem(2));
%             set(handles.I3Slope, 'String', ch1CurSlopTem(3));
%             set(handles.I4Slope, 'String', ch1CurSlopTem(4));
%         elseif (strcmp(slopeChSelectValue,'CH2'))
%             set(handles.I1Slope, 'String', ch2CurSlopTem(1));
%             set(handles.I2Slope, 'String', ch2CurSlopTem(2));
%             set(handles.I3Slope, 'String', ch2CurSlopTem(3));
%             set(handles.I4Slope, 'String', ch2CurSlopTem(4));
%         elseif (strcmp(slopeChSelectValue,'CH3'))
%             set(handles.I1Slope, 'String', ch3CurSlopTem(1));
%             set(handles.I2Slope, 'String', ch3CurSlopTem(2));
%             set(handles.I3Slope, 'String', ch3CurSlopTem(3));
%             set(handles.I4Slope, 'String', ch3CurSlopTem(4));
%         elseif (strcmp(slopeChSelectValue,'CH4'))
%             set(handles.I1Slope, 'String', ch4CurSlopTem(1));
%             set(handles.I2Slope, 'String', ch4CurSlopTem(2));
%             set(handles.I3Slope, 'String', ch4CurSlopTem(3));
%             set(handles.I4Slope, 'String', ch4CurSlopTem(4)); 
%         end
    
        
        data_cycle_L1=[];
        data_cycle_R1=[];
        data_cycle_L2=[];
        data_cycle_R2=[];
        
    
        handles.data_L1 = [];
        handles.current_L1 = [];
        handles.data_R1 = [];
        handles.current_R1 = [];
        handles.data_L2 = [];
        handles.current_L2 = [];
        handles.data_R2 = [];
        handles.current_R2 = [];
    end

    
    
    
    
    
    
    t = toc;
    ifmod3 = mod(i,100);
    if(ifmod3 == 0)
        disp(i)
        disp(toc)
        disp(t)
    end

end
assignin('base','Data_Test2',tmp_A2);
assignin('base','Data_Test3',tmp_A3);
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



% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pretreatChooseDir.
function pretreatChooseDir_Callback(hObject, eventdata, handles)

handles.pretreatDname = uigetdir('C:\');
set(handles.myPretreatDir,'String',handles.pretreatDname);

guidata(hObject, handles);


% --- Executes on button press in setupPretreatFileName.
function setupPretreatFileName_Callback(hObject, eventdata, handles)
Dev = get(handles.pretreatDevID,'String');


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

guidata(hObject, handles);



function edit86_Callback(hObject, eventdata, handles)
% hObject    handle to edit86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit86 as text
%        str2double(get(hObject,'String')) returns contents of edit86 as a double


% --- Executes during object creation, after setting all properties.
function edit86_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pretreatDevID_Callback(hObject, eventdata, handles)
% hObject    handle to pretreatDevID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pretreatDevID as text
%        str2double(get(hObject,'String')) returns contents of pretreatDevID as a double


% --- Executes during object creation, after setting all properties.
function pretreatDevID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pretreatDevID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function myPretreatDir_Callback(hObject, eventdata, handles)
% hObject    handle to myPretreatDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of myPretreatDir as text
%        str2double(get(hObject,'String')) returns contents of myPretreatDir as a double


% --- Executes during object creation, after setting all properties.
function myPretreatDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to myPretreatDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in slopeChSelect.
function slopeChSelect_Callback(hObject, eventdata, handles)
% hObject    handle to slopeChSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns slopeChSelect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from slopeChSelect


% --- Executes during object creation, after setting all properties.
function slopeChSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slopeChSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function I1Slope_Callback(hObject, eventdata, handles)
% hObject    handle to I1Slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of I1Slope as text
%        str2double(get(hObject,'String')) returns contents of I1Slope as a double


% --- Executes during object creation, after setting all properties.
function I1Slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I1Slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function I3Slope_Callback(hObject, eventdata, handles)
% hObject    handle to I3Slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of I3Slope as text
%        str2double(get(hObject,'String')) returns contents of I3Slope as a double


% --- Executes during object creation, after setting all properties.
function I3Slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I3Slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function I2Slope_Callback(hObject, eventdata, handles)
% hObject    handle to I2Slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of I2Slope as text
%        str2double(get(hObject,'String')) returns contents of I2Slope as a double


% --- Executes during object creation, after setting all properties.
function I2Slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I2Slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function I4Slope_Callback(hObject, eventdata, handles)
% hObject    handle to I4Slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of I4Slope as text
%        str2double(get(hObject,'String')) returns contents of I4Slope as a double


% --- Executes during object creation, after setting all properties.
function I4Slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I4Slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit150_Callback(hObject, eventdata, handles)
% hObject    handle to edit150 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit150 as text
%        str2double(get(hObject,'String')) returns contents of edit150 as a double


% --- Executes during object creation, after setting all properties.
function edit150_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit150 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit151_Callback(hObject, eventdata, handles)
% hObject    handle to edit151 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit151 as text
%        str2double(get(hObject,'String')) returns contents of edit151 as a double


% --- Executes during object creation, after setting all properties.
function edit151_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit151 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit152_Callback(hObject, eventdata, handles)
% hObject    handle to edit152 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit152 as text
%        str2double(get(hObject,'String')) returns contents of edit152 as a double


% --- Executes during object creation, after setting all properties.
function edit152_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit152 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerVolch4meas_Callback(hObject, eventdata, handles)
% hObject    handle to lowerVolch4meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerVolch4meas as text
%        str2double(get(hObject,'String')) returns contents of lowerVolch4meas as a double


% --- Executes during object creation, after setting all properties.
function lowerVolch4meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerVolch4meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerCurch4meas_Callback(hObject, eventdata, handles)
% hObject    handle to lowerCurch4meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerCurch4meas as text
%        str2double(get(hObject,'String')) returns contents of lowerCurch4meas as a double


% --- Executes during object creation, after setting all properties.
function lowerCurch4meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerCurch4meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperVolch4meas_Callback(hObject, eventdata, handles)
% hObject    handle to upperVolch4meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperVolch4meas as text
%        str2double(get(hObject,'String')) returns contents of upperVolch4meas as a double


% --- Executes during object creation, after setting all properties.
function upperVolch4meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperVolch4meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperCurch4meas_Callback(hObject, eventdata, handles)
% hObject    handle to upperCurch4meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperCurch4meas as text
%        str2double(get(hObject,'String')) returns contents of upperCurch4meas as a double


% --- Executes during object creation, after setting all properties.
function upperCurch4meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperCurch4meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerVolch3meas_Callback(hObject, eventdata, handles)
% hObject    handle to lowerVolch3meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerVolch3meas as text
%        str2double(get(hObject,'String')) returns contents of lowerVolch3meas as a double


% --- Executes during object creation, after setting all properties.
function lowerVolch3meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerVolch3meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerCurch3meas_Callback(hObject, eventdata, handles)
% hObject    handle to lowerCurch3meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerCurch3meas as text
%        str2double(get(hObject,'String')) returns contents of lowerCurch3meas as a double


% --- Executes during object creation, after setting all properties.
function lowerCurch3meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerCurch3meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperVolch3meas_Callback(hObject, eventdata, handles)
% hObject    handle to upperVolch3meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperVolch3meas as text
%        str2double(get(hObject,'String')) returns contents of upperVolch3meas as a double


% --- Executes during object creation, after setting all properties.
function upperVolch3meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperVolch3meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperCurch3meas_Callback(hObject, eventdata, handles)
% hObject    handle to upperCurch3meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperCurch3meas as text
%        str2double(get(hObject,'String')) returns contents of upperCurch3meas as a double


% --- Executes during object creation, after setting all properties.
function upperCurch3meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperCurch3meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerVolch2meas_Callback(hObject, eventdata, handles)
% hObject    handle to lowerVolch2meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerVolch2meas as text
%        str2double(get(hObject,'String')) returns contents of lowerVolch2meas as a double


% --- Executes during object creation, after setting all properties.
function lowerVolch2meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerVolch2meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerCurch2meas_Callback(hObject, eventdata, handles)
% hObject    handle to lowerCurch2meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerCurch2meas as text
%        str2double(get(hObject,'String')) returns contents of lowerCurch2meas as a double


% --- Executes during object creation, after setting all properties.
function lowerCurch2meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerCurch2meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperVolch2meas_Callback(hObject, eventdata, handles)
% hObject    handle to upperVolch2meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperVolch2meas as text
%        str2double(get(hObject,'String')) returns contents of upperVolch2meas as a double


% --- Executes during object creation, after setting all properties.
function upperVolch2meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperVolch2meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperCurch2meas_Callback(hObject, eventdata, handles)
% hObject    handle to upperCurch2meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperCurch2meas as text
%        str2double(get(hObject,'String')) returns contents of upperCurch2meas as a double


% --- Executes during object creation, after setting all properties.
function upperCurch2meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperCurch2meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerVolch1meas_Callback(hObject, eventdata, handles)
% hObject    handle to lowerVolch1meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerVolch1meas as text
%        str2double(get(hObject,'String')) returns contents of lowerVolch1meas as a double


% --- Executes during object creation, after setting all properties.
function lowerVolch1meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerVolch1meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerCurch1meas_Callback(hObject, eventdata, handles)
% hObject    handle to lowerCurch1meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerCurch1meas as text
%        str2double(get(hObject,'String')) returns contents of lowerCurch1meas as a double


% --- Executes during object creation, after setting all properties.
function lowerCurch1meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerCurch1meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperVolch1meas_Callback(hObject, eventdata, handles)
% hObject    handle to upperVolch1meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperVolch1meas as text
%        str2double(get(hObject,'String')) returns contents of upperVolch1meas as a double


% --- Executes during object creation, after setting all properties.
function upperVolch1meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperVolch1meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperCurch1meas_Callback(hObject, eventdata, handles)
% hObject    handle to upperCurch1meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperCurch1meas as text
%        str2double(get(hObject,'String')) returns contents of upperCurch1meas as a double


% --- Executes during object creation, after setting all properties.
function upperCurch1meas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperCurch1meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch4v1_Callback(hObject, eventdata, handles)
% hObject    handle to Ch4v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch4v1 as text
%        str2double(get(hObject,'String')) returns contents of Ch4v1 as a double


% --- Executes during object creation, after setting all properties.
function Ch4v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch4v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch4v2_Callback(hObject, eventdata, handles)
% hObject    handle to Ch4v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch4v2 as text
%        str2double(get(hObject,'String')) returns contents of Ch4v2 as a double


% --- Executes during object creation, after setting all properties.
function Ch4v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch4v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch4v3_Callback(hObject, eventdata, handles)
% hObject    handle to Ch4v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch4v3 as text
%        str2double(get(hObject,'String')) returns contents of Ch4v3 as a double


% --- Executes during object creation, after setting all properties.
function Ch4v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch4v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch4v4_Callback(hObject, eventdata, handles)
% hObject    handle to Ch4v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch4v4 as text
%        str2double(get(hObject,'String')) returns contents of Ch4v4 as a double


% --- Executes during object creation, after setting all properties.
function Ch4v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch4v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch4I1p_Callback(hObject, eventdata, handles)
% hObject    handle to mch4I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch4I1p as text
%        str2double(get(hObject,'String')) returns contents of mch4I1p as a double


% --- Executes during object creation, after setting all properties.
function mch4I1p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch4I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch4I2p_Callback(hObject, eventdata, handles)
% hObject    handle to mch4I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch4I2p as text
%        str2double(get(hObject,'String')) returns contents of mch4I2p as a double


% --- Executes during object creation, after setting all properties.
function mch4I2p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch4I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch4I3b_Callback(hObject, eventdata, handles)
% hObject    handle to mch4I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch4I3b as text
%        str2double(get(hObject,'String')) returns contents of mch4I3b as a double


% --- Executes during object creation, after setting all properties.
function mch4I3b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch4I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch4I4b_Callback(hObject, eventdata, handles)
% hObject    handle to mch4I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch4I4b as text
%        str2double(get(hObject,'String')) returns contents of mch4I4b as a double


% --- Executes during object creation, after setting all properties.
function mch4I4b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch4I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch3v1_Callback(hObject, eventdata, handles)
% hObject    handle to Ch3v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch3v1 as text
%        str2double(get(hObject,'String')) returns contents of Ch3v1 as a double


% --- Executes during object creation, after setting all properties.
function Ch3v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch3v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch3v2_Callback(hObject, eventdata, handles)
% hObject    handle to Ch3v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch3v2 as text
%        str2double(get(hObject,'String')) returns contents of Ch3v2 as a double


% --- Executes during object creation, after setting all properties.
function Ch3v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch3v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch3v3_Callback(hObject, eventdata, handles)
% hObject    handle to Ch3v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch3v3 as text
%        str2double(get(hObject,'String')) returns contents of Ch3v3 as a double


% --- Executes during object creation, after setting all properties.
function Ch3v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch3v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch3v4_Callback(hObject, eventdata, handles)
% hObject    handle to Ch3v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch3v4 as text
%        str2double(get(hObject,'String')) returns contents of Ch3v4 as a double


% --- Executes during object creation, after setting all properties.
function Ch3v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch3v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch3I1p_Callback(hObject, eventdata, handles)
% hObject    handle to mch3I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch3I1p as text
%        str2double(get(hObject,'String')) returns contents of mch3I1p as a double


% --- Executes during object creation, after setting all properties.
function mch3I1p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch3I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch3I2p_Callback(hObject, eventdata, handles)
% hObject    handle to mch3I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch3I2p as text
%        str2double(get(hObject,'String')) returns contents of mch3I2p as a double


% --- Executes during object creation, after setting all properties.
function mch3I2p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch3I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch3I3b_Callback(hObject, eventdata, handles)
% hObject    handle to mch3I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch3I3b as text
%        str2double(get(hObject,'String')) returns contents of mch3I3b as a double


% --- Executes during object creation, after setting all properties.
function mch3I3b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch3I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch3I4b_Callback(hObject, eventdata, handles)
% hObject    handle to mch3I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch3I4b as text
%        str2double(get(hObject,'String')) returns contents of mch3I4b as a double


% --- Executes during object creation, after setting all properties.
function mch3I4b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch3I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch2v1_Callback(hObject, eventdata, handles)
% hObject    handle to Ch2v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch2v1 as text
%        str2double(get(hObject,'String')) returns contents of Ch2v1 as a double


% --- Executes during object creation, after setting all properties.
function Ch2v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch2v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch2v2_Callback(hObject, eventdata, handles)
% hObject    handle to Ch2v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch2v2 as text
%        str2double(get(hObject,'String')) returns contents of Ch2v2 as a double


% --- Executes during object creation, after setting all properties.
function Ch2v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch2v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch2v3_Callback(hObject, eventdata, handles)
% hObject    handle to Ch2v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch2v3 as text
%        str2double(get(hObject,'String')) returns contents of Ch2v3 as a double


% --- Executes during object creation, after setting all properties.
function Ch2v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch2v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch2v4_Callback(hObject, eventdata, handles)
% hObject    handle to Ch2v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch2v4 as text
%        str2double(get(hObject,'String')) returns contents of Ch2v4 as a double


% --- Executes during object creation, after setting all properties.
function Ch2v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch2v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch2I1p_Callback(hObject, eventdata, handles)
% hObject    handle to mch2I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch2I1p as text
%        str2double(get(hObject,'String')) returns contents of mch2I1p as a double


% --- Executes during object creation, after setting all properties.
function mch2I1p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch2I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch2I2p_Callback(hObject, eventdata, handles)
% hObject    handle to mch2I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch2I2p as text
%        str2double(get(hObject,'String')) returns contents of mch2I2p as a double


% --- Executes during object creation, after setting all properties.
function mch2I2p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch2I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch2I3b_Callback(hObject, eventdata, handles)
% hObject    handle to mch2I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch2I3b as text
%        str2double(get(hObject,'String')) returns contents of mch2I3b as a double


% --- Executes during object creation, after setting all properties.
function mch2I3b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch2I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch2I4b_Callback(hObject, eventdata, handles)
% hObject    handle to mch2I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch2I4b as text
%        str2double(get(hObject,'String')) returns contents of mch2I4b as a double


% --- Executes during object creation, after setting all properties.
function mch2I4b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch2I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch1v1_Callback(hObject, eventdata, handles)
% hObject    handle to Ch1v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch1v1 as text
%        str2double(get(hObject,'String')) returns contents of Ch1v1 as a double


% --- Executes during object creation, after setting all properties.
function Ch1v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch1v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch1v2_Callback(hObject, eventdata, handles)
% hObject    handle to Ch1v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch1v2 as text
%        str2double(get(hObject,'String')) returns contents of Ch1v2 as a double


% --- Executes during object creation, after setting all properties.
function Ch1v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch1v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch1v3_Callback(hObject, eventdata, handles)
% hObject    handle to Ch1v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch1v3 as text
%        str2double(get(hObject,'String')) returns contents of Ch1v3 as a double


% --- Executes during object creation, after setting all properties.
function Ch1v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch1v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ch1v4_Callback(hObject, eventdata, handles)
% hObject    handle to Ch1v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ch1v4 as text
%        str2double(get(hObject,'String')) returns contents of Ch1v4 as a double


% --- Executes during object creation, after setting all properties.
function Ch1v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ch1v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch1I1p_Callback(hObject, eventdata, handles)
% hObject    handle to mch1I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch1I1p as text
%        str2double(get(hObject,'String')) returns contents of mch1I1p as a double


% --- Executes during object creation, after setting all properties.
function mch1I1p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch1I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch1I2p_Callback(hObject, eventdata, handles)
% hObject    handle to mch1I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch1I2p as text
%        str2double(get(hObject,'String')) returns contents of mch1I2p as a double


% --- Executes during object creation, after setting all properties.
function mch1I2p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch1I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch1I3b_Callback(hObject, eventdata, handles)
% hObject    handle to mch1I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch1I3b as text
%        str2double(get(hObject,'String')) returns contents of mch1I3b as a double


% --- Executes during object creation, after setting all properties.
function mch1I3b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch1I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mch1I4b_Callback(hObject, eventdata, handles)
% hObject    handle to mch1I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mch1I4b as text
%        str2double(get(hObject,'String')) returns contents of mch1I4b as a double


% --- Executes during object creation, after setting all properties.
function mch1I4b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mch1I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerVolch4_Callback(hObject, eventdata, handles)
% hObject    handle to lowerVolch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerVolch4 as text
%        str2double(get(hObject,'String')) returns contents of lowerVolch4 as a double


% --- Executes during object creation, after setting all properties.
function lowerVolch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerVolch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerCurch4_Callback(hObject, eventdata, handles)
% hObject    handle to lowerCurch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerCurch4 as text
%        str2double(get(hObject,'String')) returns contents of lowerCurch4 as a double


% --- Executes during object creation, after setting all properties.
function lowerCurch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerCurch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperVolch4_Callback(hObject, eventdata, handles)
% hObject    handle to upperVolch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperVolch4 as text
%        str2double(get(hObject,'String')) returns contents of upperVolch4 as a double


% --- Executes during object creation, after setting all properties.
function upperVolch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperVolch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperCurch4_Callback(hObject, eventdata, handles)
% hObject    handle to upperCurch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperCurch4 as text
%        str2double(get(hObject,'String')) returns contents of upperCurch4 as a double


% --- Executes during object creation, after setting all properties.
function upperCurch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperCurch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerVolch3_Callback(hObject, eventdata, handles)
% hObject    handle to lowerVolch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerVolch3 as text
%        str2double(get(hObject,'String')) returns contents of lowerVolch3 as a double


% --- Executes during object creation, after setting all properties.
function lowerVolch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerVolch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerCurch3_Callback(hObject, eventdata, handles)
% hObject    handle to lowerCurch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerCurch3 as text
%        str2double(get(hObject,'String')) returns contents of lowerCurch3 as a double


% --- Executes during object creation, after setting all properties.
function lowerCurch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerCurch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperVolch3_Callback(hObject, eventdata, handles)
% hObject    handle to upperVolch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperVolch3 as text
%        str2double(get(hObject,'String')) returns contents of upperVolch3 as a double


% --- Executes during object creation, after setting all properties.
function upperVolch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperVolch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperCurch3_Callback(hObject, eventdata, handles)
% hObject    handle to upperCurch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperCurch3 as text
%        str2double(get(hObject,'String')) returns contents of upperCurch3 as a double


% --- Executes during object creation, after setting all properties.
function upperCurch3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperCurch3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerVolch2_Callback(hObject, eventdata, handles)
% hObject    handle to lowerVolch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerVolch2 as text
%        str2double(get(hObject,'String')) returns contents of lowerVolch2 as a double


% --- Executes during object creation, after setting all properties.
function lowerVolch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerVolch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerCurch2_Callback(hObject, eventdata, handles)
% hObject    handle to lowerCurch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerCurch2 as text
%        str2double(get(hObject,'String')) returns contents of lowerCurch2 as a double


% --- Executes during object creation, after setting all properties.
function lowerCurch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerCurch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperVolch2_Callback(hObject, eventdata, handles)
% hObject    handle to upperVolch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperVolch2 as text
%        str2double(get(hObject,'String')) returns contents of upperVolch2 as a double


% --- Executes during object creation, after setting all properties.
function upperVolch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperVolch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperCurch2_Callback(hObject, eventdata, handles)
% hObject    handle to upperCurch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperCurch2 as text
%        str2double(get(hObject,'String')) returns contents of upperCurch2 as a double


% --- Executes during object creation, after setting all properties.
function upperCurch2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperCurch2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerVolch1_Callback(hObject, eventdata, handles)
% hObject    handle to lowerVolch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerVolch1 as text
%        str2double(get(hObject,'String')) returns contents of lowerVolch1 as a double


% --- Executes during object creation, after setting all properties.
function lowerVolch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerVolch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lowerCurch1_Callback(hObject, eventdata, handles)
% hObject    handle to lowerCurch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lowerCurch1 as text
%        str2double(get(hObject,'String')) returns contents of lowerCurch1 as a double


% --- Executes during object creation, after setting all properties.
function lowerCurch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerCurch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperVolch1_Callback(hObject, eventdata, handles)
% hObject    handle to upperVolch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperVolch1 as text
%        str2double(get(hObject,'String')) returns contents of upperVolch1 as a double


% --- Executes during object creation, after setting all properties.
function upperVolch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperVolch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upperCurch1_Callback(hObject, eventdata, handles)
% hObject    handle to upperCurch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upperCurch1 as text
%        str2double(get(hObject,'String')) returns contents of upperCurch1 as a double


% --- Executes during object creation, after setting all properties.
function upperCurch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperCurch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh4v1_Callback(hObject, eventdata, handles)
% hObject    handle to preCh4v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh4v1 as text
%        str2double(get(hObject,'String')) returns contents of preCh4v1 as a double


% --- Executes during object creation, after setting all properties.
function preCh4v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh4v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh4v2_Callback(hObject, eventdata, handles)
% hObject    handle to preCh4v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh4v2 as text
%        str2double(get(hObject,'String')) returns contents of preCh4v2 as a double


% --- Executes during object creation, after setting all properties.
function preCh4v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh4v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh4v3_Callback(hObject, eventdata, handles)
% hObject    handle to preCh4v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh4v3 as text
%        str2double(get(hObject,'String')) returns contents of preCh4v3 as a double


% --- Executes during object creation, after setting all properties.
function preCh4v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh4v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh4v4_Callback(hObject, eventdata, handles)
% hObject    handle to preCh4v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh4v4 as text
%        str2double(get(hObject,'String')) returns contents of preCh4v4 as a double


% --- Executes during object creation, after setting all properties.
function preCh4v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh4v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch4I1p_Callback(hObject, eventdata, handles)
% hObject    handle to ch4I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch4I1p as text
%        str2double(get(hObject,'String')) returns contents of ch4I1p as a double


% --- Executes during object creation, after setting all properties.
function ch4I1p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch4I1p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch4I2p_Callback(hObject, eventdata, handles)
% hObject    handle to ch4I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch4I2p as text
%        str2double(get(hObject,'String')) returns contents of ch4I2p as a double


% --- Executes during object creation, after setting all properties.
function ch4I2p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch4I2p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch4I3b_Callback(hObject, eventdata, handles)
% hObject    handle to ch4I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch4I3b as text
%        str2double(get(hObject,'String')) returns contents of ch4I3b as a double


% --- Executes during object creation, after setting all properties.
function ch4I3b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch4I3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch4I4b_Callback(hObject, eventdata, handles)
% hObject    handle to ch4I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch4I4b as text
%        str2double(get(hObject,'String')) returns contents of ch4I4b as a double


% --- Executes during object creation, after setting all properties.
function ch4I4b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch4I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh3v1_Callback(hObject, eventdata, handles)
% hObject    handle to preCh3v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh3v1 as text
%        str2double(get(hObject,'String')) returns contents of preCh3v1 as a double


% --- Executes during object creation, after setting all properties.
function preCh3v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh3v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh3v2_Callback(hObject, eventdata, handles)
% hObject    handle to preCh3v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh3v2 as text
%        str2double(get(hObject,'String')) returns contents of preCh3v2 as a double


% --- Executes during object creation, after setting all properties.
function preCh3v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh3v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh3v3_Callback(hObject, eventdata, handles)
% hObject    handle to preCh3v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh3v3 as text
%        str2double(get(hObject,'String')) returns contents of preCh3v3 as a double


% --- Executes during object creation, after setting all properties.
function preCh3v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh3v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh3v4_Callback(hObject, eventdata, handles)
% hObject    handle to preCh3v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh3v4 as text
%        str2double(get(hObject,'String')) returns contents of preCh3v4 as a double


% --- Executes during object creation, after setting all properties.
function preCh3v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh3v4 (see GCBO)
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



function edit73_Callback(hObject, eventdata, handles)
% hObject    handle to ch4I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch4I4b as text
%        str2double(get(hObject,'String')) returns contents of ch4I4b as a double


% --- Executes during object creation, after setting all properties.
function edit73_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch4I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh2v1_Callback(hObject, eventdata, handles)
% hObject    handle to preCh2v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh2v1 as text
%        str2double(get(hObject,'String')) returns contents of preCh2v1 as a double


% --- Executes during object creation, after setting all properties.
function preCh2v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh2v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh2v2_Callback(hObject, eventdata, handles)
% hObject    handle to preCh2v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh2v2 as text
%        str2double(get(hObject,'String')) returns contents of preCh2v2 as a double


% --- Executes during object creation, after setting all properties.
function preCh2v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh2v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh2v3_Callback(hObject, eventdata, handles)
% hObject    handle to preCh2v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh2v3 as text
%        str2double(get(hObject,'String')) returns contents of preCh2v3 as a double


% --- Executes during object creation, after setting all properties.
function preCh2v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh2v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh2v4_Callback(hObject, eventdata, handles)
% hObject    handle to preCh2v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh2v4 as text
%        str2double(get(hObject,'String')) returns contents of preCh2v4 as a double


% --- Executes during object creation, after setting all properties.
function preCh2v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh2v4 (see GCBO)
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



function preCh1v1_Callback(hObject, eventdata, handles)
% hObject    handle to preCh1v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh1v1 as text
%        str2double(get(hObject,'String')) returns contents of preCh1v1 as a double


% --- Executes during object creation, after setting all properties.
function preCh1v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh1v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh1v2_Callback(hObject, eventdata, handles)
% hObject    handle to preCh1v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh1v2 as text
%        str2double(get(hObject,'String')) returns contents of preCh1v2 as a double


% --- Executes during object creation, after setting all properties.
function preCh1v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh1v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh1v3_Callback(hObject, eventdata, handles)
% hObject    handle to preCh1v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh1v3 as text
%        str2double(get(hObject,'String')) returns contents of preCh1v3 as a double


% --- Executes during object creation, after setting all properties.
function preCh1v3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh1v3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function preCh1v4_Callback(hObject, eventdata, handles)
% hObject    handle to preCh1v4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of preCh1v4 as text
%        str2double(get(hObject,'String')) returns contents of preCh1v4 as a double


% --- Executes during object creation, after setting all properties.
function preCh1v4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to preCh1v4 (see GCBO)
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


% --- Executes on button press in ChooseDir.
function ChooseDir_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.dname = uigetdir('C:\');
set(handles.myDir,'String',handles.dname);

guidata(hObject, handles);

% --- Executes on button press in setupFileName.
function setupFileName_Callback(hObject, eventdata, handles)
% hObject    handle to setupFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Dev = get(handles.DevID,'String');
MeMo = get(handles.measuredMolecule,'String');
Concentration = get(handles.consentrationOfMol,'String');
rampRate = get(handles.editScanRate,'String');
freq = get(handles.editFrequency,'String');

%Modify the peak voltage for 4ch
peakch1 = get(handles.editPeakVoltageCh1,'String');
vpeak1 = str2num(peakch1);
if (vpeak1<0)  
    peakStrch1 = "ne"+peakch1(2)+"p"+peakch1(4:end);
end
if (vpeak1>0)  
    peakStrch1 = "po"+peakch1(1)+"p"+peakch1(3:end);
end

peakch2 = get(handles.editPeakVoltageCh2,'String');
vpeak2 = str2num(peakch2);
if (vpeak2<0)  
    peakStrch2 = "ne"+peakch2(2)+"p"+peakch2(4:end);
end
if (vpeak2>0)  
    peakStrch2 = "po"+peakch2(1)+"p"+peakch2(3:end);
end

peakch3 = get(handles.editPeakVoltageCh3,'String');
vpeak3 = str2num(peakch3);
if (vpeak3<0)  
    peakStrch3 = "ne"+peakch3(2)+"p"+peakch3(4:end);
end
if (vpeak3>0)  
    peakStrch3 = "po"+peakch3(1)+"p"+peakch3(3:end);
end

peakch4 = get(handles.editPeakVoltageCh4,'String');
vpeak4 = str2num(peakch4);
if (vpeak4<0)  
    peakStrch4 = "ne"+peakch4(2)+"p"+peakch4(4:end);
end
if (vpeak4>0)  
    peakStrch4 = "po"+peakch4(1)+"p"+peakch4(3:end);
end

pchar1 = convertStringsToChars(peakStrch1);
pchar2 = convertStringsToChars(peakStrch2);
pchar3 = convertStringsToChars(peakStrch3);
pchar4 = convertStringsToChars(peakStrch4);

%Modify the bottom voltage for 4ch
bottomch1 = get(handles.editBottomVoltageCh1,'String');
vbottom1 = str2num(bottomch1);
if (vbottom1<0)  
    bottomStrch1 = "ne"+bottomch1(2)+"p"+bottomch1(4:end);
end
if (vbottom1>0)  
    bottomStrch1 = "po"+bottomch1(1)+"p"+bottomch1(3:end);
end

bottomch2 = get(handles.editBottomVoltageCh2,'String');
vbottom2 = str2num(bottomch2);
if (vbottom2<0)  
    bottomStrch2 = "ne"+bottomch2(2)+"p"+bottomch2(4:end);
end
if (vbottom2>0)  
    bottomStrch2 = "po"+bottomch2(1)+"p"+bottomch2(3:end);
end

bottomch3 = get(handles.editBottomVoltageCh3,'String');
vbottom3 = str2num(bottomch3);
if (vbottom3<0)  
    bottomStrch3 = "ne"+bottomch3(2)+"p"+bottomch3(4:end);
end
if (vbottom3>0)  
    bottomStrch3 = "po"+bottomch3(1)+"p"+bottomch3(3:end);
end

bottomch4 = get(handles.editBottomVoltageCh4,'String');
vbottom4 = str2num(bottomch4);
if (vbottom4<0)  
    bottomStrch4 = "ne"+bottomch4(2)+"p"+bottomch4(4:end);
end
if (vbottom4>0)  
    bottomStrch4 = "po"+bottomch4(1)+"p"+bottomch4(3:end);
end

bchar1 = convertStringsToChars(bottomStrch1);
bchar2 = convertStringsToChars(bottomStrch2);
bchar3 = convertStringsToChars(bottomStrch3);
bchar4 = convertStringsToChars(bottomStrch4);

time = datestr(now,'ddmmyy_HHMMSS');

strArray1 = {Dev,MeMo,Concentration,rampRate,freq,bchar1,pchar1,time};
strArray2 = {Dev,MeMo,Concentration,rampRate,freq,bchar2,pchar2,time};
strArray3 = {Dev,MeMo,Concentration,rampRate,freq,bchar3,pchar3,time};
strArray4 = {Dev,MeMo,Concentration,rampRate,freq,bchar4,pchar4,time};

dir = get(handles.myDir,'String');

fileName1 = strjoin(strArray1,'_');
fileName2 = strjoin(strArray2,'_');
fileName3 = strjoin(strArray3,'_');
fileName4 = strjoin(strArray4,'_');

set(handles.myFileName,'String',fileName1);
handles.name1Vol = strcat(dir,'\',fileName1,'_ch1Vol.txt');
handles.name2Vol = strcat(dir,'\',fileName2,'_ch2Vol.txt');
handles.name3Vol = strcat(dir,'\',fileName3,'_ch3Vol.txt');
handles.name4Vol = strcat(dir,'\',fileName4,'_ch4Vol.txt');
handles.name1Cur = strcat(dir,'\',fileName1,'_ch1Cur.txt');
handles.name2Cur = strcat(dir,'\',fileName2,'_ch2Cur.txt');
handles.name3Cur = strcat(dir,'\',fileName3,'_ch3Cur.txt');
handles.name4Cur = strcat(dir,'\',fileName4,'_ch4Cur.txt');

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



function DevID_Callback(hObject, eventdata, handles)
% hObject    handle to DevID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DevID as text
%        str2double(get(hObject,'String')) returns contents of DevID as a double


% --- Executes during object creation, after setting all properties.
function DevID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DevID (see GCBO)
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



function myDir_Callback(hObject, eventdata, handles)
% hObject    handle to myDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of myDir as text
%        str2double(get(hObject,'String')) returns contents of myDir as a double


% --- Executes during object creation, after setting all properties.
function myDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to myDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in nshapeCh12DataAnalysis.
function nshapeCh12DataAnalysis_Callback(hObject, eventdata, handles)
disp('Code begins running...')

%% Define folder path and file name


directoryName = handles.dname;
dataFolderPath=directoryName;
%File_name_I ='CM_N5A_9_C3260319_190906200nA_vern100p_1uM_400Vs_10Hz_ne_0p4_to_1p3_V2.tdms';
ch1DataFileName = handles.name1Vol;
fileName_I = ch3DataFileName;
ch2DataFileName = handles.name2Vol;
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
str2num(get(handles.editFrequency,'String'));
Voltage_High = str2num(get(handles.editPeakVoltageCh1,'String'));
Voltage_Low = str2num(get(handles.editBottomVoltageCh1,'String'));
% Voltage_hold=-0.02;
Voltage_hold=-0.05;
% Voltage_hold=-0.0;
Ramp_rate=200;
FSCV_frequency=10;
%Duration=((Voltage_High-Voltage_hold)+(-Voltage_Low-Voltage_hold)+(Voltage_High-Voltage_Low-8*Voltage_hold))/Ramp_rate;
Duration=(Voltage_High-Voltage_Low)/Ramp_rate*2;
First_cycle_PBS=str2num(get(handles.nshapePBS,'String'));  %first background cycle for current subtraction 
N_cycle_PBS=30;

First_cycle_DA=str2num(get(handles.nshapeDA,'String'));  %first DA cycle for current subtraction
N_cycle_DA=10;

%% Read data from tdms file
% cd (Datafolder)

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


summary=[Voltage_matrix,Subtracted_current_matrix];
fid=fopen('current_matrix1.txt','w');
fprintf(fid, 'Voltage\tPeak current\t\r\n');
[m,n]=size(summary);
for i=1:m
    fprintf(fid, '%f\t%f\t\r\n',summary(i,:));
end
fclose(fid);


% --- Executes on button press in nshapeCh34DataAnalysis.
function nshapeCh34DataAnalysis_Callback(hObject, eventdata, handles)
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
str2num(get(handles.editFrequency,'String'));
Voltage_High = str2num(get(handles.editPeakVoltageCh3,'String'));
Voltage_Low = str2num(get(handles.editBottomVoltageCh3,'String'));
% Voltage_hold=-0.02;
Voltage_hold=-0.05;
% Voltage_hold=-0.0;
Ramp_rate=200;
FSCV_frequency=10;
%Duration=((Voltage_High-Voltage_hold)+(-Voltage_Low-Voltage_hold)+(Voltage_High-Voltage_Low-8*Voltage_hold))/Ramp_rate;
Duration=(Voltage_High-Voltage_Low)/Ramp_rate*2;
First_cycle_PBS=str2num(get(handles.nshapePBS,'String'));  %first background cycle for current subtraction 
N_cycle_PBS=30;

First_cycle_DA=str2num(get(handles.nshapeDA,'String'));  %first DA cycle for current subtraction
N_cycle_DA=10;

%% Read data from tdms file
% cd (Datafolder)

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


summary=[Voltage_matrix,Subtracted_current_matrix];
fid=fopen('current_matrix1.txt','w');
fprintf(fid, 'Voltage\tPeak current\t\r\n');
[m,n]=size(summary);
for i=1:m
    fprintf(fid, '%f\t%f\t\r\n',summary(i,:));
end
fclose(fid);




% --- Executes on button press in rampCh1DataAnalysis.
function rampCh1DataAnalysis_Callback(hObject, eventdata, handles)
 %% Define folder path and file name

        directoryName = handles.dname;
        Datafolder = directoryName;
        save_file_name ='SF1-8_C2_10Hz_20K_50_15percent_1103_400_extended_2uMDA_after_pretreatment_V1.csv';
        Device='CM N5A 64 C2 C6 10Hz 200V/s 2uM DA';

        %% Define parameters
        Frequency = str2num(get(handles.editFrequency,'String'));
        Voltage_High = str2num(get(handles.editPeakVoltageCh1,'String'));
        Voltage_Low = str2num(get(handles.editBottomVoltageCh1,'String'));
        Ramp_rate = str2num(get(handles.editScanRate,'String'));
        vcom = str2num(get(handles.editVcomCh1,'String'));
        startCycle = str2num(get(handles.DAstartCycle,'String'));
        endCycle = str2num(get(handles.DAendCycle,'String'));
        
        Rfb=4.1e6; % (Ohm)

        FSCV_frequency=10; % (Hz) or 0.1s
        Duration=2*(Voltage_High-Voltage_Low)/Ramp_rate; % 12 (ms)

        OSR=250;
        sampling_rate_ADC=2.5e6/(1*OSR); % (Hz)
        Data_points=Duration*sampling_rate_ADC;
        %% Read data from txt file
        cd (Datafolder)
        % Data_cell1 = csvread(save_file_name);
        ch1DataFileName = handles.name1Vol;
        fileID=fopen(ch1DataFileName,'r');  % aquired data from ADC
        A=fscanf(fileID,'%f\n');
        fclose(fileID);
        data_1=A;
        
        FSCV_PBS_data1=data_1;
        FSCV_DA_data1=data_1;

        [Peak1, Peak_index1]=findpeaks(data_1, 'MinPeakHeight', 0.1, 'MinPeakDistance',round(1/FSCV_frequency*sampling_rate_ADC)-10);
        peakInterval = diff(Peak_index1);
        NOCycle=length(Peak_index1);

        %% Correct the indecies of the maximum sampled ramp voltage 
        diff_data=diff(A);
        diff_peak=find(diff_data> 0.05);

        for i=[1:(NOCycle)]
        
        Peak_index1(i)=(Peak_index1(1)+1000*(i-1));  %the index represents the starting point of each cycle
        end  
        offset_DA =Peak_index1(1)- diff_peak(1);
        offset_PBS=offset_DA;
        
        %%

        half_period_num=round(Duration*sampling_rate_ADC/2);

        FSCV_current_PBS=(FSCV_PBS_data1-vcom)/Rfb;
       

        FSCV_current_Dopamine=((FSCV_DA_data1-vcom)/Rfb);
      

        %% Find the averaging for the first PBS measurement

        
        NumOfCycle=length(Peak_index1);
        

        Current_Matrix_PBS=[];
        Voltage_Matrix_PBS=[];
        for i=180:210  

        
            One_Cycle_Index=(Peak_index1(i)-offset_PBS):(Peak_index1(i)+round(Data_points)-offset_PBS-1);


            Current_single_cycle=FSCV_current_PBS(One_Cycle_Index)';

       

            Current_Matrix_PBS=[Current_Matrix_PBS;Current_single_cycle];
       
        end
        Average_current_PBS=mean(Current_Matrix_PBS);
       


        %% Find the averaging for the DA measurement    
        
        NumOfCycle_DA=length(Peak_index1);
       

        Current_Matrix_Dopamine=[];
        Voltage_Matrix_Dopamine=[];
        for i = startCycle:endCycle % dopamine cycles
        
            One_Cycle_Index_DA=(Peak_index1(i)-offset_DA):1:(Peak_index1(i)+round(Data_points)-offset_DA-1);

            Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
       
            Current_Matrix_Dopamine=[Current_Matrix_Dopamine;Current_single_cycle_DA];
        end
            Average_current_DA=mean(Current_Matrix_Dopamine);
       

        %% Calculate the substracted current    
        
        Substrated_current=(Average_current_DA-Average_current_PBS);
        Peak_current_matrix=[];
       
        Subtracted_current_matrix=[];
        pluss=0;

        for j=4:1:(NumOfCycle_DA-10)   

            if((Peak_index1(j)-round(Duration/2*sampling_rate_ADC))==0)
                pluss=1;
            else
                pluss=0;
            end
        
            One_Cycle_Index_DA=(Peak_index1(j)-offset_DA):1:(Peak_index1(j)+round(Data_points)-offset_DA-1);
      

            Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
     
            Subtracted_current_single_cycle=Current_single_cycle_DA-Current_single_cycle;
       
            Index_low=[15:38];
            Subtracted_current_local=Subtracted_current_single_cycle(Index_low);

            Peak_current=max(Subtracted_current_local);

            Peak_current_matrix=[Peak_current_matrix Peak_current];
            Subtracted_current_matrix=[Subtracted_current_matrix Subtracted_current_single_cycle'];
       
        end

        period=Data_points;  
        vaxis = [-0.2:0.8/(Data_points/2):0.6-0.8/(Data_points/2)   0.6:-0.8/(Data_points/2):-0.2+0.8/(Data_points/2)] ;
        vaxis=vaxis';
       
        
        figure('color','w','position',[66 107 1750 857]);
        subplot(2,3,1)
        plot(vaxis, (Current_Matrix_Dopamine')*10^9,'r-',vaxis,(Current_Matrix_PBS')*10^9, 'b-','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine','PBS')
        grid minor;

            
        subplot(2,3,2)
        plot(vaxis, (Average_current_DA)*10^9,'r',vaxis,(Average_current_PBS)*10^9, 'b','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine','PBS')
        grid on;

       
        subplot(2,3,3)
        plot(vaxis, (Substrated_current)*10^9,'r','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine')
        grid on;

        
        subplot(2,3,4)
        plot((Peak_current_matrix)*10^9,'r','LineWidth',2)
        xlabel('Number of samples','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        grid minor;

       
        subplot(2,3,5)
        Total_length=length(Peak_current_matrix);
        Time_peak_current=(1:Total_length)*1/FSCV_frequency;
        plot(Time_peak_current,Peak_current_matrix*10^9,'r','LineWidth',2)
        xlabel('Time (sec)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        grid on;

        subplot(2,3,6)
        length_sub=length(Substrated_current);
        Time=(1:length_sub)/length_sub*(Voltage_High-Voltage_Low)/Ramp_rate*2*1e3;
        plot(Time, (Substrated_current)*10^9, 'r')
        xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        


% --- Executes on button press in rampCh2DataAnalysis.
function rampCh2DataAnalysis_Callback(hObject, eventdata, handles)
%% Define folder path and file name

        directoryName = handles.dname;
        Datafolder = directoryName;
        save_file_name ='SF1-8_C2_10Hz_20K_50_15percent_1103_400_extended_2uMDA_after_pretreatment_V1.csv';
        Device='CM N5A 64 C2 C6 10Hz 200V/s 2uM DA';

        %% Define parameters
        Frequency = str2num(get(handles.editFrequency,'String'));
        Voltage_High = str2num(get(handles.editPeakVoltageCh2,'String'));
        Voltage_Low = str2num(get(handles.editBottomVoltageCh2,'String'));
        Ramp_rate = str2num(get(handles.editScanRate,'String'));
        vcom = str2num(get(handles.editVcomCh2,'String'));
        startCycle = str2num(get(handles.DAstartCycle,'String'));
        endCycle = str2num(get(handles.DAendCycle,'String'));
        
        Rfb=4.1e6; % (Ohm)

        FSCV_frequency=10; % (Hz) or 0.1s
        Duration=2*(Voltage_High-Voltage_Low)/Ramp_rate; % 12 (ms)

        OSR=250;
        sampling_rate_ADC=2.5e6/(1*OSR); % (Hz)
        Data_points=Duration*sampling_rate_ADC;
        %% Read data from txt file
        cd (Datafolder)
        % Data_cell1 = csvread(save_file_name);
        ch2DataFileName = handles.name2Vol;
        fileID=fopen(ch2DataFileName,'r');  % aquired data from ADC
        A=fscanf(fileID,'%f\n');
        fclose(fileID);
        data_2=A;
        
        FSCV_PBS_data1=data_2;
        FSCV_DA_data1=data_2;

        [Peak1, Peak_index1]=findpeaks(data_2, 'MinPeakHeight', 0.1, 'MinPeakDistance',round(1/FSCV_frequency*sampling_rate_ADC)-10);
        peakInterval = diff(Peak_index1);
        NOCycle=length(Peak_index1);

        %% Correct the indecies of the maximum sampled ramp voltage 
        diff_data=diff(A);
        diff_peak=find(diff_data> 0.05);

        for i=[1:(NOCycle)]
        
        Peak_index1(i)=(Peak_index1(1)+1000*(i-1));  %the index represents the starting point of each cycle
        end  
        offset_DA =Peak_index1(1)- diff_peak(1);
        offset_PBS=offset_DA;
        
        %%

        half_period_num=round(Duration*sampling_rate_ADC/2);

        FSCV_current_PBS=(FSCV_PBS_data1-vcom)/Rfb;
       

        FSCV_current_Dopamine=((FSCV_DA_data1-vcom)/Rfb);
      

        %% Find the averaging for the first PBS measurement

        
        NumOfCycle=length(Peak_index1);
        

        Current_Matrix_PBS=[];
        Voltage_Matrix_PBS=[];
        for i=180:210  

        
            One_Cycle_Index=(Peak_index1(i)-offset_PBS):(Peak_index1(i)+round(Data_points)-offset_PBS-1);


            Current_single_cycle=FSCV_current_PBS(One_Cycle_Index)';

       

            Current_Matrix_PBS=[Current_Matrix_PBS;Current_single_cycle];
       
        end
        Average_current_PBS=mean(Current_Matrix_PBS);
       


        %% Find the averaging for the DA measurement    
        
        NumOfCycle_DA=length(Peak_index1);
       

        Current_Matrix_Dopamine=[];
        Voltage_Matrix_Dopamine=[];
        for i = startCycle:endCycle % dopamine cycles
        
            One_Cycle_Index_DA=(Peak_index1(i)-offset_DA):1:(Peak_index1(i)+round(Data_points)-offset_DA-1);

            Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
       
            Current_Matrix_Dopamine=[Current_Matrix_Dopamine;Current_single_cycle_DA];
        end
            Average_current_DA=mean(Current_Matrix_Dopamine);
       

        %% Calculate the substracted current    
        
        Substrated_current=(Average_current_DA-Average_current_PBS);
        Peak_current_matrix=[];
       
        Subtracted_current_matrix=[];
        pluss=0;

        for j=4:1:(NumOfCycle_DA-10)   

            if((Peak_index1(j)-round(Duration/2*sampling_rate_ADC))==0)
                pluss=1;
            else
                pluss=0;
            end
        
            One_Cycle_Index_DA=(Peak_index1(j)-offset_DA):1:(Peak_index1(j)+round(Data_points)-offset_DA-1);
      

            Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
     
            Subtracted_current_single_cycle=Current_single_cycle_DA-Current_single_cycle;
       
            Index_low=[15:38];
            Subtracted_current_local=Subtracted_current_single_cycle(Index_low);

            Peak_current=max(Subtracted_current_local);

            Peak_current_matrix=[Peak_current_matrix Peak_current];
            Subtracted_current_matrix=[Subtracted_current_matrix Subtracted_current_single_cycle'];
       
        end

        period=Data_points;  
        vaxis = [-0.2:0.8/(Data_points/2):0.6-0.8/(Data_points/2)   0.6:-0.8/(Data_points/2):-0.2+0.8/(Data_points/2)] ;
        vaxis=vaxis';
       
        
        figure('color','w','position',[66 107 1750 857]);
        subplot(2,3,1)
        plot(vaxis, (Current_Matrix_Dopamine')*10^9,'r-',vaxis,(Current_Matrix_PBS')*10^9, 'b-','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine','PBS')
        grid minor;

            
        subplot(2,3,2)
        plot(vaxis, (Average_current_DA)*10^9,'r',vaxis,(Average_current_PBS)*10^9, 'b','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine','PBS')
        grid on;

       
        subplot(2,3,3)
        plot(vaxis, (Substrated_current)*10^9,'r','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine')
        grid on;

        
        subplot(2,3,4)
        plot((Peak_current_matrix)*10^9,'r','LineWidth',2)
        xlabel('Number of samples','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        grid minor;

       
        subplot(2,3,5)
        Total_length=length(Peak_current_matrix);
        Time_peak_current=(1:Total_length)*1/FSCV_frequency;
        plot(Time_peak_current,Peak_current_matrix*10^9,'r','LineWidth',2)
        xlabel('Time (sec)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        grid on;

        subplot(2,3,6)
        length_sub=length(Substrated_current);
        Time=(1:length_sub)/length_sub*(Voltage_High-Voltage_Low)/Ramp_rate*2*1e3;
        plot(Time, (Substrated_current)*10^9, 'r')
        xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        


% --- Executes on button press in rampCh3DataAnalysis.
function rampCh3DataAnalysis_Callback(hObject, eventdata, handles)
%% Define folder path and file name

        directoryName = handles.dname;
        Datafolder = directoryName;
        save_file_name ='SF1-8_C2_10Hz_20K_50_15percent_1103_400_extended_2uMDA_after_pretreatment_V1.csv';
        Device='CM N5A 64 C2 C6 10Hz 200V/s 2uM DA';

        %% Define parameters
        Frequency = str2num(get(handles.editFrequency,'String'));
        Voltage_High = str2num(get(handles.editPeakVoltageCh3,'String'));
        Voltage_Low = str2num(get(handles.editBottomVoltageCh3,'String'));
        Ramp_rate = str2num(get(handles.editScanRate,'String'));
        vcom = str2num(get(handles.editVcomCh3,'String'));
        startCycle = str2num(get(handles.DAstartCycle,'String'));
        endCycle = str2num(get(handles.DAendCycle,'String'));
        
        Rfb=4.1e6; % (Ohm)

        FSCV_frequency=10; % (Hz) or 0.1s
        Duration=2*(Voltage_High-Voltage_Low)/Ramp_rate; % 12 (ms)

        OSR=250;
        sampling_rate_ADC=2.5e6/(1*OSR); % (Hz)
        Data_points=Duration*sampling_rate_ADC;
        %% Read data from txt file
        cd (Datafolder)
        % Data_cell1 = csvread(save_file_name);
        ch3DataFileName = handles.name3Vol;
        fileID=fopen(ch3DataFileName,'r');  % aquired data from ADC
        A=fscanf(fileID,'%f\n');
        fclose(fileID);
        data_3=A;
        
        FSCV_PBS_data1=data_3;
        FSCV_DA_data1=data_3;

        [Peak1, Peak_index1]=findpeaks(data_3, 'MinPeakHeight', 0.1, 'MinPeakDistance',round(1/FSCV_frequency*sampling_rate_ADC)-10);
        peakInterval = diff(Peak_index1);
        NOCycle=length(Peak_index1);

        %% Correct the indecies of the maximum sampled ramp voltage 
        diff_data=diff(A);
        diff_peak=find(diff_data> 0.05);

        for i=[1:(NOCycle)]
        
        Peak_index1(i)=(Peak_index1(1)+1000*(i-1));  %the index represents the starting point of each cycle
        end  
        offset_DA =Peak_index1(1)- diff_peak(1);
        offset_PBS=offset_DA;
        
        %%

        half_period_num=round(Duration*sampling_rate_ADC/2);

        FSCV_current_PBS=(FSCV_PBS_data1-vcom)/Rfb;
       

        FSCV_current_Dopamine=((FSCV_DA_data1-vcom)/Rfb);
      

        %% Find the averaging for the first PBS measurement

        
        NumOfCycle=length(Peak_index1);
        

        Current_Matrix_PBS=[];
        Voltage_Matrix_PBS=[];
        for i=180:210  

        
            One_Cycle_Index=(Peak_index1(i)-offset_PBS):(Peak_index1(i)+round(Data_points)-offset_PBS-1);


            Current_single_cycle=FSCV_current_PBS(One_Cycle_Index)';

       

            Current_Matrix_PBS=[Current_Matrix_PBS;Current_single_cycle];
       
        end
        Average_current_PBS=mean(Current_Matrix_PBS);
       


        %% Find the averaging for the DA measurement    
        
        NumOfCycle_DA=length(Peak_index1);
       

        Current_Matrix_Dopamine=[];
        Voltage_Matrix_Dopamine=[];
        for i = startCycle:endCycle % dopamine cycles
        
            One_Cycle_Index_DA=(Peak_index1(i)-offset_DA):1:(Peak_index1(i)+round(Data_points)-offset_DA-1);

            Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
       
            Current_Matrix_Dopamine=[Current_Matrix_Dopamine;Current_single_cycle_DA];
        end
            Average_current_DA=mean(Current_Matrix_Dopamine);
       

        %% Calculate the substracted current    
        
        Substrated_current=(Average_current_DA-Average_current_PBS);
        Peak_current_matrix=[];
       
        Subtracted_current_matrix=[];
        pluss=0;

        for j=4:1:(NumOfCycle_DA-10)   

            if((Peak_index1(j)-round(Duration/2*sampling_rate_ADC))==0)
                pluss=1;
            else
                pluss=0;
            end
        
            One_Cycle_Index_DA=(Peak_index1(j)-offset_DA):1:(Peak_index1(j)+round(Data_points)-offset_DA-1);
      

            Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
     
            Subtracted_current_single_cycle=Current_single_cycle_DA-Current_single_cycle;
       
            Index_low=[15:38];
            Subtracted_current_local=Subtracted_current_single_cycle(Index_low);

            Peak_current=max(Subtracted_current_local);

            Peak_current_matrix=[Peak_current_matrix Peak_current];
            Subtracted_current_matrix=[Subtracted_current_matrix Subtracted_current_single_cycle'];
       
        end

        period=Data_points;  
        vaxis = [-0.2:0.8/(Data_points/2):0.6-0.8/(Data_points/2)   0.6:-0.8/(Data_points/2):-0.2+0.8/(Data_points/2)] ;
        vaxis=vaxis';
       
        
        figure('color','w','position',[66 107 1750 857]);
        subplot(2,3,1)
        plot(vaxis, (Current_Matrix_Dopamine')*10^9,'r-',vaxis,(Current_Matrix_PBS')*10^9, 'b-','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine','PBS')
        grid minor;

            
        subplot(2,3,2)
        plot(vaxis, (Average_current_DA)*10^9,'r',vaxis,(Average_current_PBS)*10^9, 'b','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine','PBS')
        grid on;

       
        subplot(2,3,3)
        plot(vaxis, (Substrated_current)*10^9,'r','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine')
        grid on;

        
        subplot(2,3,4)
        plot((Peak_current_matrix)*10^9,'r','LineWidth',2)
        xlabel('Number of samples','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        grid minor;

       
        subplot(2,3,5)
        Total_length=length(Peak_current_matrix);
        Time_peak_current=(1:Total_length)*1/FSCV_frequency;
        plot(Time_peak_current,Peak_current_matrix*10^9,'r','LineWidth',2)
        xlabel('Time (sec)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        grid on;

        subplot(2,3,6)
        length_sub=length(Substrated_current);
        Time=(1:length_sub)/length_sub*(Voltage_High-Voltage_Low)/Ramp_rate*2*1e3;
        plot(Time, (Substrated_current)*10^9, 'r')
        xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        



% --- Executes on button press in rampCh4DataAnalysis.
function rampCh4DataAnalysis_Callback(hObject, eventdata, handles)
%% Define folder path and file name

        directoryName = handles.dname;
        Datafolder = directoryName;
        save_file_name ='SF1-8_C2_10Hz_20K_50_15percent_1103_400_extended_2uMDA_after_pretreatment_V1.csv';
        Device='CM N5A 64 C2 C6 10Hz 200V/s 2uM DA';

        %% Define parameters
        Frequency = str2num(get(handles.editFrequency,'String'));
        Voltage_High = str2num(get(handles.editPeakVoltageCh4,'String'));
        Voltage_Low = str2num(get(handles.editBottomVoltageCh4,'String'));
        Ramp_rate = str2num(get(handles.editScanRate,'String'));
        vcom = str2num(get(handles.editVcomCh4,'String'));
        startCycle = str2num(get(handles.DAstartCycle,'String'));
        endCycle = str2num(get(handles.DAendCycle,'String'));
        
        Rfb=4.1e6; % (Ohm)

        FSCV_frequency=10; % (Hz) or 0.1s
        Duration=2*(Voltage_High-Voltage_Low)/Ramp_rate; % 12 (ms)

        OSR=250;
        sampling_rate_ADC=2.5e6/(1*OSR); % (Hz)
        Data_points=Duration*sampling_rate_ADC;
        %% Read data from txt file
        cd (Datafolder)
        % Data_cell1 = csvread(save_file_name);
        ch4DataFileName = handles.name4Vol;
        fileID=fopen(ch2DataFileName,'r');  % aquired data from ADC
        A=fscanf(fileID,'%f\n');
        fclose(fileID);
        data_4=A;
        
        FSCV_PBS_data1=data_4;
        FSCV_DA_data1=data_4;

        [Peak1, Peak_index1]=findpeaks(data_4, 'MinPeakHeight', 0.1, 'MinPeakDistance',round(1/FSCV_frequency*sampling_rate_ADC)-10);
        peakInterval = diff(Peak_index1);
        NOCycle=length(Peak_index1);

        %% Correct the indecies of the maximum sampled ramp voltage 
        diff_data=diff(A);
        diff_peak=find(diff_data> 0.05);

        for i=[1:(NOCycle)]
        
        Peak_index1(i)=(Peak_index1(1)+1000*(i-1));  %the index represents the starting point of each cycle
        end  
        offset_DA =Peak_index1(1)- diff_peak(1);
        offset_PBS=offset_DA;
        
        %%

        half_period_num=round(Duration*sampling_rate_ADC/2);

        FSCV_current_PBS=(FSCV_PBS_data1-vcom)/Rfb;
       

        FSCV_current_Dopamine=((FSCV_DA_data1-vcom)/Rfb);
      

        %% Find the averaging for the first PBS measurement

        
        NumOfCycle=length(Peak_index1);
        

        Current_Matrix_PBS=[];
        Voltage_Matrix_PBS=[];
        for i=180:210  

        
            One_Cycle_Index=(Peak_index1(i)-offset_PBS):(Peak_index1(i)+round(Data_points)-offset_PBS-1);


            Current_single_cycle=FSCV_current_PBS(One_Cycle_Index)';

       

            Current_Matrix_PBS=[Current_Matrix_PBS;Current_single_cycle];
       
        end
        Average_current_PBS=mean(Current_Matrix_PBS);
       


        %% Find the averaging for the DA measurement    
        
        NumOfCycle_DA=length(Peak_index1);
       

        Current_Matrix_Dopamine=[];
        Voltage_Matrix_Dopamine=[];
        for i = startCycle:endCycle % dopamine cycles
        
            One_Cycle_Index_DA=(Peak_index1(i)-offset_DA):1:(Peak_index1(i)+round(Data_points)-offset_DA-1);

            Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
       
            Current_Matrix_Dopamine=[Current_Matrix_Dopamine;Current_single_cycle_DA];
        end
            Average_current_DA=mean(Current_Matrix_Dopamine);
       

        %% Calculate the substracted current    
        
        Substrated_current=(Average_current_DA-Average_current_PBS);
        Peak_current_matrix=[];
       
        Subtracted_current_matrix=[];
        pluss=0;

        for j=4:1:(NumOfCycle_DA-10)   

            if((Peak_index1(j)-round(Duration/2*sampling_rate_ADC))==0)
                pluss=1;
            else
                pluss=0;
            end
        
            One_Cycle_Index_DA=(Peak_index1(j)-offset_DA):1:(Peak_index1(j)+round(Data_points)-offset_DA-1);
      

            Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
     
            Subtracted_current_single_cycle=Current_single_cycle_DA-Current_single_cycle;
       
            Index_low=[15:38];
            Subtracted_current_local=Subtracted_current_single_cycle(Index_low);

            Peak_current=max(Subtracted_current_local);

            Peak_current_matrix=[Peak_current_matrix Peak_current];
            Subtracted_current_matrix=[Subtracted_current_matrix Subtracted_current_single_cycle'];
       
        end

        period=Data_points;  
        vaxis = [-0.2:0.8/(Data_points/2):0.6-0.8/(Data_points/2)   0.6:-0.8/(Data_points/2):-0.2+0.8/(Data_points/2)] ;
        vaxis=vaxis';
       
        
        figure('color','w','position',[66 107 1750 857]);
        subplot(2,3,1)
        plot(vaxis, (Current_Matrix_Dopamine')*10^9,'r-',vaxis,(Current_Matrix_PBS')*10^9, 'b-','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine','PBS')
        grid minor;

            
        subplot(2,3,2)
        plot(vaxis, (Average_current_DA)*10^9,'r',vaxis,(Average_current_PBS)*10^9, 'b','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine','PBS')
        grid on;

       
        subplot(2,3,3)
        plot(vaxis, (Substrated_current)*10^9,'r','LineWidth',2 )
        xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
        legend('Dopamine')
        grid on;

        
        subplot(2,3,4)
        plot((Peak_current_matrix)*10^9,'r','LineWidth',2)
        xlabel('Number of samples','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        grid minor;

       
        subplot(2,3,5)
        Total_length=length(Peak_current_matrix);
        Time_peak_current=(1:Total_length)*1/FSCV_frequency;
        plot(Time_peak_current,Peak_current_matrix*10^9,'r','LineWidth',2)
        xlabel('Time (sec)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        grid on;

        subplot(2,3,6)
        length_sub=length(Substrated_current);
        Time=(1:length_sub)/length_sub*(Voltage_High-Voltage_Low)/Ramp_rate*2*1e3;
        plot(Time, (Substrated_current)*10^9, 'r')
        xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
        ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
        




function pretreatDuration_Callback(hObject, eventdata, handles)
% hObject    handle to pretreatDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pretreatDuration as text
%        str2double(get(hObject,'String')) returns contents of pretreatDuration as a double


% --- Executes during object creation, after setting all properties.
function pretreatDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pretreatDuration (see GCBO)
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



function DAstartCycle_Callback(hObject, eventdata, handles)
% hObject    handle to DAstartCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DAstartCycle as text
%        str2double(get(hObject,'String')) returns contents of DAstartCycle as a double


% --- Executes during object creation, after setting all properties.
function DAstartCycle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DAstartCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DAendCycle_Callback(hObject, eventdata, handles)
% hObject    handle to DAendCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DAendCycle as text
%        str2double(get(hObject,'String')) returns contents of DAendCycle as a double


% --- Executes during object creation, after setting all properties.
function DAendCycle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DAendCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nshapeDA_Callback(hObject, eventdata, handles)
% hObject    handle to nshapeDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nshapeDA as text
%        str2double(get(hObject,'String')) returns contents of nshapeDA as a double


% --- Executes during object creation, after setting all properties.
function nshapeDA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nshapeDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nshapePBS_Callback(hObject, eventdata, handles)
% hObject    handle to nshapePBS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nshapePBS as text
%        str2double(get(hObject,'String')) returns contents of nshapePBS as a double


% --- Executes during object creation, after setting all properties.
function nshapePBS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nshapePBS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
