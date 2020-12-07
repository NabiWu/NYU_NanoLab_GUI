function [expInfo] = findPeak(expInfo)

% findPeak.m function takes in a struct expInfo and finds peak positions in
% the data variables newData_V when two files are read; it
% finds peaks in variable newData_I when only one file is read.


fprintf("Interpolation and Find peaks...... (findPeak)\n\n")
expInfo.peakPos = [];

if expInfo.inputFileNum == 1
    peakNumLowerLim = (length(expInfo.newData_I) / ((expInfo.FSCVperiod*expInfo.samplingRateADC)/expInfo.interpolationFactor)) * 0.80;
    searchingStep = 0.1; % mV
    peakCurr = max(expInfo.newData_I) - searchingStep;
    while length(expInfo.peakPos) <= peakNumLowerLim && peakCurr > -2 % V
        [peakVal, expInfo.peakPos] = findpeaks(expInfo.newData_I, 'MinPeakHeight', peakCurr);
        peakCurr = peakCurr - searchingStep;
    end
    if peakCurr <= -2
        fprintf("Cannot find peaks!! Check input files and parameters. (findPeak)\n\n")
        return
    end
    avgPeakVal = mean(peakVal);
    expInfo.numOfPeakFound = length(expInfo.peakPos);
    fprintf(expInfo.numOfPeakFound + " peaks are found. (findPeak)\n\n")
    fprintf("Average peak value is " + avgPeakVal + "(V) (findPeak)\n\n")
else
    peakNumLowerLim = (length(expInfo.newData_V) / (2 * (expInfo.FSCVperiod*expInfo.samplingRateADC)/expInfo.interpolationFactor)) * 0.85;
    searchingStep = 5; % mV
    peakCurr = max(expInfo.newData_V) - searchingStep;
    prevLength = length(expInfo.peakPos);
    found = false;
    while ~found && peakCurr > expInfo.lowVolt
        [peakVal, expInfo.peakPos] = findpeaks(expInfo.newData_V, 'MinPeakHeight', peakCurr);
        if length(expInfo.peakPos) < (1.3 * prevLength) && length(expInfo.peakPos) > peakNumLowerLim
            found = true;
            expInfo.numOfPeakFound = length(expInfo.peakPos);
        else
            prevLength = length(expInfo.peakPos);
            peakCurr = peakCurr - searchingStep;
        end
    end
    if peakCurr <= expInfo.lowVolt
        fprintf("Cannot find peaks!! Check input files and parameters. (findPeak)\n\n")
        return
    end
    avgPeakVal = mean(peakVal);
    fprintf(expInfo.numOfPeakFound + " peaks are found. (findPeak)\n\n")
    fprintf("Average peak value is " + avgPeakVal + "(mV) (findPeak)\n\n")
end

% if expInfo.inputFileNum == 1
%     if avgPeakVal < 0.55 || avgPeakVal > 0.75
%         ques = input('Abnormal peak values,continue?? yes or no\n\n','s');
%         if strcmp(ques,'no')
%             return
%         end
%     end
% else
%     if avgPeakVal < (expInfo.highVolt*1000 - 11 * searchingStep) || avgPeakVal > (expInfo.highVolt*1000 + 11 * searchingStep)
%         ques = input('Abnormal peak values,continue?? yes or no\n\n','s');
%         if strcmp(ques,'no')
%             return
%         end
%     end
% end





% for i = 1 : expInfo.numOfPeakFound
%     rangee = expInfo.peakPos(i)-expInfo.newNumOfPtPerHalfCycle : expInfo.peakPos(i)+expInfo.newNumOfPtPerHalfCycle-1;
%     if expInfo.peakPos(i)-expInfo.newNumOfPtPerHalfCycle > 0
%           a=[130 131 132 133 134 550 551];
% %         a = [7 30 36 59 88 111 140 169 192 198 250 360 383 412 469 521
% %         578 572 613 617 669 721 727 750]; %1
% %         a=[192 383 572 750]; %1 large spike
% 
% %         a=[11 144 198 273 318 319 320 321 328 386 461 479 480 481 516 643 644 645 646 704 834 892 75 76 77 78 79 80]; %2 large
% % %         a=[540:580];
%         b = i - a;
%         if ~all(b)
%             % % %         if (expInfo.newData_V(expInfo.peakPos(i))>1300)
%             % % %             disp(i)
%             % % %         end
%             
% %             disp(i)
%             plot(expInfo.newData_V(rangee))
%             hold on
%             grid on
%         end
% %         if expInfo.newData_V(expInfo.peakPos(i)-expInfo.newNumOfPtPerHalfCycle) < -250 && expInfo.newData_V(expInfo.peakPos(i)-expInfo.newNumOfPtPerHalfCycle) > -350
% %             %         ind(length(ind)+1) = i;
% %             disp(i)
% %             plot(expInfo.newData_V(rangee))
% %             hold on
% %         end
% %         if expInfo.newData_V(expInfo.peakPos(i)+expInfo.newNumOfPtPerHalfCycle-1) < -250 && expInfo.newData_V(expInfo.peakPos(i)+expInfo.newNumOfPtPerHalfCycle-1) > -350
% %             %         ind(length(ind)+1) = i;
% %             disp(i)
% %             plot(expInfo.newData_V(rangee))
% %             hold on
% %         end
%         %     if i == 1
%         %         plot(expInfo.newData_I(rangee))
%         %         hold on
%         %     end
%         
%         %     plot(expInfo.newData_I(rangee))
%         %     hold on
%     end
% end

% cycle1 = 1;
% cycle2 = 14;
% plot(expInfo.newData_V(expInfo.peakPos(cycle1)-expInfo.newNumOfPtPerHalfCycle : expInfo.peakPos(cycle1)+expInfo.newNumOfPtPerHalfCycle-1))
% hold on
% plot(expInfo.newData_V(expInfo.peakPos(cycle2)-expInfo.newNumOfPtPerHalfCycle : expInfo.peakPos(cycle2)+expInfo.newNumOfPtPerHalfCycle-1))
% hold on



end

