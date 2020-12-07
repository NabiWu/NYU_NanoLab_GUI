function varargout = Automatic(varargin)
% AUTOMATIC M-file for Automatic.fig
%      AUTOMATIC, by itself, creates a new AUTOMATIC or raises the existing
%      singleton*.
%
%      H = AUTOMATIC returns the handle to a new AUTOMATIC or the handle to
%      the existing singleton*.
%
%      AUTOMATIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTOMATIC.M with the given input arguments.
%
%      AUTOMATIC('Property','Value',...) creates a new AUTOMATIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Automatic_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Automatic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Automatic

% Last Modified by GUIDE v2.5 24-Feb-2008 21:44:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Automatic_OpeningFcn, ...
                   'gui_OutputFcn',  @Automatic_OutputFcn, ...
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


% --- Executes just before Automatic is made visible.
function Automatic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Automatic (see VARARGIN)

% Choose default command line output for Automatic
handles.output = hObject;
handles.t='null';
web -browser http://www.ilovematlab.cn/thread-3329-1-1.html
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Automatic wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Automatic_OutputFcn(hObject, eventdata, handles) 
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
% t = timer('TimerFcn', 'stat=false; disp(''Timer!'')',... 
%                  'StartDelay',10);
% t = timer('TimerFcn', {@myfun,handles},... 
%                  'StartDelay',1);

% T = timer(`PropertyName1', PropertyValue1, 'PropertyName2', 
% PropertyValue2,...)

global mycount
mycount =1;

t= timer('TimerFcn',{@my_callback_fcn,handles},  'Period', 1.0, 'StartDelay',1);

set(t,'ExecutionMode','fixedRate');

handles.t=t;
guidata(hObject, handles);
start(t);



function my_callback_fcn(obj, event,handles)

txt1 = ' event occurred at ';
event_type = event.Type;
event_time = datestr(event.Data.time);
set(handles.edit1,'string',event_time);

global mycount

tt=0:0.1:2*pi;
if mod(mycount,2)==0
plot(handles.axes3,tt,mycount*sin(tt),'r');
else
    plot(handles.axes3,tt,mycount*cos(tt),'b');
end;
mycount=mycount+1;


%这里，你可以做你想做的事情

% msgbox('发生事件了，祝你开心！！！   ');

% msg = [event_type txt1 event_time];
% disp(msg)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.t);



% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


