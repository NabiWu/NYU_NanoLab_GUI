
function [current_obj] = findCycles(expInfo,current_obj,dataPointDiff,peakPos)

% findCycles.m stores the starting index of the cycle(s) into an array.


next = 0;
numOfCycleCollected = 0;
current_obj.usableCoordinates = zeros(1,current_obj.cycleNeeded);
usedCycle = [];

while (numOfCycleCollected < current_obj.cycleNeeded) && ((current_obj.fstCycleInd + next) <= length(peakPos))
    
    localRoughInd = peakPos(current_obj.fstCycleInd+next) - (expInfo.newNumOfPtPerCycle);
    try
        localDiff = dataPointDiff(localRoughInd:(localRoughInd+(expInfo.newNumOfPtPerCycle)));
    catch 
        next = next + 1;
        continue
    end
        passCondition1 = find(localDiff > (expInfo.comV+expInfo.error)); % condition 1
    if isempty(passCondition1)
        plot(current_obj.newData(localRoughInd:(localRoughInd+(expInfo.newNumOfPtPerCycle))))
        title('Local difference for cycle '+(current_obj.fstCycleInd+next))
        ylabel('Voltage (V)')
        xlabel('Local index')
        fprintf('Error with cycle '+(current_obj.fstCycleInd+next)+', zero element in the list! (findCycles)\n\n')
        return
    end
    
    localFineInd = passCondition1(1) - 1;
    currCycleStartingInd = localRoughInd + localFineInd;
    
    numOfCycleCollected = numOfCycleCollected + 1;
    current_obj.usableCoordinates(numOfCycleCollected) = currCycleStartingInd;
    usedCycle(numOfCycleCollected) = current_obj.fstCycleInd + next;
    next = next + 1;
    
end

if current_obj.cycleNeeded ~= 1
    fprintf("These cycles are used: " + num2str(usedCycle) + " (findCycles)\n\n")
end

if (numOfCycleCollected < current_obj.cycleNeeded)
    fprintf("Cannot find enough " + current_obj.type + "cycles when starting cycle is " + current_obj.fstCycleInd + " (findCycles)\n\n");
    return
end

end


