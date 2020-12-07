function varargout = DC_decimation(varargin)
% DC_DECIMATION MATLAB code for DC_decimation.fig
%      DC_DECIMATION, by itself, creates a new DC_DECIMATION or raises the existing
%      singleton*.
%
%      H = DC_DECIMATION returns the handle to a new DC_DECIMATION or the handle to
%      the existing singleton*.
%```
%      DC_DECIMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DC_DECIMATION.M with the given input arguments.
%
%      DC_DECIMATION('Property','Value',...) creates a new DC_DECIMATION or raises the
%      existing singleton*  Starting from the left, property value pairs are
%      applied to the GUI before DC_decimation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DC_decimation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DC_decimation

% Last Modified by GUIDE v2.5 05-Jul-2019 14:44:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DC_decimation_OpeningFcn, ...
                   'gui_OutputFcn',  @DC_decimation_OutputFcn, ...
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


% --- Executes just before DC_decimation is made visible.
function DC_decimation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DC_decimation (see VARARGIN)

% Choose default command line output for DC_decimation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DC_decimation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DC_decimation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;







% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'), 1,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
pause(0.1);
success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('00'), 0,hex2dec('01'));
calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);

guidata(hObject, handles);

% --- Executes on button press in Enable.
function Enable_Callback(hObject, eventdata, handles)
% hObject    handle to Enable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Enable
if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('02'), 0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

guidata(hObject, handles);

% --- Executes on button press in ch_selL0.
function ch_selL0_Callback(hObject, eventdata, handles)
% hObject    handle to ch_selL0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch_selL0

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('03'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('03'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end


guidata(hObject, handles);

% --- Executes on button press in ch_selL1.
function ch_selL1_Callback(hObject, eventdata, handles)
% hObject    handle to ch_selL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch_selL1

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('04'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('04'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in bfet_selL0.
function bfet_selL0_Callback(hObject, eventdata, handles)
% hObject    handle to bfet_selL0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bfet_selL0

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('05'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('05'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end


% --- Executes on button press in bfet_selL1.
function bfet_selL1_Callback(hObject, eventdata, handles)
% hObject    handle to bfet_selL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bfet_selL1

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('06'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('06'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in tstenL.
function tstenL_Callback(hObject, eventdata, handles)
% hObject    handle to tstenL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tstenL

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('07'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('07'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in tia_enL1.
function tia_enL1_Callback(hObject, eventdata, handles)
% hObject    handle to tia_enL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tia_enL1

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('08'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('08'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in pga_enL.
function pga_enL_Callback(hObject, eventdata, handles)
% hObject    handle to pga_enL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pga_enL

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('09'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('09'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in tia_enL2.
function tia_enL2_Callback(hObject, eventdata, handles)
% hObject    handle to tia_enL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tia_enL2

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0A'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in pgaL0.
function pgaL0_Callback(hObject, eventdata, handles)
% hObject    handle to pgaL0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pgaL0

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0B'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0B'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in pgaL1.
function pgaL1_Callback(hObject, eventdata, handles)
% hObject    handle to pgaL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pgaL1

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0C'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0C'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in tia_enL3.
function tia_enL3_Callback(hObject, eventdata, handles)
% hObject    handle to tia_enL3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tia_enL3

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0D'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0D'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in adc_enL.
function adc_enL_Callback(hObject, eventdata, handles)
% hObject    handle to adc_enL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of adc_enL

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0E'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in ck_enL.
function ck_enL_Callback(hObject, eventdata, handles)
% hObject    handle to ck_enL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ck_enL

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('0F'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in iref_enL.
function iref_enL_Callback(hObject, eventdata, handles)
% hObject    handle to iref_enL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of iref_enL

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('10'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('10'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in ch_selR0.
function ch_selR0_Callback(hObject, eventdata, handles)
% hObject    handle to ch_selR0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch_selR0

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('11'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in ch_selR1.
function ch_selR1_Callback(hObject, eventdata, handles)
% hObject    handle to ch_selR1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch_selR1

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('12'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in bfet_selR0.
function bfet_selR0_Callback(hObject, eventdata, handles)
% hObject    handle to bfet_selR0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bfet_selR0

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('13'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('13'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in bfet_selR1.
function bfet_selR1_Callback(hObject, eventdata, handles)
% hObject    handle to bfet_selR1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bfet_selR1

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('14'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('14'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in tstenR.
function tstenR_Callback(hObject, eventdata, handles)
% hObject    handle to tstenR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tstenR

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('15'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('15'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in tia_enR1.
function tia_enR1_Callback(hObject, eventdata, handles)
% hObject    handle to tia_enR1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tia_enR1

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('16'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('16'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in pga_enR.
function pga_enR_Callback(hObject, eventdata, handles)
% hObject    handle to pga_enR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pga_enR

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('17'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('17'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in tia_enR2.
function tia_enR2_Callback(hObject, eventdata, handles)
% hObject    handle to tia_enR2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tia_enR2

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('18'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in pga_R0.
function pga_R0_Callback(hObject, eventdata, handles)
% hObject    handle to pga_R0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pga_R0

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('19'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('19'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in pga_R1.
function pga_R1_Callback(hObject, eventdata, handles)
% hObject    handle to pga_R1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pga_R1

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1A'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1A'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in tia_enR3.
function tia_enR3_Callback(hObject, eventdata, handles)
% hObject    handle to tia_enR3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tia_enR3

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1B'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1B'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in adc_enR.
function adc_enR_Callback(hObject, eventdata, handles)
% hObject    handle to adc_enR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of adc_enR

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1C'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in ck_enR.
function ck_enR_Callback(hObject, eventdata, handles)
% hObject    handle to ck_enR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ck_enR

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1D'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in iref_enR.
function iref_enR_Callback(hObject, eventdata, handles)
% hObject    handle to iref_enR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of iref_enR

if(get(hObject,'Value') == 1)
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),1,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
else
  success_wirein=calllib('okFrontPanel', 'okFrontPanel_SetWireInValue', handles.xem, hex2dec('1E'),0,hex2dec('01'));
  calllib('okFrontPanel', 'okFrontPanel_UpdateWireIns', handles.xem);
end

% --- Executes on button press in Set.
function Set_Callback(hObject, eventdata, handles)
% hObject    handle to Set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%str=inputdlg({'P','Q','div1(delta_sigma)','div2(DAC)'},'Input dialog');
%P=str2num(str{1});
%Q=str2num(str{2});
%div1=str2num(str{3});
%div2=str2num(str{4});
loadlibrary('okFrontPanel', 'okFrontPanelDLL.h');
handles.xem = calllib('okFrontPanel', 'okFrontPanel_Construct');
handles.numDevices = calllib('okFrontPanel', 'okFrontPanel_GetDeviceCount', handles.xem);
handles.ret = calllib('okFrontPanel', 'okFrontPanel_OpenBySerial', handles.xem, '');
handles.success_checkOPEN = calllib('okFrontPanel', 'okFrontPanel_IsOpen', handles.xem);
%handles.pll = calllib('okFrontPanel', 'okPLL22150_Construct');
%calllib('okFrontPanel', 'okPLL22150_SetCrystalLoad', handles.pll, 12.0);
%calllib('okFrontPanel', 'okPLL22150_SetReference', handles.pll, 48.0, 1);
%calllib('okFrontPanel', 'okPLL22150_SetVCOParameters', handles.pll, P, Q);
%handles.VCO_freq = calllib('okFrontPanel', 'okPLL22150_GetVCOFrequency', handles.pll);
%calllib('okFrontPanel', 'okPLL22150_SetDiv1', handles.pll, 1, div1);
%calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 4, 1);
%calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 0, 1);
%handles.freq_out1 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 4);
%handles.freq_out1 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 0);
%calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 1, 0);
%handles.freq_out2 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 1);
%calllib('okFrontPanel', 'okPLL22150_SetDiv2', handles.pll, 1, div2);
%calllib('okFrontPanel', 'okPLL22150_SetOutputSource', handles.pll, 0, 4);
%handles.freq_out3 = calllib('okFrontPanel', 'okPLL22150_GetOutputFrequency', handles.pll, 0);
%calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 4, 1);
%calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 0, 1);
%calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 1, 1);
%calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 4, 1);
%calllib('okFrontPanel', 'okPLL22150_SetOutputEnable', handles.pll, 0, 1);
%calllib('okFrontPanel', 'okFrontPanel_SetPLL22150Configuration', handles.xem, handles.pll);
handles.success_configure = calllib('okFrontPanel', 'okFrontPanel_ConfigureFPGA', handles.xem,'chip4_adc_cont.bit');
handles.OSR=256;
%handles.Fout=(handles.freq_out1/handles.OSR)*1000000;
handles.ENOB=12;

%assignin('base','VCO_MHz',handles.VCO_freq);
%assignin('base','delta_sigma_clk_MHz',handles.freq_out1);
%assignin('base','USB_clk_MHz',handles.freq_out2);
%assignin('base','DAC_clk_MHz',handles.freq_out3);
%assignin('base','OSR',handles.OSR);
%assignin('base','Fout_Hz',handles.Fout);

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
    handles.axes_total=[handles.axes_total tmp];   

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
    
 
% handles.p_Left1=[-583.913; 1030.5];
% handles.p_Right1=[-583.913; 1030.5];
% handles.p_Left2=[-583.913; 1030.5];
% handles.p_Right2=[-583.913; 1030.5];

handles.p_Left1=[-1173.26; 2057.25];
handles.p_Right1=[-1173.26; 2057.25];
handles.p_Left2=[-1173.26; 2057.25];
handles.p_Right2=[-1173.26; 2057.25];


% 

% handles.p_Left=[-580.935439; 1984.094664];
% handles.p_Right=[-574.775140; 1974.650152];



handles.RfeedBack_TIA2L1=4.1*(10^6);
handles.RfeedBack_TIA2R1=4.1*(10^6);
handles.RfeedBack_TIA2L2=4.1*(10^6);
handles.RfeedBack_TIA2R2=4.1*(10^6);

guidata(hObject, handles);

% --- Executes on button press in unload.

function unload_Callback(hObject, eventdata, handles)
% hObject    handle to unload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
calllib('okFrontPanel', 'okFrontPanel_Destruct', handles.xem);
%cla(handles.tab1_axes,'reset')
%cla(handles.tab2_axes,'reset')
guidata(hObject, handles);
clear all;
unloadlibrary okFrontPanel


% --- Executes on button press in Manual_RealTime_Plot_120s.
function Manual_RealTime_Plot_120s_Callback(hObject, eventdata, handles)
% hObject    handle to Manual_RealTime_Plot_120s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%BTPIPEOUT 
cycle=120; 
FIFO_size=4096;%32bit 
blocksize=16384;%byte
Unit_length= (4*FIFO_size);
%data((cycle*(FIFO_size-1)),1)=uint16(0);
handles.data_L1=[];
handles.data_R1=[];


handles.data_L2=[];
handles.data_R2=[];



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
Plot_Ylimit=2;
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
%     handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize, Unit_length, pv_A0);
%     epvalue_A0 = get(pv_A0, 'value');
%     handles.BTpipeOut_A1=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A1'), blocksize, Unit_length, pv_A1);
%     epvalue_A1 = get(pv_A1, 'value');
    %delta_sigma_clk_MHz
    
    
    handles.BTpipeOut_A2=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A2'), blocksize, Unit_length, pv_A2);
    epvalue_A2 = get(pv_A2, 'value');
    handles.BTpipeOut_A3=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A3'), blocksize, Unit_length, pv_A3);
    epvalue_A3 = get(pv_A3, 'value');
    
    
    
    
    %data(((i-1)*(FIFO_size-1)+1):(i*(FIFO_size-1)))=double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))));
    %data=[data; double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))))];
    
    
    
    
%     data_tmp_L1 = quantizer_one_forth((double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
%     data_tmp_L1=(data_tmp_L1-handles.p_Left1(2))/handles.p_Left1(1);
%     handles.data_L1=[handles.data_L1; data_tmp_L1];
%     
%     data_tmp_R1 = quantizer_one_forth((double(epvalue_A1(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A1(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
%     data_tmp_R1=(data_tmp_R1-handles.p_Right1(2))/handles.p_Right1(1);
%     handles.data_R1=[handles.data_R1; data_tmp_R1];
    
    data_tmp_L2 = (double(epvalue_A2(1:4:(4*(FIFO_size-1)-1)))+256*double(epvalue_A2(2:4:(4*(FIFO_size-1)))))/(2^(16-ENOB));
    data_tmp_L2=(data_tmp_L2-handles.p_Left2(2))/handles.p_Left2(1);
    handles.data_L2=[handles.data_L2; data_tmp_L2];
    
    data_tmp_R2 = (double(epvalue_A3(1:4:(4*(FIFO_size-1)-1)))+256*double(epvalue_A3(2:4:(4*(FIFO_size-1)))))/(2^(16-ENOB));
    data_tmp_R2=(data_tmp_R2-handles.p_Right2(2))/handles.p_Right2(1);
    handles.data_R2=[handles.data_R2; data_tmp_R2];    
    
    
    
    tmp0 = round(((i-1)-mod((i-1),N_window))/N_window)+1;
%     plot(handles.axes_total(1),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L1)
%     axis(handles.axes_total(1),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
%     title('t vs v (AinL1)','Color', 'b') 
%     xlabel(handles.axes_total(1),'time (s)')
%     ylabel(handles.axes_total(1),'voltage (v)')
%     hold(handles.axes_total(1),'on')
%     
%     
%     plot(handles.axes_total(6),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R1)
%     axis(handles.axes_total(6),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
%     title('t vs v (AinR1)','Color', 'b') 
%     xlabel(handles.axes_total(6),'time (s)')
%     ylabel(handles.axes_total(6),'voltage (v)')
%     %axis([handles.tab1_axes handles.tab2_axes],[((tmp0-1)*(4*(FIFO_size-1))) (tmp0*(4*(FIFO_size-1))-1) 0 inf])
%     hold(handles.axes_total(6),'on')
    
    plot(handles.axes_total(11),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
    axis(handles.axes_total(11),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
    title('t vs v (AinL2)','Color', 'b') 
    xlabel(handles.axes_total(11),'time (s)')
    ylabel(handles.axes_total(11),'voltage (v)')
    hold(handles.axes_total(11),'on')
    
    plot(handles.axes_total(16),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
    axis(handles.axes_total(16),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -2 Plot_Ylimit])
    title('t vs v (AinR2)','Color', 'b') 
    xlabel(handles.axes_total(16),'time (s)')
    ylabel(handles.axes_total(16),'voltage (v)')
    %axis([handles.tab1_axes handles.tab2_axes],[((tmp0-1)*(4*(FIFO_size-1))) (tmp0*(4*(FIFO_size-1))-1) 0 inf])
    hold(handles.axes_total(16),'on')
    
    
    
    %hold on
    t = toc;
    %tmp(i) = t;
end

%hold off
hold(handles.axes_total(1),'off')
hold(handles.axes_total(6),'off')


hold(handles.axes_total(11),'off')
hold(handles.axes_total(16),'off')

guidata(hObject, handles);

% --- Executes on button press in Plot_V_I.
function Plot_V_I_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_V_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% plot(handles.axes_total(3),((1:length(handles.data_L1))/handles.Fout),handles.data_L1)
% title(handles.axes_total(3),'t vs v (TIA L1)','Color', 'b') 
% xlabel(handles.axes_total(3),'time (s)')
% ylabel(handles.axes_total(3),'voltage (v)')
% grid minor
% plot(handles.axes_total(8),((1:length(handles.data_R1))/handles.Fout),handles.data_R1)
% title(handles.axes_total(8),'t vs v (TIA R1)','Color', 'b')
% xlabel(handles.axes_total(8),'time (s)')
% ylabel(handles.axes_total(8),'voltage (v)')
% grid minor
% 
% plot(handles.axes_total(4),((1:length(handles.data_L1))/handles.Fout),handles.current_L1*(10^9))
% title(handles.axes_total(4),'t vs i (TIA L1)','Color', 'b')
% xlabel(handles.axes_total(4),'time (s)')
% ylabel(handles.axes_total(4),'current (nA)')
% grid minor
% plot(handles.axes_total(9),((1:length(handles.data_R1))/handles.Fout),handles.current_R1*(10^9))
% title(handles.axes_total(9),'t vs i (TIA R1)','Color', 'b')
% xlabel(handles.axes_total(9),'time (s)')
% ylabel(handles.axes_total(9),'current (nA)')
% grid minor

plot(handles.axes_total(13),((1:length(handles.data_L2))/handles.Fout),handles.data_L2)
title(handles.axes_total(13),'t vs v (TIA L2)','Color', 'b') 
xlabel(handles.axes_total(13),'time (s)')
ylabel(handles.axes_total(13),'voltage (v)')
grid minor
plot(handles.axes_total(18),((1:length(handles.data_R2))/handles.Fout),handles.data_R2)
title(handles.axes_total(18),'t vs v (TIA R2)','Color', 'b')
xlabel(handles.axes_total(18),'time (s)')
ylabel(handles.axes_total(18),'voltage (v)')
grid minor

plot(handles.axes_total(14),((1:length(handles.data_L2))/handles.Fout),handles.current_L2*(10^9))
title(handles.axes_total(14),'t vs i (TIA L2)','Color', 'b')
xlabel(handles.axes_total(14),'time (s)')
ylabel(handles.axes_total(14),'current (nA)')
grid minor
plot(handles.axes_total(19),((1:length(handles.data_R2))/handles.Fout),handles.current_R2*(10^9))
title(handles.axes_total(19),'t vs i (TIA R2)','Color', 'b')
xlabel(handles.axes_total(19),'time (s)')
ylabel(handles.axes_total(19),'current (nA)')
grid minor

guidata(hObject, handles);

% --- Executes on button press in Save_DC_Plot.
function Save_DC_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Save_DC_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% fileID=fopen('DC_RESULT_CHL1.txt','w');
% fprintf(fileID,'%f\n', handles.data_L1);
% fclose(fileID);
% 
% fileID=fopen('DC_RESULT_CHR1.txt','w');
% fprintf(fileID,'%f\n', handles.data_R1);
% fclose(fileID);

fileID=fopen('DC_RESULT_CHL2.txt','w');
fprintf(fileID,'%f\n', handles.data_L2);
fclose(fileID);

fileID=fopen('DC_RESULT_CHR2.txt','w');
fprintf(fileID,'%f\n', handles.data_R2);
fclose(fileID);


% --- Executes on button press in Save_VtoI_Plot.
function Save_VtoI_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Save_VtoI_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% fileID=fopen('V2I_RESULT_CHL1.txt','w');
% fprintf(fileID,'%f\n', handles.data_L1);
% fclose(fileID);
% 
% fileID=fopen('V2I_RESULT_CHR1.txt','w');
% fprintf(fileID,'%f\n', handles.data_R1);
% fclose(fileID);

fileID=fopen('V2I_RESULT_CHL2.txt','w');
fprintf(fileID,'%f\n', handles.data_L2);
fclose(fileID);

fileID=fopen('V2I_RESULT_CHR2.txt','w');
fprintf(fileID,'%f\n', handles.data_R2);
fclose(fileID);


% --- Executes on button press in Code_to_Voltage.
function Code_to_Voltage_Callback(hObject, eventdata, handles)
% hObject    handle to Code_to_Voltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=[handles.data_L1 handles.data_R1];
data2=[handles.data_L2 handles.data_R2];


[m1,n1] = size(data); 
[m2,n2] = size(data2); 

V_set=(-115:10:115)'/100; 
%V_set=V_set.'; 
%Fs=16000; 
Duration=5; 
Span_center=3; 
Span_range=2; 
Code1=[]; 
Code2=[]; 


p1=[]; 
Name1={'Left1', 'Right1'}; 

p2=[]; 
Name2={'Left2', 'Right2'};

% for k=1:n1 
% 
%     [Code_tmp1, p_tmp1]=Code_To_Voltage(V_set,data(:,k),handles.Fout,Span_center,Span_range,Duration); 
%     Code1=[Code1 Code_tmp1]; 
%     p1=[p1 p_tmp1]; 
% 
%     figure 
%     plot(V_set,(V_set*p1(1,k)+p1(2,k)),'r')
%     hold on
%     plot(V_set,round(Code1(:,k)),'LineStyle','none','Marker','*','MarkerFaceColor','b','MarkerSize',10) 
%     hold off
%     xlabel('Voltage') 
%     ylabel('Code') 
%     title(Name1(k))
%     axis([-inf inf -inf inf])
%     grid minor
%     
% end 

for k=1:n2 

    [Code_tmp2, p_tmp2]=Code_To_Voltage(V_set,data2(:,k),handles.Fout,Span_center,Span_range,Duration); 
    Code2=[Code2 Code_tmp2]; 
    p2=[p2 p_tmp2]; 

    figure 
    plot(V_set,(V_set*p2(1,k)+p2(2,k)),'r')
    hold on
    plot(V_set,round(Code2(:,k)),'LineStyle','none','Marker','*','MarkerFaceColor','b','MarkerSize',10) 
    hold off
    xlabel('Voltage') 
    ylabel('Code') 
    title(Name2(k))
    axis([-inf inf -inf inf])
    grid minor
    
end 

% handles.p_Left1=p1(:,1);
% handles.p_Right1=p1(:,2);

handles.p_Left2=p2(:,1);
handles.p_Right2=p2(:,2);

% assignin('base','Slope_Left1',handles.p_Left1(1));
% assignin('base','Offset_Left1',handles.p_Left1(2));
% assignin('base','Slope_Right1',handles.p_Right1(1));
% assignin('base','Offset_Right1',handles.p_Right1(2));


assignin('base','Slope_Left2',handles.p_Left2(1));
assignin('base','Offset_Left2',handles.p_Left2(2));
assignin('base','Slope_Right2',handles.p_Right2(1));
assignin('base','Offset_Right2',handles.p_Right2(2));

% fileID = fopen('Code2Voltage1.txt','w');
% fprintf(fileID,'%12.6f %12.6f\r\n',handles.p_Left1(1),handles.p_Right1(1));
% fprintf(fileID,'%12.6f %12.6f\r\n',handles.p_Left1(2),handles.p_Right1(2));
% fclose(fileID);


fileID = fopen('Code2Voltage2.txt','w');
fprintf(fileID,'%12.6f %12.6f\r\n',handles.p_Left2(1),handles.p_Right2(1));
fprintf(fileID,'%12.6f %12.6f\r\n',handles.p_Left2(2),handles.p_Right2(2));
fclose(fileID);

guidata(hObject, handles);


% --- Executes on button press in Save_FSCV_Plot.
function Save_FSCV_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Save_FSCV_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% fileID=fopen('FSCV_VOLTAGE_CHL1.txt','w');
% fprintf(fileID,'%f\n', handles.data_L1);
% fclose(fileID);
% 
% fileID=fopen('FSCV_VOLTAGE_CHR1.txt','w');
% fprintf(fileID,'%f\n', handles.data_R1);
% fclose(fileID);
% 
% fileID=fopen('FSCV_CURRENT_CHL1.txt','w');
% fprintf(fileID,'%f\n', 10e9*(handles.current_L1));
% fclose(fileID);
% 
% fileID=fopen('FSCV_CURRENT_CHR1.txt','w');
% fprintf(fileID,'%f\n', 10e9*(handles.current_R1));
% fclose(fileID);

fileID=fopen('FSCV_VOLTAGE_CHL2.txt','w');
fprintf(fileID,'%f\n', handles.data_L2);
fclose(fileID);

fileID=fopen('FSCV_VOLTAGE_CHR2.txt','w');
fprintf(fileID,'%f\n', handles.data_R2);
fclose(fileID);

fileID=fopen('FSCV_CURRENT_CHL2.txt','w');
fprintf(fileID,'%f\n', 10e9*(handles.current_L2));
fclose(fileID);

fileID=fopen('FSCV_CURRENT_CHR2.txt','w');
fprintf(fileID,'%f\n', 10e9*(handles.current_R2));
fclose(fileID);

% --- Executes on button press in RealTime_Plot_120s_V_to_I.
function RealTime_Plot_120s_V_to_I_Callback(hObject, eventdata, handles)
% hObject    handle to RealTime_Plot_120s_V_to_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=inputdlg({'FSCV Period','FSCV ScanRate','FSCV Peak Voltage','FSCV Buttom Voltage','FSCV Vcom'},'Input dialog');
Period=str2num(str{1});
ScanRate=str2num(str{2});
Vr_H=str2num(str{3});
Vr_L=str2num(str{4});
Vcom=str2num(str{5});

RfeedBack=[handles.RfeedBack_TIA2L1 handles.RfeedBack_TIA2R1 handles.RfeedBack_TIA2L2 handles.RfeedBack_TIA2R2];

   

%BTPIPEOUT
tolerance_range=0.9;
N_ok=5; 
cycle=120; 
FIFO_size=4096;%32bit 
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
    
    
%     data_tmp_R1 = quantizer_one_forth((double(epvalue_A1(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A1(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
%     data_tmp_R1 = (data_tmp_R1-handles.p_Right1(2))/(handles.p_Right1(1));
%     handles.data_R1=[handles.data_R1; data_tmp_R1];
%     current_tmp_R1=(data_tmp_R1-Vcom)/(RfeedBack(2));
%     handles.current_R1=[handles.current_R1; current_tmp_R1];
%     data_cycle_R1=[data_cycle_R1; data_tmp_R1];
    
                                                            
    data_tmp_L2 = (double(epvalue_A2(1:4:(4*(FIFO_size-1)-1)))+256*double(epvalue_A2(2:4:(4*(FIFO_size-1)))))/(2^(16-ENOB));
    data_tmp_L2 = (data_tmp_L2-handles.p_Left2(2))/(handles.p_Left2(1));
    handles.data_L2=[handles.data_L2; data_tmp_L2];
    current_tmp_L2=(data_tmp_L2-Vcom)/(RfeedBack(3));
    handles.current_L2=[handles.current_L2; current_tmp_L2];
    data_cycle_L2=[data_cycle_L2; data_tmp_L2];
%     disp(data_tmp_L2)
    
    
    data_tmp_R2 = (double(epvalue_A3(1:4:(4*(FIFO_size-1)-1)))+256*double(epvalue_A3(2:4:(4*(FIFO_size-1)))))/(2^(16-ENOB));
    data_tmp_R2 = (data_tmp_R2-handles.p_Right2(2))/(handles.p_Right2(1));
    handles.data_R2=[handles.data_R2; data_tmp_R2];
    current_tmp_R2=(data_tmp_R2-Vcom)/(RfeedBack(4));
    handles.current_R2=[handles.current_R2; current_tmp_R2];
    data_cycle_R2=[data_cycle_R2; data_tmp_R2];
    
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

    if mod(i,N_window)==0
%         [data_FSCV_L1, N_L1]=FSCV_cycle_v2(data_cycle_L1, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Left1);
%         [data_FSCV_R1, N_R1]=FSCV_cycle_v2(data_cycle_R1, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Right1);
        [data_FSCV_L2, N_L2]=FSCV_cycle_v2(data_cycle_L2, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Left2);
        [data_FSCV_R2, N_R2]=FSCV_cycle_v2(data_cycle_R2, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Right2);
        
        
%         if length(data_FSCV_L1)==0
%             imp_L1=zeros(1,(2*N_L1+1));
%         else
%             imp_L1=(((mean(data_FSCV_L1')-0)/(1))-Vcom)/(RfeedBack(1));
%         end
%         if length(data_FSCV_R1)==0
%             imp_R1=zeros(1,(2*N_R1+1));
%         else
%             imp_R1=(((mean(data_FSCV_R1')-0)/(1))-Vcom)/(RfeedBack(2));
%         end
        
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
%         Xaxes_L1=[(((0:(N_L1-1))*((Vr_H-Vr_L)/N_L1))+Vr_L) Vr_H ((((N_L1-1):(-1):0)*((Vr_H-Vr_L)/N_L1))+Vr_L)];
%         Xaxes_R1=[(((0:(N_R1-1))*((Vr_H-Vr_L)/N_R1))+Vr_L) Vr_H ((((N_R1-1):(-1):0)*((Vr_H-Vr_L)/N_R1))+Vr_L)];
        
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
        
        plot(handles.axes_total(15),Xaxes_L2,imp_L2*(10^9))
        axis(handles.axes_total(15),[Vr_L Vr_H -inf inf])
        title(handles.axes_total(15),'v vs i (TIA L2)','Color', 'b')
        xlabel(handles.axes_total(15),'FSCV VCM (V)')
        ylabel(handles.axes_total(15),'Input Current (nA)')
        %legend(handles.axes_total(5),'')
        plot(handles.axes_total(20),Xaxes_R2,imp_R2*(10^9))
        axis(handles.axes_total(20),[Vr_L Vr_H -inf inf])
        title(handles.axes_total(20),'v vs i (TIA R2)','Color', 'b')
        xlabel(handles.axes_total(20),'FSCV VCM (V)')
        ylabel(handles.axes_total(20),'Input Current (nA)')
        
        
        
        
        
        data_cycle_L1=[];
        data_cycle_R1=[];
        data_cycle_L2=[];
        data_cycle_R2=[];
    end

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

guidata(hObject, handles);

% --- Executes on button press in Calculate_FeedBack_Res.
function Calculate_FeedBack_Res_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate_FeedBack_Res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=inputdlg({'FSCV Period','FSCV ScanRate','FSCV Peak Voltage','FSCV Buttom Voltage','FSCV Vcom','TIA mode 1 to 4','Input Capacitance Left pF','Input Capacitance Right pF'},'Input dialog');
Period=str2num(str{1});
ScanRate=str2num(str{2});
Vr_H=str2num(str{3});
Vr_L=str2num(str{4});
Vcom=str2num(str{5});
R_select=str2num(str{6});
Cin_L=(str2num(str{7}))/(10^12);
Cin_R=(str2num(str{8}))/(10^12);
tolerance_range=0.85;
N_ok=5; 
N0=round(((Vr_H-Vr_L)/ScanRate)*handles.Fout);
N_span=round(tolerance_range*N0/2);
X_set1=((round(N0/2)-N_span):(round(N0/2)+N_span));
X_set2=((round(N0*3/2)-N_span):(round(N0*3/2)+N_span));
[data_FSCV_L1, N_L1]=FSCV_cycle_v2(handles.data_L1, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Left1);
[data_FSCV_R1, N_R1]=FSCV_cycle_v2(handles.data_R1, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Right1);

[data_FSCV_L2, N_L2]=FSCV_cycle_v2(handles.data_L2, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Left2);
[data_FSCV_R2, N_R2]=FSCV_cycle_v2(handles.data_R2, handles.Fout, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, handles.p_Right2);


FSCV_L1_avg=mean(data_FSCV_L1');
FSCV_R1_avg=mean(data_FSCV_R1');
FSCV_L2_avg=mean(data_FSCV_L2');
FSCV_R2_avg=mean(data_FSCV_R2');

switch R_select
    case 1
        handles.RfeedBack_TIA2L1=(mean(FSCV_L1_avg(X_set1)')-mean(FSCV_L1_avg(X_set2)'))/(2*Cin_L*ScanRate);
        handles.RfeedBack_TIA2L2=(mean(FSCV_L2_avg(X_set1)')-mean(FSCV_L2_avg(X_set2)'))/(2*Cin_R*ScanRate);
    case 2
        handles.RfeedBack_TIA2R1=(mean(FSCV_R1_avg(X_set1)')-mean(FSCV_R1_avg(X_set2)'))/(2*Cin_L*ScanRate);
        handles.RfeedBack_TIA2R2=(mean(FSCV_R2_avg(X_set1)')-mean(FSCV_R2_avg(X_set2)'))/(2*Cin_R*ScanRate);
    case 3
        handles.RfeedBack_TIA2L1=(mean(FSCV_L1_avg(X_set1)')-mean(FSCV_L1_avg(X_set2)'))/(2*Cin_L*ScanRate);
        handles.RfeedBack_TIA2L2=(mean(FSCV_L2_avg(X_set1)')-mean(FSCV_L2_avg(X_set2)'))/(2*Cin_R*ScanRate);
        handles.RfeedBack_TIA2R1=(mean(FSCV_R1_avg(X_set1)')-mean(FSCV_R1_avg(X_set2)'))/(2*Cin_L*ScanRate);
        handles.RfeedBack_TIA2R2=(mean(FSCV_R2_avg(X_set1)')-mean(FSCV_R2_avg(X_set2)'))/(2*Cin_R*ScanRate);        
    otherwise
       handles.RfeedBack_TIA2L1=(mean(FSCV_L1_avg(X_set1)')-mean(FSCV_L1_avg(X_set2)'))/(2*Cin_L*ScanRate);
        handles.RfeedBack_TIA2L2=(mean(FSCV_L2_avg(X_set1)')-mean(FSCV_L2_avg(X_set2)'))/(2*Cin_R*ScanRate);
        handles.RfeedBack_TIA2R1=(mean(FSCV_R1_avg(X_set1)')-mean(FSCV_R1_avg(X_set2)'))/(2*Cin_L*ScanRate);
        handles.RfeedBack_TIA2R2=(mean(FSCV_R2_avg(X_set1)')-mean(FSCV_R2_avg(X_set2)'))/(2*Cin_R*ScanRate);
end

assignin('base','TIA2L1_Rf',handles.RfeedBack_TIA2L1);
assignin('base','TIA2R1_Rf',handles.RfeedBack_TIA2R1);
assignin('base','TIA2L2_Rf',handles.RfeedBack_TIA2L2);
assignin('base','TIA2R2_Rf',handles.RfeedBack_TIA2R2);

guidata(hObject, handles);


% --- Executes on button press in RealTime_Plot_Code_Value.
function RealTime_Plot_Code_Value_Callback(hObject, eventdata, handles)
% hObject    handle to RealTime_Plot_Code_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%BTPIPEOUT 
cycle=120; 
FIFO_size=4096;%32bit 
blocksize=16384;%byte
Unit_length= (4*FIFO_size);
%data((cycle*(FIFO_size-1)),1)=uint16(0);
handles.data_L1=[];
handles.data_R1=[];

handles.data_L2=[];
handles.data_R2=[];



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
%     handles.BTpipeOut_A0=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A0'), blocksize, Unit_length, pv_A0);
%     epvalue_A0 = get(pv_A0, 'value');
%     handles.BTpipeOut_A1=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A1'), blocksize, Unit_length, pv_A1);
%     epvalue_A1 = get(pv_A1, 'value');
    
    handles.BTpipeOut_A2=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A2'), blocksize, Unit_length, pv_A2);
    epvalue_A2 = get(pv_A2, 'value');
    disp(epvalue_A2)
    handles.BTpipeOut_A3=calllib('okFrontPanel', 'okFrontPanel_ReadFromBlockPipeOut', handles.xem, hex2dec('A3'), blocksize, Unit_length, pv_A3);
    epvalue_A3 = get(pv_A3, 'value');
    %data(((i-1)*(FIFO_size-1)+1):(i*(FIFO_size-1)))=double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))));
    %data=[data; double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1))))];
    
    
%     data_tmp_L1 = quantizer_one_forth((double(epvalue_A0(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A0(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
%     %data_tmp_L=(data_tmp_L-handles.p_Left(2))/handles.p_Left(1);
%     handles.data_L1=[handles.data_L1; data_tmp_L1];
%     data_tmp_R1 = quantizer_one_forth((double(epvalue_A1(1:2:(2*(FIFO_size-1)-1)))+256*double(epvalue_A1(2:2:(2*(FIFO_size-1)))))/(2^(16-ENOB)));
%     %data_tmp_R=(data_tmp_R-handles.p_Right(2))/handles.p_Right(1);
%     handles.data_R1=[handles.data_R1; data_tmp_R1];
    
    data_tmp_L2 = (double(epvalue_A2(1:4:(4*(FIFO_size-1)-1)))+256*double(epvalue_A2(2:4:(4*(FIFO_size-1)))))/(2^(16-ENOB));
    %data_tmp_L=(data_tmp_L-handles.p_Left(2))/handles.p_Left(1);
    handles.data_L2=[handles.data_L2; data_tmp_L2];
    data_tmp_R2 = (double(epvalue_A3(1:4:(4*(FIFO_size-1)-1)))+256*double(epvalue_A3(2:4:(4*(FIFO_size-1)))))/(2^(16-ENOB));
    %data_tmp_R=(data_tmp_R-handles.p_Right(2))/handles.p_Right(1);
    handles.data_R2=[handles.data_R2; data_tmp_R2];
    
    
    
    
    tmp0 = floor(((i-1)-mod((i-1),N_window))/N_window)+1;
%     plot(handles.axes_total(2),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L1)
%     axis(handles.axes_total(2),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
%     title(handles.axes_total(2),'t vs code (AinL1)','Color', 'b')
%     xlabel(handles.axes_total(2),'time (s)')
%     ylabel(handles.axes_total(2),'Code Value')
%     hold(handles.axes_total(2),'on')
%     plot(handles.axes_total(7),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R1)
%     axis(handles.axes_total(7),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
%     title(handles.axes_total(7),'t vs code (AinR1)','Color', 'b')
%     xlabel(handles.axes_total(7),'time (s)')
%     ylabel(handles.axes_total(7),'Code Value')
%     %axis([handles.tab4_axes handles.tab2_axes],[((tmp0-1)*(4*(FIFO_size-1))) (tmp0*(4*(FIFO_size-1))-1) 0 inf])
%     hold(handles.axes_total(7),'on')
    
    
    plot(handles.axes_total(12),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_L2)
    axis(handles.axes_total(12),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
    title(handles.axes_total(12),'t vs code (AinL2)','Color', 'b')
    xlabel(handles.axes_total(12),'time (s)')
    ylabel(handles.axes_total(12),'Code Value')
    hold(handles.axes_total(12),'on')
    plot(handles.axes_total(17),((((i-1)*(FIFO_size-1)):1:(i*(FIFO_size-1)-1))/handles.Fout),data_tmp_R2)
    axis(handles.axes_total(17),[((tmp0-1)*(N_window*(FIFO_size-1))/handles.Fout) ((tmp0*(N_window*(FIFO_size-1))-1)/handles.Fout) -0.1 Plot_Ylimit])
    title(handles.axes_total(17),'t vs code (AinR2)','Color', 'b')
    xlabel(handles.axes_total(17),'time (s)')
    ylabel(handles.axes_total(17),'Code Value')
    %axis([handles.tab4_axes handles.tab2_axes],[((tmp0-1)*(4*(FIFO_size-1))) (tmp0*(4*(FIFO_size-1))-1) 0 inf])
    hold(handles.axes_total(17),'on')
    
    
    
    %hold on
    t = toc;
    %tmp(i) = t;
end

%hold off
hold(handles.axes_total(2),'off')
hold(handles.axes_total(7),'off')
hold(handles.axes_total(12),'off')
hold(handles.axes_total(17),'off')

guidata(hObject, handles);


% --- Executes on button press in Plot_Code_Value.
function Plot_Code_Value_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Code_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% plot(handles.axes_total(2),((1:length(handles.data_L1))/handles.Fout),handles.data_L1)
% title(handles.axes_total(2),'t vs code (AinL1)','Color', 'b')
% xlabel(handles.axes_total(2),'time (s)')
% ylabel(handles.axes_total(2),'Code Value')
% grid minor
% plot(handles.axes_total(7),((1:length(handles.data_R1))/handles.Fout),handles.data_R1)
% title(handles.axes_total(7),'t vs code (AinR1)','Color', 'b')
% xlabel(handles.axes_total(7),'time (s)')
% ylabel(handles.axes_total(7),'Code Value')
% grid minor

plot(handles.axes_total(12),((1:length(handles.data_L2))/handles.Fout),handles.data_L2)
title(handles.axes_total(12),'t vs code (AinL2)','Color', 'b')
xlabel(handles.axes_total(12),'time (s)')
ylabel(handles.axes_total(12),'Code Value')
grid minor
plot(handles.axes_total(17),((1:length(handles.data_R2))/handles.Fout),handles.data_R2)
title(handles.axes_total(17),'t vs code (AinR2)','Color', 'b')
xlabel(handles.axes_total(17),'time (s)')
ylabel(handles.axes_total(17),'Code Value')
grid minor

guidata(hObject, handles);


% --- Executes on button press in Plot_AIN.
function Plot_AIN_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_AIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% plot(handles.axes_total(1),((1:length(handles.data_L1))/handles.Fout),handles.data_L1)
% title(handles.axes_total(1),'t vs voltage (AinL1)','Color', 'b')
% xlabel(handles.axes_total(1),'time (s)')
% ylabel(handles.axes_total(1),'voltage (v)')
% grid minor
% plot(handles.axes_total(6),((1:length(handles.data_R1))/handles.Fout),handles.data_R1)
% title(handles.axes_total(6),'t vs voltage (AinR1)','Color', 'b')
% xlabel(handles.axes_total(6),'time (s)')
% ylabel(handles.axes_total(6),'voltage (v)')
% grid minor

plot(handles.axes_total(11),((1:length(handles.data_L2))/handles.Fout),handles.data_L2)
title(handles.axes_total(11),'t vs voltage (AinL2)','Color', 'b')
xlabel(handles.axes_total(11),'time (s)')
ylabel(handles.axes_total(11),'voltage (v)')
grid minor
plot(handles.axes_total(16),((1:length(handles.data_R2))/handles.Fout),handles.data_R2)
title(handles.axes_total(16),'t vs voltage (AinR2)','Color', 'b')
xlabel(handles.axes_total(16),'time (s)')
ylabel(handles.axes_total(16),'voltage (v)')
grid minor

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
