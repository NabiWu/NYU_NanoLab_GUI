function varargout = tstDataAqui(varargin)
% TSTDATAAQUI MATLAB code for tstDataAqui.fig
%      TSTDATAAQUI, by itself, creates a new TSTDATAAQUI or raises the existing
%      singleton*.
%
%      H = TSTDATAAQUI returns the handle to a new TSTDATAAQUI or the handle to
%      the existing singleton*.
%
%      TSTDATAAQUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TSTDATAAQUI.M with the given input arguments.
%
%      TSTDATAAQUI('Property','Value',...) creates a new TSTDATAAQUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tstDataAqui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tstDataAqui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tstDataAqui

% Last Modified by GUIDE v2.5 10-Aug-2019 18:34:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tstDataAqui_OpeningFcn, ...
                   'gui_OutputFcn',  @tstDataAqui_OutputFcn, ...
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


% --- Executes just before tstDataAqui is made visible.
function tstDataAqui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tstDataAqui (see VARARGIN)

% Choose default command line output for tstDataAqui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tstDataAqui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tstDataAqui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
cycle_org = 1300;
period = 0.1;
VDAC = handles.VDAC;
daqreset;
daqSession = daq.createSession('ni');
daqSession.IsContinuous = true;
addAnalogOutputChannel(daqSession,'Dev1','ao0','Voltage');
ch0 = addAnalogInputChannel(daqSession,'Dev1',0,'voltage');
daqSession.Rate=20000;
h = daqSession.addlistener('DataAvailable', @(src,event) src.queueOutputData(VDAC));
%ch0.TerminalConfig = 'SingleEnded';
Sampling_rate=50000;
disp('ok');
queueOutputData(daqSession,VDAC);
daqSession.startBackground();

pause;





% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

% s = daq.createSession('ni');
% ch = addAnalogOutputChannel(s,'Dev1','ao0','Voltage');
% s.IsContinuous = true;
% s.Rate = 10000;
% data = linspace(0,0,5000)';
% lh = addlistener(s,'DataRequired',...
%     @(src,event) src.queueOutputData(data));
% queueOutputData(s,data)
% startBackground(s);
% % delete(lh);
% % 
% % delete(s);
% % clear s;


cycle_org = 1300;
period = 0.1;
VDAC = linspace(0,0,5000)';
daqreset;
daqSession = daq.createSession('ni');
daqSession.IsContinuous = true;
addAnalogOutputChannel(daqSession,'Dev1','ao0','Voltage');
ch0 = addAnalogInputChannel(daqSession,'Dev1',0,'voltage');
daqSession.Rate=5000;
h = daqSession.addlistener('DataAvailable', @(src,event) src.queueOutputData(VDAC));
%ch0.TerminalConfig = 'SingleEnded';
Sampling_rate=50000;
disp('ok');
queueOutputData(daqSession,VDAC);
daqSession.startBackground();
% if (get(handles.togglebutton1,'Value')==1)
%     pause on;
% else
%     pause off;
% end

daqSession.stop(); 
delete(h);
daqSession.release();
delete(daqSession);
clear daqSession;

% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
period  = 0.1;
Vr_L = -0.4;
Vr_H = 1.3;
Vcom = 0;
Sampling_rate=18000;
Rfeedback_L = 4.1;
Rfeedback_R = 4.1;
ReducedRate = 1;
Iref = 10;
ScanRate = 200;

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

ramp1tmp=ramp1;
ramp2tmp=ramp2;

for(k1=1:5)
    ramp1tmp=[ramp1tmp;ramp1];
    ramp2tmp=[ramp2tmp;ramp2];
end
handles.VDAC = ramp1tmp;
disp(handles.VDAC);
disp('Okay')
guidata(hObject, handles);
