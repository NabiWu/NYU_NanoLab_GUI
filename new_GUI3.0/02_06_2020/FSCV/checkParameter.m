
function [expInfo] = checkParameter(expInfo,PBSinfo,DAinfo)


% checkParameter.m checks all priliminary and user define variables. It
% prints error messages if conditions are not met


positiveNum = @(v) isnumeric(v) && v > 0;
btw1n0      = @(y) y > 0 && y <= 1;

function isf = isflint(m)
    isf = (abs(m) <= flintmax && m == floor(m) && m > 0);
end



if ~ischar(expInfo.fileName_I) || ~ischar(expInfo.fileName_V)
    fprintf('Please check file names!! (checkParameter.m)\n\n')
end

if ~ischar(expInfo.dataFolderPath)
    fprintf('Please check dataFolderPath!! (checkParameter.m)\n\n')
end

if ~isnumeric(expInfo.lowVolt) || ~isnumeric(expInfo.highVolt)
    fprintf('Please check voltage range!! (checkParameter.m)\n\n')
end

if ~positiveNum(expInfo.rampRate)
    fprintf('Please check rampRate!! (checkParameter.m)\n\n')
end

if ~isnumeric(expInfo.comV)
    fprintf('Please check common voltage!! (checkParameter.m)\n\n')
end

if ~isnumeric(expInfo.fbR)
    fprintf('Please check feedback resistor!! (checkParameter.m)\n\n')
end

if ~isnumeric(expInfo.FSCVfrqncy)
    fprintf('Please check FSCV frequency!! (checkParameter.m)\n\n')
end

if ~isnumeric(expInfo.OSR)
    fprintf('Please check OSR!! (checkParameter.m)\n\n')
end

if ~positiveNum(PBSinfo.cycleNeeded)
    fprintf('Please check PBScycleNeeded!! (checkParameter.m)\n\n')
end

if ~positiveNum(PBSinfo.fstCycleInd)
    fprintf('Please check PBSfstCycleInd!! (checkParameter.m)\n\n')
end

if ~positiveNum(DAinfo.cycleNeeded)
    fprintf('Please check DAcycleNeeded!! (checkParameter.m)\n\n')
end

if ~positiveNum(DAinfo.fstCycleInd)
    fprintf('Please check DAfstCycleInd!! (checkParameter.m)\n\n')
end

if ~btw1n0(expInfo.interpolationFactor)
    fprintf('Please check interpolationFactor!! (checkParameter.m)\n\n')
end

if ~positiveNum(expInfo.clockRate)
    fprintf('Please check clockRate!! (checkParameter.m)\n\n')
end

if ~positiveNum(expInfo.concentration)
    fprintf('Please check concentration!! (checkParameter.m)\n\n')
end

if ~ischar(expInfo.neurotransmitter)
    fprintf('Please check neurotransmitter!! (checkParameter.m)\n\n')
end

if ~ischar(expInfo.sensorId)
    fprintf('Please check sensorId!! (checkParameter.m)\n\n')
end

if ~positiveNum(expInfo.error)
    fprintf('Please check error!! (checkParameter.m)\n\n')
end

if ~positiveNum(PBSinfo.condition2)
    fprintf('Please check PBScondition2!! (checkParameter.m)\n\n')
end

if ~positiveNum(DAinfo.condition2)
    fprintf('Please check DAcondition2!! (checkParameter.m)\n\n')
end

if ~isflint(expInfo.newNumOfPtPerCycle)
    fprintf("expInfo.newNumOfPtPerCycle is not integer or negative!! (cycleAnalysis.m)\n\n")
end

if ~isflint(expInfo.newNumOfPtPerHalfCycle)
    expInfo.newNumOfPtPerHalfCycle = ceil(expInfo.newNumOfPtPerHalfCycle);
end
   

    
end



