
function [expInfo,PBSinfo,DAinfo] = cycleAnalysis(expInfo,PBSinfo,DAinfo)

% DESCRIPTION:
%
%   cycleAnalysis.m finds PBS and DA cycles according to the beginning cycle
%   number chosen by user. It then calculates subtracted current and make a
%   number of plots to display results. Transient plot is calculated and
%   the type of cycles are determined.


% ALL THE FIELDS IN STRUCT expInfo:
%
%   dataFolderPath
%   fileName_I
%   fileName_V
%   concentration
%   neurotransmitter
%   sensorId
%   rampRate
%   lowVolt
%   highVolt
%   interpolationFactor
%   OSR
%   clockRate
%   comV
%   fbR
%   FSCVfrqncy
%   error
%   FSCVperiod
%   duration
%   durationMs
%   samplingRateADC
%   dataPts
%   newNumOfPtPerCycle
%   newNumOfPtPerHalfCycle
%   inputFileNum
%   data_I
%   data_V
%   newData_I
%   newData_V
%   dataPointDiff
%   peakPos
%   numOfPeakFound
%   subtractedCurr
%   FSCVvolt
%   timeMs
%   proceedCalculation
%   timeRow
%   timeCol
%   subCurrRow
%   subCurrCol
%   voltRow
%   voltCol
%   oxidationPeakCurr
%   oxidationPeakTime
%   oxidationPeakVolt
%   reductionPeakCurr
%   reductionPeakTime
%   reductionPeakVolt
%   oxidationReductionIRatio
%   oxidationReductionTimeDiff
%   oxidationReductionVoltDiff
% 
% 
% 
% ALL THE FIELDS IN STRUCT PBSinfo and DAinfo
% 
%   fstCycleInd
%   cycleNeeded
%   condition2
%   type
%   usableCoordinates
%   avgCurr
%   avgVolt



%% DEPENDENT PARAMETERS

expInfo.FSCVperiod             = 1 / expInfo.FSCVfrqncy;                                      % s
expInfo.duration               = 2 * ((expInfo.highVolt-expInfo.lowVolt)/expInfo.rampRate);   % s/cycle; expInfo.duration of one cycle
expInfo.durationMs             = expInfo.duration * 1000;                                     % ms/cycle
expInfo.samplingRateADC        = (expInfo.clockRate * 1.024e6) / expInfo.OSR;                 % points/second
expInfo.dataPts                = round(expInfo.duration * expInfo.samplingRateADC);           % points/cycle
expInfo.newNumOfPtPerCycle     = expInfo.dataPts / expInfo.interpolationFactor;               % number of point/cycle after interpolation
expInfo.newNumOfPtPerHalfCycle = expInfo.newNumOfPtPerCycle / 2;

%% Check Input Parameters

[expInfo] = checkParameter(expInfo,PBSinfo,DAinfo);

%% READ DATA

[expInfo] = readTXT(expInfo);

%% Find peaks

if expInfo.inputFileNum == 1
    expInfo.dataPointDiff = diff(expInfo.newData_I);
else
    expInfo.dataPointDiff = [];
end
       

[expInfo] = findPeak(expInfo);

if expInfo.numOfPeakFound < 100
    fprintf('Only '+expInfo.numOfPeakFound+' peaks is found!! (cycleAnalysis)\n\n')
end

if PBSinfo.fstCycleInd + PBSinfo.cycleNeeded - 1 > expInfo.numOfPeakFound || DAinfo.fstCycleInd + DAinfo.cycleNeeded - 1 > expInfo.numOfPeakFound
    fprintf('Please choose an appropriate PBS or DA cycle!! (cycleAnalysis)\n\n')
end



%% FIND PBS AND DA transient.cycles

fprintf('FIND PBS AND DA transient.cycles...... (cycleAnalysis)\n\n')

[PBSinfo] = findCycles(expInfo,PBSinfo);
[DAinfo] = findCycles(expInfo,DAinfo);


%% SUM AND AVERAGE

fprintf('SUM AND AVERAGE...... (cycleAnalysis)\n\n')

[PBSinfo] = sumAndAverage(expInfo,PBSinfo);

[DAinfo]  = sumAndAverage(expInfo,DAinfo);


%% OUTPUT AND PLOT

fprintf('OUTPUT AND PLOT...... (cycleAnalysis)\n\n')

% SUBTRACTED CURRENT
% expInfo.subtractedCurr = smooth(DAinfo.avgCurr - PBSinfo.avgCurr);
expInfo.subtractedCurr = (DAinfo.avgCurr - PBSinfo.avgCurr);

% VOLTAGE ARRAY
expInfo.FSCVvolt = ((PBSinfo.cycleNeeded*PBSinfo.avgVolt)+(DAinfo.cycleNeeded*DAinfo.avgVolt))/(PBSinfo.cycleNeeded+DAinfo.cycleNeeded);

% TIME ARRAY
expInfo.timeMs = (0:(expInfo.durationMs/expInfo.newNumOfPtPerCycle):(expInfo.durationMs-(expInfo.durationMs/expInfo.newNumOfPtPerCycle)));



%% Calculate transient and plot

% can be moved to somewhere else for now they are here 
transient.cycleNeeded = 1;
transient.type        = 'Transient';
transient.condition2  = 0.006;
transient.FSCVvolt    = expInfo.FSCVvolt;
transient.timeMs      = expInfo.timeMs;
transient.fstCycleInd = Inf;


% Calculate transient
amplitude   = zeros(1,expInfo.numOfPeakFound);
for i = 1: expInfo.numOfPeakFound
    transient.fstCycleInd = i;
    [transient] = findCycles(expInfo,transient);
    if transient.usableCoordinates > 0 && (transient.usableCoordinates+expInfo.newNumOfPtPerCycle-1) < length(expInfo.newData_I)
        [transient] = sumAndAverage(expInfo,transient);
        transient.subtractedCurr = transient.avgCurr - PBSinfo.avgCurr;
        [oxidationPeakCurr,~, ~] = findPeakPos(transient,'oxidation');
        if oxidationPeakCurr ~= Inf
            amplitude(i) = oxidationPeakCurr;
        else
            fprintf('PBS or DA cycles chosen have a voltage problem!! (cycleAnalysis)\n\n')
        end
    else
        fprintf('Skip ' + i + 'th cycle for transcient plot. Reason: negative index or exceed data length!! (cycleAnalysis)\n\n')
    end
end





% copy used to identify DA transient.cycles by using max() and avoid spikes
smoothAmplitude  = amplitude;
for i = 1:10
    smoothAmplitude = smooth(smoothAmplitude);
end


leftRightSize = 6; % set average calculation coverage size

avgDiffThredhold = 2.7; % diff thredhold

deriv1 = [amplitude(1) diff(amplitude)]; % first derivative
derivCondThredhold = 2.7;

PBSrange = 1.5; % A range around 0 for cycles to be considered as PBS

% preallocation
transient.cycles(expInfo.numOfPeakFound).type = '';
transient.cycles(expInfo.numOfPeakFound).oxiPeakVal = amplitude(expInfo.numOfPeakFound);
transient.cycles(expInfo.numOfPeakFound).smoothPeakVal = smoothAmplitude(expInfo.numOfPeakFound);

transient.spikeNum = 0;
transient.spikePos = 0;

% determine the type of cycle using avg and diff
for i = 1: expInfo.numOfPeakFound
    
    % calculate average
    sum = 0;
    counter = 0;
    for j = 1: leftRightSize
        if i - j >= 1
            sum = sum + amplitude(i - j);
            counter = counter + 1;
        end
        if i + j <= expInfo.numOfPeakFound
            sum = sum + amplitude(i + j);
            counter = counter + 1;
        end
    end
    avg = sum / counter;
    
    transient.cycles(i).oxiPeakVal = amplitude(i);
    transient.cycles(i).smoothPeakVal = smoothAmplitude(i);
    
    % record the type of cycle
    if isempty(transient.cycles(i).type)
        if abs(deriv1(i)) > derivCondThredhold
            if abs(transient.cycles(i).oxiPeakVal) < PBSrange
                transient.cycles(i).type = 'PBS';
            else
                transient.cycles(i).type = 'transitionOrDA';
            end
            diffBeforeSpike = abs(deriv1(i));
            signDiffBeforeSpike = sign(deriv1(i));
            next = 1;
            stop = false;
            while ~stop && (i+next) <= expInfo.numOfPeakFound
                currDiff = abs(deriv1(i+next));
                signCurrDiff = sign(deriv1(i+next));
                absValCondition = abs(currDiff - diffBeforeSpike) < (0.15 * diffBeforeSpike); % 0.15 = 15% in difference for diff before spike and end of spike
                signCondition = (signCurrDiff ~= signDiffBeforeSpike);
                if abs(amplitude(i+next) - avg) > avgDiffThredhold
                    transient.cycles(i+next).type = 'Spike';
                    transient.spikeNum = transient.spikeNum + 1;
                    transient.spikePos(transient.spikeNum) = i + next;
                end
                if absValCondition && signCondition
                    stop = true;
                else
                    next = next + 1;
                end
            end
        end
        if abs(transient.cycles(i).oxiPeakVal) < PBSrange
            transient.cycles(i).type = 'PBS';
        else
            transient.cycles(i).type = 'transitionOrDA';
        end
    end
end



% % define the type of last cycle
% ind = expInfo.numOfPeakFound - 1;
% while strcmp(transient.cycles(ind).type,'Spike')
%     ind = ind - 1;
% end
% if abs(amplitude(ind) - amplitude(expInfo.numOfPeakFound)) < 1.5
%     transient.cycles(expInfo.numOfPeakFound).type = transient.cycles(ind).type;
% else
%     transient.cycles(expInfo.numOfPeakFound).type = 'Spike';
% end


% find max that is not a spike
temp = smoothAmplitude;
found = false;
% count = llength(temp);
while ~found
%     if 
    [maxVal,maxInd] = max(temp);
    if ~strcmp(transient.cycles(maxInd).type,'Spike')
        found = true;
    else
        temp(maxInd) = 0;
    end
end

% differentiate DA from transition
for i = 1: expInfo.numOfPeakFound
    if strcmp(transient.cycles(i).type,'transitionOrDA')
        if abs(transient.cycles(i).oxiPeakVal - maxVal) < 1.5
            transient.cycles(i).type = 'DA';
        else
            transient.cycles(i).type = 'Transition';
        end
    end
end
    
% % check if there's any empty type and print spikes
% for i = 1:expInfo.numOfPeakFound
%     if isempty(transient.cycles(i).type)
%         disp('empty')
%         disp(i)
%     end
%     if strcmp(transient.cycles(i).type,'Spike')
%         disp('spike')
%         disp(i)
%     end
% end
% 
% for i = 1:expInfo.numOfPeakFound
%     disp(i)
%     disp(transient.cycles(i).type)
% end


transient.spikeCoordinate = zeros(1,transient.spikeNum);
for i = 1: transient.spikeNum
    transient.fstCycleInd = transient.spikePos(i);
    [transient] = findCycles(expInfo,transient);
    transient.spikeCoordinate(i) = transient.usableCoordinates;
end




% figure('Color', 'w', 'Position', [132 101 1188 661]); % A figure to present all spike with PBS cycle
% 
% 
% lg = cell(PBSinfo.cycleNeeded,1);
% for i = 1: PBSinfo.cycleNeeded
%     lg{i} = 'PBS';
% end
% 
% lg2 = cell(transient.spikeNum,1);
% for i = 1: transient.spikeNum
%     lg2{i} = 'Spike';
% end
% 
% plotCycle(expInfo,PBSinfo,true,'','','','')
% plotCycle(expInfo,transient,false,'Spikes and normal PBS transient.cycles','Sample point','Current ($nA$)',[lg;lg2])



% Decide if it should proceed to do calculation by looking at the type of
% the cycles chosen
expInfo.proceedCalculation = true;

for i = 1: PBSinfo.cycleNeeded
    if ~strcmp(transient.cycles(PBSinfo.fstCycleInd+i-1).type,'PBS')
        expInfo.proceedCalculation = false;
        break
    end
end

for i = 1: DAinfo.cycleNeeded
    if ~strcmp(transient.cycles(DAinfo.fstCycleInd+i-1).type,'DA')
        expInfo.proceedCalculation = false;
        break
    end
end



%% Plot 


figure('Color', 'w', 'Position', [132 101 1188 661]);

subplot(2,3,1)
plot(expInfo.newData_I)
xlabel('Sample points','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
title('Delta ibg','FontSize',19,'FontWeight','bold')
grid on

subplot(2,3,2)
plot(expInfo.newData_V,'o-')
xlabel('Sample points','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
grid on
if expInfo.inputFileNum == 1
    title('Constant voltage','FontSize',19,'FontWeight','bold')
else
    title('FSCV Voltage','FontSize',19,'FontWeight','bold')
end


subplot(2,3,4)
plot(amplitude)
xlabel('Time','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Oxidation Peak Current ($nA$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
title('Transient Plot','FontSize',19,'FontWeight','bold')
grid minor



subplot(2,3,5)
plot(expInfo.FSCVvolt,PBSinfo.avgCurr,'b','LineWidth',2)
hold on
plot(expInfo.FSCVvolt,DAinfo.avgCurr,'r','LineWidth',2)
xlabel('FSCV Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current ($nA$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylim([floor(min(PBSinfo.avgCurr)/100)*100 max(PBSinfo.avgCurr)+60])
plotTitle = 'PBS and DA transient.cycles';
title(plotTitle,'FontSize',19,'FontWeight','bold')
[hleg, ~] = legend;
set(hleg,'Location','Best','NumColumns',2,'FontSize',8);
blueCurve = 'PBS';
redCurve = 'Dopamine';
legend(blueCurve,redCurve)
grid minor
ax = gca;
ax.GridAlpha=1;




%% Check dimension

[expInfo] = checkDimension(expInfo);

%% Compute peak position

fprintf('Compute peak positions...... (cycleAnalysis)\n\n')

% Position results
findPeakPos(expInfo,'oxidation');
findPeakPos(expInfo,'reduction');

[oxidationPeakCurr,oxidationPeakTime, oxidationPeakVolt] = findPeakPos(expInfo,'oxidation');
expInfo.oxidationPeakCurr = oxidationPeakCurr;
expInfo.oxidationPeakTime = oxidationPeakTime;
expInfo.oxidationPeakVolt = oxidationPeakVolt;

[reductionPeakCurr,reductionPeakTime, reductionPeakVolt] = findPeakPos(expInfo,'reduction');
expInfo.reductionPeakCurr = reductionPeakCurr;
expInfo.reductionPeakTime = reductionPeakTime;
expInfo.reductionPeakVolt = reductionPeakVolt;

% Peak current ratio and difference
expInfo.oxidationReductionIRatio    = abs(expInfo.oxidationPeakCurr / expInfo.reductionPeakCurr);
expInfo.oxidationReductionTimeDiff  = expInfo.oxidationPeakTime - expInfo.reductionPeakTime;
expInfo.oxidationReductionVoltDiff  = expInfo.oxidationPeakVolt - expInfo.reductionPeakVolt;


% Finish plotting everthing besides area and FWHM
subCurrPlotTitle = strcat(expInfo.sensorId,' ',expInfo.concentration,'uM ',num2str(expInfo.rampRate),'V/s ',expInfo.lowVolt,'V to ',expInfo.highVolt,'V');

%     Plot current vs. time
subplot(2,3,3)
plot(expInfo.timeMs,expInfo.subtractedCurr,'r','LineWidth',2)
set(gca,'FontSize',13)
yticks(round(linspace(min(expInfo.subtractedCurr)-5,max(expInfo.subtractedCurr)+5,10)))
xlabel('Time ($ms$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current($nA$)', 'Interpreter', 'LaTex','FontSize',19);
ylim([min(expInfo.subtractedCurr)-2 max(expInfo.subtractedCurr)+2])
xlim([min(expInfo.timeMs) max(expInfo.timeMs)]);
title(subCurrPlotTitle,'FontSize',19,'FontWeight','bold')
legend('Dopamine')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',1,'FontSize',9);
set(hleg,'Location','Best','FontSize',9);
grid on
hold on

plot(expInfo.oxidationPeakTime,expInfo.oxidationPeakCurr, 'k*-', 'DisplayName', sprintf('oxi_peak'));
hold on
plot(expInfo.reductionPeakTime,expInfo.reductionPeakCurr, 'k*-', 'DisplayName', sprintf('red_peak'));

%     Plot current vs. voltage
subplot(2,3,6)
plot(expInfo.FSCVvolt, expInfo.subtractedCurr,'r','LineWidth',2)
yticks(round(linspace(min(expInfo.subtractedCurr)-5,max(expInfo.subtractedCurr)+5,10)))
set(gca,'FontSize',13)
xlabel('FSCV Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current($nA$)', 'Interpreter', 'LaTex','FontSize',19);
ylim([min(expInfo.subtractedCurr)-2 max(expInfo.subtractedCurr)+2])
xlim([expInfo.lowVolt*1000 expInfo.highVolt*1000]);
title(subCurrPlotTitle,'FontSize',19,'FontWeight','bold')
legend('Dopamine')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',1,'FontSize',9);
set(hleg,'Location','Best','FontSize',9);
grid on
hold on
plot(expInfo.oxidationPeakVolt, expInfo.oxidationPeakCurr, 'k*-', 'DisplayName', sprintf('oxi_peak'));
hold on
plot(expInfo.reductionPeakVolt, expInfo.reductionPeakCurr, 'k*-', 'DisplayName', sprintf('red_peak'));





end

