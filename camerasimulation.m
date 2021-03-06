function varargout = camerasimulation(varargin)
% CAMERASIMULATION MATLAB code for camerasimulation.fig
%      CAMERASIMULATION, by itself, creates a new CAMERASIMULATION or raises the existing
%      singleton*.
%
%      H = CAMERASIMULATION returns the handle to a new CAMERASIMULATION or the handle to
%      the existing singleton*.
%
%      CAMERASIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMERASIMULATION.M with the given input arguments.
%
%      CAMERASIMULATION('Property','Value',...) creates a new CAMERASIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before camerasimulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to camerasimulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help camerasimulation

% Last Modified by GUIDE v2.5 14-Mar-2013 13:44:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @camerasimulation_OpeningFcn, ...
    'gui_OutputFcn',  @camerasimulation_OutputFcn, ...
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


% --- Executes just before camerasimulation is made visible.
function camerasimulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to camerasimulation (see VARARGIN)

% Choose default command line output for camerasimulation
handles.output = hObject;
handles.count_camera = 0;
handles.count_object = 0;
handles.coordinates_camera = [];
handles.coordinates_object = [];
handles.str = [];
handles.text = [];
handles.Table1 = [];
handles.Table2 = [];
handles.Table3 = [];
handles.TableOcc = [];
handles.Assignment = 0;
handles.Time = 0;
handles.text_C = [];
handles.str_C = [];
handles.text_handle = [];
handles.line_handle = [];
handles.energy = [];
handles.utility = [];
handles.utility_f = [];
handles.Energy = [];
handles.Resolution = [];
handles.utilityE = [];
handles.utilityR = [];
handles.utilityL = [];
handles.probability = [];
handles.distance = [];
handles.rate = [];
handles.VarE = [];
handles.VarR = [];
handles.VarL = [];
handles.E = [];
handles.R = [];
handles.L = [];
handles.trackingEnergy = [];
handles.trackingLoad = [];
handles.trackingE = [];
handles.trackingR = [];
handles.count_com = [];
handles.count_com_overall = [];
% handles.Trajectory = [];
% handles.hLine1 = [];
% handles.hLine2 = [];

% handles.camerastruct = struct('index', index_val, ...
%                       'xcood', x, ...
%                       'ycood', y, ...
%                       'noOfObjInFov', noOfObjInFov_val, ...
%                       'labelOfObj', labelOfObj_val, ...
%                       'energyLevel', engergyLevel_Val, ...
%                       'distWithObj', distWithObj_val);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes camerasimulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = camerasimulation_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function cameraAngle_Callback(hObject, eventdata, handles)
% hObject    handle to cameraAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of cameraAngle as text
%        str2double(get(hObject,'String')) returns contents of cameraAngle as a double


% --- Executes during object creation, after setting all properties.
function cameraAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cameraAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addCamera.
function addCamera_Callback(hObject, eventdata, handles)
% hObject    handle to addCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% adding camera initialization


[ x , y ] = ginput(1);                                                     % camera position


cameraAngle = str2double(get(handles.cameraAngle,'String'));               % camera orientation
cameraAngle = mod(cameraAngle, 360)/180*pi;
handles.count_camera = handles.count_camera + 1;                           % camera number

str = ['Cam ' num2str(handles.count_camera)];                              % text for camera
handles.text_C(handles.count_camera) = text((x + 0.01), y , str);
handles.str_C = str;

% camera FOV
FOVAngle = 60;
FOVAngle = FOVAngle/180*pi;
FOVlen = 0.5;

% FOV lines
handles.hLine1(handles.count_camera) = line([x, x + FOVlen*cos(cameraAngle + FOVAngle/2)], ...
    [ y , y + FOVlen*sin(cameraAngle + FOVAngle/2)]);
handles.hLine2(handles.count_camera) = line([x, x + FOVlen*cos(cameraAngle - FOVAngle/2)], ...
    [ y , y + FOVlen*sin(cameraAngle - FOVAngle/2)]);
hold on;

theta = linspace((cameraAngle - FOVAngle/2), (cameraAngle + FOVAngle/2), 100);
x0 = x + FOVlen*cos(theta);
y0 = y + FOVlen*sin(theta);
handles.hCameraPlot(handles.count_camera) = plot(x0, y0, 'r');

handles.coordinates_camera = [handles.coordinates_camera, ...
    [x, y, cameraAngle, FOVAngle, FOVlen]'];

camera_parameters = handles.coordinates_camera;
save('camera_parameters', 'camera_parameters');

guidata(hObject, handles);


function Trajectory_Callback(hObject, eventdata, handles)
% hObject    handle to Trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Trajectory as text
%        str2double(get(hObject,'String')) returns contents of Trajectory as a double

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Trajectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function UpdatingWay_Callback(hObject, eventdata, handles)
% hObject    handle to UpdatingWay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UpdatingWay as text
%        str2double(get(hObject,'String')) returns contents of UpdatingWay as a double


% --- Executes during object creation, after setting all properties.
function UpdatingWay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UpdatingWay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Weight1_Callback(hObject, eventdata, handles)
% hObject    handle to Weight1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Weight1 as text
%        str2double(get(hObject,'String')) returns contents of Weight1 as a double


% --- Executes during object creation, after setting all properties.
function Weight1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Weight1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Weight2_Callback(hObject, eventdata, handles)
% hObject    handle to Weight2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Weight2 as text
%        str2double(get(hObject,'String')) returns contents of Weight2 as a double


% --- Executes during object creation, after setting all properties.
function Weight2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Weight2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Weight3_Callback(hObject, eventdata, handles)
% hObject    handle to Weight3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Weight3 as text
%        str2double(get(hObject,'String')) returns contents of Weight3 as a double


% --- Executes during object creation, after setting all properties.
function Weight3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Weight3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function aerfa_Callback(hObject, eventdata, handles)
% hObject    handle to aerfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aerfa as text
%        str2double(get(hObject,'String')) returns contents of aerfa as a double


% --- Executes during object creation, after setting all properties.
function aerfa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aerfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in applySetting.
function applySetting_Callback(hObject, eventdata, handles)
% hObject    handle to applySetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in addObject.
function addObject_Callback(hObject, eventdata, handles)
% hObject    handle to addObject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ObjectSize = 0.03;
handles.count_object = handles.count_object + 1;
[ x , y ] = ginput(1);
str = ['  O' num2str(handles.count_object)];
handles.text(handles.count_object) = text(x - ObjectSize/2, y - ObjectSize/2, str);
handles.str{handles.count_object} = str;
handles.coordinates_object = [handles.coordinates_object, [x, y]'];
handles.hObjectPlot(handles.count_object) = rectangle('Position', ...
    [x-ObjectSize/2,y-ObjectSize/2,ObjectSize,ObjectSize]);

object_parameters = handles.coordinates_object;
save('object_parameters', 'object_parameters');

guidata(hObject, handles);


function Filename_Callback(hObject, eventdata, handles)
% hObject    handle to Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Filename as text
%        str2double(get(hObject,'String')) returns contents of Filename as a double


% --- Executes during object creation, after setting all properties.
function Filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function InitialE_Callback(hObject, eventdata, handles)
% hObject    handle to InitialE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InitialE as text
%        str2double(get(hObject,'String')) returns contents of InitialE as a double


% --- Executes during object creation, after setting all properties.
function InitialE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InitialE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function activeorpassive_Callback(hObject, eventdata, handles)
% hObject    handle to activeorpassive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of activeorpassive as text
%        str2double(get(hObject,'String')) returns contents of activeorpassive as a double


% --- Executes during object creation, after setting all properties.
function activeorpassive_CreateFcn(hObject, eventdata, handles)
% hObject    handle to activeorpassive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function method_ethr_Callback(hObject, eventdata, handles)
% hObject    handle to method_ethr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of method_ethr as text
%        str2double(get(hObject,'String')) returns contents of method_ethr as a double


% --- Executes during object creation, after setting all properties.
function method_ethr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method_ethr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function simulationPlot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to simulationPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate simulationPlot


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close('camerasimulation');
% delete(handles.camerasimulation);


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% simulation runs
% getting set up from gui
% Trajectory = str2double(get(handles.Trajectory,'String'));                 % trajectory type
% aerfa = str2double(get(handles.aerfa,'String'));                           % alpha contributes angles-distance
% Updating_Method = str2double(get(handles.UpdatingWay,'String'));           % updating weights
Filename = get(handles.Filename,'String');
% InitialE = str2double(get(handles.InitialE,'String'));                     % intial energy
% Trigger = str2double(get(handles.activeorpassive,'String'));               % active/passive
% Method_ethr = str2double(get(handles.method_ethr,'String'));               % critical energy threshould
%
% W_E = str2double(get(handles.Weight1,'String'));
% W_R = str2double(get(handles.Weight2,'String'));
% W_L = str2double(get(handles.Weight3,'String'));

% if (isempty(Trajectory) || isempty(Updating_Method) || isempty(Filename))
%     error('Wrong Setting');
%     disp('Wrong Setting');
%     close('camerasimulation');
% end

% if (W_E > 1 || W_E < 0 || W_R > 1 || W_R < 0 || W_L > 1 || W_L < 0 ...
%         || isempty(W_E) || isempty(W_R) || isempty(W_L))
%     error('Wrong Weights');
%     disp('Wrong Weights');
%     close('camerasimulation');
% end

% default set up
Trajectory = 6;
W_E = 0.4;
W_R = 0.4;
W_L = 0.2;
aerfa = 0.4;
Updating_Method = 4;
InitialE = 1;
Trigger = 1;
Method_ethr = 1;

load('camera_parameters');
load('object_parameters');

% Making directionary to save files
SS = './%s';
ss = sprintf(SS, Filename);
mkdir(ss);

savefile1 = './%s/camera_parameters';
ssfile1 = sprintf(savefile1, Filename);
save(ssfile1, 'camera_parameters');
savefile2 = './%s/object_parameters';
ssfile2 = sprintf(savefile2, Filename);
save(ssfile2, 'object_parameters');


handles.coordinates_camera = camera_parameters;
handles.coordinates_object = object_parameters;
FOVAngle = 60;                                                               % Angle of FOV
FOVAngle = FOVAngle/180*pi;
FOVlen = 0.5;
ObjectSize = 0.03;

[~, nO] = size(handles.coordinates_object);                                  % The number of objects is nO
[~, nC] = size(handles.coordinates_camera);                                  % The number of cameras is nC

for count = 1:nC
    x1 = camera_parameters(1, count);
    y1 = camera_parameters(2, count);
    cameraAngle = camera_parameters(3, count);
    str = ['Cam ' num2str(count)];
    text((x1 + 0.01), y1 , str);
    handles.str_C = str;
    line([x1,x1 + FOVlen*cos(cameraAngle + FOVAngle/2)], ...              % FOV lines
        [ y1 , y1 + FOVlen*sin(cameraAngle + FOVAngle/2)], 'Color', 'b');
    line([x1,x1 + FOVlen*cos(cameraAngle - FOVAngle/2)], ...
        [ y1 , y1 + FOVlen*sin(cameraAngle - FOVAngle/2)], 'Color', 'b');
    hold on;
    theta = linspace((cameraAngle - FOVAngle/2), (cameraAngle + FOVAngle/2), 100);
    x0 = x1 + FOVlen*cos(theta);
    y0 = y1 + FOVlen*sin(theta);
    plot(x0, y0, 'r');
end

for count = 1:nO
    x2 = object_parameters(1, count);
    y2 = object_parameters(2, count);
    str = ['  O' num2str(count)];
    handles.text(count) = text(x2 - ObjectSize/2, y2 - ObjectSize/2, str);
    handles.str{count} = str;
    handles.hObjectPlot(count) = rectangle('Position', ...
        [x2-ObjectSize/2,y2-ObjectSize/2,ObjectSize,ObjectSize]);
end

Energy = 8;
switch InitialE
    case 1
        Initial_Energy = Energy*ones(1, nC);                                         % Initial energy for each camera
        savefile3 = './%s/Initial_Energy';
        ssfile3 = sprintf(savefile3, Filename);
        save(ssfile3, 'Initial_Energy');
        save('Initial_Energy', 'Initial_Energy');
        
    case 2
        Initial_Energy = rand(1, nC)*Energy/2 + Energy/2;
        savefile3 = './%s/Initial_Energy';
        ssfile3 = sprintf(savefile3, Filename);
        save(ssfile3, 'Initial_Energy');
        save('Initial_Energy', 'Initial_Energy');
        
    case 3
        load('Initial_Energy');
        savefile3 = './%s/Initial_Energy';
        ssfile3 = sprintf(savefile3, Filename);
        save(ssfile3, 'Initial_Energy');
        
    case 4
        % test
        Initial_Energy = [7, 7, 7, 7, 7];
        
    otherwise
        error('Wrong Initial Energy');
        disp('Wrong Initial Energy');
        close('camerasimulation');
end

% E_Thr = 0;
E_Thr = 0.1*Energy;                                                           % Energy left alert threshold

Idle_Consumption = 0.0001;
% Dist_Thr = 0.4;                                                               % Distance(Resolution) alert threshold
Res_Thr = 0.3;
Tracking_Consumption = 0.001;
T_int = 250;



% if (W_E > 1 || W_E < 0 || W_R > 1 || W_R < 0 || W_L > 1 || W_L < 0 ...
%         || isempty(W_E) || isempty(W_R) || isempty(W_L))
%     error('Wrong Weights');
%     disp('Wrong Weights');
%     close('camerasimulation');
% end

Weight = [W_E W_R W_L];                                                       % Weights for each factor (Energy Resolution Load)

Weights1 = repmat(Weight, nO, 1);
Weights = repmat(zeros(1, 3), nO, 1);

handles.energy = Initial_Energy;

delete(handles.hObjectPlot);
delete(handles.text);

t = 0:0.0001:2.5;                                                               % Time setting
axislimits = [0 2 0 2];
ObjectSize = 0.03;
tau = 0.7;                                                                    % Parameter for Bargain
N = 25;                                                                       % Times of Bargain iteration
radius = 0.2;
step = 1.4/length(t);

Time_Period = 1;


switch Trajectory                                                               % Trajectory definition
    case 1
        for i = 1:nO                                                                  % moving x+ axis
            x(i,:) = handles.coordinates_object(1,i) + 1*t*2 - ObjectSize/2;
            y(i,:) = handles.coordinates_object(2,i) + t*0 - ObjectSize/2;
            handles.text_handle(i) = text(x(i,1), y(i,1), handles.str{i});
            handles.line_handle(i) = rectangle('Position', [x(i,1) , y(i,1) , ObjectSize, ObjectSize]);
        end
        
    case 2                                                                             % Moving circle
        for i = 1:nO
            x(i,:) = step*t*10000 + radius*cos(-pi/2 + t*100) + handles.coordinates_object(1,i) - ObjectSize/2;
            y(i,:) = radius + radius*sin(-pi/2 + t*100) + handles.coordinates_object(2,i) - ObjectSize/2;
            handles.text_handle(i) = text(x(i,1), y(i,1), handles.str{i});
            handles.line_handle(i) = rectangle('Position', [x(i,1) , y(i,1) , ObjectSize, ObjectSize]);
        end
        
    case 3
        for i = 1:nO
            x(i, :) = handles.coordinates_object(1,i) + (0.01-abs(mod(t, 0.02)-0.01))*10 - ObjectSize/2;
            y(i, :) = handles.coordinates_object(2,i) +  t*0 - ObjectSize/2;
            
            handles.text_handle(i) = text(x(i,1), y(i,1), handles.str{i});
            handles.line_handle(i) = rectangle('Position', [x(i,1) , y(i,1) , ObjectSize, ObjectSize]);
        end
        
    case 4                                                                         % Fixed circle
        Center = mean(camera_parameters(1:2, :), 2);
        rads = sqrt(sum((handles.coordinates_object - repmat(Center, 1, nO)).^2));
        CC = handles.coordinates_object - repmat(Center, 1, nO);
        CC1 = CC(1, :);
        CC1(CC1 > 0) = 0;
        CC1(CC1 < 0) = 1;
        DD = CC1;
        Angles1 = mod(atan(CC(2, :)./CC(1, :)) + pi*DD, 2*pi);
        
        for i = 1:nO
            x(i, :) = rads(i)*cos(Angles1(i) + t*100) + Center(1) - ObjectSize/2;
            y(i, :) = rads(i)*sin(Angles1(i) + t*100) + Center(2) - ObjectSize/2;
            handles.text_handle(i) = text(x(i,1), y(i,1), handles.str{i});
            handles.line_handle(i) = rectangle('Position', [x(i,1) , y(i,1) , ObjectSize, ObjectSize]);
        end
        
    case 5
        for i = 2:nO
            x(i, :) = handles.coordinates_object(1,i) + (0.001-abs(mod(t, 0.002)-0.001))*10 - ObjectSize/2;
            y(i, :) = handles.coordinates_object(2,i) + t*0 - ObjectSize/2;
            %             handles.text_handle(i) = text(x(i,1), y(i,1), handles.str{i});
            %             handles.line_handle(i) = rectangle('Position', [x(i,1) , y(i,1) , ObjectSize, ObjectSize]);
        end
        t1 = 0:0.0001:0.1999;
        t2 = 0.2000:0.0001:0.2079;
        t3 = 0.2080:0.0001:2.5;
        x(1, 1:2000) = handles.coordinates_object(1,1) + (0.001-abs(mod(t1, 0.002)-0.001))*10 - ObjectSize/2;
        y(1, 1:2000) = handles.coordinates_object(2,1) + t1*0 - ObjectSize/2;
        x(1, 2001:2080) = x(1, 2000) - (t2-0.1999)*10 - ObjectSize/2;
        y(1, 2001:2080) = y(1, 2000) - t2*0 - ObjectSize/2;
        x(1, 2081:25001) = x(1, 2080) + (0.001-abs(mod((t3 - 0.2080), 0.002)-0.001))*10 - ObjectSize/2;
        y(1, 2081:25001) = y(1, 2080) - t3*0 - ObjectSize/2;
        for i = 1:nO
            handles.text_handle(i) = text(x(i,1), y(i,1), handles.str{i});
            handles.line_handle(i) = rectangle('Position', [x(i,1) , y(i,1) , ObjectSize, ObjectSize]);
        end
        
    case 6
        for i = 1:nO                 % moving y+ axis
            if mod(i,2) == 1
                x(i,:) = handles.coordinates_object(1,i) + t*0 - ObjectSize/2;
                y(i,:) = handles.coordinates_object(2,i) - 1*t*2 - ObjectSize/2;
            else
                x(i,:) = handles.coordinates_object(1,i) + t*0 - ObjectSize/2;
                y(i,:) = handles.coordinates_object(2,i) + 1*t*2 - ObjectSize/2;
            end
            handles.text_handle(i) = text(x(i,1), y(i,1), handles.str{i});
            handles.line_handle(i) = rectangle('Position', [x(i,1) , y(i,1) , ObjectSize, ObjectSize]);
        end
        
        
    otherwise
        error('Unknown trajectory');
        disp('Unknown trajectory');
        close('camerasimulation');
end

axis(axislimits);

for i = 1:nO
    str = ['O' num2str(i)];
    columnname{i} = str;
end
columnname{nO+1} = 'E_Left';

for i = 1:nC
    str = ['C' num2str(i)];
    rowname{i} = str;
end


rowname{nC+1} = 'Uti';

tt1 = uitable('Position',[950 350 300 200],'ColumnWidth',{40}, ...
    'ColumnName', columnname(1:nO+1), ...
    'RowName', rowname(1:nC+1));

tt2 = uitable('Position',[950 150 300 200],'ColumnWidth',{40}, ...
    'ColumnName', columnname(1:nO+1), ...
    'RowName', rowname(1:nC+1));

% tt2 = uitable('Position',[900 -100 420 650],'ColumnWidth',{32}, ...
%              'ColumnName', columnname(1:nO+1), ...
%              'RowName', rowname(1:nC+1));

cnames = {'Time','Assignment'};
tt3 = uitable('Position',[950 550 300 40],'ColumnWidth',{60}, ...
    'ColumnName', cnames, 'RowName', 'Times');

ttO = uitable('Position',[950 600 300 100],'ColumnWidth',{40}, ...
    'ColumnName', columnname(1:nO), ...
    'RowName', rowname(1:nC));

Energy_Left = Initial_Energy;
Load = zeros(1, nC);

handles.Table2 = zeros(nC+1, nO+1);

handles.utility = zeros(nC, ceil(length(t)/Time_Period), nO);
handles.utility_f = zeros(nC, nO, ceil(length(t)/Time_Period));
handles.Energy = zeros(nC, length(t), nO);
handles.Resolution = zeros(nC, length(t), nO);
handles.utilityE = zeros(nC, ceil(length(t)/Time_Period), nO);
handles.utilityR = zeros(nC, ceil(length(t)/Time_Period), nO);
handles.utilityL = zeros(nC, ceil(length(t)/Time_Period), nO);
handles.probability = zeros(nC, ceil(length(t)/Time_Period), nO);
handles.distance = zeros(nC, ceil(length(t)/Time_Period), nO);
handles.VarE = zeros(nO, ceil(length(t)/Time_Period));
handles.VarR = zeros(nO, ceil(length(t)/Time_Period));
handles.VarL = zeros(nO, ceil(length(t)/Time_Period));
handles.E = zeros(nO, ceil(length(t)/Time_Period));
handles.R = zeros(nO, ceil(length(t)/Time_Period));
handles.L = zeros(nO, ceil(length(t)/Time_Period));
handles.trackingEnergy = zeros(nO, length(t));
handles.trackingLoad = zeros(nO, length(t));
handles.trackingE = zeros(nO, length(t));
handles.trackingR = zeros(nO, length(t));

Table3 = zeros(1, 2);

Processing_Power = ones(1, nC);
Processing_Power(1:2:19) = 2*ones(1, 10);
% Processing_Power(1) = 3;
temp = zeros(1, nC);
tempD1 = zeros(1, nO);
tempD2 = zeros(1, nO);
% Dist = zeros(1, nO);
tempR1 = zeros(1, nO);
tempR2 = zeros(1, nO);
Res = zeros(1, nO);
flag3 = 0;                                                               % Distance(Resolution) alert
Table2 = zeros(nC+1, nO+1);
flag4 = 0;
Rate_Thr = 0.001*2;
% Table5 = zeros(nC, nO);
% Table6 = zeros(nC, nO);
Energy_cons = [0.002, 0.002, 0.002, 0.002];                              % Unit energy consumption for each type of message
for j = 2:length(t)
    Table3(1) = Table3(1) + 1;
    handles.count_com_overall(Table3(1)) = 0;
    for i = 1:nO                                                         % Draw dynamic predefined trajectories
        set(handles.line_handle(i), 'Position', [x(i,j), y(i,j), ObjectSize, ObjectSize]);
        set(handles.text_handle(i), 'Position', [x(i,j), y(i,j)], 'string', handles.str{i});
    end
    
    drawnow;
    trigger = 0;
    
    %     if a
    %     end
    
    flag1 = 0;                                                           % Flag for energy changing
    temp1 = temp;
    if (j == 2)
        temp1(Energy_Left < E_Thr) = 1;
    end
    temp(Energy_Left < E_Thr) = 1;                                       % Energy left alert
    if (sum(abs(temp-temp1)) ~= 0)
        a3 = find(temp ~= temp1, 1);
        if (sum(handles.Table2(a3, 1:nO)) ~= 0)
            flag1 = 1;
        end
        flag1_coor = [a3, 0];                                               % Which camera trigger the EnergyLeft threshold
    end
    
    Objects_Position = [x(:, j) + ObjectSize/2, y(:, j) + ObjectSize/2]';
    [handles.Table1, handles.TableOcc] = labeling(handles.coordinates_camera, Objects_Position, ObjectSize);    % Table1 is the table that denote the observation situation
    Table1_1 = handles.Table1;
    TableOcc = handles.TableOcc;
    set(ttO, 'Data', TableOcc);
    
    
    
    % If the remaining energy of any camera is less than threshold,
    % reassign the observing table
    Cam_Die = Energy_Left <= 0;
    Table1_1(Cam_Die, :) = 0;
    
    Table4 = Table1_1;
    Cam_Low = find(Energy_Left < E_Thr);
    AA = sum(Table4);
    if (~isempty(Cam_Low))
        if (length(Cam_Low) > 1)
            BB = sum(Table4(Cam_Low, :));
        else
            BB = Table4(Cam_Low, :);
        end
        CC = AA > BB;
        Table4(Cam_Low, CC) = 0;
    end
    
    Load2 = zeros(1, nC);
    N_O = sum(Table4, 1);
    Load_Num = sum(N_O ~= 0);
    
    flag2 = 0;
    flag5 = 0;                                                                          % If flag5 equals to 1, the object out a camera's FOV, the camera is not the tracking one
    flag6 = 0;
    if (j == 2)
        Table1 = zeros(nC, nO+1);
    end                                                                                 % Object moving alert
    Table_pre = Table1(1:nC, 1:nO);
    if (~isempty(find(Table_pre(:, :) ~= Table1_1, 1)))
        flag2 = 1;                                                                      % Object in or out the FOV
        Number = find(Table_pre(:, :) ~= Table1_1, 1);
        a2 = mod(Number, nC);
        a2(a2 == 0) = nC;
        b2 = ceil(Number/nC);
        flag2_coor = [a2, b2];                                                          % Which object in which camera trigger the reassignment
        aa1 = Table_pre(a2, b2) - Table1_1(a2, b2);
        if (aa1 == -1)                                                                  % Move in
            flag5 = 1;
        elseif (handles.Table2(a2, b2) == 1 && aa1 == 1)
            flag6 = 1;                                                                  % Tracking, move out
        end
    end
    
    Table1 = [Table1_1, Energy_Left'];
    set(tt1, 'Data', Table1);
    
    if (max(Energy_Left) == 0)
        disp('All cameras die');
        break;
    end
    
    pp = zeros(nC, nO);
    uu = zeros(nC, nO);
    for k = 1:nO
        Camera_Index1 = find(Table1(:, k) == 1);                                         % The camera that can observe object k
        nc = length(Camera_Index1);
        
        if (~isempty(Camera_Index1))
            
            
            
            Utility_Energy = Energy_Left(Camera_Index1);
            Utility_Energy = Utility_Energy/max(Utility_Energy);                 % Normalized energy 1
            %                Utility_Energy = Utility_Energy/sum(Utility_Energy);                 % Normalized energy 2
            
            B = repmat([x(k,j) + ObjectSize/2, y(k,j) + ObjectSize/2]', 1, nc);
            C = B - handles.coordinates_camera(1:2, Camera_Index1);
            C1 = C(1, :);
            C1(C1 > 0) = 0;
            C1(C1 < 0) = 1;
            D = C1;
            Angles = mod(atan(C(2, :)./C(1, :)) + pi*D, 2*pi);
            
            Angles_Diff = abs(Angles - handles.coordinates_camera(3, Camera_Index1));
            Angles_Diff = abs((Angles_Diff > pi)*2*pi - Angles_Diff);
            Angles_Diff(Angles_Diff > pi/6) = pi/6;
            
            Distance = sqrt(sum(C.^2, 1));                                   % The reciprocals of distances between the object and the cameras that can observe this object
            
            %                   Utility_Distance = 1 - Distance/max(Distance);
            Utility_Distance = 1 - Distance/0.5;
            Utility_Angles = 1 - 6*Angles_Diff/pi;
            
            beta = 0.4;
            Utility_Resolution = beta*Utility_Angles + (1-beta)*Utility_Distance;   % Normalized resolution
            
            handles.Energy(Camera_Index1, Table3(1), k) = Utility_Energy;
            handles.Resolution(Camera_Index1, Table3(1), k) = Utility_Resolution;
            handles.Distance(Camera_Index1, Table3(1), k) = Utility_Distance;
            
            if (nc == 1)
                pp(Camera_Index1, k) = 1;
                uu(Camera_Index1, k) = Weight*[handles.Energy(Camera_Index1, Table3(1), k); ...
                    handles.Resolution(Camera_Index1, Table3(1), k); ...
                    1];
                
                
            end
        end
    end
    
    
    % The requirement for task assignment, do not need Time_Period
    switch Trigger
        case 0
            if (flag1 == 1 || flag3 == 1 || flag4 == 1 || flag5 == 1 || flag6 == 1)                % Task assignment
                %             if (flag1 == 1 || flag3 == 1 || flag5 == 1 || flag6 == 1)
                trigger = 1;
            end
            
        case 1
            if (mod(j, Time_Period) == 0 || j == 2)
                trigger = 1;
            end
            
        otherwise
            error('Unknown Trigger');
            disp('Unknown Trigger');
            close('camerasimulation');
    end
    
    if (trigger == 1);
        
        %         disp('flag');
        %         disp([flag1, flag2, flag3, flag4, flag5, flag6]);
        
        Table3(2) = Table3(2) + 1;                                                   % Table3(2) is the count of task assignment
        count_send_list = zeros(1, nC);
        count_rec_list = zeros(1, nC);
        count_send_load = zeros(1, nC);                           % The number of feed back (Load and camera)
        count_rec_load = zeros(1, nC);
        count_send_feature = zeros(1, nC);                                          % Num of messages sent from Cameras
        count_rec_feature = zeros(1, nC);                                           % Num of messages received for cameras
        count_send_resource = zeros(1, nC);
        count_rec_resource = zeros(1, nC);
        
        % Calculate the communication part
        handles.probability(:, Table3(2), :) = pp;
        handles.utility(:, Table3(2), :) = uu;
        
        % Method 2, broadcast is one count
        
        if (Table3(2) == 1)
            Table_message = zeros(nC, nO);
            Table7 = Table1_1;
            for i3 = 1:nC-1
                Index3 = Table7(i3, :) == 1;
                if (sum(Index3) ~= 0)
                    Table_message(i3, Index3) = 1;
                    count_send_feature(i3) = count_send_feature(i3) + sum(Index3);                     % Num of message sent from Cam i3
                    count_rec_feature(i3+1:nC) = count_rec_feature(i3+1:nC) + sum(Index3);
                    for i4 = i3+1:nC
                        Index4 = Table7(i4, :) == 1;
                        Index5 = Index3 == Index4;
                        Index6 = Index4(Index5) == 1;
                        if (sum(Index6) ~= 0)
                            count_send_resource(i4) = count_send_resource(i4) + sum(Index6);
                            count_rec_resource(i3) = count_rec_resource(i3) + sum(Index6);
                            Table7(i4, Index5) = 0;
                        end
                    end
                end
            end
            Table_message(nC, :) = Table7(nC, :);                                    % The information of object collected by which camera
        else
            
            % Then request information from current table1
            
            if (flag6 == 1)                                                              % Tracking, move out
                Table_message = handles.Table2(1:nC, 1:nO);
                Table_other = Table_pre - Table_message;
                %                 if (sum(Table1_1(:, flag2_coor(2))) == 0)                                % If a object can only be seen by this camera, drop this object.
                %                     Table_message(flag2_coor(1), flag2_coor(2)) = 0;
                %                 end
                
                % Then request information from previous table1
                
            elseif (flag5 == 1)
                Table_message = handles.Table2(1:nC, 1:nO);
                Table_message(:, flag2_coor(2)) = 0;
                Table_message(flag2_coor(1), flag2_coor(2)) = 1;
                Table_other  = Table1_1 - Table_message;
                % Then request information from current table1
            else
                Table_message = handles.Table2(1:nC, 1:nO);
                Table_other = Table1_1 - Table_message;
            end
            
            for iO = 1:nO
                iC = find(Table_message(:, iO) == 1);
                iC1 = find(Table_other(:, iO) == 1);
                if (~isempty(iC))
                    count_send_feature(iC) = count_send_feature(iC) + 1;       % Request information from other cameras  (contains energy/new or exist)
                    count_rec_feature(iC1) = count_rec_feature(iC1) + 1;
                    if (flag6 == 0)
                        if (Energy_Left(iC) > E_Thr)
                            iC2 = Energy_Left(iC1) > E_Thr;
                            iC3 = iC1(iC2);
                            count_send_resource(iC3) = count_send_resource(iC3) + 1;
                            count_rec_resource(iC) = count_rec_resource(iC) + sum(iC2);
                        else
                            count_send_resource(iC1) = count_send_resource(iC1) + 1;
                            count_rec_resource(iC) = count_rec_resource(iC) + sum(iC1);
                        end
                    else
                        count_send_resource(iC1) = count_send_resource(iC1) + 1;
                        count_rec_resource(iC) = count_rec_resource(iC) + sum(iC1);
                    end
                end
            end
        end
        %         disp('Table1_1');
        %         disp(Table1_1);
        %         disp('Table2');
        %         disp(handles.Table2(1:nC, 1:nO));
        %         disp('Table_message');
        %         disp(Table_message);
        %         disp('count_send_feature');
        %         disp(count_send_feature);
        %         disp('count_send_resource');
        %         disp(count_send_resource);
        %
        %         disp('count_send_load');
        %         disp(count_send_load);
        
        % Task assignment
        Load = zeros(1, nC);
        Table2(1:nC, 1:nO) = zeros(nC, nO);                                             % Table2 is the task assignment situation
        
        for k1 = 1:nO                                                                % Give the only seen object the highest priority
            Index_only = find(Table4(:, k1) == 1);
            if (length(Index_only) == 1)
                Load2(Index_only) = Load2(Index_only) + 1;
                Table2(Index_only, k1) = 1;
                %                 if (flag6 == 1 && k1 == flag2_coor(2));
                %                     count_send_list(flag2_coor(1)) = count_send_list(flag2_coor(1)) + 1;
                %                 end
            end
        end
        
        %         disp('count_send_list');
        %         disp(count_send_list);
        
        Cam = zeros(1, nO);
        Table_temp = Table4;
        Table_in = Table2(1:nC, 1:nO);
        Table4 = zeros(nC, nO);
        loop = 0;
        while (sum(Load) ~= Load_Num)
            %             disp(Load_Num);
            
            loop = loop + 1;
            
            %             if (loop > 10)
            %                 error('error');
            %             end
            
            Utility_Save = zeros(nC, nO);
            for k = 1:nO
                Camera_Index = find(Table_temp(:, k) == 1);                                 % The camera that can observe object k
                
                nc = length(Camera_Index);
                
                if (~isempty(Camera_Index))
                    
                    if (max(Load(Camera_Index)) == 0)                                                   % Load definition
                        Utility_Load = ones(1, nc);
                    else
                        Utility_Load1 = Load(Camera_Index)./Processing_Power(Camera_Index);
                        %                         Utility_Load = (max(Load) - Load(Camera_Index)./Processing_Power(Camera_Index))/max(Load);
                        Utility_Load = 1 - Utility_Load1/max(Utility_Load1);
                    end
                    
                    handles.utilityE(Camera_Index, Table3(2), k) = handles.Energy(Camera_Index, Table3(1), k);
                    handles.utilityR(Camera_Index, Table3(2), k) = handles.Resolution(Camera_Index, Table3(1), k);
                    handles.utilityL(Camera_Index, Table3(2), k) = Utility_Load;
                    
                    % Find the camera with the highest energy to calculate
                    % the utility
                    
                    %                     High_E = find(Energy_Left == max(Energy_Left(Camera_Index)));
                    
                    % Calculate the weights based on variance
                    Var_E = var(handles.utilityE(Camera_Index, Table3(2), k));
                    Var_R = var(handles.utilityR(Camera_Index, Table3(2), k));
                    Var_L = var(handles.utilityL(Camera_Index, Table3(2), k));
                    
                    if (Updating_Method == 3)                            % Variance method
                        %                     aerfa = 0.5;
                        if (nc == 1)
                            Weights1(k, :) = [1/3, 1/3, 1/3];
                        else
                            V = [Var_E, Var_R, Var_L];
                            Weights1(k, :) = V./sum(V)*aerfa + (1-aerfa)/3;
                        end
                    end
                    
                    handles.VarE(k, Table3(2)) = Var_E;
                    handles.VarR(k, Table3(2)) = Var_R;
                    handles.VarL(k, Table3(2)) = Var_L;
                    
                    % Utility calculating
                    Utility_O = Weights1(k, :)*[handles.utilityE(Camera_Index, Table3(2), k)'; ...
                        handles.utilityR(Camera_Index, Table3(2), k)'; ...
                        handles.utilityL(Camera_Index, Table3(2), k)'];
                    
                    
                    % Normalization of utility
                    Utility_O1 = Utility_O/max(Utility_O);
                    handles.utility(Camera_Index, Table3(2), k) = Utility_O;
                    handles.distance(Camera_Index, Table3(2), k) = handles.Distance(Camera_Index, Table3(1), k);
                    
                    % Bargaining mechanism
                    
                    aa = zeros(1, nC);
                    bb = zeros(1, nC);
                    aa(Camera_Index') = 1;
                    bb(Cam_Low) = 1;
                    
                    if (nc > 1)
                        if (Method_ethr == 0)
                            [Pr, Cam(k)] = Bargain(tau, k, N, Camera_Index, Utility_O1);
                            handles.probability(Camera_Index, Table3(2), k) = Pr;
                        end
                        
                        if (Method_ethr == 1)
                            if (~isempty(find(aa - bb > 0, 1)))                            % The energies of the cameras are higher than E_Thr
                                [Pr, Cam(k)] = Bargain(tau, k, N, Camera_Index, Utility_O1);
                                handles.probability(Camera_Index, Table3(2), k) = Pr;
                            else                                                          % The energies of the cameras are lower than E_Thr
                                Cam1 = find(Energy_Left(Cam_Low) == max(Energy_Left(Camera_Index')));
                                if (length(Cam1) > 1)
                                    Cam1 = 1;
                                end
                                Cam(k) = Cam_Low(Cam1);
                                handles.probability(Cam(k), Table3(2), k) = 1;
                            end
                        end
                        
                        Max_Index = Camera_Index == Cam(k);
                        Utility_Save(Cam(k), k) = Utility_O(Max_Index);
                        
                        Table_in(Cam(k), k) = 1;                                      % The loop-th decision make
                    end
                end
            end
            %             disp('Table_message');
            %             disp(Table_message);
            %             disp('Table_in');
            %             disp(Table_in);
            % Calculate the loop-th communication count
            
            TT = Table_message - Table_in;
            for i = 1:nO
                a8 = find(TT(:, i) > 0);
                if (~isempty(a8))
                    count_send_list(a8) = count_send_list(a8) + 1;
                end
                a9 = find(TT(:, i) < 0);
                if (~isempty(a9))
                    count_rec_list(a9) = count_rec_list(a9) + 1;
                end
            end
            
            a = max(Utility_Save, [], 2);
            
            for i1 = 1:nC
                % If give the object to the highest energy one when all
                % energies are lower than E_Thr
                a6 = zeros(1, nO);
                if (Load2(i1) ~= 0 && loop == 1)
                    Load(i1) = Load(i1) + Load2(i1);
                else
                    % Method 1 ------ Both cameras' energies are less than thr,
                    % give it to highest utility one
                    if (Method_ethr == 0)
                        if (a(i1) ~= 0)
                            Index1 = find(Utility_Save(i1, :) == a(i1));
                            a6(Utility_Save(i1, :) > 0) = 1;
                            a6(Utility_Save(i1, :) == a(i1)) = 0;
                            if (sum(a6) ~= 0)
                                a6_1 = find(a6 == 1);
                                Table_in(:, a6_1) = 0;
                                a7 = Table_message(:, a6_1) - Table_in(:, a6_1);
                                Index7 = mod(find(a7 > 0), nC);
                                Index7(Index7 == 0) = nC;
                                for ii1 = 1:length(Index7)
                                    count_rec_load(Index7(ii1)) = count_rec_load(Index7(ii1)) + 1;
                                end
                            end
                            handles.utility_f(i1, Index1, Table3(2)) = Utility_Save(i1, Index1);
                            Load(i1) = Load(i1) + 1;
                            Table2(i1, Index1) = 1;
                            Table_temp(:, Index1) = zeros(nC, 1);
                        end
                    elseif (Method_ethr == 1)
                        % Method 2 ------ Both cameras' energies are less than thr,
                        % give it to highest energy one
                        if (a(i1) ~= 0 && Energy_Left(i1) >= E_Thr)
                            Index1 = find(Utility_Save(i1, :) == a(i1));
                            a6(Utility_Save(i1, :) > 0) = 1;
                            a6(Utility_Save(i1, :) == a(i1)) = 0;
                            if (sum(a6) ~= 0)
                                a6_1 = find(a6 == 1);
                                Table_in(:, a6_1) = 0;
                                a7 = Table_message(:, a6_1) - Table_in(:, a6_1);
                                Index7 = mod(find(a7 > 0), nC);
                                Index7(Index7 == 0) = nC;
                                for ii1 = 1:length(Index7)
                                    count_rec_load(Index7(ii1)) = count_rec_load(Index7(ii1)) + 1;
                                end
                            end
                            handles.utility_f(i1, Index1, Table3(2)) = Utility_Save(i1, Index1);
                            Load(i1) = Load(i1) + 1;
                            Table2(i1, Index1) = 1;
                            Table_temp(:, Index1) = zeros(nC, 1);
                        elseif (a(i1) ~= 0 && Energy_Left(i1) < E_Thr)
                            Load(i1) = Load(i1) + length(find(Utility_Save(i1, :) ~= 0));
                            Index1_1 = find(Utility_Save(i1, :) ~= 0);
                            Table2(i1, Index1_1) = 1;
                            Table_temp(:, Index1_1) = 0;
                        end
                    end
                end
            end
            
            %             disp('Table2');
            %             disp(Table2);
            Table_T = Table2(1:nC, 1:nO) - Table4;
            Table4 = Table2(1:nC, 1:nO);
            Table_pre = Table1_1;
            Table_m = Table_message;
            T_S1 = sum(Table2(1:nC, 1:nO));
            a11 = T_S1 ~= 0;
            Table_pre(:, a11) = 0;
            Table_m(:, a11) = 0;
            T_S2 = sum(Table_T(1:nC, 1:nO), 2);
            a12 = find(T_S2 ~= 0);
            if (~isempty(a12) && sum(sum(Table_pre)) ~= 0)
                for i = 1:length(a12)
                    %                     count_send_load(a12(i)) = sum(Table_pre(a12(i), :) - Table_m(a12(i), :)) + count_send_load(a12(i));     % Send one message for each one object
                    
                    
                    
                    a13 = Table_pre(a12(i), :) - Table_m(a12(i), :) > 0;     % Send one message for all object
                    a14 = Table_message(:, a13);
                    a15 = sum(a14, 2) > 0;
                    count_send_load(a12(i)) = sum(a15) + count_send_load(a12(i));
                end
            end
            
            %         disp('count_send_feature');
            %         disp(count_send_feature);
            %         disp('count_send_resource');
            %         disp(count_send_resource);
            %         disp('count_send_list');
            %         disp(count_send_list);
            %         disp('count_send_load');
            %         disp(count_send_load);
            
            a10 = sum(Table2(1:nC, 1:nO));
            Table_message(:, a10 ~= 0) = 0;
            Table_in = zeros(nC, nO);
        end
        
        handles.count_com(Table3(2)) = sum(count_send_feature) + sum(count_send_resource) + ...
            sum(count_send_list) +  sum(count_send_load);
        %         disp(handles.count_com(Table3(2)));
        handles.Table2 = Table2;
        handles.count_com_overall(Table3(1)) = handles.count_com(Table3(2));
        
        
        % Weights updating way
        for i2 = 1:nO
            Index2 = find(Table1(:, i2) == 1);                                         % The camera that can observe object k
            nc1 = length(Index2);
            
            if (~isempty(Index2) && nc1 > 1)
                Max_Index = Table2(:, i2) == 1;
                
                UEnergy_avg = sum(handles.utilityE(Index2, Table3(2), i2))/nc1;
                UResolution_avg = sum(handles.utilityR(Index2, Table3(2), i2))/nc1;
                ULoad_avg = sum(handles.utilityL(Index2, Table3(2), i2))/nc1;
                
                UEnergy_max = handles.utilityE(Max_Index, Table3(2), i2);
                UResolution_max = handles.utilityR(Max_Index, Table3(2), i2);
                ULoad_max = handles.utilityL(Max_Index, Table3(2), i2);
                handles.E(i2, Table3(2)) = UEnergy_max;
                handles.R(i2, Table3(2)) = UResolution_max;
                handles.L(i2, Table3(2)) = ULoad_max;
                
                if (Updating_Method ~= 3)
                    switch Updating_Method
                        case 1                                    % Youlu's method
                            q_E1 = (UEnergy_max - UEnergy_avg) >= 0;
                            q_D1 = (UResolution_max - UResolution_avg) >= 0;
                            q_L1 = (ULoad_max - ULoad_avg) >= 0;
                            
                            QQ = q_E1 + q_D1 + q_L1;
                            if (QQ ~= 0)
                                K = [q_E1, q_D1, q_L1]/QQ;
                                %                           aerfa = 0.9;
                                
                                Weights1(i2, :) = K*aerfa + (1 - aerfa)/3;
                            else
                                Weights1(i2, :) = Weights1(i2, :);
                            end
                            
                        case 2                                    % Agreement
                            q_E1 = UEnergy_max == max(handles.utilityE(Index2, Table3(2), i2));
                            q_D1 = UResolution_max == max(handles.utilityR(Index2, Table3(2), i2));
                            q_L1 = ULoad_max == max(handles.utilityL(Index2, Table3(2), i2));
                            
                            QQ = q_E1 + q_D1 + q_L1;
                            if (QQ ~= 0)
                                K = [q_E1, q_D1, q_L1]/QQ;
                                %                           aerfa = 0.2
                                Weights1(i2, :) = K*aerfa + (1 - aerfa)*Weights1(i2, :);
                            else
                                Weights1(i2, :) = Weights1(i2, :);
                            end
                            
                        case 4
                            Weights(k, :) = 1./Weights1(k, :);
                            Weights1(k, :) = Weights(k, :)./sum(Weights(k, :));
                            
                        otherwise                                 % Constant
                            Weights1(i2, :) = Weight;
                            
                            
                    end
                end
            elseif (~isempty(Index2) && nc1 == 1)
                handles.E(i2, Table3(2)) = handles.utilityE(Index2, Table3(2), i2);
                handles.R(i2, Table3(2)) = handles.utilityR(Index2, Table3(2), i2);
                handles.L(i2, Table3(2)) = handles.utilityL(Index2, Table3(2), i2);
                Weights1(i2, :) = Weight;
            else
                Weights1(i2, :) = Weight;
            end
        end
        
        handles.Assignment = Table3(2);
        handles.Table3 = Table3;
        for i = 1:nO                                                        % Calculate the distance (resolution) between the object and the cooresponding camera
            index1 = find(handles.Table2(1:nC, i) == 1);
            if (isempty(index1));
                tempD1(i) = 0;
                tempR1(i) = 0;
            else
                B1 = [x(i,j) + ObjectSize/2, y(i,j) + ObjectSize/2]';
                C1 = B1 - handles.coordinates_camera(1:2, index1);
                tempD1(i) = norm(C1);
                tempR1(i) = handles.Resolution(index1, Table3(1), i);
            end
        end
        
        %         Table2(nC+1, :) = tempD1;                                  % Distance threshold
        %         tempD1(tempD1 > Dist_Thr) = 1;
        %         tempD1(tempD1 <= Dist_Thr) = 0;
        %         Dist = tempD1;
        
        Table2(nC+1, 1:nO) = tempR1;                                  % Resolution threshold
        tempR1(tempR1 > Res_Thr) = 1;
        tempR1(tempR1 <= Res_Thr) = 0;
        Res = tempR1;
        
        handles.Table2 = Table2;
        set(tt2, 'Data', Table2);
    end
    
    
    set(tt3, 'Data', Table3);
    
    a1 = sum(handles.Table2(1:nC, 1:nO), 2);
    b1 = a1 == 0;                                                                    % The number of cameras do not track object
    Load1 = a1';                                                                     % The number of objects that each camera tracking
    for i = 1:nO
        index2 = find(handles.Table2(1:nC, i) == 1);
        if (isempty(index2));
            tempD2(i) = 0;
            tempR2(i) = 0;
        else
            B2 = [x(i,j) + ObjectSize/2, y(i,j) + ObjectSize/2]';
            C2 = B2 - handles.coordinates_camera(1:2, index2);
            tempD2(i) = norm(C2);
            tempR2(i) = handles.Resolution(index2, Table3(1), i);
            handles.trackingEnergy(i, Table3(1)) = Energy_Left(index2);
            handles.trackingLoad(i, Table3(1)) = Load1(index2);
            handles.trackingE(i, Table3(1)) = handles.Energy(index2, Table3(1), i);
            handles.trackingR(i, Table3(1)) = handles.Resolution(index2, Table3(1), i);
        end
    end
    
    %     Table2(nC+1, :) = tempD2;
    %     tempD2(tempD2 > Dist_Thr) = 1;
    %     tempD2(tempD2 <= Dist_Thr) = 0;
    %     flag3 = ~isempty(find(tempD2-Dist > 0, 1));
    %     a4 = find(tempD2-Dist > 0, 1);
    %     flag3_coor = [find(Table2(:, a4) == 1), a4];                                   % Which object in which camera trigger the Distance Threshold
    %     Dist = tempD2;
    
    ha = zeros(1, nO);
    for k = 1:nO
        aaa = find(Table2(1:nC, k) == 1);
        if (~isempty(aaa))
            ha(k) = handles.utility(aaa, Table3(2), k);
        end
    end
    Table2(nC+1, 1:nO) = ha;
    Table2(1:nC, nO+1) = Energy_Left';
    tempR2(tempR2 > Res_Thr) = 1;
    tempR2(tempR2 <= Res_Thr) = 0;
    flag3 = ~isempty(find(tempR2-Res < 0, 1));
    a4 = find(tempR2-Res < 0, 1);
    flag3_coor = [find(Table2(:, a4) == 1), a4];                                   % Which object in which camera trigger the Resolution Threshold
    Res = tempR2;
    handles.Table2 = Table2;
    set(tt2, 'Data', Table2);
    
    
    Energy_Left = Energy_Left - a1'*Tracking_Consumption - b1'*Idle_Consumption;
    %     Energy_Left = Energy_Left - a1'*Tracking_Consumption - b1'*Idle_Consumption - ...
    Energy_cons * [count_send_feature; count_send_resource; count_send_list; count_send_load];
    Energy_Left(Energy_Left <= 0) = 0;
    handles.energy = [handles.energy; Energy_Left];
    
    flag4 = 0;
    if (mod(j, T_int) == 0)
        if (j == T_int)
            Rate_Consumption = (handles.energy(1, :) - handles.energy(j, :))/T_int;
        else
            Rate_Consumption = (handles.energy(j-T_int, :) - handles.energy(j, :))/T_int;
        end
        Index8 = Rate_Consumption > Rate_Thr;
        if (sum(Index8) > 0 && sum(sum(handles.Table2(Index8, 1:nO))) > 0)
            flag4 = 1;
            a5 = find(Rate_Consumption > Rate_Thr);
            flag4_coor = a5;                                                       % Which camera trigger the EnergyConsumption Threshold
        end
        handles.rate = [handles.rate; Rate_Consumption];
    end
    
end

%     Probability = handles.probability;
%     save('./data/Probability', 'Probability');

%     if (mod(j, Time_Period) == 0)
%         hold on;
%         plot(j*ones(nC, 1), Energy_Left'/10, 'r.', 'MarkerSize',1);
%         axis([0 length(t) 0 1]);
%     end


handles.Time = Table3(1);

Miu = zeros(nO, 3);
Variance = zeros(nO, 3);
for i = 1:nO
    be = handles.trackingE(i, :) ~= 0;
    br = handles.trackingR(i, :) ~= 0;
    bl = handles.trackingLoad(i, :) ~= 0;
    dd = be & br & bl;
    ce = handles.trackingE(i, dd);
    cr = handles.trackingR(i, dd);
    cl = handles.trackingLoad(i, dd);
    
    Mat = [ce', cr', cl'];
    Miu(i, :) = mean(Mat);
    Variance(i, :) = var(Mat);
    
    savefilename4 = './%s/TrackingE_O%d.mat';
    ssname4 = sprintf(savefilename4, Filename, i);
    TrackingE = handles.trackingE(i, :);
    save(ssname4, 'TrackingE');
    
    savefilename5 = './%s/TrackingEnergy_O%d.mat';
    ssname5 = sprintf(savefilename5, Filename, i);
    TrackingEnergy = handles.trackingEnergy(i, :);
    save(ssname5, 'TrackingEnergy');
    
    savefilename6 = './%s/TrackingR_O%d.mat';
    ssname6 = sprintf(savefilename6, Filename, i);
    TrackingR = handles.trackingR(i, :);
    save(ssname6, 'TrackingR');
    
    savefilename7 = './%s/TrackingLoad_O%d.mat';
    ssname7 = sprintf(savefilename7, Filename, i);
    TrackingLoad = handles.trackingLoad(i, :);
    save(ssname7, 'TrackingLoad');
    
    
end
savefilename2 = './%s/Mean.mat';
ssname2 = sprintf(savefilename2, Filename);
save(ssname2, 'Miu');

savefilename3 = './%s/Variance.mat';
ssname3 = sprintf(savefilename3, Filename);
save(ssname3, 'Variance');

disp(Miu);
disp(Variance);
% for i = 1:nO
%     be = handles.E(i, 1:Table3(2)) ~= 0;
%     br = handles.R(i, 1:Table3(2)) ~= 0;
%     bl = handles.L(i, 1:Table3(2)) ~= 0;
%     ce = handles.E(i, be);
%     cr = handles.R(i, br);
%     cl = handles.L(i, bl);
%
%     Mat = [ce', cr', cl'];
%     Miu(i, :) = mean(Mat);
%     Variance(i, :) = var(Mat);
%
%     savefilename2 = './%s/Mean_O%d.mat';
%     ssname2 = sprintf(savefilename2, Filename, i);
%     Mean = Miu(i, :);
%     save(ssname2, 'Mean');
%
%     savefilename3 = './%s/Variance_O%d.mat';
%     ssname3 = sprintf(savefilename3, Filename, i);
%     Var = Variance(i, :);
%     save(ssname3, 'Var');
%
%     disp(Mean);
%     disp(Var);
% end


energy = handles.energy';
savefilename1 = './%s/handles_energy';
ssname1 = sprintf(savefilename1, Filename);
save(ssname1, 'energy');


for i = 1:nO
    savefile1 = './%s/Utility_O%d.mat';
    ss1 = sprintf(savefile1, Filename, i);
    Utility = handles.utility(:, 1:Table3(2), i);
    save(ss1, 'Utility');
    
    savefile2 = './%s/Probability_O%d.mat';
    ss2 = sprintf(savefile2, Filename, i);
    Probability = handles.probability(:, 1:Table3(2), i);
    save(ss2, 'Probability');
    
    savefile3 = './%s/Distance_O%d.mat';
    ss3 = sprintf(savefile3, Filename, i);
    Distance_U = handles.distance(:, 1:Table3(2), i);
    save(ss3, 'Distance_U');
    
    savefile4 = './%s/VarianceE_O%d.mat';
    ss4 = sprintf(savefile4, Filename, i);
    VarianceE = handles.VarE(i, 1:Table3(2));
    save(ss4, 'VarianceE');
    
    savefile5 = './%s/VarianceR_O%d.mat';
    ss5 = sprintf(savefile5, Filename, i);
    VarianceR = handles.VarR(i, 1:Table3(2));
    save(ss5, 'VarianceR');
    
    savefile6 = './%s/VarianceL_O%d.mat';
    ss6 = sprintf(savefile6, Filename, i);
    VarianceL = handles.VarL(i, 1:Table3(2));
    save(ss6, 'VarianceL');
    
    savefile7 = './%s/UtilityE_O%d.mat';
    ss7 = sprintf(savefile7, Filename, i);
    UtilityE = handles.E(i, 1:Table3(2));
    save(ss7, 'UtilityE');
    
    savefile8 = './%s/UtilityR_O%d.mat';
    ss8 = sprintf(savefile8, Filename, i);
    UtilityR = handles.R(i, 1:Table3(2));
    save(ss8, 'UtilityR');
    
    savefile9 = './%s/UtilityL_O%d.mat';
    ss9 = sprintf(savefile9, Filename, i);
    UtilityL = handles.L(i, 1:Table3(2));
    save(ss9, 'UtilityL');
    
    for j = 1:nC
        savefile10 = './%s/UtilityE_O%dC%d.mat';
        ss10 = sprintf(savefile10, Filename, i, j);
        Utility_E =  handles.utilityE(j, 1:Table3(2), i);
        save(ss10, 'Utility_E');
    end
    
    for j = 1:nC
        savefile11 = './%s/UtilityR_O%dC%d.mat';
        ss11 = sprintf(savefile11, Filename, i, j);
        Utility_R =  handles.utilityR(j, 1:Table3(2), i);
        save(ss11, 'Utility_R');
    end
    
    for j = 1:nC
        savefile12 = './%s/UtilityL_O%dC%d.mat';
        ss12 = sprintf(savefile12, Filename, i, j);
        Utility_L =  handles.utilityL(j, 1:Table3(2), i);
        save(ss12, 'Utility_L');
    end
    
end

savefile13 = './%s/count_com.mat';
ss13 = sprintf(savefile13, Filename);
count_com = handles.count_com;
save(ss13, 'count_com');

savefile14 = './%s/count_com_overall.mat';
ss14 = sprintf(savefile14, Filename);
count_com_overall = handles.count_com_overall;
save(ss13, 'count_com_overall');

guidata(hObject, handles);

% --- Executes on button press in drawfigure.
function drawfigure_Callback(hObject, eventdata, handles)
% hObject    handle to drawfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ss{1} = 'r-';
ss{2} = 'k-.';
ss{3} = 'b--';
ss{4} = 'm-.';
ss{5} = 'k-d';
ss{6} = 'r-s';
ss{7} = 'g-o';
ss{8} = 'b-*';
ss{9} = 'm-x';
ss{10} = 'k-+';
ss{11} = 'r--';
ss{12} = 'r:';
ss{13} = 'g--';
ss{14} = 'g:';
ss{15} = 'r-d';
ss{16} = 'k-s';
ss{17} = 'r-o';
ss{18} = 'r-*';
ss{19} = 'k-x';
ss{20} = 'm-+';
[~, nO] = size(handles.coordinates_object);
[~, nC] = size(handles.coordinates_camera);

figure;                                    % Energy Left
for i = 1:nC
    plot(1:handles.Time, handles.energy(1:handles.Time, i)', ss{i}, 'MarkerSize', 2, 'linewidth', 2);
    s = 'Cam[%d]';
    s_s{i} = sprintf(s, i);
    hold on;
end
xlabel('Time');
ylabel('Energy Left');
legend(s_s, 1-i);

% for i = 1:nO
%     figure;                                % Utility
%     for j = 1:nC
%         plot(1:handles.Assignment, handles.utility(j, 1:handles.Assignment, i), ss{j}, 'MarkerSize', 3);
%         s = 'utility_O[%d][%d]';
%         s_s{j} = sprintf(s, i, j);
%         hold on;
%     end
%     xlabel('Assignment');
%     ylabel('Overall Utility');
%     legend(s_s, 1-j);
% end


% for i = 1:nO
%     figure;                                    % Probability
%     for j = 1:nC
%         plot(1:handles.Assignment, handles.probability(j, 1:handles.Assignment, i), ss{j}, 'MarkerSize', 3);
%         s = 'probability_O[%d][%d]';
%         s_s{j} = sprintf(s, i, j);
%         hold on;
%     end
%     xlabel('Assignment');
%     ylabel('Probability');
%     legend(s_s, 1-j);
% end

% for i = 1:nO
%     figure;                                   % Variance for each feature
%     plot(1:handles.Assignment, handles.VarE(i, 1:handles.Assignment), ss{1}, 'MarkerSize', 3);
%     hold on;
%     plot(1:handles.Assignment, handles.VarR(i, 1:handles.Assignment), ss{2}, 'MarkerSize', 3);
%     hold on;
%     plot(1:handles.Assignment, handles.VarL(i, 1:handles.Assignment), ss{3}, 'MarkerSize', 3);
%     s_s{1} = 'VarE';
%     s_s{2} = 'VarR';
%     s_s{3} = 'VarL';
%     s = 'Variance for O%d';
%     sss{i} = sprintf(s, i);
%     xlabel('Assignment');
%     ylabel(sss{i});
%     legend(s_s, 1-3);
% end


% for i = 1:nO
%     figure;
%     plot(1:handles.Assignment, handles.E(i, 1:handles.Assignment), ss{1}, 'MarkerSize', 3);
%     hold on;
%     plot(1:handles.Assignment, handles.R(i, 1:handles.Assignment), ss{2}, 'MarkerSize', 3);
%     hold on;
%     plot(1:handles.Assignment, handles.L(i, 1:handles.Assignment), ss{3}, 'MarkerSize', 3);
%     s_s{1} = 'UtilityE';
%     s_s{2} = 'UtilityR';
%     s_s{3} = 'UtilityL';
%     s = 'Utility for O%d';
%     sss{i} = sprintf(s, i);
%     xlabel('Assignment');
%     ylabel(sss{i});
%     legend(s_s, 1-3);
% end

% for i = 1:nO
%     for j = 1:nC
%         figure;
%         plot(1:handles.Assignment, handles.utilityE(j, 1:handles.Assignment, i), ss{1}, 'MarkerSize', 3);
%         hold on;
%         plot(1:handles.Assignment, handles.utilityR(j, 1:handles.Assignment, i), ss{2}, 'MarkerSize', 3);
%         hold on;
%         plot(1:handles.Assignment, handles.utilityL(j, 1:handles.Assignment, i), ss{3}, 'MarkerSize', 3);
%         s_s{1} = 'UtilityE';
%         s_s{2} = 'UtilityR';
%         s_s{3} = 'UtilityL';
%         s = 'Utility for O%dC%d';
%         sss{i} = sprintf(s, i, j);
%         xlabel('Assignment');
%         ylabel(sss{i});
%         legend(s_s, 1-3);
%     end
% end

% for i = 1:nO
%     figure;
%     plot(1:handles.Time, handles.trackingE(i, 1:handles.Time), ss{1}, 'MarkerSize', 3);
%     hold on;
%     plot(1:handles.Time, handles.trackingR(i, 1:handles.Time), ss{2}, 'MarkerSize', 3);
%     hold on;
%     plot(1:handles.Time, handles.trackingLoad(i, 1:handles.Time), ss{3}, 'MarkerSize', 3);
% %     hold on;
% %     plot(1:handles.Time, handles.trackingEnergy(i, 1:handles.Time), ss{4}, 'MarkerSize', 3);
%     s_s{1} = 'TrackingEnergyUtility';
%     s_s{2} = 'TrackingResolution';
%     s_s{3} = 'TrackingLoad';
% %     s_s{4} = 'TrackingEnergy';
%     s = 'Tracking utility for O%d';
%     sss{i} = sprintf(s, i);
%     xlabel('Assignment');
%     ylabel(sss{i});
%     legend(s_s, 1-3);
% end

figure;
plot(1:handles.Time, handles.count_com_overall(1:handles.Time));
xlabel('Assignment');
ylabel('Communication Count');


% --- Executes on button press in clearObjects.
function clearObjects_Callback(hObject, eventdata, handles)
% hObject    handle to clearObjects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% delete(handles.hObjectPlot);
% delete(handles.text);
delete(handles.line_handle);
delete(handles.text_handle);
handles.count_object = 0;
handles.coordinates_object = [];
guidata(hObject, handles);


% --- Executes on button press in clearCameras.
function clearCameras_Callback(hObject, eventdata, handles)
% hObject    handle to clearCameras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.hCameraPlot);
delete(handles.text_C);
delete(handles.hLine1);
delete(handles.hLine2);
handles.coordinates_camera = [];
handles.count_camera = 0;
guidata(hObject, handles);
