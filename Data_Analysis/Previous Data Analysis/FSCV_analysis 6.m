clc;
close all;
tic;
digits(32);
syms u;
%% Define folder path and file name

Datafolder = '/Users/apple/Desktop/Data_analysis';
Device = 'Device C3 10Hz 200V/s 1 uM DA';

%% Define parameters

% basic parameters:
Voltage_High = 0.8; % V       %max input voltage
Voltage_Low = - 0.6; % V      %min input voltage
Ramp_rate = 200; % V/s        %predetermined slope of the triangle wave
vcom = 1.65; % V              %common mode voltage
Rfb = 4.1e6; % (Ohm)          %feedback resistor

FSCV_frequency = 10; % (Hz) or 0.1s 
Duration = 2 * ((Voltage_High-Voltage_Low)/Ramp_rate);  % 14 millisecond/cycle; duration of one cycle

OSR = 128;                    
sampling_rate_ADC = 2.25*1.024e6/(1*OSR);               % (Hz), 288->2.25*128 // 18,000 points/second
Data_points = round(10 * Duration * sampling_rate_ADC); %2520 points/cycle    


% PBS parameters:
num_PBS_cycle = 5;     
PBS_starting_ind = 125;                 % ideal: 100 - 160
Voltage_Matrix_PBSX = 0;
%bad cycle 136;138;139;134;132;

num_PBS_cycle_collected = 0;
usable_PBS_coordinates = zeros(1,num_PBS_cycle);    % array to store 5 -usable- waveform's coordinates
 
PBS_condition2 = 0.006;                 % 6mV (3*LSB)


% DA parameters:
num_DA_cycle = 2;        
DA_starting_index = 350;                % ideal: 350-400
Voltage_Matrix_DAX = 0;
DA_condition2 = 0.01;                   % 10 mV

num_DA_cycle_collected = 0;
usable_DA_coordinates = zeros(1,num_DA_cycle);
           

% other parameters:
peak_volt = 2.33;                       % observation
error = 0.003;                          % 3 mV 
next = 0;                               % used by both PBS and DA
volt_condition = 2.17;                  % observation: it separates two types of waves at middle point
local_volt_condition_ind = 1260;        % observation
tail_volt = 1.005;                      % differentiate different types at cycle end point
wave_difference_threshold = 0.015;      % it's an observation




% *** defective cycle can cause unexpected result ***

% *** when start_index is too large, ideal cycles may not be found ***

%difference in cycles may be explianed by peak distance between cycles

% use tail_volt = 1.005;

%find cycle with the least sum of differences of slope at each point; use
%diff1


%% Read data from txt file and simple data process

cd (Datafolder);
fileID = fopen('FSCV_VOLTAGE_CHL.txt','r');  % aquired data from ADC
data = fscanf(fileID,'%f\n');
fclose(fileID);

len_data = length(data);      % get data length
new_data_interp = interp1((1:1:len_data),smooth(data,5),(1:0.1:len_data),'spline'); % use interpolation -- new_data_interp = (958230*1) x 1 --> (958230*10) x 1 array

diff1 = 1.645 + diff(smooth(new_data_interp));

[Peak, Peak_index] = findpeaks(new_data_interp, 'MinPeakHeight', peak_volt, 'MinPeakDistance', 10*(round((1/FSCV_frequency)*sampling_rate_ADC)-10));

%% Find the averaging for the first PBS measurement

while num_PBS_cycle_collected < num_PBS_cycle
    
    Diff_local_index_PBS = Peak_index(PBS_starting_ind + next) - (50 * 10);
    PBS_local_starting_points = diff1(Diff_local_index_PBS : Diff_local_index_PBS + (50 * 10));
    Find_index_start_PBS = find(PBS_local_starting_points > (1.645 + error)); % condition 1
    local_index_PBS = Find_index_start_PBS(1) - 1;
    
    curr_PBS_starting_ind = Diff_local_index_PBS + local_index_PBS;
    
    %     check condition 2 once:
    if (new_data_interp(curr_PBS_starting_ind + 1) - new_data_interp(curr_PBS_starting_ind)) < PBS_condition2
        local_index_PBS = local_index_PBS + 1;
    end
    
    % check for other two conditions:
    if usable_PBS_coordinates == 0
        usable_PBS_coordinates(1) = curr_PBS_starting_ind;
        num_PBS_cycle_collected = num_PBS_cycle_collected + 1;
        first_PBS_mid_pt_volt = new_data_interp(curr_PBS_starting_ind + local_volt_condition_ind);
    elseif abs(new_data_interp(curr_PBS_starting_ind + (Data_points - 1)) - new_data_interp(usable_PBS_coordinates(1) + (Data_points - 1))) < wave_difference_threshold % compare their last point's y-value
        disp(new_data_interp(curr_PBS_starting_ind + (Data_points - 1)) - new_data_interp(usable_PBS_coordinates(1) + (Data_points - 1)));
        curr_cycle_mid_pt_volt = new_data_interp(curr_PBS_starting_ind + local_volt_condition_ind);
        if (first_PBS_mid_pt_volt > volt_condition && curr_cycle_mid_pt_volt > volt_condition) || (first_PBS_mid_pt_volt < volt_condition && curr_cycle_mid_pt_volt < volt_condition)
            num_PBS_cycle_collected = num_PBS_cycle_collected + 1;
            usable_PBS_coordinates(num_PBS_cycle_collected) = curr_PBS_starting_ind;
        end
    end
    next = next + 1;
end

% align PBS cycles at the starting point:
for i = 2: num_PBS_cycle
    cycle_offset = 0; % shift index
    
    % calibrate other cycles to the 1st one
    while new_data_interp(usable_PBS_coordinates(i) + cycle_offset) > new_data_interp(usable_PBS_coordinates(1)) % if later one > calibrated one
        cycle_offset = cycle_offset - 1;
    end
    
    while new_data_interp(usable_PBS_coordinates(i) + cycle_offset) < new_data_interp(usable_PBS_coordinates(1)) % if <
        cycle_offset = cycle_offset + 1;
    end
    
    larger_point_ind = usable_PBS_coordinates(i) + cycle_offset;
    smaller_point_ind = usable_PBS_coordinates(i) + cycle_offset - 1;
    difference1 = new_data_interp(larger_point_ind) - new_data_interp(usable_PBS_coordinates(1));
    difference2 =  new_data_interp(usable_PBS_coordinates(1)) - new_data_interp(smaller_point_ind);
    if (difference1) > (difference2)
        cycle_offset = cycle_offset - 1;
    end
    usable_PBS_coordinates(i) = usable_PBS_coordinates(i) + cycle_offset; % update every cycle
end

% sum up PBS voltage:
for i = 1: 1: num_PBS_cycle
    Voltage_Matrix_PBSX = Voltage_Matrix_PBSX + new_data_interp(usable_PBS_coordinates(i) : usable_PBS_coordinates(i) + (Data_points - 1));
    
    % plot PBS cycles
    plot(new_data_interp(usable_PBS_coordinates(i) : usable_PBS_coordinates(i) + (Data_points - 1)));
    hold on;
    grid on;
    
end

% compute avg current:
Average_current_PBSX = (((Voltage_Matrix_PBSX / num_PBS_cycle) - vcom) * 1e9) / Rfb;

next = 0; % reset variable
        

%% Find DA

while num_DA_cycle_collected < num_DA_cycle
    %     disp(next);
    Diff_local_index = Peak_index(DA_starting_index + next) - (50 * 10);
    DA_local_starting_points = diff1(Diff_local_index : Diff_local_index + (50 * 10));
    Find_index_start_DA = find(DA_local_starting_points > (1.645 + error));  % condition 1
    local_index = Find_index_start_DA(1) - 1;
    
    curr_DA_starting_pt = Diff_local_index + local_index;
    
    % check condition 2 once:
    if (new_data_interp(curr_DA_starting_pt + 1) - new_data_interp(curr_DA_starting_pt)) < DA_condition2
        local_index = local_index + 1;
    end
    
    
    % find DA such that they're similar to PBS:
    if abs(new_data_interp(curr_DA_starting_pt + (Data_points - 1)) - new_data_interp(usable_PBS_coordinates(1) + (Data_points - 1))) < wave_difference_threshold % compare their last point's y-value
        %         disp(new_data_interp(curr_DA_starting_pt + (Data_points - 1)) - new_data_interp(usable_PBS_coordinates(1) + (Data_points - 1)));
        curr_cycle_mid_pt_volt = new_data_interp(curr_DA_starting_pt + local_volt_condition_ind);
        if (first_PBS_mid_pt_volt > volt_condition && curr_cycle_mid_pt_volt > volt_condition) || (first_PBS_mid_pt_volt < volt_condition && curr_cycle_mid_pt_volt < volt_condition)
            %             disp("2");
            num_DA_cycle_collected = num_DA_cycle_collected + 1;
            usable_DA_coordinates(num_DA_cycle_collected) = curr_DA_starting_pt;
        end
    end
    next = next + 1;
end

% align DA to PBS at the starting point:
for i = 1: 1: num_DA_cycle
    cycle_offset = 0; % shift index
    
    % calibrate other cycles to the 1st one
    while new_data_interp(usable_DA_coordinates(i) + cycle_offset) > new_data_interp(usable_PBS_coordinates(1)) % if later one > calibrated one
        cycle_offset = cycle_offset - 1;
    end
    
    while new_data_interp(usable_DA_coordinates(i) + cycle_offset ) < new_data_interp(usable_PBS_coordinates(1)) % if <
        cycle_offset = cycle_offset + 1;
    end
    
    larger_point_index = usable_DA_coordinates(i) + cycle_offset;
    smaller_point_index = usable_DA_coordinates(i) + cycle_offset - 1;
    difference1 = new_data_interp(larger_point_index) - new_data_interp(usable_PBS_coordinates(1));
    difference2 =  new_data_interp(usable_PBS_coordinates(1)) - new_data_interp(smaller_point_index);
    if (difference1) > (difference2)
        cycle_offset = cycle_offset - 1;
    end
    usable_DA_coordinates(i) = usable_DA_coordinates(i) + cycle_offset; %update every cycle
end

% sum up PBS voltage:
for i = 1: 1: num_DA_cycle
    Voltage_Matrix_DAX = Voltage_Matrix_DAX + new_data_interp(usable_DA_coordinates(i) : usable_DA_coordinates(i) + (Data_points - 1));
    
    %     plot DA cycles:
           plot(new_data_interp(usable_DA_coordinates(i) : (usable_DA_coordinates(i) + (Data_points - 1))));
           grid on;
           hold on;
    
end

% compute avg current:
Average_current_DAX = (((Voltage_Matrix_DAX / num_DA_cycle) - vcom) * 1e9) / Rfb;


%% Plot

%{
    figure(33);
    plot(data_s (Diff_local_index + local_index +  check (j): Diff_local_index + local_index + Data_points), 'r')
    hold on;
    title('2 DA cycles','FontSize',15,'FontWeight','bold')
    xlabel('sample number','FontSize',15,'FontWeight','bold');
    ylabel('Total current (A)','FontSize',15,'FontWeight','bold');
    grid on;

%}


figure(19);
plot(Average_current_DAX - Average_current_PBSX);
xlabel('Sample number','FontSize',15,'FontWeight','bold');
ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold');
grid on;


vaxisX = [-0.6:1.4/(Data_points/2):0.8-1.4/(Data_points/2)   0.8:-1.4/(Data_points/2):-0.6+1.4/(Data_points/2)] ;
vaxis = vaxisX';

figure(21);
plot(vaxis,smooth(Average_current_DAX), 'r-', vaxis,smooth(Average_current_PBSX), 'b-', 'LineWidth',2 )
xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;


Substrated_currentX = (smooth(Average_current_DAX) - smooth(Average_current_PBSX));



%Find the max, min currents and the range of the current 
maxOf_Substrated_currentX = max(Substrated_currentX);
minOf_Substrated_currentX = min(Substrated_currentX);
rangeOf_Substrated_currentX = maxOf_Substrated_currentX - minOf_Substrated_currentX;



%Find the max index
for i = 1: 1: Data_points
    if Substrated_currentX(i)==maxOf_Substrated_currentX
        max_index = i;
    end
end



%Find the min index 
for i = 1: 1: Data_points
    if Substrated_currentX(i)==minOf_Substrated_currentX
        min_index = i;
    end
end


%Find the voltage when peak current occured and the range  
maxOf_Substrated_voltage = vaxis(max_index);
minOf_Substrated_voltage = vaxis(min_index);
rangeOf_Substrated_voltage = maxOf_Substrated_voltage - minOf_Substrated_voltage; 




%Find to total Area and the total Amount of Current
max_start_point=1;
max_end_point=500;
min_start_point = 1500;
min_end_point = 2000;
diffOf_AvgCurrent = Average_current_DAX - Average_current_PBSX;
max_totalArea = trapz(diffOf_AvgCurrent(max_start_point:max_end_point)); %nA*points
min_totalArea = trapz(diffOf_AvgCurrent(min_start_point:min_end_point)); %nA*points
totalArea = max_totalArea + min_totalArea;
totalAmountOfCurrent = totalArea * Duration * (1/Data_points); %nA*ms



%Find the curve fitting 
x1 = vaxis(1:Data_points/2);
y1 = Substrated_currentX(1:Data_points/2);


%Plot the diff of Current figure
figure(29)
plot(vaxis, smooth(Substrated_currentX, 6),'r','LineWidth',2 )
xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine')
grid on;



% 
% figure(32);
% plot(Average_current_DAX);
% hold on;
% %plot(Average_current_PBSX);
% xlabel('sample number','FontSize',15,'FontWeight','bold');
% ylabel('Total current (nA)','FontSize',15,'FontWeight','bold');
% grid on;

