function [current_obj] = sumAndAverage(expInfo,current_obj,data)


if length(current_obj.usableCoordinates) ~= current_obj.cycleNeeded
    fprintf("Inconsistence: "+current_obj.cycleNeeded+" cycles expected, only "+length(current_obj.usableCoordinates)+" is found. (sumAndAverage)\n\n")
    return
end

currSum = 0;

for i = 1: current_obj.cycleNeeded
    cycleRange = (current_obj.usableCoordinates(i) : (current_obj.usableCoordinates(i)+expInfo.newNumOfPtPerCycle-1));
    
    if cycleRange(1) <= 0
        fprintf("Negative index. (sumAndAverage)\n\n")
        return
    end

    if (current_obj.usableCoordinates(i)+expInfo.newNumOfPtPerCycle-1) > length(data)
        fprintf("Cycle index exceed data length!! (sumAndAverage)\n\n")
        return
    end
%     plot(data(cycleRange))
%     hold on
    currSum = currSum + data(cycleRange);

end

current_obj.avgCurr = (((currSum / current_obj.cycleNeeded) - expInfo.comV) * 1e9) / expInfo.fbR;
current_obj.avgVolt = expInfo.newData_V;


end

