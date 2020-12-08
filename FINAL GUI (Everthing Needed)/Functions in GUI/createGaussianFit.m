

function [fit] = createGaussianFit(subCurrNA,xAxis,subplotPos,peakType,unit,expInfo)


%   createGaussianFit.m creates a Gaussian fit for the curve given and make a
%   plot consisting of original curve, points chosen for the fitting, and the
%   final Gaussian fit


fitPointOnLeft  = round(10/expInfo.interpolationFactor);
fitPointOnRight = round(4/expInfo.interpolationFactor);

currLen = length(subCurrNA);

if strcmp(peakType, "Reduction")
    subCurrNA = -subCurrNA;
    peakCurr = -expInfo.reductionPeakCurr;
    peakInd = find(subCurrNA == peakCurr);
    leftRange = peakInd - fitPointOnLeft;
    rightRange = min(currLen,peakInd+fitPointOnRight);
else % oxidation
    peakCurr = expInfo.oxiBslnSubPeakCurr;
    peakInd = find(subCurrNA == peakCurr);
    leftRange = max(1,peakInd-fitPointOnLeft);
    rightRange = min(currLen,peakInd+fitPointOnRight);
end

% A section of data used to make the fit
selectedXRange  = xAxis(leftRange: rightRange);
selectedSubCurr = subCurrNA(leftRange: rightRange);

% DEFINE TOLERANCE AND ERROR
tol = 1e-14; % lower than 1e-14 may cause infinit loops in while loop
err = inf;   % initial error value

% MAKE AN INTELLIGENT INITIAL GUESS 
amplitude = peakCurr;
mean = xAxis(peakInd);
std = 0.5 * (max(selectedXRange) - min(selectedXRange));

%% MAIN ITERATION LOOP

while err > tol
    
    % Compute ColumnVector f
    fit = amplitude*exp(-((selectedXRange-mean)/std).^2);
    
    %Calculate Column Vector d
    d = selectedSubCurr - fit;
    
    % Construct Z Matrix 
    z1 = fit/amplitude;
    z2 = 2*fit.*(selectedXRange-mean)/std^2;
    z3 = 2*fit.*(selectedXRange-mean).^2/std^3;
    Z  = [z1 z2 z3];
    
    % Update Coefficients 
    da   = (Z.'*Z)\(Z.'*d);
    amplitude = amplitude + da(1);
    mean = mean +da(2);
    std  = std + da(3);
     
    % Calculate Error 
    err = max(abs(da./[amplitude; mean; std]));
    
end

% Compute Gaussian function
fit = amplitude * exp(-((xAxis-mean)/std).^2);


%% Plot Gaussian fit for oxidation and reduction peak in both time and voltage unit

try



% display the result of Gaussian fitting according to mean of the curve and
% its std.

leftVal = mean - 3*std;
leftInd = Inf;
foundLeft = false;
stopLeft = round(currLen);
indexLeft = 1;
while ~foundLeft && indexLeft < stopLeft
    if xAxis(indexLeft) < leftVal && xAxis(indexLeft+1) > leftVal
        foundLeft = true;
        if (leftVal - xAxis(indexLeft)) > (xAxis(indexLeft+1) - leftVal)
            leftInd = indexLeft + 1;
        else
            leftInd = indexLeft;
        end
    else
        indexLeft = indexLeft + 1;
    end
end

rightVal = mean + 3*std;
rightInd = Inf;
foundRight = false;
indexRight = round(currLen/2);
stopRight = currLen;
while ~foundRight && indexRight < stopRight
    if xAxis(indexRight) < rightVal && xAxis(indexRight+1) > rightVal
        foundRight = true;
        if (rightVal - xAxis(indexRight)) > (xAxis(indexRight+1) - rightVal)
            rightInd = indexRight + 1;
        else
            rightInd = indexRight;
        end
    else
        indexRight = indexRight + 1;
    end
end

% if indexRight == stopRight
%     rightInd = stopRight;
% end




subplot(2,2,subplotPos)
plot (selectedXRange, selectedSubCurr, "xr", "LineWidth",2); 
hold on;
set(gca,"FontSize",13)

% if strcmp(peakType, "Reduction")
%     leftDisplayRange = round(peakInd-12/expInfo.interpolationFactor);
%     rightDisplayRange = min(round(peakInd+12/expInfo.interpolationFactor),currLen);
%     plot (xAxis(leftDisplayRange: rightDisplayRange),fit(leftDisplayRange: rightDisplayRange),"b","LineWidth",1);
%     hold on;
%     plot(xAxis(leftDisplayRange: rightDisplayRange),subCurrNA(leftDisplayRange: rightDisplayRange),"k");
%     xMin = min(xAxis(leftDisplayRange),xAxis(rightDisplayRange));
%     xMax = max(xAxis(leftDisplayRange),xAxis(rightDisplayRange));
% else
    plot (xAxis(leftInd:rightInd),fit(leftInd:rightInd),"b","LineWidth",1);
    hold on;
    plot(xAxis(leftInd:rightInd),subCurrNA(leftInd:rightInd),"k");
    ylabel("Current($nA$)", "Interpreter", "LaTex", "Rotation", 0,"HorizontalAlignment", "right", "FontSize",19);
    xMin = xAxis(leftInd);
    xMax = xAxis(rightInd);
% end

hold off;
xlim([xMin xMax]);
ylim([min(fit)-1 max(fit)+1]);

if strcmp(unit, "voltage")
    xlabel("FSCV Voltage ($mV$)","Interpreter", "LaTex","FontSize",19);
elseif strcmp(unit, "time")
    xlabel("Time ($ms$)","Interpreter", "LaTex","FontSize",19);
end


legend("Range for curve fitting","Gaussian Fit","Original Data")
if strcmp(peakType, "Reduction") && strcmp(unit, "voltage") 
    [hleg, ~] = legend;
    set(hleg,'Location','NorthWest','NumColumns',1,'FontSize',7);
else
    [hleg, ~] = legend;
    set(hleg,'Location','best','NumColumns',1,'FontSize',7);
end

title ("Gaussian Fit For " + peakType + " Peak","FontSize",19);
grid on;

catch ME
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(warndlg(errorMessage));
%     fprintf("Cannot properly display the plot!! Error: "+exception.message+" (createGaussianFit)\n\n")
%     return
end

end




