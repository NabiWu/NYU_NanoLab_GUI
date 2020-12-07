
function [baselineCurr] = baselineSubtraction(expInfo)

% baselineSubtraction.m computes baseline and subtract it to obtain more accurate area results

deriv2y = smooth(diff(diff(expInfo.subtractedCurr)));

currentLength = length(expInfo.subtractedCurr);
[oxidationPeakCurr,~, ~] = findPeakPos(expInfo,'oxidation');
stopInd = 0;
errorSection = (1:currentLength/2);

maxInd = find(expInfo.subtractedCurr == oxidationPeakCurr); % start to search for baselineInd at peak index
baselineInd = maxInd;

% Find the second zero crossing (baseline location) for second derivative
counter = 0;
while counter < 2 && baselineInd > stopInd
    if sign(deriv2y(baselineInd)) ~= sign(deriv2y(baselineInd-1))
        counter = counter + 1;
    end
    baselineInd = baselineInd - 1;
end

% % Find the left and right indexes
if counter == 2 % found baseline
    
    baselineCurr = expInfo.subtractedCurr(baselineInd);
%     baselineLeftPos = maxInd;
%     baselineRightPos = maxInd;
%     while sign(baselineCurr(baselineLeftPos-1)) == sign(baselineCurr(baselineLeftPos))
%         baselineLeftPos = baselineLeftPos - 1;
%     end
%     
%     bslnRtPosStopInd = maxInd + (maxInd-baselineLeftPos);
%     while baselineRightPos < (bslnRtPosStopInd - 1)
%         if (sign(baselineCurr(baselineRightPos)) == sign(baselineCurr(baselineRightPos+1)))
%             baselineRightPos = baselineRightPos + 1;
%         else
%             break
%         end
%     end
    
elseif counter == 1 % no baseline
    baselineCurr = 0;
%     % Use default range for fitting Gaussian later
%     defaultRangeBeforePeak = 10/expInfo.interpolationFactor;
%     defaultRangeAfterPeak = 4/expInfo.interpolationFactor;
%     baselineLeftPos = max(1,maxInd - defaultRangeBeforePeak);
%     baselineRightPos = maxInd + defaultRangeAfterPeak;
    
else
    fprintf('No inflection point found for oxidation peak. Unknown error (baselineSubtraction)\n\n')
    plot(expInfo.FSCVvolt(errorSection),expInfo.subtractedCurr(errorSection),'b')
    title('oxidation peak -- no inflection point.')
    xlabel('FSCV Voltage ($mV$)',"Interpreter", "LaTex",'FontSize',19,'FontWeight','bold')
    ylabel('Current ($nA$)',"Interpreter", "LaTex",'FontSize',19,'FontWeight','bold')
    legend('Problem section')
end


end

