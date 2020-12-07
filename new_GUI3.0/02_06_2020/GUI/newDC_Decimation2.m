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

% Last Modified by GUIDE v2.5 06-Feb-2020 14:34:36

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
