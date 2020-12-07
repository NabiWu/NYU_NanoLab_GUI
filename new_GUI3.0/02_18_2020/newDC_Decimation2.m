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

% Last Modified by GUIDE v2.5 18-Feb-2020 17:53:54

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

    
 thirdTab = uitab(tg,'Title', 'Channel3 Data Analysis');
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
    
 fourthTab = uitab(tg,'Title', 'Channel4 Data Analysis');
 axes('Parent',fourthTab);
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



function edit148_Callback(hObject, eventdata, handles)
% hObject    handle to edit148 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit148 as text
%        str2double(get(hObject,'String')) returns contents of edit148 as a double


% --- Executes during object creation, after setting all properties.
function edit148_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit148 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit149_Callback(hObject, eventdata, handles)
% hObject    handle to edit149 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit149 as text
%        str2double(get(hObject,'String')) returns contents of edit149 as a double


% --- Executes during object creation, after setting all properties.
function edit149_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit149 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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



function edit205_Callback(hObject, eventdata, handles)
% hObject    handle to edit205 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit205 as text
%        str2double(get(hObject,'String')) returns contents of edit205 as a double


% --- Executes during object creation, after setting all properties.
function edit205_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit205 (see GCBO)
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
            imp_L1=(((mean(data_FSCV_L1')-0)/(1))-Vcom)/(RfeedBack(1));
        end
        if length(data_FSCV_R1)==0
            imp_R1=zeros(1,(2*N_R1+1));
        else
            imp_R1=(((mean(data_FSCV_R1')-0)/(1))-Vcom)/(RfeedBack(2));
        end
        
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
        
        ch1I = [ch1I1p ch1I2p ch1I3b ch1I4b];
        ch2I = [ch2I1p ch2I2p ch2I3b ch2I4b];
        ch3I = [ch3I1p ch3I2p ch3I3b ch3I4b];
        ch4I = [ch4I1p ch4I2p ch4I3b ch4I4b];
        
        ch1LastRow = ch1cursorCur(end, :);
        ch2LastRow = ch1cursorCur(end, :);
        ch3LastRow = ch1cursorCur(end, :);
        ch4LastRow = ch1cursorCur(end, :);
        
        ch1CurSlopTem = ch1I ./ ch1LastRow;
        ch2CurSlopTem = ch2I ./ ch2LastRow;
        ch3CurSlopTem = ch3I ./ ch3LastRow;
        ch4CurSlopTem = ch4I ./ ch4LastRow;
        
        %This is what we need to store
        ch1cursorCur = [ch1cursorCur; ch1I];
        ch2cursorCur = [ch2cursorCur; ch2I];
        ch3cursorCur = [ch3cursorCur; ch3I];
        ch4cursorCur = [ch4cursorCur; ch4I];
        
        ch1CurSlop = [ch1CurSlop; ch1CurSlopTem];
        ch2CurSlop = [ch2CurSlop; ch2CurSlopTem];
        ch3CurSlop = [ch3CurSlop; ch3CurSlopTem];
        ch4CurSlop = [ch4CurSlop; ch4CurSlopTem];
        
        

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
        
        contents = get(handles.slopeChSelect,'String'); 
        slopeChSelectValue = contents{get(handles.slopeChSelect,'Value')};
        
        if (strcmp(slopeChSelectValue,'CH1'))
            set(handles.I1Slope, 'String', ch1CurSlopTem(1));
            set(handles.I2Slope, 'String', ch1CurSlopTem(2));
            set(handles.I3Slope, 'String', ch1CurSlopTem(3));
            set(handles.I4Slope, 'String', ch1CurSlopTem(4));
        elseif (strcmp(slopeChSelectValue,'CH2'))
            set(handles.I1Slope, 'String', ch2CurSlopTem(1));
            set(handles.I2Slope, 'String', ch2CurSlopTem(2));
            set(handles.I3Slope, 'String', ch2CurSlopTem(3));
            set(handles.I4Slope, 'String', ch2CurSlopTem(4));
        elseif (strcmp(slopeChSelectValue,'CH3'))
            set(handles.I1Slope, 'String', ch3CurSlopTem(1));
            set(handles.I2Slope, 'String', ch3CurSlopTem(2));
            set(handles.I3Slope, 'String', ch3CurSlopTem(3));
            set(handles.I4Slope, 'String', ch3CurSlopTem(4));
        elseif (strcmp(slopeChSelectValue,'CH4'))
            set(handles.I1Slope, 'String', ch4CurSlopTem(1));
            set(handles.I2Slope, 'String', ch4CurSlopTem(2));
            set(handles.I3Slope, 'String', ch4CurSlopTem(3));
            set(handles.I4Slope, 'String', ch4CurSlopTem(4)); 
        end
    
        
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



function edit157_Callback(hObject, eventdata, handles)
% hObject    handle to edit157 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit157 as text
%        str2double(get(hObject,'String')) returns contents of edit157 as a double


% --- Executes during object creation, after setting all properties.
function edit157_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit157 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit158_Callback(hObject, eventdata, handles)
% hObject    handle to edit158 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit158 as text
%        str2double(get(hObject,'String')) returns contents of edit158 as a double


% --- Executes during object creation, after setting all properties.
function edit158_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit158 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit159_Callback(hObject, eventdata, handles)
% hObject    handle to edit159 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit159 as text
%        str2double(get(hObject,'String')) returns contents of edit159 as a double


% --- Executes during object creation, after setting all properties.
function edit159_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit159 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit160_Callback(hObject, eventdata, handles)
% hObject    handle to edit160 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit160 as text
%        str2double(get(hObject,'String')) returns contents of edit160 as a double


% --- Executes during object creation, after setting all properties.
function edit160_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit160 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit161_Callback(hObject, eventdata, handles)
% hObject    handle to edit161 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit161 as text
%        str2double(get(hObject,'String')) returns contents of edit161 as a double


% --- Executes during object creation, after setting all properties.
function edit161_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit161 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit162_Callback(hObject, eventdata, handles)
% hObject    handle to edit162 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit162 as text
%        str2double(get(hObject,'String')) returns contents of edit162 as a double


% --- Executes during object creation, after setting all properties.
function edit162_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit162 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit163_Callback(hObject, eventdata, handles)
% hObject    handle to edit163 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit163 as text
%        str2double(get(hObject,'String')) returns contents of edit163 as a double


% --- Executes during object creation, after setting all properties.
function edit163_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit163 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit164_Callback(hObject, eventdata, handles)
% hObject    handle to edit164 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit164 as text
%        str2double(get(hObject,'String')) returns contents of edit164 as a double


% --- Executes during object creation, after setting all properties.
function edit164_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit164 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit165_Callback(hObject, eventdata, handles)
% hObject    handle to edit165 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit165 as text
%        str2double(get(hObject,'String')) returns contents of edit165 as a double


% --- Executes during object creation, after setting all properties.
function edit165_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit165 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit166_Callback(hObject, eventdata, handles)
% hObject    handle to edit166 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit166 as text
%        str2double(get(hObject,'String')) returns contents of edit166 as a double


% --- Executes during object creation, after setting all properties.
function edit166_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit166 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit167_Callback(hObject, eventdata, handles)
% hObject    handle to edit167 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit167 as text
%        str2double(get(hObject,'String')) returns contents of edit167 as a double


% --- Executes during object creation, after setting all properties.
function edit167_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit167 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit168_Callback(hObject, eventdata, handles)
% hObject    handle to edit168 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit168 as text
%        str2double(get(hObject,'String')) returns contents of edit168 as a double


% --- Executes during object creation, after setting all properties.
function edit168_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit168 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit169_Callback(hObject, eventdata, handles)
% hObject    handle to edit169 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit169 as text
%        str2double(get(hObject,'String')) returns contents of edit169 as a double


% --- Executes during object creation, after setting all properties.
function edit169_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit169 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit170_Callback(hObject, eventdata, handles)
% hObject    handle to edit170 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit170 as text
%        str2double(get(hObject,'String')) returns contents of edit170 as a double


% --- Executes during object creation, after setting all properties.
function edit170_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit170 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit171_Callback(hObject, eventdata, handles)
% hObject    handle to edit171 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit171 as text
%        str2double(get(hObject,'String')) returns contents of edit171 as a double


% --- Executes during object creation, after setting all properties.
function edit171_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit171 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit172_Callback(hObject, eventdata, handles)
% hObject    handle to edit172 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit172 as text
%        str2double(get(hObject,'String')) returns contents of edit172 as a double


% --- Executes during object creation, after setting all properties.
function edit172_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit172 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit173_Callback(hObject, eventdata, handles)
% hObject    handle to edit173 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit173 as text
%        str2double(get(hObject,'String')) returns contents of edit173 as a double


% --- Executes during object creation, after setting all properties.
function edit173_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit173 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit174_Callback(hObject, eventdata, handles)
% hObject    handle to edit174 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit174 as text
%        str2double(get(hObject,'String')) returns contents of edit174 as a double


% --- Executes during object creation, after setting all properties.
function edit174_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit174 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit175_Callback(hObject, eventdata, handles)
% hObject    handle to edit175 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit175 as text
%        str2double(get(hObject,'String')) returns contents of edit175 as a double


% --- Executes during object creation, after setting all properties.
function edit175_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit175 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit176_Callback(hObject, eventdata, handles)
% hObject    handle to edit176 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit176 as text
%        str2double(get(hObject,'String')) returns contents of edit176 as a double


% --- Executes during object creation, after setting all properties.
function edit176_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit176 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit177_Callback(hObject, eventdata, handles)
% hObject    handle to edit177 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit177 as text
%        str2double(get(hObject,'String')) returns contents of edit177 as a double


% --- Executes during object creation, after setting all properties.
function edit177_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit177 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit178_Callback(hObject, eventdata, handles)
% hObject    handle to edit178 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit178 as text
%        str2double(get(hObject,'String')) returns contents of edit178 as a double


% --- Executes during object creation, after setting all properties.
function edit178_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit178 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit179_Callback(hObject, eventdata, handles)
% hObject    handle to edit179 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit179 as text
%        str2double(get(hObject,'String')) returns contents of edit179 as a double


% --- Executes during object creation, after setting all properties.
function edit179_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit179 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit180_Callback(hObject, eventdata, handles)
% hObject    handle to edit180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit180 as text
%        str2double(get(hObject,'String')) returns contents of edit180 as a double


% --- Executes during object creation, after setting all properties.
function edit180_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit181_Callback(hObject, eventdata, handles)
% hObject    handle to edit181 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit181 as text
%        str2double(get(hObject,'String')) returns contents of edit181 as a double


% --- Executes during object creation, after setting all properties.
function edit181_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit181 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit182_Callback(hObject, eventdata, handles)
% hObject    handle to edit182 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit182 as text
%        str2double(get(hObject,'String')) returns contents of edit182 as a double


% --- Executes during object creation, after setting all properties.
function edit182_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit182 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit183_Callback(hObject, eventdata, handles)
% hObject    handle to edit183 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit183 as text
%        str2double(get(hObject,'String')) returns contents of edit183 as a double


% --- Executes during object creation, after setting all properties.
function edit183_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit183 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit184_Callback(hObject, eventdata, handles)
% hObject    handle to edit184 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit184 as text
%        str2double(get(hObject,'String')) returns contents of edit184 as a double


% --- Executes during object creation, after setting all properties.
function edit184_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit184 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit185_Callback(hObject, eventdata, handles)
% hObject    handle to edit185 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit185 as text
%        str2double(get(hObject,'String')) returns contents of edit185 as a double


% --- Executes during object creation, after setting all properties.
function edit185_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit185 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit186_Callback(hObject, eventdata, handles)
% hObject    handle to edit186 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit186 as text
%        str2double(get(hObject,'String')) returns contents of edit186 as a double


% --- Executes during object creation, after setting all properties.
function edit186_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit186 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit187_Callback(hObject, eventdata, handles)
% hObject    handle to edit187 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit187 as text
%        str2double(get(hObject,'String')) returns contents of edit187 as a double


% --- Executes during object creation, after setting all properties.
function edit187_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit187 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit188_Callback(hObject, eventdata, handles)
% hObject    handle to edit188 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit188 as text
%        str2double(get(hObject,'String')) returns contents of edit188 as a double


% --- Executes during object creation, after setting all properties.
function edit188_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit188 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit189_Callback(hObject, eventdata, handles)
% hObject    handle to edit189 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit189 as text
%        str2double(get(hObject,'String')) returns contents of edit189 as a double


% --- Executes during object creation, after setting all properties.
function edit189_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit189 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit190_Callback(hObject, eventdata, handles)
% hObject    handle to edit190 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit190 as text
%        str2double(get(hObject,'String')) returns contents of edit190 as a double


% --- Executes during object creation, after setting all properties.
function edit190_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit190 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit191_Callback(hObject, eventdata, handles)
% hObject    handle to edit191 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit191 as text
%        str2double(get(hObject,'String')) returns contents of edit191 as a double


% --- Executes during object creation, after setting all properties.
function edit191_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit191 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit192_Callback(hObject, eventdata, handles)
% hObject    handle to edit192 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit192 as text
%        str2double(get(hObject,'String')) returns contents of edit192 as a double


% --- Executes during object creation, after setting all properties.
function edit192_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit192 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit193_Callback(hObject, eventdata, handles)
% hObject    handle to edit193 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit193 as text
%        str2double(get(hObject,'String')) returns contents of edit193 as a double


% --- Executes during object creation, after setting all properties.
function edit193_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit193 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit194_Callback(hObject, eventdata, handles)
% hObject    handle to edit194 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit194 as text
%        str2double(get(hObject,'String')) returns contents of edit194 as a double


% --- Executes during object creation, after setting all properties.
function edit194_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit194 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit195_Callback(hObject, eventdata, handles)
% hObject    handle to edit195 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit195 as text
%        str2double(get(hObject,'String')) returns contents of edit195 as a double


% --- Executes during object creation, after setting all properties.
function edit195_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit195 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit196_Callback(hObject, eventdata, handles)
% hObject    handle to edit196 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit196 as text
%        str2double(get(hObject,'String')) returns contents of edit196 as a double


% --- Executes during object creation, after setting all properties.
function edit196_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit196 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit197_Callback(hObject, eventdata, handles)
% hObject    handle to edit197 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit197 as text
%        str2double(get(hObject,'String')) returns contents of edit197 as a double


% --- Executes during object creation, after setting all properties.
function edit197_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit197 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit198_Callback(hObject, eventdata, handles)
% hObject    handle to edit198 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit198 as text
%        str2double(get(hObject,'String')) returns contents of edit198 as a double


% --- Executes during object creation, after setting all properties.
function edit198_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit198 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit199_Callback(hObject, eventdata, handles)
% hObject    handle to edit199 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit199 as text
%        str2double(get(hObject,'String')) returns contents of edit199 as a double


% --- Executes during object creation, after setting all properties.
function edit199_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit199 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit200_Callback(hObject, eventdata, handles)
% hObject    handle to edit200 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit200 as text
%        str2double(get(hObject,'String')) returns contents of edit200 as a double


% --- Executes during object creation, after setting all properties.
function edit200_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit200 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit201_Callback(hObject, eventdata, handles)
% hObject    handle to edit201 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit201 as text
%        str2double(get(hObject,'String')) returns contents of edit201 as a double


% --- Executes during object creation, after setting all properties.
function edit201_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit201 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit202_Callback(hObject, eventdata, handles)
% hObject    handle to edit202 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit202 as text
%        str2double(get(hObject,'String')) returns contents of edit202 as a double


% --- Executes during object creation, after setting all properties.
function edit202_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit202 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit203_Callback(hObject, eventdata, handles)
% hObject    handle to edit203 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit203 as text
%        str2double(get(hObject,'String')) returns contents of edit203 as a double


% --- Executes during object creation, after setting all properties.
function edit203_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit203 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit204_Callback(hObject, eventdata, handles)
% hObject    handle to edit204 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit204 as text
%        str2double(get(hObject,'String')) returns contents of edit204 as a double


% --- Executes during object creation, after setting all properties.
function edit204_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit204 (see GCBO)
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
% hObject    handle to ch3I4b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3I4b as text
%        str2double(get(hObject,'String')) returns contents of ch3I4b as a double


% --- Executes during object creation, after setting all properties.
function edit73_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3I4b (see GCBO)
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


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit206_Callback(hObject, eventdata, handles)
% hObject    handle to edit206 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit206 as text
%        str2double(get(hObject,'String')) returns contents of edit206 as a double


% --- Executes during object creation, after setting all properties.
function edit206_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit206 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit207_Callback(hObject, eventdata, handles)
% hObject    handle to edit207 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit207 as text
%        str2double(get(hObject,'String')) returns contents of edit207 as a double


% --- Executes during object creation, after setting all properties.
function edit207_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit207 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit208_Callback(hObject, eventdata, handles)
% hObject    handle to edit208 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit208 as text
%        str2double(get(hObject,'String')) returns contents of edit208 as a double


% --- Executes during object creation, after setting all properties.
function edit208_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit208 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit209_Callback(hObject, eventdata, handles)
% hObject    handle to edit209 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit209 as text
%        str2double(get(hObject,'String')) returns contents of edit209 as a double


% --- Executes during object creation, after setting all properties.
function edit209_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit209 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit210_Callback(hObject, eventdata, handles)
% hObject    handle to edit210 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit210 as text
%        str2double(get(hObject,'String')) returns contents of edit210 as a double


% --- Executes during object creation, after setting all properties.
function edit210_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit210 (see GCBO)
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


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
