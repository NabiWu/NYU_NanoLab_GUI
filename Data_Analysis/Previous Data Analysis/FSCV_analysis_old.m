clc;
close all;
tic
digits(32)
%% Define folder path and file name

Datafolder='/Users/apple/Desktop/Data_analysis';
Device='Device C3 10Hz 200V/s 1 uM DA';

%% Define parameters

Voltage_High = 0.8; % V       %max input voltage
Voltage_Low = -0.6; % V       %min input voltage
Ramp_rate = 200; % V/s        %predetermined slope of the triangle wave
vcom = 1.65; % V              %common mode voltage
Rfb = 4.1e6; % (Ohm)          %feedback resistor

FSCV_frequency = 10; % (Hz) or 0.1s 
Duration = 2 * ((Voltage_High-Voltage_Low)/Ramp_rate); % 14 millisecond/cycle; duration of one cycle

OSR = 128;                    
sampling_rate_ADC = 2.25*1.024e6/(1*OSR);        % (Hz), 288->2.25*128 // 18,000 points/second
Data_points = round(10 * Duration * sampling_rate_ADC); %252 points/cycle    

NoCycle_DA = 10;               % Dopemine is used
NoCycle_PBS = 20;              % Dopemine isn't used
Voltage_Matrix_PBSX = 0;      % total voltage PBS
Voltage_Matrix_DAX = 0;       % total voltage DA
% Voltage_Matrix_DAX1 = 0;
% Voltage_Matrix_DAX2 = 0;
%???????

index_start = 125;            % start index 100 or 125 or btw
start_index_DA = 384;         %350-400

error = 0.003;                % 3 mV
condition2 = 0.006;           % 6mV (3*LSB)
DA_condition2 = 0.01;         % 10 mV



%% Read data from txt file

cd (Datafolder);
fileID = fopen('FSCV_VOLTAGE_CHL.txt','r');  % aquired data from ADC
data = fscanf(fileID,'%f\n');
fclose(fileID);

len_data = length(data); % get length
data_s = smooth(data,5); % data_s = 958230 x 1 array

new_data_interp = interp1((1:1:len_data),data_s,(1:0.1:len_data),'spline'); % use interpolation -- new_data_interp = (958230*10) x 1 array

diff1 = 1.645 + diff(new_data_interp);

%% Find the averaging for the first PBS measurement

[Peak1, Peak_index1] = findpeaks(new_data_interp, 'MinPeakHeight', 2.33, 'MinPeakDistance', 10*(round((1/FSCV_frequency)*sampling_rate_ADC)-10));

%need waves that difference at tail is no larger than 0.02
num_of_PBS_cycles_collected = 0;
next = 0;
wave_difference_threshold = 0.02; % it's an observation 
usable_PBS_coordinates = zeros(1,5); % array to store 5 -usable- waveform's coordinates

while num_of_PBS_cycles_collected < NoCycle_PBS 
    
    Diff_local_index_PBS = Peak_index1(index_start + next) - (50 * 10);
    local_starting_points = diff1(Diff_local_index_PBS : Diff_local_index_PBS + (50 * 10));
    Find_index_start_PBS = find(local_starting_points > (1.645 + error)); % condition 1
    local_index_PBS = Find_index_start_PBS(1) - 1;
    
    % check condition 2 several time until it is satisfied:
    %     while (new_data_interp(Diff_local_index_PBS + local_index_PBS + 1) - new_data_interp(Diff_local_index_PBS + local_index_PBS)) < condition2
    %         local_index_PBS = local_index_PBS + 1;
    %     end
    
    %     check condition 2 once:
    if (new_data_interp (Diff_local_index_PBS + local_index_PBS + 1) - new_data_interp(Diff_local_index_PBS + local_index_PBS)) < condition2
        local_index_PBS = local_index_PBS + 1;
    end
    
    current_cycle_starting_pt = Diff_local_index_PBS + local_index_PBS;
    
    if usable_PBS_coordinates == 0
        usable_PBS_coordinates(1) = current_cycle_starting_pt;
        num_of_PBS_cycles_collected = num_of_PBS_cycles_collected + 1;
    elseif abs(new_data_interp(current_cycle_starting_pt + (Data_points - 1)) - new_data_interp(usable_PBS_coordinates(1) + (Data_points - 1))) < wave_difference_threshold % compare their last point's y-value
        num_of_PBS_cycles_collected = num_of_PBS_cycles_collected + 1;
        usable_PBS_coordinates(num_of_PBS_cycles_collected) = current_cycle_starting_pt;
    end
    
    next = next + 1;
    
end

 % align PBS cycles at the starting point:
 for i = 2: NoCycle_PBS
     cycle_offset = 0; % shift index
     
     % calibrate others to the 1st cycle
     
     while new_data_interp(usable_PBS_coordinates(i) + cycle_offset) > new_data_interp(usable_PBS_coordinates(1)) % if later one > calibrated one
         cycle_offset = cycle_offset - 1;
     end
     
     while new_data_interp(usable_PBS_coordinates(i) + cycle_offset ) < Voltage_Matrix_PBSX(1) % if <
         cycle_offset = cycle_offset + 1;
     end
     
     larger_point_index = usable_PBS_coordinates(i) + cycle_offset;
     smaller_point_index = usable_PBS_coordinates(i) + cycle_offset - 1;
     difference1 = new_data_interp(larger_point_index) - Voltage_Matrix_PBSX(1);
     difference2 =  Voltage_Matrix_PBSX(1) - new_data_interp(smaller_point_index);
     if (difference1) > (difference2)
         cycle_offset = cycle_offset - 1;
     end
     usable_PBS_coordinates(i) = usable_PBS_coordinates(i) + cycle_offset; %update every cycle
 end

% sum up PBS voltage:
    for i = 1: 1: NoCycle_PBS
       Voltage_Matrix_PBSX = Voltage_Matrix_PBSX + new_data_interp(usable_PBS_coordinates(i):usable_PBS_coordinates(i) + (Data_points - 1)); 
       
       % plot PBS cycles
       %        plot(new_data_interp(usable_PBS_coordinates(i):usable_PBS_coordinates(i) + (Data_points - 1)));
       %        hold on;
       
    end
    
% compute avg current:
Average_current_PBSX = (((Voltage_Matrix_PBSX / NoCycle_PBS) - vcom) * 1e9) / Rfb;

        

%% Find DA

for j = 1: 1: NoCycle_DA
    
    Diff_local_index = Peak_index1(start_index_DA + j) - (50 * 10); % start DA cycle #1
    DA = diff1(Diff_local_index : Diff_local_index + (50 * 10));
    Find_index_start = find(DA > (1.645 + error));  % condition 1
    local_index = Find_index_start(1) - 1; 
    
    % check condition 2 repeatedly until condition is satisfied:
    %     while (new_data_interp (Diff_local_index + local_index + 1) - new_data_interp (Diff_local_index + local_index)) < DA_condition2
    %         local_index = local_index + 1;
    %     end

    % align DA cycles:
    offset = 0; % shift index
    if (Voltage_Matrix_DAX) ~= 0 % not first loop
        
        while new_data_interp(Diff_local_index + local_index + offset ) > Voltage_Matrix_DAX(1) % if later one > calibrated one
            offset = offset - 1;
        end
        while new_data_interp(Diff_local_index + local_index + offset ) < Voltage_Matrix_DAX(1) % if <
            offset = offset + 1;
        end
        
        difference1 = new_data_interp(Diff_local_index + local_index + offset ) - Voltage_Matrix_DAX(1);
        difference2 =  Voltage_Matrix_DAX(1) - new_data_interp(Diff_local_index + local_index + offset -1);
        if (difference1) > (difference2)
            offset = offset -1;
        end
    end
    
    Voltage_Matrix_DAX = (Voltage_Matrix_DAX * (j-1) + new_data_interp((Diff_local_index + local_index + offset) : (Diff_local_index + local_index + (Data_points - 1 + offset))))/j;

%     plot DA cycles:
    plot(new_data_interp((Diff_local_index + local_index + offset) : (Diff_local_index + local_index + (Data_points - 1 + offset))));
    grid on;
    hold on;
    title('PBS/DA Cycle','FontSize',15,'FontWeight','bold')
    xlabel('Cycle Index','FontSize',15,'FontWeight','bold');
    ylabel('Voltage(V)','FontSize',15,'FontWeight','bold');

% separate one cycle into two parts 
%     Voltage_Matrix_DAX1 = (Voltage_Matrix_DAX1 * (j-1) + new_data_interp((Diff_local_index + local_index + offset -0) : (Diff_local_index + local_index + (Data_points/2 - 1 + offset -0 -0))))/j; % 1st num: whole shift; 2nd num: increase/decrease points in interval
%     Voltage_Matrix_DAX2 = (Voltage_Matrix_DAX2 * (j-1) + new_data_interp((Diff_local_index + local_index + Data_points/2 + offset -0 -0) : (Diff_local_index + local_index + (Data_points - 1 + offset -0))))/j;
%     Voltage_Matrix_DAX = cat(2,Voltage_Matrix_DAX1,Voltage_Matrix_DAX2);

end

Average_current_DAX = ((Voltage_Matrix_DAX - vcom) / Rfb) * 1e9;


%{
figure(32);
plot(Average_current_DAX);
hold on;
%plot(Average_current_PBSX);
xlabel('sample number','FontSize',15,'FontWeight','bold');
ylabel('Total current (nA)','FontSize',15,'FontWeight','bold');
grid on;
%}

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
% figure(19);
% plot(Average_current_DAX - Average_current_PBSX);
% xlabel('Sample number','FontSize',15,'FontWeight','bold');
% ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold');
% grid on;


% vaxisX = [-0.6:1.4/(Data_points/2):0.8-1.4/(Data_points/2)   0.8:-1.4/(Data_points/2):-0.6+1.4/(Data_points/2)] ;
% vaxis = vaxisX';
% 
% figure(21);
% plot(vaxis,smooth(Average_current_DAX), 'r-', vaxis,smooth(Average_current_PBSX), 'b-', 'LineWidth',2 )
% xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
% ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
% legend('Dopamine','PBS')
% grid minor;
% 
% 
% Substrated_currentX = (smooth(Average_current_DAX) - smooth(Average_current_PBSX));
% 
% figure(29)
% plot(vaxis, smooth(Substrated_currentX, 6),'r','LineWidth',2 )
% xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
% ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
% legend('Dopamine')
% grid on;
