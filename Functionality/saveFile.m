function varargout = saveFile(varargin)
% SAVEFILE MATLAB code for saveFile.fig
%      SAVEFILE, by itself, creates a new SAVEFILE or raises the existing
%      singleton*.
%
%      H = SAVEFILE returns the handle to a new SAVEFILE or the handle to
%      the existing singleton*.
%
%      SAVEFILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVEFILE.M with the given input arguments.
%
%      SAVEFILE('Property','Value',...) creates a new SAVEFILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saveFile_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saveFile_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saveFile

% Last Modified by GUIDE v2.5 07-Aug-2019 17:06:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saveFile_OpeningFcn, ...
                   'gui_OutputFcn',  @saveFile_OutputFcn, ...
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


% --- Executes just before saveFile is made visible.
function saveFile_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saveFile (see VARARGIN)

% Choose default command line output for saveFile
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saveFile wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = saveFile_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% filename = '/Users/apple/Desktop/Data_analysis/wan/cool.txt';
% arrayname = linspace(-5,5);
% % dir = get(handles.edit1,'String');
% % newdir = dir+'/cool.txt';
% % disp(newdir)
% [fid,msg] = fopen(filename,'wt');
% assert(fid>=3,msg)
% fprintf(fid, '%g %g %g 3.300 20.0000 3600 1\n',arrayname );
% fclose(fid);
% save(filename, arrayname, '-ascii', '-double', '-append');
% % disp(fid)
% % save(dir+'cool.txt','close');




My_matrix = linspace(-5,5).';


dir = get(handles.edit1,'String');
txtfile = '/cool.txt';
filename = strcat(dir,txtfile);

arrayname = 'My_matrix';
fid = fopen(filename, 'w'); 
fclose(fid)
save(filename, arrayname,'-ascii', '-double', '-append');

% % Get the name of the file that the user wants to save.
% % Note, if you're saving an image you can use imsave() instead of uiputfile().
% startingFolder = get(handles.edit1,'String');
% defaultFileName = fullfile(startingFolder, '*.*');
% [baseFileName, folder] = uiputfile(defaultFileName, 'Specify a file','Cool.txt');
% if baseFileName == 0
%   % User clicked the Cancel button.
%   return;
% end
% fullFileName = fullfile(folder, baseFileName)
% fid = fopen(fullFileName, 'wt');
% if fid ~= -1
%     % write the data to file
%     fprintf(fid, '%6s\t%6s\t\n', 'x', 'y');
%     fprintf(fid, '%6.4f\t%6.41f\t\n', result);
%     fclose(fid);
% else
%     warningMessage = sprintf('Cannot open file:\n', fullFileName);
%     uiwait(warndlg(warningMessage));
% end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
dname = uigetdir('C:\');

disp(dname);
set(handles.edit1,'String',dname);



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
