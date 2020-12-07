function varargout = pipeout_wirein(varargin)
% PIPEOUT_WIREIN MATLAB code for pipeout_wirein.fig
%      PIPEOUT_WIREIN, by itself, creates a new PIPEOUT_WIREIN or raises the existing
%      singleton*.
%
%      H = PIPEOUT_WIREIN returns the handle to a new PIPEOUT_WIREIN or the handle to
%      the existing singleton*.
%
%      PIPEOUT_WIREIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIPEOUT_WIREIN.M with the given input arguments.
%
%      PIPEOUT_WIREIN('Property','Value',...) creates a new PIPEOUT_WIREIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pipeout_wirein_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pipeout_wirein_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pipeout_wirein

% Last Modified by GUIDE v2.5 02-Jul-2018 11:31:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pipeout_wirein_OpeningFcn, ...
                   'gui_OutputFcn',  @pipeout_wirein_OutputFcn, ...
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

% --- Executes just before pipeout_wirein is made visible.
function pipeout_wirein_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pipeout_wirein (see VARARGIN)

% Choose default command line output for pipeout_wirein
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pipeout_wirein wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pipeout_wirein_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% ------------------------- %


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% disp('hello world start');

cla(handles.axes1);

%{
str = inputdlg({'P','Q','div1(delta_sigma)'},'Input dialog');
P = str2num(str{1}); %128
Q = str2num(str{2}); %48
div1 = str2num(str{3}); %125
%}

P = 128;
Q = 48;
div1 = 125;

% Clock
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
calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 0, 1);
handles.freq_out1 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 0);
calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 0, 1);

calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 1, 0);
handles.freq_out2 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 1);
calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 1, 1);

% Upload Bit File
calllib('okFrontPanel', 'okFrontPanel_SetPLL22150Configuration', handles.xem, handles.pll);
handles.success_configure = calllib('okFrontPanel', 'okFrontPanel_ConfigureFPGA', handles.xem,'wirein_test1.bit');

guidata(hObject, handles);

% View Variables
assignin('base','VCO',handles.VCO_freq);
assignin('base','ramp_clk',handles.freq_out1);
assignin('base','USB_clk',handles.freq_out2);

% --- Executes on button press in test_signal.
function test_signal_Callback(hObject, eventdata, handles)
% hObject    handle to test_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%disp('hello world test_signal');

freq = str2double(get(handles.frequency,'String'));
t = eval(get(handles.time,'String'));

% Calculate data
x = sin(2*pi*freq*t);

% Create time plot
plot(handles.axes1,t,x);
set(handles.axes1,'XMinorTick','on');
grid on

% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function time_Callback(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time as text
%        str2double(get(hObject,'String')) returns contents of time as a double
set(handles.test_signal,'Enable','off');
try
    t = eval(get(handles.time,'String'));
    if ~isnumeric(t)
        % t is not a number
        set(handles.test_signal,'String','t is not numeric')
    elseif length(t) < 2
        % t is not a vector
        set(handles.test_signal,'String','t must be vector')
    elseif length(t) > 1000
        % t is too long a vector to plot clearly
        set(handles.test_signal,'String','t is too long')
    elseif min(diff(t)) < 0
        % t is not monotonically increasing
        set(handles.test_signal,'String','t must increase')
    else
        % Enable the Plot button with its original name
        set(handles.test_signal,'String','Plot')
        set(handles.test_signal,'Enable','on')
        return
    end

 catch ME
    % Cannot evaluate expression user typed
    set(handles.test_signal,'String','Cannot plot t');
    uicontrol(hObject);
end

% --- Executes during object creation, after setting all properties.
function frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function frequency_Callback(hObject, eventdata, handles)
% hObject    handle to frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequency as text
%        str2double(get(hObject,'String')) returns contents of frequency as a double
freq = str2double(get(hObject,'String'));
if isnan(freq) || ~isreal(freq)  
    set(handles.test_signal,'String','Unable to Plot');
    set(handles.test_signal,'Enable','off');
    uicontrol(hObject);
else 
    set(handles.test_signal,'String','Plot');
    set(handles.test_signal,'Enable','on');
end

% --- Executes on button press in pipeout.
function pipeout_Callback(hObject, eventdata, handles)
% hObject    handle to pipeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% disp('hello world pipeout');

blocksize = 512;
f0 = 2*blocksize;

% Datasheet Buffer
buf_A0(f0,1) = uint8(0);
epvalue_A0(f0,1) = uint8(0);
pv_A0 = libpointer('uint8Ptr', buf_A0);

calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), 1024,f0, pv_A0);
epvalue_A0 = get(pv_A0, 'value');
pause(0.1);
t = 0:.001:1.023;

% Read in Values for Plot
%  disp(size(t));
%  disp(size(epvalue_A0));
disp(t);
disp(double(epvalue_A0));

plot(handles.axes1, t, double(epvalue_A0));
set(handles.axes1,'XMinorTick','on');
grid on

% --- Executes on button press in reset_ramp.
function reset_ramp_Callback(hObject, eventdata, handles)
% hObject    handle to reset_ramp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),1,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
pause(0.1)
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'),0,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);

% --- Executes on button press in enable_ramp.
function enable_ramp_Callback(hObject, eventdata, handles)
% hObject    handle to enable_ramp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in reset_fifo.
function reset_fifo_Callback(hObject, eventdata, handles)
% hObject    handle to reset_fifo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'),1,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
pause(0.1)
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'),0,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);

% --- Executes on button press in unload.
function unload_Callback(hObject, eventdata, handles)
% hObject    handle to unload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('hello world unload');

calllib('okFrontPanel', 'okFrontPanel_Destruct', handles.xem);
guidata(hObject, handles);
clear all;
unloadlibrary okFrontPanel
