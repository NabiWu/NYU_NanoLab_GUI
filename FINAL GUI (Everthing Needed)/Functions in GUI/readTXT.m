
function [expInfo] = readTXT(expInfo)


% readTXT.m reads one or two files from a designated location. It prints
% error message if file(s) cannot be opened


% inputFileNum = input('Use only one file or two? Type in 1 or 2 below\n','s');
inputFileNum='2';

trys = 2;
while ~strcmp(inputFileNum,'2') && ~strcmp(inputFileNum,'1') && trys >= 0
    fprintf('Invalid number. (readTXT)\n\n')
    inputFileNum = input('Use only one file or two? Type 1 or type 2 below\n','s');
    trys = trys - 1;
end

expInfo.inputFileNum = str2double(inputFileNum);


cd (expInfo.dataFolderPath);

try
    if expInfo.inputFileNum == 1
        
        fileID_I = fopen(expInfo.fileName_I);
        expInfo.data_I = fscanf(fileID_I,'%f\n');
        fclose(fileID_I);
        
        voltStep = (expInfo.highVolt + abs(expInfo.lowVolt))/(expInfo.newNumOfPtPerCycle/2);
        expInfo.data_V = [expInfo.lowVolt:voltStep:(expInfo.highVolt-voltStep)  expInfo.highVolt:-voltStep:(expInfo.lowVolt+voltStep)]';
        
    else
        fileID_I = fopen(expInfo.fileName_I);
        expInfo.data_I = fscanf(fileID_I,'%f\n');
        fclose(fileID_I);
        
        fileID_V = fopen(expInfo.fileName_V);
        expInfo.data_V = fscanf(fileID_V,'%f\n');
        fclose(fileID_V);
        
    end
catch
    fprintf("Check dataFolderPath and fileName!! (readTXT)\n\n")
end


% Interpolation
% useSmooth = input("Apply smooth() to both files? yes or no\n",'s');
useSmooth = 'no';
if strcmp(useSmooth,'yes')
        expInfo.newData_I = interp1((1:1:length(expInfo.data_I)),smooth(expInfo.data_I),(1:expInfo.interpolationFactor:length(expInfo.data_I)),'spline');
        expInfo.newData_V = interp1((1:1:length(expInfo.data_V)),smooth(expInfo.data_V),(1:expInfo.interpolationFactor:length(expInfo.data_V)),'spline');
elseif strcmp(useSmooth,'no')
        expInfo.newData_I = interp1((1:1:length(expInfo.data_I)),expInfo.data_I,(1:expInfo.interpolationFactor:length(expInfo.data_I)),'spline');
        expInfo.newData_V = interp1((1:1:length(expInfo.data_V)),expInfo.data_V,(1:expInfo.interpolationFactor:length(expInfo.data_V)),'spline');
end


expInfo.newData_V = expInfo.newData_V * 1000; % V -> mV

plot(expInfo.newData_V)

end

