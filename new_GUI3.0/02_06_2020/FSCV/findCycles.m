
function [analyteInfo] = findCycles(expInfo,analyteInfo)

% findCycles.m stores the starting index of the cycle(s) into an array.


next = 0;
numOfCycleCollected = 0;
analyteInfo.usableCoordinates = zeros(1,analyteInfo.cycleNeeded);
usedCycle = [];

while (numOfCycleCollected < analyteInfo.cycleNeeded) && ((analyteInfo.fstCycleInd + next) <= length(expInfo.peakPos))
    
    if expInfo.inputFileNum == 2
        currCycleStartingInd = expInfo.peakPos(analyteInfo.fstCycleInd + next) - expInfo.newNumOfPtPerHalfCycle;
        if currCycleStartingInd < 0
            fprintf("Negative currCycleStartingInd, choose another "+analyteInfo.type+" cycle. (findCycles)\n\n")
            return
        end
    else
        localRoughInd = expInfo.peakPos(fstCycleInd+next) - (expInfo.newNumOfPtPerHalfCycle);
        localDiff = expInfo.dataPointDiff(localRoughInd:(localRoughInd+(expInfo.newNumOfPtPerHalfCycle)));
        passCondition1 = find(localDiff > expInfo.error); % condition 1
        
        if isempty(passCondition1)
            plot(expInfo.newData_I(localRoughInd:(localRoughInd+(expInfo.newNumOfPtPerHalfCycle))))
            title('Local difference for cycle '+(analyteInfo.fstCycleInd+next))
            ylabel('Voltage (V)')
            xlabel('Local index')
            fprintf("Error with cycle '+(fstCycleInd+next)+'!! (findCycles)\n\n")
            return
        end
        
        localFineInd = passCondition1(1) - 1;
        currCycleStartingInd = localRoughInd + localFineInd;
        
        if (expInfo.newData_I(currCycleStartingInd + 1) - expInfo.newData_I(currCycleStartingInd)) < analyteInfo.condition2
            currCycleStartingInd = currCycleStartingInd + 1;
        end
    end
    
    numOfCycleCollected = numOfCycleCollected + 1;
    analyteInfo.usableCoordinates(numOfCycleCollected) = currCycleStartingInd;
    usedCycle(numOfCycleCollected) = analyteInfo.fstCycleInd + next;
    next = next + 1;
    
end

if ~strcmp(analyteInfo.type,'Transient')
    fprintf("These " + analyteInfo.type + " cycles are used: " + num2str(usedCycle) + " (findCycles)\n\n")
end

if (numOfCycleCollected < analyteInfo.cycleNeeded)
    fprintf("Cannot find enough " + analyteInfo.type + "cycles when starting cycle is " + analyteInfo.fstCycleInd + " (findCycles)\n\n");
    return
end

end


