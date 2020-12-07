function [analyteInfo] = sumAndAverage(expInfo,analyteInfo)

if length(analyteInfo.usableCoordinates) ~= analyteInfo.cycleNeeded
    fprintf("Inconsistence: "+analyteInfo.cycleNeeded+" cycles expected, only "+length(analyteInfo.usableCoordinates)+" is found. (sumAndAverage)\n\n")
    return
end

currSum = 0;
voltSum = 0;

for i = 1: 1: analyteInfo.cycleNeeded
    cycleRange = (analyteInfo.usableCoordinates(i) : (analyteInfo.usableCoordinates(i)+expInfo.newNumOfPtPerCycle-1));
    
    if cycleRange(1) <= 0
        fprintf("Negative index. (sumAndAverage)\n\n")
        return
    end
    if (analyteInfo.usableCoordinates(i)+expInfo.newNumOfPtPerCycle-1) > length(expInfo.newData_I)
        fprintf("Cycle index exceed data length!! (sumAndAverage)\n\n")
        return
    end
    
    currSum = currSum + expInfo.newData_I(cycleRange);
    
    if expInfo.inputFileNum == 2
        voltSum = voltSum + expInfo.newData_V(cycleRange);
    end

end

analyteInfo.avgCurr = (((currSum / analyteInfo.cycleNeeded) - expInfo.comV) * 1e9) / expInfo.fbR;

if expInfo.inputFileNum == 2
    analyteInfo.avgVolt = voltSum / analyteInfo.cycleNeeded;
else
    analyteInfo.avgVolt = expInfo.newData_V;
end

end

