%% Updates:

% 1. change variable names

%% Clear

clc;
fclose all; close all; clear all; 
tic;
digits(32);

%% Define folder path and file name

dataFolder = '/Users/apple/Desktop/Data_analysis';
device = 'device C3 10Hz 200V/s 1 uM DA';

%% Define parameters

% basic parameters:
voltageHigh = 1; % V                 %max input voltage
voltageLow = -0.4; % V                 %min input voltage
rampRate = 200; % V/s                  %predetermined slope of the triangle wave
comV = 0.078; % V                        %common mode voltage
fbR = 4.1e6; % (Ohm)                    %feedback resistor
FSCVfrequency = 10; % (Hz) or 0.1s 
FSCVperiod = 1/FSCVfrequency;
duration = 2 * ((voltageHigh-voltageLow)/rampRate); % 14 ms/cycle; duration of one cycle
durationMs = duration * 1000;          % 1000 for unit convertion
halfCycledurationMs = durationMs / 2;
OSR = 128;                    
samplingRateADC = (1*1.024e6) / (1*OSR); % (Hz), 288->2.25*128 // 18,000 points/second
dataPoints = round(duration * samplingRateADC); %252 points/cycle    


% PBS parameters:
PBScycleNum = 5;     
PBSstartingInd = 115;                 % ideal: 100 - 160    %bad cycle 136;138;139;134;132;
PBSvoltMatrix = 0;
PBScycleNumCollected = 0;
usablePBSCoordinates = zeros(1,PBScycleNum);        % array to store 5 -usable- waveform's coordinates
PBScondition2 = 0.006; % V (3*LSB)


% DA parameters:
DAcycleNum = 2;        
DAstartingInd = 170;                % ideal: 350 - 400
DAvoltMatrix = 0;
DAcondition2 = 0.01; % V
DAcycleNumCollected = 0;
usableDACoordinatesd = zeros(1,DAcycleNum);
           

% other parameters:
peakVolt = 0.55;                       % observation
error = 0.003; % V 
next = 0;                               % used by both PBS and DA
voltCondition = 2.17;                  % observation: it separates two types of waves at middle point
localVoltConditionInd = 1260;        % observation
% tail_volt = 1.005;                      % differentiate different types at cycle end point
tailDifferenceThreshold = 0.015;      % an observation
endOfDAcycleSearch = 20;                   % looking for appropriate PBS cycles will stop at this point
intrptnFactor = 0.1;                   % factor that decides num pts to insert between each existing pt; e.g. 0.1 -> 10 times more


% *** when start_index is too large, ideal cycles may not be found ***
%find cycle with the least sum of differences of slope at each point; use
%diff1
%use peak to align each cycle???


%% Read data from txt file

cd (dataFolder);
fileID = fopen('V2I_RESULT_CHR2.txt');  % aquired data from ADC
data = fscanf(fileID,'%f\n');
fclose(fileID);

%% Simple data process

dataLen = length(data); % get data length
newData = interp1((1:1:dataLen),smooth(data,5),(1:intrptnFactor:dataLen),'spline'); % use interpolation -- newData = (958230*1) x 1 --> (958230*10) x 1 array
newDataPoints = dataPoints / intrptnFactor; % interplation increase the current number of points per cycle by a factor
diff1 = 1.645 + diff(smooth(newData)); % calculate slope at each point with step size 1
[~, peakIndices] = findpeaks(newData, 'MinPeakHeight', peakVolt, 'MinPeakDistance', 10*(round((FSCVperiod)*samplingRateADC)-10));


%% Finding and averaging PBS measurement

while (PBScycleNumCollected < PBScycleNum) || ((PBSstartingInd + next) <= length(peakIndices)) 
% loop continues if specific number isn't reached or the cycle number is lt or eq the total number of cycles in the whole data set
    
    PBSlocalDiff = peakIndices(PBSstartingInd + next) - (50 * 10); % the searching of starting point begins at an index which is a number of indecies ahead of the peak index
    PBSlocalActualStartingPt = diff1(PBSlocalDiff : PBSlocalDiff + (50 * 10)); % get the difference for the points chosen
    Find_index_start_PBS = find(PBSlocalActualStartingPt > (1.645 + error)); % condition 1
    local_index_PBS = Find_index_start_PBS(1) - 1; % 
    
    curr_PBSstartingInd = PBSlocalDiff + local_index_PBS;
    
    %     check condition 2 once:
    if (newData(curr_PBSstartingInd + 1) - newData(curr_PBSstartingInd)) < PBScondition2
        local_index_PBS = local_index_PBS + 1;
    end
    
    % check for other two conditions:
    if usablePBSCoordinates == 0
        usablePBSCoordinates(1) = curr_PBSstartingInd;
        PBScycleNumCollected = PBScycleNumCollected + 1;
        first_PBS_mid_pt_volt = newData(curr_PBSstartingInd + localVoltConditionInd);
    elseif abs(newData(curr_PBSstartingInd + (newDataPoints - 1)) - newData(usablePBSCoordinates(1) + (newDataPoints - 1))) < tailDifferenceThreshold % compare their last point's y-value
        curr_cycle_mid_pt_volt = newData(curr_PBSstartingInd + localVoltConditionInd);
        if (first_PBS_mid_pt_volt > voltCondition && curr_cycle_mid_pt_volt > voltCondition) || (first_PBS_mid_pt_volt < voltCondition && curr_cycle_mid_pt_volt < voltCondition)
            PBScycleNumCollected = PBScycleNumCollected + 1;
            usablePBSCoordinates(PBScycleNumCollected) = curr_PBSstartingInd;
        end
    end
    next = next + 1;
end

% just checking
if (PBScycleNumCollected < PBScycleNum) || ((PBSstartingInd + next) == length(peakIndices) - 1)
    disp("Not enough cycles found");
end
    

% align PBS cycles at the starting point:
for i = 2: 1: PBScycleNum
    cycleOffset = 0; % shift index
    
    % calibrate other cycles to the 1st one
    while newData(usablePBSCoordinates(i) + cycleOffset) > newData(usablePBSCoordinates(1)) % if later one > calibrated one
        cycleOffset = cycleOffset - 1;
    end
    
    while newData(usablePBSCoordinates(i) + cycleOffset) < newData(usablePBSCoordinates(1)) % if <
        cycleOffset = cycleOffset + 1;
    end
    
    largerPtInd = usablePBSCoordinates(i) + cycleOffset;
    smallerPtInd = usablePBSCoordinates(i) + cycleOffset - 1;
    difference1 = newData(largerPtInd) - newData(usablePBSCoordinates(1));
    difference2 =  newData(usablePBSCoordinates(1)) - newData(smallerPtInd);
    if (difference1) > (difference2)
        cycleOffset = cycleOffset - 1;
    end
    usablePBSCoordinates(i) = usablePBSCoordinates(i) + cycleOffset; % update every cycle
end

% sum up PBS voltage:
for i = 1: 1: PBScycleNum
    PBSvoltMatrix = PBSvoltMatrix + newData(usablePBSCoordinates(i) : usablePBSCoordinates(i) + (newDataPoints - 1));
    
    % plot PBS cycles
%     plot(newData(usablePBSCoordinates(i) : usablePBSCoordinates(i) + (newDataPoints - 1)));
%     hold on;
%     grid on;
    
end

% compute avg current:
PBSavgCurr = (((PBSvoltMatrix / PBScycleNum) - comV) * 1e9) / fbR;

% reset variable for later use
next = 0;
        
%% Finding and averaging DA measurement

while DAcycleNumCollected < DAcycleNum
    Diff_local_index = peakIndices(DAstartingInd + next) - (50 * 10);
    DA_local_starting_points = diff1(Diff_local_index : Diff_local_index + (50 * 10));
    Find_index_start_DA = find(DA_local_starting_points > (1.645 + error));  % condition 1
    local_index = Find_index_start_DA(1) - 1;
    
    curr_DA_starting_pt = Diff_local_index + local_index;
    
    % check condition 2 once:
    if (newData(curr_DA_starting_pt + 1) - newData(curr_DA_starting_pt)) < DAcondition2
        local_index = local_index + 1;
    end
    
    
    % find DA such that they're similar to PBS:
    if abs(newData(curr_DA_starting_pt + (newDataPoints - 1)) - newData(usablePBSCoordinates(1) + (newDataPoints - 1))) < tailDifferenceThreshold % compare their last point's y-value
        %         disp(newData(curr_DA_starting_pt + (newDataPoints - 1)) - newData(usablePBSCoordinates(1) + (newDataPoints - 1)));
        curr_cycle_mid_pt_volt = newData(curr_DA_starting_pt + localVoltConditionInd);
        if (first_PBS_mid_pt_volt > voltCondition && curr_cycle_mid_pt_volt > voltCondition) || (first_PBS_mid_pt_volt < voltCondition && curr_cycle_mid_pt_volt < voltCondition)
            %             disp("2");
            DAcycleNumCollected = DAcycleNumCollected + 1;
            usableDACoordinatesd(DAcycleNumCollected) = curr_DA_starting_pt;
        end
    end
    next = next + 1;
end

% align DA to PBS at the starting point:
for i = 1: 1: DAcycleNum
    cycleOffset = 0; % shift index
    
    % calibrate other cycles to the 1st one
    while newData(usableDACoordinatesd(i) + cycleOffset) > newData(usablePBSCoordinates(1)) % if later one > calibrated one
        cycleOffset = cycleOffset - 1;
    end
    
    while newData(usableDACoordinatesd(i) + cycleOffset ) < newData(usablePBSCoordinates(1)) % if <
        cycleOffset = cycleOffset + 1;
    end
    
    largerPtIndex = usableDACoordinatesd(i) + cycleOffset;
    smallerPtIndex = usableDACoordinatesd(i) + cycleOffset - 1;
    difference1 = newData(largerPtIndex) - newData(usablePBSCoordinates(1));
    difference2 =  newData(usablePBSCoordinates(1)) - newData(smallerPtIndex);
    if (difference1) > (difference2)
        cycleOffset = cycleOffset - 1;
    end
    usableDACoordinatesd(i) = usableDACoordinatesd(i) + cycleOffset; %update every cycle
end

% sum up PBS voltage:
for i = 1: 1: DAcycleNum
    DAvoltMatrix = DAvoltMatrix + newData(usableDACoordinatesd(i) : usableDACoordinatesd(i) + (newDataPoints - 1));
    
    %     plot DA cycles:
%            plot(newData(usableDACoordinatesd(i) : (usableDACoordinatesd(i) + (newDataPoints - 1))));
%            grid on;
%            hold on;
    
end

% compute avg current:
Average_current_DAX = (((DAvoltMatrix / DAcycleNum) - comV) * 1e9) / fbR;


%% Plot

%{
    figure(33);
    plot(data_s (Diff_local_index + local_index +  check (j): Diff_local_index + local_index + newDataPoints), 'r')
    hold on;
    title('2 DA cycles','FontSize',15,'FontWeight','bold')
    xlabel('sample number','FontSize',15,'FontWeight','bold');
    ylabel('Total current (A)','FontSize',15,'FontWeight','bold');
    grid on;

%}

%{
% figure(19);
% plot(Average_current_DAX - PBSavgCurr);
% xlabel('Sample number','FontSize',15,'FontWeight','bold');
% ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold');
% grid on;
%}

%{ 
% figure(32);
% plot(Average_current_DAX);
% hold on;
% plot(PBSavgCurr);
% xlabel('sample number','FontSize',15,'FontWeight','bold');
% ylabel('Total current (nA)','FontSize',15,'FontWeight','bold');
% grid on;
%}


% Change horizontal time_axis:
% bent_volt_vaxis = [-0.6 : 1.4/(newDataPoints/2) : 0.8-1.4/(newDataPoints/2)   0.8:-1.4/(newDataPoints/2):-0.6+1.4/(newDataPoints/2)];
bent_volt_axis_step = (voltageHigh + abs(voltageLow))/(newDataPoints/2);
bent_volt_axis = [voltageLow: bent_volt_axis_step: (voltageHigh - bent_volt_axis_step)   voltageHigh: -bent_volt_axis_step: (voltageLow + bent_volt_axis_step)];

straight_time_axis = (0: (durationMs/newDataPoints): (durationMs-(durationMs/newDataPoints)))';

bent_time_axis_step = halfCycledurationMs / (newDataPoints/2);
bent_time_axis = [0: bent_time_axis_step: (halfCycledurationMs - bent_time_axis_step)   halfCycledurationMs: -bent_time_axis_step: (0 + bent_time_axis_step)]';



%{
% figure(21);
% plot(time_axis,smooth(Average_current_DAX), 'r-', time_axis,smooth(PBSavgCurr), 'b-', 'LineWidth',2 )
% xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
% ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
% title(device,'FontSize',15,'FontWeight','bold')
% legend('Dopamine','PBS')
% grid minor;
%}

subtracted_currentX = (smooth(Average_current_DAX) - smooth(PBSavgCurr));


% Plot the subtracted_currentX as current vs. voltage
figure(29)
plot(bent_volt_axis, smooth(subtracted_currentX, 6),'r','LineWidth',2 )
xlabel('FSCV Voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
title(device,'FontSize',15,'FontWeight','bold')
legend('Dopamine')
grid on;

% Plot the subtracted_currentX as current vs. time
figure(30)
plot(bent_time_axis, smooth(subtracted_currentX, 6),'r','LineWidth',2 )
xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
title(device,'FontSize',15,'FontWeight','bold')
legend('Dopamine')
grid on;


%% Calculations


%{
% figure(20); % plot abs_subtracted
% plot(abs_subtracted);
% xlabel('Sample number','FontSize',15,'FontWeight','bold');
% ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold');
% grid on;
%} 



%Find the current, voltage and time position of both peaks and their ranges  
oxidation_peak_curr = max(subtracted_currentX);
reduction_peak_curr = min(subtracted_currentX);
subtracted_currentX_diff = oxidation_peak_curr - reduction_peak_curr;

oxidation_ind = find(subtracted_currentX == oxidation_peak_curr); % find x-value(index) with the y-value(max & min)
reduction_ind = find(subtracted_currentX == reduction_peak_curr);

oxidation_peakVolt = bent_volt_axis(oxidation_ind);
reduction_peakVolt = bent_volt_axis(reduction_ind);
peaks_volt_diff = oxidation_peakVolt - reduction_peakVolt; 

oxidation_peak_time = bent_time_axis(oxidation_ind);
reduction_peak_time = bent_time_axis(reduction_ind);
peaks_time_diff = oxidation_peak_time - reduction_peak_time;


% Create Gaussian fit and obtain result
abs_subtracted = abs(subtracted_currentX); % take abs values to allow cfit func to fit both peaks at the same time
[fitresult, gof] = createGaussianFit(straight_time_axis, abs_subtracted); % function definition

% Computing Area
max_area = integrate(fitresult, (durationMs/2), 0);
min_area = integrate(fitresult, durationMs, (durationMs/2));

% Computing FWHM
ax = gca;
x = ax.Children.XData;
y = ax.Children.YData;
y_len = length(y);
y_oxi = y(1: (y_len-1)/2);
y_red = y((y_len+1)/2: y_len);

zci = @(v) find(v(:).*circshift(v(:), [-1 0]) <= 0);

y_oxi_temp = y_oxi - 0.5 * max(y_oxi); % calculate zero crossing point
y_red_temp = y_red - 0.5 * max(y_red);

ind_oxi = zci(y_oxi_temp);
ind_red = zci(y_red_temp);
FWHM_oxi = diff(x(ind_oxi)); % unit in time
FWHM_red = diff(x(ind_red)); % 


%% Print Computation Results and Make Plots

hold on
%plot(x(ind_oxi), y(ind_oxi), "k*-", "DisplayName", sprintf("Oxidation_FWHM = %.1f", FWHM_oxi));
hold on
%plot(x(ind_red+(y_len-1)/2), y(ind_red+(y_len-1)/2), "k*-", "DisplayName", sprintf("Reduction_FWHM = %.1f", FWHM_red));

% Convert unit from current to voltage
oxi_FWHM_in_volt = FWHM_oxi * ((voltageHigh + abs(voltageLow)) / halfCycledurationMs);
red_FWHM_in_volt = FWHM_red * ((voltageHigh + abs(voltageLow)) / halfCycledurationMs);


% Print results
fprintf("Oxidation peak position: " + oxidation_peakVolt + "(V)/" + oxidation_peak_time + "(ms) and " + oxidation_peak_curr + "(nA); Area: " + max_area + "(nA*ms); FWHM: " + oxi_FWHM_in_volt + "(V)/" + FWHM_oxi + "(ms)\n\n");
fprintf("Reduction peak position: " + reduction_peakVolt + "(V)/" + reduction_peak_time + "(ms) and " + reduction_peak_curr + "(nA): Area: " + min_area + "(nA*ms); FWHM: " + red_FWHM_in_volt + "(V)/" + FWHM_red + "(ms)\n\n");
fprintf("Peaks voltage difference: " + peaks_volt_diff + "(V); time difference: " + peaks_time_diff + "(ms); and current difference: " + subtracted_currentX_diff + "(nA)\n\n");


%% Creat Gaussian Fit -- Function implementation

function [fitresult, gof] = createGaussianFit(x_axis, abs_subtracted)

[xData, yData] = prepareCurveData(x_axis, abs_subtracted );

% Set up fittype and options.
ft = fittype( 'gauss2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0 -Inf -Inf 0];
opts.Normalize = 'on';
opts.StartPoint = [12.8802842721962 0.995731668140828 0.218352580159724 12.1654061454156 -0.593041014220521 0.149727495275557];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'Gaussian Fit' );
 h = plot( fitresult, xData, yData );
 legend( h, 'Original Data', 'Gaussian fit', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
%xlabel( 'Time (ms)', "FontSize", 15, 'Interpreter', 'none' );
%ylabel( 'Current (nA)', "FontSize", 15, 'Interpreter', 'none' );
%title("Gaussian Fit Curve and FWHM", "FontSize", 15, "FontWeight", "Bold");
grid on

end

