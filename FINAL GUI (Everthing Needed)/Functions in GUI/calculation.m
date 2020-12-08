function [expInfo] = calculation(expInfo)

% DESCRIPTION:
%   calculation.m function calculates the peak position of oxidation and
%   reduction peak, and it computes area and FWHM of each peak after
%   performing Gaussian fitting. Peak current ratio and difference, area
%   ratio, and FWHM ratio are also computed.
%


%% Area and FWHM calculation

if ~expInfo.proceedCalculation
%     stillProceed = input('Detect non ideal cycle type chosen, still proceed? yes or no\n\n','s');
    stillProceed='no';
    if strcmp(stillProceed,'yes')
        stillProceed = true;
    elseif strcmp(stillProceed,'no')
        stillProceed = false;
    end
end


if expInfo.proceedCalculation || stillProceed
    
%     try
        %% Perform Gaussian fitting
        
        % Baseline subtraction
        fprintf("Perform baseline subtraction...... (calculation)\n\n")
        [oxiBslnCurr] = baselineSubtraction(expInfo);
%         oxiBslnSubcurr = expInfo.subtractedCurr(oxiBaselineIndLeft:oxiBaselineIndRight) - expInfo.subtractedCurr(oxiBaselineIndLeft);
%         oxiBslnSubTime = expInfo.timeMs(oxiBaselineIndLeft: oxiBaselineIndRight);
%         oxiBslnSubVolt = expInfo.FSCVvolt(oxiBaselineIndLeft: oxiBaselineIndRight);
        
        % Open a figure window for plots. Plots for Gaussian fitting are done in file "createGaussianFit"
        figureName = expInfo.concentration+"uM "+expInfo.neurotransmitter+"; Sensor ID: "+expInfo.sensorId+"; "+expInfo.rampRate+"V/s; "+expInfo.lowVolt+" to "+expInfo.highVolt+" V";
        figure("Color", "w", "Position", [132 101 1188 661],"Name",figureName);
        oxiTimePlotPos = 1;
        oxiVoltPlotPos = 3;
        redTimePlotPos = 2;
        redVoltPlotPos = 4;
        
        len = length(expInfo.subtractedCurr);
        expInfo.oxiBslnSubPeakCurr = expInfo.oxidationPeakCurr - oxiBslnCurr;
        oxiBslnSubCurr = expInfo.subtractedCurr - oxiBslnCurr;
        
        % Oxidation Gaussian Fitting
        fprintf("Perform Oxidation Gaussian Fitting...... (calculation)\n\n")
        [oxidationTimeFit] = createGaussianFit(oxiBslnSubCurr(1:len/2),expInfo.timeMs(1:len/2),oxiTimePlotPos,"Oxidation","time",expInfo);
        [oxidationVoltFit] = createGaussianFit(oxiBslnSubCurr(1:len/2),expInfo.FSCVvolt(1:len/2),oxiVoltPlotPos,"Oxidation","voltage",expInfo);
        
        % Reduction Gaussian Fitting
        fprintf("Perform Reduction Gaussian Fitting...... (calculation)\n\n")
        [reductionTimeFit] = createGaussianFit(expInfo.subtractedCurr(len/2:len),expInfo.timeMs(len/2:len),redTimePlotPos,"Reduction","time",expInfo);
        [reductionVoltFit] = createGaussianFit(expInfo.subtractedCurr(len/2:len),expInfo.FSCVvolt(len/2:len),redVoltPlotPos,"Reduction","voltage",expInfo);
        
        %% Calculate area and FWHM
        
        fprintf("Calculate area and FWHM...... (calculation)\n\n")
        
        % Area
        oxidationTimeArea = trapz(expInfo.timeMs(1:len/2), oxidationTimeFit);
        oxidationVoltArea = trapz(expInfo.FSCVvolt(1:len/2),oxidationVoltFit);
        reductionTimeArea = trapz(expInfo.timeMs(round(len/2):len),reductionTimeFit);
        reductionVoltArea = abs(trapz(expInfo.FSCVvolt(round(len/2):len),reductionVoltFit));
        
        % Area ratio
        oxidationReductionTimeAreaRatio = oxidationTimeArea / reductionTimeArea;
        oxidationReductionVoltAreaRatio = oxidationVoltArea / reductionVoltArea;
        
        % FWHM
        [oxidationTimeFWHM] = fwhm(expInfo.timeMs(1:round(len/2)), oxidationTimeFit);
        [oxidationVoltFWHM] = fwhm(expInfo.FSCVvolt(1:round(len/2)), oxidationVoltFit);
        
        [reductionTimeFWHM] = fwhm(expInfo.timeMs(round(len/2): len), reductionTimeFit);
        [reductionVoltFWHM] = fwhm(expInfo.FSCVvolt(round(len/2): len), reductionVoltFit);
        
        % FWHM ratio
        oxidationReductionTimeFWHMRatio = oxidationTimeFWHM / reductionTimeFWHM;
        oxidationReductionVoltFWHMRatio = oxidationVoltFWHM / reductionVoltFWHM;
        
        
        %% Print results
        
        fprintf("Print results...... (calculation)\n\n")
        
        % define message inputs
        info = "              "+expInfo.concentration+"uM "+expInfo.neurotransmitter+"; Sensor ID: "+expInfo.sensorId+"; "+expInfo.rampRate+"V/s; "+expInfo.lowVolt+" to "+expInfo.highVolt+" V";
        
        catagory = "             Position(ms;mV)   FWHM(ms;mV)    I_peak(nA)     Area(ms;mV)";
        
        oxidationPeak = "O_peak   " + round(expInfo.oxidationPeakTime,3) + ";" + round(expInfo.oxidationPeakVolt,3) +...
            "     " + round(oxidationTimeFWHM,3) + ";" + round(oxidationVoltFWHM,3) +...
            "         " + round(expInfo.oxidationPeakCurr,3) + "    " + round(oxidationTimeArea,3) + ";" +...
            round(oxidationVoltArea,3);
        
        reductionPeak = "R_peak   " + round(expInfo.reductionPeakTime,3) + ";" + round(expInfo.reductionPeakVolt,3) +...
            "        " + round(reductionTimeFWHM,3) + ";" + round(reductionVoltFWHM,3) + "       " +...
            round(expInfo.reductionPeakCurr,3) + "  " + round(reductionTimeArea,3) + ";" + round(reductionVoltArea,3);
        
        oxidationReductionRatio = "O/R ratio  -----N/A-----       " + oxidationReductionTimeFWHMRatio +...
            ";" + oxidationReductionVoltFWHMRatio + "       " + expInfo.oxidationReductionIRatio +...
            "  " + round(oxidationReductionTimeAreaRatio,3) + ";" + round(oxidationReductionVoltAreaRatio,3);
        
        oxidationReductionDiff = "O - R     "+round(expInfo.oxidationReductionTimeDiff,3)+";" +round(expInfo.oxidationReductionVoltDiff,3)+"   ---------------------N/A---------------------";
        
        % open message box
        message = [info;" ";" ";catagory;" ";oxidationPeak;" ";reductionPeak;" ";oxidationReductionRatio;" ";oxidationReductionDiff];
        msgbox(message,'Calculation Results');
        
        fprintf("Task completed!\n\n")
        
%     catch ME
%         errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
%             ME.stack(1).name, ME.stack(1).line, ME.message);
%         fprintf(1, '%s\n', errorMessage);
%         uiwait(warndlg(errorMessage));
%         fprintf("Calculation can not be completed!! (calculation)\n\n")
%         fprintf("Error message: "+exception.message+" (calculation)\n\n")
%         return
%         
%     end
    
else
    fprintf('Task done successfully! (calculation)\n\n')
    fprintf('Calculation will be not done with same type of cycles. (calculation)\n\n')
end




