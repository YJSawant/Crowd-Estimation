function varargout = testing(varargin)
% TESTING MATLAB code for testing.fig
%      TESTING, by itself, creates a new TESTING or raises the existing
%      singleton*.
%
%      H = TESTING returns the handle to a new TESTING or the handle to
%      the existing singleton*.
%
%      TESTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTING.M with the given input arguments.
%
%      TESTING('Property','Value',...) creates a new TESTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testing

% Last Modified by GUIDE v2.5 30-Mar-2016 19:18:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testing_OpeningFcn, ...
                   'gui_OutputFcn',  @testing_OutputFcn, ...
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


% --- Executes just before testing is made visible.
function testing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testing (see VARARGIN)

% Choose default command line output for testing
handles.output = hObject;
axes(handles.axes7);
imshow('download.jpeg');
axis off;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testing wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% Read image file
%imraw=imread('download.jpeg');


% --- Outputs from this function are returned to the command line.
function varargout = testing_OutputFcn(hObject, eventdata, handles) 
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
handles.vid = videoinput('winvideo' , 1, 'YUY2_640X480');
%preview(handles.vid);
guidata(hObject, handles);
prompt={'Enter Maximum Capacity Environment Can Have '};
dlg_title='Max Capacity';
num_lines=1;
answer=inputdlg(prompt, dlg_title, num_lines);
global val;
val = str2num(answer{1});



% --- Executes on button press in face.
function face_Callback(hObject, eventdata, handles)
% hObject    handle to face (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.vid = videoinput('winvideo' , 1, 'YUY2_640X480');
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 5;
start(handles.vid);
while(1)
facedetector = vision.CascadeObjectDetector;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(facedetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'Face');
imshow(hello);
%Display the number of faces in a string 
n= size(bbox,1);
% n is the no. of rows of bounding box which gives no. of faces
str_n=num2str(n);
str =strcat('Crowd Count :   ', str_n);
disp(str); 
set(handles.ccdisp,'String',str);
global val;
if (n >= val)
    myicon = imread('alert.jpeg');
l=msgbox('WARNING : AREA CROWDED!!','Success','custom',myicon);

   %l = msgbox('WARNING : AREA CROWDED!!');
   handles.output = hObject;
   stop(handles.vid),clear handles.vid % delete(handles.vid)
   guidata(hObject, handles);
end
end
guidata(hObject, handles);



% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
stop(handles.vid),clear handles.vid % delete(handles.vid)
guidata(hObject, handles);


% --- Executes on button press in eyes.
function eyes_Callback(hObject, eventdata, handles)
% hObject    handle to eyes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 2;
start(handles.vid);
while(1)
bodyDetector = vision.CascadeObjectDetector('EyePairBig');
bodyDetector.MinSize = [11 45]; 
%bodyDetector.ScaleFactor = 1.05;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(bodyDetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'EYE');
imshow(hello);
end
guidata(hObject, handles);


% --- Executes on button press in upperbody.
function upperbody_Callback(hObject, eventdata, handles)
% hObject    handle to upperbody (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
triggerconfig(handles.vid ,'manual');
set(handles.vid, 'TriggerRepeat',inf);
set(handles.vid, 'FramesPerTrigger',1);
handles.vid.ReturnedColorspace = 'rgb';
 handles.vid.Timeout = 5;
start(handles.vid);
while(1)
bodyDetector = vision.CascadeObjectDetector('UpperBody');
bodyDetector.MinSize = [60 60]; 
bodyDetector.ScaleFactor = 1.05;                                                 
trigger(handles.vid); 
handles.im = getdata(handles.vid, 1);
bbox = step(bodyDetector, handles.im);
hello = insertObjectAnnotation(handles.im,'rectangle',bbox,'UpperBody');
imshow(hello);
end
guidata(hObject, handles);



function ccdisp_Callback(hObject, eventdata, handles)
% hObject    handle to ccdisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ccdisp as text
%        str2double(get(hObject,'String')) returns contents of ccdisp as a double


% --- Executes during object creation, after setting all properties.
function ccdisp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ccdisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CAM2.
function CAM2_Callback(hObject, eventdata, handles)
% hObject    handle to CAM2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'Enter Maximum Capacity Environment Can Have '};
dlg_title='Max Capacity';
num_lines=1;
answer=inputdlg(prompt, dlg_title, num_lines);
global val;
val = str2num(answer{1});
url = 'http://192.168.43.1:8080/shot.jpg';
ss  = imread(url);
fh = image(ss,'Parent', handles.axes7);
while(1)
    ss  = imread(url);
    FaceDetector = vision.CascadeObjectDetector();

%To declare a threshold value according to which face detection is done
%FaceDetector.MergeThreshold= 10;

%Use FaceDetector on img and get the faces
BBox = step(FaceDetector,ss);

%Annotate these faces on the top of the image 
img1= insertObjectAnnotation(ss,'rectangle',BBox,'Face');
%imshow(img1);
 m = size(BBox,1);
% n is the no. of rows of bounding box which gives no. of faces

str_m = num2str(m);
str3 = strcat('Crowd Count = ', str_m);

  disp(str3);
  set(handles.ccdisp,'String',str3);
  set(fh,'CData',img1);   
  drawnow;  

end
guidata(hObject, handles);
