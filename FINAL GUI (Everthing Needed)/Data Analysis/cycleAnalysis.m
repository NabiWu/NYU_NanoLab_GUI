
function [expInfo,current_arr] = cycleAnalysis(expInfo,current_arr)

% DESCRIPTION:
%
%   cycleAnalysis.m finds PBS and DA cycles according to the beginning cycle
%   number chosen by user. It then calculates subtracted current and make a
%   number of plots to display results. Transient plot is calculated and
%   the type of cycles are determined.


% positiveNum = @(v) isnumeric(v) && v > 0;
% btw1n0      = @(y) y > 0 && y <= 1;
% isflint     = @(m) (abs(m) <= flintmax && m == floor(m) && m > 0); % if input is an integer

expInfo.FSCVperiod             = 1 / expInfo.FSCVfrqncy;                                      % s
expInfo.duration               = 2 * ((expInfo.highVolt-expInfo.lowVolt)/expInfo.rampRate);   % s/cycle; expInfo.duration of one cycle
expInfo.durationMs             = expInfo.duration * 1000;                                     % ms/cycle
expInfo.samplingRateADC        = (expInfo.clockRate * 1.024e6) / expInfo.OSR;                 % points/second
expInfo.dataPts                = round(expInfo.duration * expInfo.samplingRateADC);           % points/cycle
expInfo.newNumOfPtPerCycle     = expInfo.dataPts / expInfo.interpolationFactor;               % number of point/cycle after interpolation

%% READ DATA

for i = 1 : length(current_arr)
    [expInfo,current_arr{i}] = readTXT(expInfo,current_arr{i});
end

%% Find peaks

for i = 1 : length(current_arr)
    current_arr{i} = findPeak(expInfo,current_arr{i});
end

%% Find PBS and DA cycles

fprintf('Find PBS and DA cycles...... (cycleAnalysis)\n\n')

for i = 1 : length(current_arr)
    current_arr{i}.dataPointDiff = diff(current_arr{i}.newData);
    current_arr{i}.PBSinfo = findCycles(expInfo,current_arr{i}.PBSinfo,current_arr{i}.dataPointDiff,current_arr{i}.peakPos);
    current_arr{i}.DAinfo = findCycles(expInfo,current_arr{i}.DAinfo,current_arr{i}.dataPointDiff,current_arr{i}.peakPos);
end

%% Sum and average

fprintf('SUM & AVERAGE...... (cycleAnalysis)\n\n')

for i = 1 : length(current_arr)
    current_arr{i}.PBSinfo = sumAndAverage(expInfo,current_arr{i}.PBSinfo,current_arr{i}.newData);
    current_arr{i}.DAinfo  = sumAndAverage(expInfo,current_arr{i}.DAinfo,current_arr{i}.newData);
end


%% Current, Voltage, Time

fprintf('Compute current, Voltage, and Time...... (cycleAnalysis)\n\n')

for i = 1 : length(current_arr)
    current_arr{i}.subtractedCurr = (current_arr{i}.DAinfo.avgCurr - current_arr{i}.PBSinfo.avgCurr); % SUBTRACTED CURRENT
    current_arr{i}.FSCVvolt = expInfo.newData_V; % VOLTAGE ARRAY
    current_arr{i}.timeMs = (0:(expInfo.durationMs/expInfo.newNumOfPtPerCycle):(expInfo.durationMs-(expInfo.durationMs/expInfo.newNumOfPtPerCycle))); % TIME ARRAY
end


%% Calculate transient and plot

fprintf('Compute transient...... (cycleAnalysis)\n\n')

for i = 1 : length(current_arr)
    current_arr{i}.transient = computeTransient(expInfo,current_arr{i});
end


%% Plot -- channel 1 & 2

% transient
figure('Color', 'w', 'Position', [132 101 1188 661]);

for i = 1 : length(current_arr)
    subplot(2,2,i)
    plot(current_arr{i}.transient)
    xlabel('Samples','FontSize',16,'FontWeight','bold')
    ylabel('Current','FontSize',16,'FontWeight','bold')
    title(['Transient -- channel ' num2str(i)],'FontSize',16,'FontWeight','bold')
    grid on
end


% Plot current, voltage, and time

figure('Color', 'w', 'Position', [132 101 1188 661]);

axes( 'Position', [0, 0.95, 1, 0.05] ); % these lines add a super title above the subplots
set( gca, 'Color', 'None', 'XColor', 'White', 'YColor', 'White' ) ;
text( 0.5, .25, 'Channel 1(top) & 2(bottom)', 'FontSize', 16', 'FontWeight', 'Bold', ...
    'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Bottom' ) ;


subplot(2,3,1)
plot(current_arr{1}.FSCVvolt,current_arr{1}.PBSinfo.avgCurr,'b','LineWidth',2)
hold on
plot(current_arr{1}.FSCVvolt,current_arr{1}.DAinfo.avgCurr,'r','LineWidth',2)
xlabel('FSCV Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current ($nA$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylim([floor(min(current_arr{1}.DAinfo.avgCurr)/100)*100 max(current_arr{1}.DAinfo.avgCurr)+60])
plotTitle = 'PBS and DA cycles';
title(plotTitle,'FontSize',16,'FontWeight','bold')
[hleg, ~] = legend;
set(hleg,'Location','Best','NumColumns',2,'FontSize',8);
blueCurve = 'PBS';
redCurve = 'Dopamine';
legend(blueCurve,redCurve)
grid minor
ax = gca;
ax.GridAlpha=1;

subplot(2,3,4)
plot(current_arr{2}.FSCVvolt,current_arr{2}.PBSinfo.avgCurr,'b','LineWidth',2)
hold on
plot(current_arr{2}.FSCVvolt,current_arr{2}.DAinfo.avgCurr,'r','LineWidth',2)
xlabel('FSCV Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current ($nA$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylim([floor(min(current_arr{2}.DAinfo.avgCurr)/100)*100 max(current_arr{2}.DAinfo.avgCurr)+60])
plotTitle = 'PBS and DA cycles';
title(plotTitle,'FontSize',19,'FontWeight','bold')
[hleg, ~] = legend;
set(hleg,'Location','Best','NumColumns',2,'FontSize',8);
blueCurve = 'PBS';
redCurve = 'Dopamine';
legend(blueCurve,redCurve)
grid minor
ax = gca;
ax.GridAlpha=1;




fprintf('Compute peak positions...... (cycleAnalysis)\n\n') % Compute peak position

for i = 1 : length(current_arr)
    [current_arr{i}] = findPeakPos(current_arr{i},'oxidation');
    [current_arr{i}] = findPeakPos(current_arr{i},'reduction');
    
    current_arr{i}.oxidationReductionIRatio    = abs(current_arr{i}.oxidationPeakCurr / current_arr{i}.reductionPeakCurr); % Peak current ratio and difference
    current_arr{i}.oxidationReductionTimeDiff  = current_arr{i}.oxidationPeakTime - current_arr{i}.reductionPeakTime;
    current_arr{i}.oxidationReductionVoltDiff  = current_arr{i}.oxidationPeakVolt - current_arr{i}.reductionPeakVolt;
end




% Plotting everything else besides area and FWHM
subCurrPlotTitle = expInfo.sensorId+ " " +expInfo.concentration+"uM "+num2str(expInfo.rampRate)+"V/s "+expInfo.lowVolt+"V to "+expInfo.highVolt+"V";


%     Plot current vs. time
subplot(2,3,2)
plot(current_arr{1}.timeMs,current_arr{1}.subtractedCurr,'r','LineWidth',2)
set(gca,'FontSize',13)
yticks(round(linspace(min(current_arr{1}.subtractedCurr)-5,max(current_arr{1}.subtractedCurr)+5,10)))
xlabel('Time ($ms$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current($nA$)', 'Interpreter', 'LaTex','FontSize',19);
ylim([min(current_arr{1}.subtractedCurr)-2 max(current_arr{1}.subtractedCurr)+2])
xlim([min(current_arr{1}.timeMs) max(current_arr{1}.timeMs)]);
title(subCurrPlotTitle,'FontSize',16,'FontWeight','bold')
legend('Dopamine')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',1,'FontSize',9);
set(hleg,'Location','Best','FontSize',9);
grid on
hold on
plot(current_arr{1}.oxidationPeakTime,current_arr{1}.oxidationPeakCurr, 'k*-', 'DisplayName', sprintf('oxi_peak'));
hold on
plot(current_arr{1}.reductionPeakTime,current_arr{1}.reductionPeakCurr, 'k*-', 'DisplayName', sprintf('red_peak'));


%     Plot current vs. voltage
subplot(2,3,3)
plot(current_arr{1}.FSCVvolt, current_arr{1}.subtractedCurr,'r','LineWidth',2)
yticks(round(linspace(min(current_arr{1}.subtractedCurr)-5,max(current_arr{1}.subtractedCurr)+5,10)))
set(gca,'FontSize',13)
xlabel('FSCV Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current($nA$)', 'Interpreter', 'LaTex','FontSize',19);
ylim([min(current_arr{1}.subtractedCurr)-2 max(current_arr{1}.subtractedCurr)+2])
xlim([expInfo.lowVolt*1000 expInfo.highVolt*1000]);
title(subCurrPlotTitle,'FontSize',16,'FontWeight','bold')
legend('Dopamine')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',1,'FontSize',9);
set(hleg,'Location','Best','FontSize',9);
grid on
hold on
plot(current_arr{1}.oxidationPeakVolt, current_arr{1}.oxidationPeakCurr, 'k*-', 'DisplayName', sprintf('oxi_peak'));
hold on
plot(current_arr{1}.reductionPeakVolt, current_arr{1}.reductionPeakCurr, 'k*-', 'DisplayName', sprintf('red_peak'));



%     Plot current vs. time
subplot(2,3,5)
plot(current_arr{2}.timeMs,current_arr{2}.subtractedCurr,'r','LineWidth',2)
set(gca,'FontSize',13)
yticks(round(linspace(min(current_arr{2}.subtractedCurr)-5,max(current_arr{2}.subtractedCurr)+5,10)))
xlabel('Time ($ms$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current($nA$)', 'Interpreter', 'LaTex','FontSize',19);
ylim([min(current_arr{2}.subtractedCurr)-2 max(current_arr{2}.subtractedCurr)+2])
xlim([min(current_arr{2}.timeMs) max(current_arr{2}.timeMs)]);
title(subCurrPlotTitle,'FontSize',19,'FontWeight','bold')
legend('Dopamine')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',1,'FontSize',9);
set(hleg,'Location','Best','FontSize',9);
grid on
hold on
plot(current_arr{2}.oxidationPeakTime,current_arr{2}.oxidationPeakCurr, 'k*-', 'DisplayName', sprintf('oxi_peak'));
hold on
plot(current_arr{2}.reductionPeakTime,current_arr{2}.reductionPeakCurr, 'k*-', 'DisplayName', sprintf('red_peak'));

%     Plot current vs. voltage
subplot(2,3,6)
plot(current_arr{2}.FSCVvolt, current_arr{2}.subtractedCurr,'r','LineWidth',2)
yticks(round(linspace(min(current_arr{2}.subtractedCurr)-5,max(current_arr{2}.subtractedCurr)+5,10)))
set(gca,'FontSize',13)
xlabel('FSCV Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current($nA$)', 'Interpreter', 'LaTex','FontSize',19);
ylim([min(current_arr{2}.subtractedCurr)-2 max(current_arr{2}.subtractedCurr)+2])
xlim([expInfo.lowVolt*1000 expInfo.highVolt*1000]);
title(subCurrPlotTitle,'FontSize',19,'FontWeight','bold')
legend('Dopamine')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',1,'FontSize',9);
set(hleg,'Location','Best','FontSize',9);
grid on
hold on
plot(current_arr{2}.oxidationPeakVolt, current_arr{2}.oxidationPeakCurr, 'k*-', 'DisplayName', sprintf('oxi_peak'));
hold on
plot(current_arr{2}.reductionPeakVolt, current_arr{2}.reductionPeakCurr, 'k*-', 'DisplayName', sprintf('red_peak'));




%% Plot current, voltage, and time -- channel 3 and 4

figure('Color', 'w', 'Position', [132 101 1188 661]);
axes( 'Position', [0, 0.95, 1, 0.05] ); % these lines add a super title above the subplots
set( gca, 'Color', 'None', 'XColor', 'White', 'YColor', 'White' ) ;
text( 0.5, .25, 'Channel 3(top) & 4(bottom)', 'FontSize', 16', 'FontWeight', 'Bold', ...
    'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Bottom' ) ;


subplot(2,3,1)
plot(current_arr{3}.FSCVvolt,current_arr{3}.PBSinfo.avgCurr,'b','LineWidth',2)
hold on
plot(current_arr{3}.FSCVvolt,current_arr{3}.DAinfo.avgCurr,'r','LineWidth',2)
xlabel('FSCV Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current ($nA$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylim([floor(min(current_arr{3}.DAinfo.avgCurr)/100)*100 max(current_arr{3}.DAinfo.avgCurr)+60])
plotTitle = 'PBS and DA cycles';
title(plotTitle,'FontSize',16,'FontWeight','bold')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',2,'FontSize',8);
set(hleg,'Location','Best','FontSize',8);
blueCurve = 'PBS';
redCurve = 'Dopamine';
legend(blueCurve,redCurve)
grid minor
ax = gca;
ax.GridAlpha=1;

subplot(2,3,4)
plot(current_arr{4}.FSCVvolt,current_arr{4}.PBSinfo.avgCurr,'b','LineWidth',2)
hold on
plot(current_arr{4}.FSCVvolt,current_arr{4}.DAinfo.avgCurr,'r','LineWidth',2)
xlabel('FSCV Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current ($nA$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylim([floor(min(current_arr{4}.DAinfo.avgCurr)/100)*100 max(current_arr{4}.DAinfo.avgCurr)+60])
plotTitle = 'PBS and DA cycles';
title(plotTitle,'FontSize',19,'FontWeight','bold')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',2,'FontSize',8);
set(hleg,'Location','Best','FontSize',8);
blueCurve = 'PBS';
redCurve = 'Dopamine';
legend(blueCurve,redCurve)
grid minor
ax = gca;
ax.GridAlpha=1;




% Finish plotting everthing besides area and FWHM
subCurrPlotTitle = expInfo.sensorId+" "+expInfo.concentration+"uM "+num2str(expInfo.rampRate)+"V/s "+expInfo.lowVolt+"V to "+expInfo.highVolt+"V";

%     Plot current vs. time
subplot(2,3,2)
plot(current_arr{3}.timeMs,current_arr{3}.subtractedCurr,'r','LineWidth',2)
set(gca,'FontSize',13)
yticks(round(linspace(min(current_arr{3}.subtractedCurr)-5,max(current_arr{3}.subtractedCurr)+5,10)))
xlabel('Time ($ms$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current($nA$)', 'Interpreter', 'LaTex','FontSize',19);
ylim([min(current_arr{3}.subtractedCurr)-2 max(current_arr{3}.subtractedCurr)+2])
xlim([min(current_arr{3}.timeMs) max(current_arr{3}.timeMs)]);
title(subCurrPlotTitle,'FontSize',16,'FontWeight','bold')
legend('Dopamine')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',1,'FontSize',9);
set(hleg,'Location','Best','FontSize',9);
grid on
hold on
plot(current_arr{3}.oxidationPeakTime,current_arr{3}.oxidationPeakCurr, 'k*-', 'DisplayName', sprintf('oxi_peak'));
hold on
plot(current_arr{3}.reductionPeakTime,current_arr{3}.reductionPeakCurr, 'k*-', 'DisplayName', sprintf('red_peak'));


%     Plot current vs. voltage
subplot(2,3,3)
plot(current_arr{3}.FSCVvolt, current_arr{3}.subtractedCurr,'r','LineWidth',2)
yticks(round(linspace(min(current_arr{3}.subtractedCurr)-5,max(current_arr{3}.subtractedCurr)+5,10)))
set(gca,'FontSize',13)
xlabel('FSCV Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current($nA$)', 'Interpreter', 'LaTex','FontSize',19);
ylim([min(current_arr{3}.subtractedCurr)-2 max(current_arr{3}.subtractedCurr)+2])
xlim([expInfo.lowVolt*1000 expInfo.highVolt*1000]);
title(subCurrPlotTitle,'FontSize',16,'FontWeight','bold')
legend('Dopamine')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',1,'FontSize',9);
set(hleg,'Location','Best','FontSize',9);
grid on
hold on
plot(current_arr{3}.oxidationPeakVolt, current_arr{3}.oxidationPeakCurr, 'k*-', 'DisplayName', sprintf('oxi_peak'));
hold on
plot(current_arr{3}.reductionPeakVolt, current_arr{3}.reductionPeakCurr, 'k*-', 'DisplayName', sprintf('red_peak'));



%     Plot current vs. time
subplot(2,3,5)
plot(current_arr{4}.timeMs,current_arr{4}.subtractedCurr,'r','LineWidth',2)
set(gca,'FontSize',13)
yticks(round(linspace(min(current_arr{4}.subtractedCurr)-5,max(current_arr{4}.subtractedCurr)+5,10)))
xlabel('Time ($ms$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current($nA$)', 'Interpreter', 'LaTex','FontSize',19);
ylim([min(current_arr{4}.subtractedCurr)-2 max(current_arr{4}.subtractedCurr)+2])
xlim([min(current_arr{4}.timeMs) max(current_arr{4}.timeMs)]);
title(subCurrPlotTitle,'FontSize',19,'FontWeight','bold')
legend('Dopamine')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',1,'FontSize',9);
set(hleg,'Location','Best','FontSize',9);
grid on
hold on
plot(current_arr{4}.oxidationPeakTime,current_arr{4}.oxidationPeakCurr, 'k*-', 'DisplayName', sprintf('oxi_peak'));
hold on
plot(current_arr{4}.reductionPeakTime,current_arr{4}.reductionPeakCurr, 'k*-', 'DisplayName', sprintf('red_peak'));


%     Plot current vs. voltage
subplot(2,3,6)
plot(current_arr{4}.FSCVvolt, current_arr{4}.subtractedCurr,'r','LineWidth',2)
yticks(round(linspace(min(current_arr{4}.subtractedCurr)-5,max(current_arr{4}.subtractedCurr)+5,10)))
set(gca,'FontSize',13)
xlabel('FSCV Voltage ($mV$)','Interpreter', 'LaTex','FontSize',19,'FontWeight','bold')
ylabel('Current($nA$)', 'Interpreter', 'LaTex','FontSize',19);
ylim([min(current_arr{4}.subtractedCurr)-2 max(current_arr{4}.subtractedCurr)+2])
xlim([expInfo.lowVolt*1000 expInfo.highVolt*1000]);
title(subCurrPlotTitle,'FontSize',19,'FontWeight','bold')
legend('Dopamine')
[hleg, ~] = legend;
% set(hleg,'Location','Best','NumColumns',1,'FontSize',9);
set(hleg,'Location','Best','FontSize',9);
grid on
hold on
plot(current_arr{4}.oxidationPeakVolt, current_arr{4}.oxidationPeakCurr, 'k*-', 'DisplayName', sprintf('oxi_peak'));
hold on
plot(current_arr{4}.reductionPeakVolt, current_arr{4}.reductionPeakCurr, 'k*-', 'DisplayName', sprintf('red_peak'));

end

