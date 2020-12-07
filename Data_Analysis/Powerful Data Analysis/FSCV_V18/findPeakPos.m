

function [obj] = findPeakPos(obj,type)

% findPeakPos.m gets an object and a peak type as inputs, and it finds the
% peak current, peak time, and peak voltage by setting a limit in the
% voltage range to counteract potential effect of large artifact.

len = length(obj.FSCVvolt);

if strcmp(type,"oxidation")
    
    upper = 440;
    lower = 290;
    searchingRange = round(1: len/2);
    subtractedCurr = obj.subtractedCurr;
    
elseif strcmp(type,"reduction")
    
    upper = 50;
    lower = -80;
    searchingRange = round(len/2: len);
    subtractedCurr = -obj.subtractedCurr;
    
end

count = 1;
rangeIndexList = 0;

for i = searchingRange
    if obj.FSCVvolt(i) > lower && obj.FSCVvolt(i) < upper
        rangeIndexList(count) = i;
        count = count + 1;
    end
end

if rangeIndexList ~= 0
    if strcmp(type,"reduction")
        peakCurr = -max(subtractedCurr(rangeIndexList));
        maxIndex = find(subtractedCurr == -peakCurr);
    else
        peakCurr = max(subtractedCurr(rangeIndexList));
        maxIndex = find(subtractedCurr == peakCurr);
    end
    
    peakVolt = obj.FSCVvolt(maxIndex);
    peakTime = obj.timeMs(maxIndex);

else
    peakCurr = Inf;
    peakTime = Inf;
    peakVolt = Inf;
end


if strcmp(type,"oxidation")
    obj.oxidationPeakCurr = peakCurr;
    obj.oxidationPeakTime = peakTime;
    obj.oxidationPeakVolt = peakVolt;
elseif strcmp(type,"reduction")
    obj.reductionPeakCurr = peakCurr;
    obj.reductionPeakTime = peakTime;
    obj.reductionPeakVolt = peakVolt;
end


end

