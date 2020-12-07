function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 03-Jul-2018 11:12:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% P = 128;
% Q = 48;
% div1 = 125;

loadlibrary('okFrontPanel', 'okFrontPanelDLL.h');
handles.xem = calllib('okFrontPanel', 'okFrontPanel_Construct');
handles.numDevices = calllib('okFrontPanel', 'okFrontPanel_GetDeviceCount', handles.xem);
handles.ret = calllib('okFrontPanel', 'okFrontPanel_OpenBySerial', handles.xem, '');
handles.success_checkOPEN = calllib('okFrontPanel', 'okFrontPanel_IsOpen', handles.xem);

% % handles.pll = calllib('okFrontPanel', 'okPLL22150_Construct');
% % calllib('okFrontPanel', 'okPLL22150_SetCrystalLoad', handles.pll, 12.0);
% % calllib('okFrontPanel', 'okPLL22150_SetReference', handles.pll, 48.0, 1);

% calllib('okFrontPanel', 'okPLL22150_SetVCOParameters', handles.pll, P, Q);
% handles.VCO_freq = calllib('okFrontPanel', 'okPLL22150_GetVCOFrequency', handles.pll);
% calllib('okFrontPanel', 'okPLL22150_SetDiv1', handles.pll, 1, div1);
% calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 0, 1);
% handles.freq_out1 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 0);
% calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 0, 1);
% 
% calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 1, 0);
% handles.freq_out2 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 1);
% calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 1, 1);
% calllib('okFrontPanel', 'okFrontPanel_SetPLL22150Configuration', handles.xem, handles.pll);
handles.success_configure = calllib('okFrontPanel', 'okFrontPanel_ConfigureFPGA', handles.xem,'wirein_test1.bit');

guidata(hObject, handles);

assignin('base','VCO',handles.numDevices);
assignin('base','ramp_clk',handles.ret);
assignin('base','USB_clk',handles.success_checkOPEN);


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
guidata(hObject, handles);

% --- Executes on button press in enable_ramp.
function enable_ramp_Callback(hObject, eventdata, handles)
% hObject    handle to enable_ramp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enable_ramp
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('01'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end
guidata(hObject, handles);

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
guidata(hObject, handles);

% --- Executes on button press in pipeout.
function pipeout_Callback(hObject, eventdata, handles)
% hObject    handle to pipeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

freq=10*1000;
cycle=120;
period=1/freq;
f0 = 4096;
blocksize=16384;
data_length=4*f0;
buf_A0(data_length,1) = uint8(0);
epvalue_A0(data_length,1) = uint8(0);
pv_A0 = libpointer('uint8Ptr', buf_A0);
epvalue_A0 = get(pv_A0, 'value');
data_A0=[];
%pause(0.1);
t = 0;
delay=f0/freq;

success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'),1,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
pause(period);
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'),0,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
pause(20*period);

for i= 1:cycle
    %disp(i);
    disp(t);
    pause(delay-t);
    tic

    handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize,(4*f0), pv_A0);
    epvalue_A0 = get(pv_A0, 'value');

    data_tmp_A0 = (double(epvalue_A0(1:4:(4*(f0-1)-1)))+256*double(epvalue_A0(2:4:(4*(f0-1)))));
    data_A0=[data_A0 data_tmp_A0];

    t = toc;
end

%assignin('base','DATA',data_A0);
assignin('base','DATA2',data_A0);

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
