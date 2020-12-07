function amplitude = computeTransient(expInfo,current_obj)

% Calculate transient

transient.cycleNeeded = 1;
transient.FSCVvolt    = current_obj.FSCVvolt;
transient.timeMs      = current_obj.timeMs;

amplitude = zeros(1,current_obj.numOfPeakFound);

for i = 1: current_obj.numOfPeakFound
    transient.fstCycleInd = i;
    transient = findCycles(expInfo,transient,current_obj.dataPointDiff,current_obj.peakPos);
    if transient.usableCoordinates > 0 && (transient.usableCoordinates+expInfo.newNumOfPtPerCycle-1) < length(current_obj.newData)
        transient = sumAndAverage(expInfo,transient,current_obj.newData);
        transient.subtractedCurr = transient.avgCurr - current_obj.PBSinfo.avgCurr;
        transient = findPeakPos(transient,'oxidation');
        if transient.oxidationPeakCurr ~= Inf
            amplitude(i) = transient.oxidationPeakCurr;
        else
            fprintf('PBS or DA cycles chosen have a voltage problem!! (cycleAnalysis)\n\n')
        end
    else
        fprintf("Skip " + i + "th cycle for transcient plot. Reason: negative index or exceed data length!! (cycleAnalysis)\n\n")
    end
end

end

