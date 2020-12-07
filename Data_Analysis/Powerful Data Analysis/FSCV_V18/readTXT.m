
function [expInfo,current_obj] = readTXT(expInfo, current_obj)


fileID = fopen(current_obj.fileName);
current_obj.data = fscanf(fileID,'%f\n');
fclose(fileID);

voltStep = (2*(expInfo.highVolt+abs(expInfo.lowVolt)))/expInfo.newNumOfPtPerCycle;
expInfo.newData_V = [-0.02:voltStep:expInfo.highVolt-voltStep expInfo.highVolt:-voltStep:expInfo.lowVolt+voltStep expInfo.lowVolt:voltStep:-0.02] * 1000;

if strcmp(expInfo.useSmooth,'yes')
    current_obj.newData = interp1((1:1:length(current_obj.data)),smooth(current_obj.data),(1:expInfo.interpolationFactor:length(current_obj.data)),'spline');
elseif strcmp(expInfo.useSmooth,'no')
    current_obj.newData = interp1((1:1:length(current_obj.data)),current_obj.data,(1:expInfo.interpolationFactor:length(current_obj.data)),'spline');
end


end

