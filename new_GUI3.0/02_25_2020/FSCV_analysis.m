clc;
clear all;
close all;

tic
digits(32)
%% Define folder path and file name

Datafolder='C:\Users\kae-d\Desktop\GGUI\Data';
save_file_name ='SF1-8_C2_10Hz_20K_50_15percent_1103_400_extended_2uMDA_after_pretreatment_V1.csv';
Device='CM_N5A_64_C2_C6 10Hz 200V/s 2uM DA';

%% Define parameters

Voltage_High=0.6; % V
Voltage_Low=-0.2; % V
Ramp_rate=200; % V/s
vcom=-0.062; % V
Rfb=4.1e6; % (Ohm)

% offset_DA =410
% offset_PBS=410

FSCV_frequency=10; % (Hz) or 0.1s
Duration=2*(Voltage_High-Voltage_Low)/Ramp_rate; % 12 (ms)

OSR=250;
sampling_rate_ADC=2.5e6/(1*OSR); % (Hz)
Data_points=Duration*sampling_rate_ADC;
%% Read data from txt file
cd (Datafolder)
% Data_cell1 = csvread(save_file_name);
fileID=fopen('CM_N5A_57_C1_DA_2_200_10_ne0p4_po1p3_210220_220731_ch4Vol.txt','r');  % aquired data from ADC

A=fscanf(fileID,'%f\n');
fclose(fileID);

data_s=A;
diff_data=diff(A);
diff_peak=find(diff_data> 0.05);
% data_s=smooth(data,'sgolay');
% data_s=smooth(data,5);
% data_s=smooth(data,5,'lowess');
% data=smooth(data);

FSCV_PBS_data1=data_s;
FSCV_DA_data1=data_s;

[Peak1, Peak_index1]=findpeaks(data_s, 'MinPeakHeight', 0.55, 'MinPeakDistance',round(1/FSCV_frequency*sampling_rate_ADC)-10);
peakInterval = diff(Peak_index1);
NOCycle=length(Peak_index1);

%% Correct the indecies of the maximum sampled ramp voltage 

for i=[1:(NOCycle)]
% Peak_index1(i)=((46)+1000*(i-1));  %the index represents the starting point of each cycle
Peak_index1(i)=(Peak_index1(1)+1000*(i-1));  %the index represents the starting point of each cycle
end  
offset_DA =Peak_index1(1)- diff_peak(1)
offset_PBS=offset_DA


%%

half_period_num=round(Duration*sampling_rate_ADC/2);

FSCV_current_PBS=(FSCV_PBS_data1-vcom)/Rfb;
% FSCV_current_PBS=smooth((FSCV_PBS_data1-vcom)/Rfb);
% FSCV_voltage_PBS=ramp1;
%FSCV_voltage_PBS=smooth(FSCV_PBS_data1);

FSCV_current_Dopamine=((FSCV_DA_data1-vcom)/Rfb);
% FSCV_current_Dopamine=smooth((FSCV_DA_data1-vcom)/Rfb);
% FSCV_voltage_Dopamine=ramp1;
%FSCV_voltage_Dopamine=smooth(FSCV_DA_data1);

% for(i=initial:(initial+N_total-1))
%     data_tmp=data((Peak_index1(i)-half_period_num):(Peak_index1(i)+half_period_num));
%     data_PBS=data_PBS+data_tmp;
% end

% data_voltage=data_PBS/N_total;
% data_current=(data_voltage-vcom)/(Rfb);

%% Find the averaging for the first PBS measurement

%Find all the peak 
% [Peak, Peak_index]=findpeaks(FSCV_voltage_PBS, 'MinPeakHeight', 1.15, 'MinPeakDistance', round(1/FSCV_frequency*Sampling_rate)-100);

% Generate a matrix of all the cycles
NumOfCycle=length(Peak_index1);
% Last_Cycle_Index=(Peak_index1(end-1)-half_period_num):1:(Peak_index1(end-1)+half_period_num);
% Voltage_single_cycle_PBS=FSCV_voltage_PBS(Last_Cycle_Index);

% M=4;
% 
% N_PBS=NumOfCycle-5;
% M_PBS=NumOfCycle-1;

Current_Matrix_PBS=[];
Voltage_Matrix_PBS=[];
% for i=110:140  

for i=180:210  

%     One_Cycle_Index=(Peak_index1(i)-half_period_num):1:((Peak_index1(i)+half_period_num)-1);
%         One_Cycle_Index=(Peak_index1(i)-10):1:((Peak_index1(i)+2*half_period_num)-1-10);
    One_Cycle_Index=(Peak_index1(i)-offset_PBS):(Peak_index1(i)+round(Data_points)-offset_PBS-1);
   
    
    Current_single_cycle=FSCV_current_PBS(One_Cycle_Index)';
    
%     [Peak2, Peak_index2]=findpeaks(Current_single_cycle*10^9, 'MinPeakHeight',200e-9, 'MinPeakDistance',185);

%     Voltage_single_cycle=FSCV_voltage_PBS(One_Cycle_Index)';
    
    Current_Matrix_PBS=[Current_Matrix_PBS;Current_single_cycle];
%     Voltage_Matrix_PBS=[Voltage_Matrix_PBS;Voltage_single_cycle];
   
%     Current_Matrix_PBS_Plot=reshape(Current_Matrix_PBS', numel(Current_Matrix_PBS),1);
%     Voltage_Matrix_PBS_Plot=reshape(Voltage_Matrix_PBS', numel(Voltage_Matrix_PBS),1);
end
Average_current_PBS=mean(Current_Matrix_PBS);
% Average_current_PBS=(Current_Matrix_PBS);


% data_tmp=[]
% data2=0
%     for l=161:165
%             One_Cycle_Index2=(Peak_index1(l)-offset_PBS):(Peak_index1(l)+round(Data_points)-offset_PBS-1);
% 
%     data_tmp=FSCV_current_PBS(One_Cycle_Index2)';
%     data2=data2+data_tmp;
% %     data1=[data1 data_tmp];
% end
% 
%   Average_current_PBS=data2/5;
  
    
%% Find the averaging for the DA measurement    
%Find all the peak 
% [Peak_DA, Peak_index_DA]=findpeaks(FSCV_voltage_Dopamine, 'MinPeakHeight', 1.15, 'MinPeakDistance', 1/FSCV_frequency*Sampling_rate-100);

% Generate a matrix of all the cycles
NumOfCycle_DA=length(Peak_index1);
% Last_Cycle_Index_DA=Peak_index1(end-1)-round(1/2/FSCV_frequency*sampling_rate_ADC):1:Peak_index1(end-1)+round(1/2/FSCV_frequency*sampling_rate_ADC);

% Last_Cycle_Index_DA=(Peak_index1(end-1)-half_period_num):1:(Peak_index1(end-1)+half_period_num);

% Last_Cycle_Index=(Peak_index1(end-1)-half_period_num):1:(Peak_index1(end-1)+half_period_num);
% Voltage_single_cycle_Dopamine=FSCV_voltage_Dopamine(Last_Cycle_Index_DA);

% N_DA=NumOfCycle_DA-5;
% M_DA=NumOfCycle_DA-1;

Current_Matrix_Dopamine=[];
Voltage_Matrix_Dopamine=[];
for i = 570:590 % dopamine cycles
% for i = 530:540 % dopamine cycles
%     One_Cycle_Index_DA=Peak_index1(i)-round(1/2/FSCV_frequency*sampling_rate_ADC):1:Peak_index1(i)+round(1/2/FSCV_frequency*sampling_rate_ADC);
   
%     One_Cycle_Index_DA=Peak_index1(i)-round(Duration/2*sampling_rate_ADC):1:Peak_index1(i)+round(Duration/2*sampling_rate_ADC);

    One_Cycle_Index_DA=(Peak_index1(i)-offset_DA):1:(Peak_index1(i)+round(Data_points)-offset_DA-1);
    
    Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
%     Voltage_single_cycle_DA=FSCV_voltage_Dopamine(One_Cycle_Index_DA)';

%     Current_Matrix_Dopamine=[Current_Matrix_Dopamine;Current_single_cycle_DA];
    Current_Matrix_Dopamine=[Current_Matrix_Dopamine;Current_single_cycle_DA];

%     Voltage_Matrix_Dopamine=[Voltage_Matrix_Dopamine;Voltage_single_cycle_DA];

%     Current_Matrix_Dopamine_Plot=reshape(Current_Matrix_Dopamine', numel(Current_Matrix_Dopamine),1);
%     Voltage_Matrix_Dopamine_Plot=reshape(Voltage_Matrix_Dopamine', numel(Voltage_Matrix_Dopamine),1);
end
    Average_current_DA=mean(Current_Matrix_Dopamine);
%     Average_current_DA=(Current_Matrix_Dopamine);


%     data1=0
% %         for(i=initial:(initial+N_total-1))
%     for k=440:441
%             One_Cycle_Index1=(Peak_index1(k)-offset_DA):1:(Peak_index1(k)+round(Data_points)-offset_DA-1);
% 
%     data_tmp=FSCV_current_Dopamine(One_Cycle_Index1)';
%     data1=data1+data_tmp;
% %     data1=[data1 data_tmp];
% end
% 
%   Average_current_DA=data1/2;
% data_current=(data_voltage-1.7888)/(Rfb);
    
%% Calculate the substracted current    
%     Substrated_current=smooth(smooth((Average_current_Dopamine-Average_current_PBS),100),10);
%Substrated_current=smooth(Average_current_PBS-Average_current_Dopamine);
    Substrated_current=(Average_current_DA-Average_current_PBS);
Peak_current_matrix=[];
% Voltage_matrix=[];
Subtracted_current_matrix=[];
pluss=0;

for j=4:1:(NumOfCycle_DA-10)   
    
    if((Peak_index1(j)-round(Duration/2*sampling_rate_ADC))==0)
        pluss=1;
    else
        pluss=0;
    end
%     One_Cycle_Index_DA=(Peak_index1(j)-round(Duration/2*sampling_rate_ADC)+pluss):1:(Peak_index1(j)+round(Duration/2*sampling_rate_ADC)+pluss);
    

    One_Cycle_Index_DA=(Peak_index1(j)-offset_DA):1:(Peak_index1(j)+round(Data_points)-offset_DA-1);
%     One_Cycle_Index_DA=(Peak_index1(i)-offset_DA):1:(Peak_index1(i)+round(Data_points)-offset_DA-1);

    
    Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
%     Voltage_single_cycle_DA=FSCV_voltage_Dopamine(One_Cycle_Index_DA)';
    
    Subtracted_current_single_cycle=Current_single_cycle_DA-Current_single_cycle;

%     Index_low=find (Voltage_single_cycle_DA>2.25 & Voltage_single_cycle_DA<2.3);
%          Index_low=[40:80];


     Index_low=[15:38];
    Subtracted_current_local=Subtracted_current_single_cycle(Index_low);
    
    Peak_current=max(Subtracted_current_local);
    
    Peak_current_matrix=[Peak_current_matrix Peak_current];
    Subtracted_current_matrix=[Subtracted_current_matrix Subtracted_current_single_cycle'];
%     Voltage_matrix=[Voltage_matrix Voltage_single_cycle_DA'];
  
end

period=Data_points;  
vaxis = [-0.2:0.8/(Data_points/2):0.6-0.8/(Data_points/2)   0.6:-0.8/(Data_points/2):-0.2+0.8/(Data_points/2)] ;
vaxis=vaxis';
% vaxis2=[vaxis' vaxis']';
% Plotting more data

% figure(1)

subplot(2,3,1)
plot(vaxis, (Current_Matrix_Dopamine')*10^9,'r-',vaxis,(Current_Matrix_PBS')*10^9, 'b-','LineWidth',2 )
xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
   
% figure(2)    
subplot(2,3,2)
plot(vaxis, (Average_current_DA)*10^9,'r',vaxis,(Average_current_PBS)*10^9, 'b','LineWidth',2 )
xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid on;

% figure(3)
subplot(2,3,3)
plot(vaxis, (Substrated_current)*10^9,'r','LineWidth',2 )

xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine')
grid on;

% figure(4)
subplot(2,3,4)
plot((Peak_current_matrix)*10^9,'r','LineWidth',2)
%ylim([0 100]);
xlabel('Number of samples','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
grid minor;

% figure(5)
subplot(2,3,5)
Total_length=length(Peak_current_matrix);
Time_peak_current=(1:Total_length)*1/FSCV_frequency;

% plot(Time_peak_current,(smooth(Peak_current_matrix,50)*10^9-0),'r','LineWidth',2)
plot(Time_peak_current,Peak_current_matrix*10^9,'r','LineWidth',2)

%ylim([0 100]);
xlabel('Time (sec)','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
grid on;

% figure(6)
subplot(2,3,6)
length_sub=length(Substrated_current);
Time=(1:length_sub)/length_sub*(Voltage_High-Voltage_Low)/Ramp_rate*2*1e3;
plot(Time, (Substrated_current)*10^9, 'r')
% title(Device,'FontSize',15,'FontWeight','bold')
xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')

% figure(7)
% % length_vol=length(FSCV_voltage_PBS);
% length_vol=138;
% Time=(1:length_vol)*1/Sampling_rate;
% plot(Time,vaxis, 'r')
% title(Device,'FontSize',15,'FontWeight','bold')
% xlabel('Time (s)','FontSize',15,'FontWeight','bold')
% ylabel('FSCV voltage (V-)','FontSize',15,'FontWeight','bold')

 
% %% Heatmap
%  figure(8)
% imagesc(Subtracted_current_matrix);
% set(gca, 'YDir', 'normal');
% colormap('jet');
% colorbar;
% 
% ylim = get(gca,'YLim');
% set(gca,'YTick',linspace(ylim(1),ylim(2),3));
% set(gca,'YTickLabel',[Voltage_Low, Voltage_High, Voltage_Low]);
% ylabel('Potential (V)')
% 
% Total_length=length(Peak_current_matrix);
% Time_peak_current=(1:Total_length)*1/FSCV_frequency; 
% 
% xlim = get(gca,'XLim');
% set(gca, 'XTick', linspace(xlim(1),xlim(2),5))
% set(gca,'XTickLabel', linspace(round(Time_peak_current(1)),round(Time_peak_current(end)),5))
% 
% xlabel('Time (seconds)');
% 
% title('Heatmap: Subtracted Current in nA')


% summary=[Voltage_matrix,Subtracted_current_matrix];
% fid=fopen('current_matrix1.txt','w');
% fprintf(fid, 'Voltage\tPeak current\t\r\n');
% [m,n]=size(summary);
% for i=1:m
%     fprintf(fid, '%f\t%f\t\r\n',summary(i,:));
% end
% fclose(fid);



    
