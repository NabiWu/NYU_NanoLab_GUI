function varargout = TabManagerExample(varargin)
% TABMANAGEREXAMPLE MATLAB code for TabManagerExample.fig
%      TABMANAGEREXAMPLE, by itself, creates a new TABMANAGEREXAMPLE or raises the existing
%      singleton*.
%
%      H = TABMANAGEREXAMPLE returns the handle to a new TABMANAGEREXAMPLE or the handle to
%      the existing singleton*.
%
%      TABMANAGEREXAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABMANAGEREXAMPLE.M with the given input arguments.
%
%      TABMANAGEREXAMPLE('Property','Value',...) creates a new TABMANAGEREXAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TabManagerExample_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TabManagerExample_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TabManagerExample

% Last Modified by GUIDE v2.5 11-Mar-2018 10:22:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TabManagerExample_OpeningFcn, ...
                   'gui_OutputFcn',  @TabManagerExample_OutputFcn, ...
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


% --- Executes just before TabManagerExample is made visible.
function TabManagerExample_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TabManagerExample (see VARARGIN)

% Choose default command line output for TabManagerExample
handles.output = hObject;

% Initialise tabs
handles.tabManager = TabManager( hObject );

% Set-up a selection changed function on the create tab groups
tabGroups = handles.tabManager.TabGroups;
for tgi=1:length(tabGroups)
    set(tabGroups(tgi),'SelectionChangedFcn',@tabChangedCB)
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TabManagerExample wait for user response (see UIRESUME)
% uiwait(handles.mainFigure);


% Called when a user clicks on a tab
function tabChangedCB(src, eventdata)

disp(['Changing tab from ' eventdata.OldValue.Title ' to ' eventdata.NewValue.Title ] );




% --- Outputs from this function are returned to the command line.
function varargout = TabManagerExample_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in buttonSelectMain.
function buttonSelectMain_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSelectMain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tabMan = handles.tabManager;
tabMan.Handles.TabA.SelectedTab = tabMan.Handles.TabA01Main;
tabMan.Handles.TabB.SelectedTab = tabMan.Handles.TabB01Main;


% --- Executes on button press in buttonSelectSupplementary.
function buttonSelectSupplementary_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSelectSupplementary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tabMan = handles.tabManager;
tabMan.Handles.TabA.SelectedTab = tabMan.Handles.TabA02Supplementary;
tabMan.Handles.TabB.SelectedTab = tabMan.Handles.TabB02Nesting;






function editSup1_Callback(hObject, eventdata, handles)
% hObject    handle to editSup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSup1 as text
%        str2double(get(hObject,'String')) returns contents of editSup1 as a double


% --- Executes during object creation, after setting all properties.
function editSup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSup2_Callback(hObject, eventdata, handles)
% hObject    handle to editSup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSup2 as text
%        str2double(get(hObject,'String')) returns contents of editSup2 as a double


% --- Executes during object creation, after setting all properties.
function editSup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editSup3_Callback(hObject, eventdata, handles)
% hObject    handle to editSup3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSup3 as text
%        str2double(get(hObject,'String')) returns contents of editSup3 as a double


% --- Executes during object creation, after setting all properties.
function editSup3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSup3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
