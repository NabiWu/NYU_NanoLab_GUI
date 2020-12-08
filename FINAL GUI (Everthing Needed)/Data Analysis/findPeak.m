function [current_obj] = findPeak(expInfo, current_obj)

% findPeak.m function takes in a struct expInfo and finds peak positions in
% the data variables newData_V when two files are read; it
% finds peaks in variable newData_I when only one file is read.


fprintf("Interpolation and Find peaks...... (findPeak)\n\n")

current_obj.peakPos = [];
inv_data = -current_obj.newData;
peakNumLowerLim = (length(inv_data) / ((expInfo.FSCVperiod*expInfo.samplingRateADC)/expInfo.interpolationFactor));
searchingStep = 0.04; % mV
searchLine = max(inv_data) - searchingStep;

while length(current_obj.peakPos) <= peakNumLowerLim && searchLine > 0 % V
    [current_obj.v, current_obj.peakPos] = findpeaks(inv_data, 'MinPeakHeight', searchLine, 'MinPeakDistance',((expInfo.FSCVperiod*expInfo.samplingRateADC)/expInfo.interpolationFactor)/2);
    searchLine = searchLine - searchingStep;
end

if searchLine <= 0
    fprintf("Cannot find peaks!! Check input files and parameters. (findPeak)\n\n")
    return
end

current_obj.numOfPeakFound = length(current_obj.peakPos);
fprintf(current_obj.numOfPeakFound + " peaks are found. (findPeak)\n\n")

if current_obj.PBSinfo.fstCycleInd + current_obj.PBSinfo.cycleNeeded - 1 > current_obj.numOfPeakFound || current_obj.DAinfo.fstCycleInd + current_obj.DAinfo.cycleNeeded - 1 > current_obj.numOfPeakFound
    fprintf("The chosen PBS or DA starting cycle are too large! (cycleAnalysis)\n\n")
end

for i = 2 : current_obj.numOfPeakFound
   if current_obj.peakPos(i) - current_obj.peakPos(i-1) < expInfo.newNumOfPtPerCycle
       current_obj.peakPos = current_obj.peakPos(1:i-1) + current_obj.peakPos(i+1:end);
   end
end


end

