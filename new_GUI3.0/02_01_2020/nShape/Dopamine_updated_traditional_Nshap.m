% Created by Ting Wu on 04/09/2016
% Modified by Ting Wu on 05/13/2016 (now could read multi sheet of the tdms file and do averaging)
% Need to change file name, Sensitivity, Sampling name and saveas file name

clc
clear all
close all
tic

disp('Code begins running...')

%% Define folder path and file name


dataFolderPath='C:\Users\kae-d\Desktop\NYU Chip 4 measurements_12062019\CM_N5A_68_C1\200Vs_10Hz_10ksa_ne0p2V_to_0p6V_N_G0dB_PBS_V4';
%File_name_I ='CM_N5A_9_C3260319_190906200nA_vern100p_1uM_400Vs_10Hz_ne_0p4_to_1p3_V2.tdms';
fileName_I = 'CM_N5A_68_C1_DA_0_200_10_ne0p2_po0p6_061219_140446_ch3Vol.txt';
fileName_V = 'CM_N5A_68_C1_DA_0_200_10_ne0p2_po0p6_061219_140446_ch4Vol.txt';
cd (dataFolderPath)
fileID_I = fopen(fileName_I);
data_I0 = fscanf(fileID_I,'%f\n');
vcom=-0.063
data_I=(data_I0-vcom)/4.1e6;

% Parasitic_200 = csvread('Parasitic_200.csv');

fclose(fileID_I);
fileID_V = fopen(fileName_V);
data_V = fscanf(fileID_V,'%f\n');
data_V = data_V-0;
fclose(fileID_V);

%Device=File_name1(1:end-5)
%Device=File_name1(1:end-5)

%% Define parameters
%Max_sensitivity=200e-9;
%Percent=100e-2;
%Sensitivity=Max_sensitivity/Percent;

Sampling_rate=2500000/250;
Voltage_High=0.6;
Voltage_Low=-0.2;
% Voltage_hold=-0.02;
Voltage_hold=-0.05;
% Voltage_hold=-0.0;
Ramp_rate=200;
FSCV_frequency=10;
%Duration=((Voltage_High-Voltage_hold)+(-Voltage_Low-Voltage_hold)+(Voltage_High-Voltage_Low-8*Voltage_hold))/Ramp_rate;
Duration=(Voltage_High-Voltage_Low)/Ramp_rate*2;
First_cycle_PBS=80;  %first background cycle for current subtraction 
N_cycle_PBS=30;

First_cycle_DA=400;  %first DA cycle for current subtraction
N_cycle_DA=10;

%% Read data from tdms file
% cd (Datafolder)
% [Data_cell1]=ReadFile4(Datafolder, File_name1);
% [Data_cell2]=ReadFile4(Datafolder, File_name2);

% FSCV_PBS_data1=Data_cell1{1,1};
% FSCV_DA_data1=Data_cell1{1,1};
% 
% 
% FSCV_current_PBS=smooth(FSCV_PBS_data1(:,1))*Sensitivity;
% FSCV_voltage_PBS=smooth(FSCV_PBS_data1(:,2));
% 
% 
% FSCV_current_Dopamine=smooth(FSCV_DA_data1(:,1))*Sensitivity;
% FSCV_voltage_Dopamine=smooth(FSCV_DA_data1(:,2));


% FSCV_current_Dopamine=smooth(data_I);
% FSCV_voltage_Dopamine=smooth(data_V);
% 
% FSCV_current_PBS=smooth(data_I);
% FSCV_voltage_PBS=smooth(data_V);
% 
FSCV_current_PBS=(data_I);
FSCV_voltage_PBS=(data_V);

FSCV_current_Dopamine=(data_I);
FSCV_voltage_Dopamine=(data_V);



%% Find the averaging for the first PBS measurement

%Find all the peak 
%[Peak, Peak_index]=findpeaks(FSCV_voltage_PBS, 'MinPeakHeight', 0.7, 'MinPeakDistance', round(1/FSCV_frequency*Sampling_rate)-100);
[Peak, Peak_index]=findpeaks((FSCV_voltage_PBS), 'MinPeakHeight', 0.3, 'MinPeakDistance', round(1/FSCV_frequency*Sampling_rate)-100);


% Generate a matrix of all the cycles
NumOfCycle=length(Peak_index);
Last_Cycle_Index=Peak_index(end-1)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index(end-1)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
Voltage_single_cycle_PBS=FSCV_voltage_PBS(Last_Cycle_Index);

M=4;

N_PBS=NumOfCycle-5;
M_PBS=NumOfCycle-1;

Current_Matrix_PBS=[];
Voltage_Matrix_PBS=[];

    
for i=First_cycle_PBS:(First_cycle_PBS+N_cycle_PBS) %N_PBS: M_PBS    
   
    One_Cycle_Index=Peak_index(i)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index(i)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
    Current_single_cycle=FSCV_current_PBS(One_Cycle_Index)';
    Voltage_single_cycle=FSCV_voltage_PBS(One_Cycle_Index)';
    
    Current_Matrix_PBS=[Current_Matrix_PBS;Current_single_cycle];
    Voltage_Matrix_PBS=[Voltage_Matrix_PBS;Voltage_single_cycle];
    
   
    Current_Matrix_PBS_Plot=reshape(Current_Matrix_PBS', numel(Current_Matrix_PBS),1);
    Voltage_Matrix_PBS_Plot=reshape(Voltage_Matrix_PBS', numel(Voltage_Matrix_PBS),1);
end
    Average_current_PBS=mean(Current_Matrix_PBS);
    
    
 %% Find the averaging for the dopamine measurement    
%Find all the peak 
%[Peak_DA, Peak_index_DA]=findpeaks(FSCV_voltage_Dopamine, 'MinPeakHeight', 0.6, 'MinPeakDistance', 1/FSCV_frequency*Sampling_rate-100);

[Peak_DA, Peak_index_DA]=findpeaks((FSCV_voltage_Dopamine), 'MinPeakHeight', 0.3, 'MinPeakDistance', 1/FSCV_frequency*Sampling_rate-100);

% Generate a matrix of all the cycles
NumOfCycle_DA=length(Peak_index_DA);
Last_Cycle_Index_DA=Peak_index_DA(end-1)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index_DA(end-1)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
Voltage_single_cycle_Dopamine=FSCV_voltage_Dopamine(Last_Cycle_Index_DA);


N_DA=NumOfCycle_DA-5;
M_DA=NumOfCycle_DA-1;

Current_Matrix_Dopamine=[];
Voltage_Matrix_Dopamine=[];



for i = First_cycle_DA:(First_cycle_DA+N_cycle_DA) %N_DA:M_DA

    One_Cycle_Index_DA=Peak_index_DA(i)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index_DA(i)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
    Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
    Voltage_single_cycle_DA=FSCV_voltage_Dopamine(One_Cycle_Index_DA)';

    Current_Matrix_Dopamine=[Current_Matrix_Dopamine;Current_single_cycle_DA];
    Voltage_Matrix_Dopamine=[Voltage_Matrix_Dopamine;Voltage_single_cycle_DA];

    Current_Matrix_Dopamine_Plot=reshape(Current_Matrix_Dopamine', numel(Current_Matrix_Dopamine),1);
    Voltage_Matrix_Dopamine_Plot=reshape(Voltage_Matrix_Dopamine', numel(Voltage_Matrix_Dopamine),1);
end
    Average_current_Dopamine=mean(Current_Matrix_Dopamine);

   
%% Calculate the substracted current    
    Substrated_current=Average_current_Dopamine-Average_current_PBS;
%%
    
    %%Find peak positions
Peak_current_matrix_ox=[]; %oxidation peak
Peak_current_matrix_r1=[]; %first reduction peak
Peak_current_matrix_r2=[]; %second reduction peak 
Voltage_matrix=[];
Subtracted_current_matrix=[];
sub_matrix=[];

for j=1:1:NumOfCycle_DA-1    
    
    One_Cycle_Index_DA=Peak_index_DA(j)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index_DA(j)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
    Current_single_cycle_DA=FSCV_current_Dopamine(One_Cycle_Index_DA)';
    Voltage_single_cycle_DA=FSCV_voltage_Dopamine(One_Cycle_Index_DA)';

    Subtracted_current_single_cycle=Current_single_cycle_DA-Current_single_cycle;
    sub_matrix=[sub_matrix;Subtracted_current_single_cycle];
    
    %%Index_low=find (Voltage_single_cycle_DA>0.34 & Voltage_single_cycle_DA<0.5);
    Index_low_ox=find (Voltage_single_cycle_DA>0.2 & Voltage_single_cycle_DA<0.45);
    Index_low_r1=find (Voltage_single_cycle_DA>-0.1 & Voltage_single_cycle_DA<0.1);
    Index_low_r2=find (Voltage_single_cycle_DA>0.1 & Voltage_single_cycle_DA<0.3);
    
    Subtracted_current_local_ox=Subtracted_current_single_cycle(Index_low_ox)*1e9;
    Subtracted_current_local_r1=Subtracted_current_single_cycle(Index_low_r1)*1e9*-1;
    Subtracted_current_local_r2=Subtracted_current_single_cycle(Index_low_r2)*1e9*-1;
    
   Peak_current_ox=max(Subtracted_current_local_ox);
   Peak_current_r1=max(Subtracted_current_local_r1);
   Peak_current_r2=max(Subtracted_current_local_r2);
   
    Peak_current_matrix_ox=[Peak_current_matrix_ox;Peak_current_ox];
    Peak_current_matrix_r1=[Peak_current_matrix_r1;Peak_current_r1];
    Peak_current_matrix_r2=[Peak_current_matrix_r2;Peak_current_r2];
    
    Subtracted_current_matrix=[Subtracted_current_matrix;Subtracted_current_single_cycle'];
    Subtracted_current_matrix_Plot=reshape(Subtracted_current_matrix', numel(Subtracted_current_matrix),1);
    
    Voltage_matrix=[Voltage_matrix;Voltage_single_cycle_DA'];
    Voltage_matrix_Plot=reshape(Voltage_matrix', numel(Voltage_matrix),1);

end

%%


figure('color','w','position',[66 107 1750 857]);
subplot(2,3,1)
%figure(1)
plot(Voltage_Matrix_Dopamine_Plot, Current_Matrix_Dopamine_Plot*10^9,'r-',Voltage_Matrix_PBS_Plot, Current_Matrix_PBS_Plot*10^9, 'b-','LineWidth',2 )
xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
    
    
    
%figure(2)    
subplot(2,3,2)
plot(Voltage_single_cycle_Dopamine', Average_current_Dopamine*10^9,'r',Voltage_single_cycle_PBS, Average_current_PBS*10^9, 'b','LineWidth',2 )
xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
Average=(Average_current_Dopamine*10^9)';
AveragePBS=(Average_current_PBS*10^9)';
D=diff(Average);
DPBS=diff(AveragePBS);
D2=diff(D);
DPBS2=(diff(DPBS));

%figure(3)
subplot(2,3,3)
plot(Voltage_single_cycle_Dopamine', Substrated_current*10^9,'r','LineWidth',2 )
xlabel('FSCV voltage (V)','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
Sub=(Substrated_current*10^9)';


%figure(4)
subplot(2,3,4)
plot(Peak_current_matrix_ox,'r','LineWidth',2)
%ylim([0 100]);
xlabel('Number of samples','FontSize',15,'FontWeight','bold')
ylabel('Peak ox (nA)','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')

grid minor;

%figure(5)
subplot(2,3,5)
plot(Peak_current_matrix_r1,'r','LineWidth',2)
%ylim([0 100]);
xlabel('Number of samples','FontSize',15,'FontWeight','bold')
ylabel('Peak R1 (nA)','FontSize',15,'FontWeight','bold')

grid minor;


%figure(6)
subplot(2,3,6)

plot(Peak_current_matrix_r2,'r','LineWidth',2)
%ylim([0 100]);
xlabel('Number of samples','FontSize',15,'FontWeight','bold')
ylabel('Peak R2 (nA)','FontSize',15,'FontWeight','bold')

grid minor;


%%
figure('color','w','position',[66 107 1750 857]);
subplot(2,3,1)
%figure(1)
length_sub=length(Substrated_current);
Time=(1:length_sub)/length_sub*(Voltage_High-Voltage_Low)/Ramp_rate*2*1e3;
for i=1:N_cycle_DA
plot(Time, Current_Matrix_Dopamine(i,:)*10^9,'r','LineWidth',2)
hold on
end
for i=1:N_cycle_PBS
plot(Time, Current_Matrix_PBS(i,:)*10^9, 'b-','LineWidth',2)
hold on
end
xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
    
    
    
%figure(2)    
subplot(2,3,2)
plot(Time, Average_current_Dopamine*10^9,'r',Time, Average_current_PBS*10^9, 'b','LineWidth',2 )
xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
ylabel('Total current(nA)','FontSize',15,'FontWeight','bold')
% title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
Average=(Average_current_Dopamine*10^9)';
AveragePBS=(Average_current_PBS*10^9)';
D=diff(Average);
DPBS=diff(AveragePBS);
D2=diff(D);
DPBS2=(diff(DPBS));

%figure(3)
subplot(2,3,3)
plot(Time, Substrated_current*10^9,'r','LineWidth',2 )
xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
ylabel('Electrochemical current(nA)','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')
legend('Dopamine','PBS')
grid minor;
Sub=(Substrated_current*10^9)';

%figure(4)
subplot(2,3,4)
plot(Voltage_single_cycle_PBS ,Time,'r','LineWidth',2 )
xlabel('FSCV voltage (V))','FontSize',15,'FontWeight','bold')
ylabel('Time (ms','FontSize',15,'FontWeight','bold')
%title(Device,'FontSize',15,'FontWeight','bold')

grid minor;
Sub=(Substrated_current*10^9)';

%-------------------------- heat map 
% %figure(4)
% subplot(2,2,4)
% Total_length=length(Peak_current_matrix_ox);
% Time_1=(1:Total_length)*1/FSCV_frequency;
% Current=sub_matrix'*10^9;
% [X,Y] = meshgrid(Time_1,Time);
% contourf(X,Y,Current,100,'lineStyle','none')
% colorbar
% c.Label.String = 'Label Text Goes Here';
% xlabel('Time (s)','FontSize',15,'FontWeight','bold')
% ylabel('Time single cycle (mS)','FontSize',15,'FontWeight','bold')
% zlabel('Electrochemical_current(na)','FontSize',15,'FontWeight','bold')

%-------------------------- 



% %figure(5)
% subplot(2,3,5)
% plot(Peak_current_matrix_r1,'r','LineWidth',2)
% %ylim([0 100]);
% xlabel('Number of samples','FontSize',15,'FontWeight','bold')
% ylabel('Peak R1 (nA)','FontSize',15,'FontWeight','bold')
% 
% grid minor;

%peak current versus time

%plot(Time_peak_current,Peak_current_matrix*10^9,'r','LineWidth',2)
% xlabel('Time (sec)','FontSize',15,'FontWeight','bold')
% ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')
% grid minor;

% %figure(6)
% subplot(2,3,6)
% 
% plot(Peak_current_matrix_r2,'r','LineWidth',2)
% %ylim([0 100]);
% xlabel('Number of samples','FontSize',15,'FontWeight','bold')
% ylabel('Peak R2 (nA)','FontSize',15,'FontWeight','bold')
% 
% grid minor;
%% redox current versus time
% length_sub=length(Substrated_current);
% Time=(1:length_sub)/length_sub*(Voltage_High-Voltage_Low)/Ramp_rate*2*1e3;
% plot(Time, Substrated_current*10^9, 'r')
% %title(Device,'FontSize',15,'FontWeight','bold')
% xlabel('Time (ms)','FontSize',15,'FontWeight','bold')
% ylabel('Electrochemical Current (nA)','FontSize',15,'FontWeight','bold')


%% making contour plot of the background subtracted current 
% 
% Time_Matrix=[];
% for i = 1:NumOfCycle-1  
% %  
%        One_Cycle_Index_sub=Peak_index(i)-round(Duration*(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low))*Sampling_rate):1:Peak_index(i)+round(Duration*(1-(Voltage_High-Voltage_hold)/(2*(Voltage_High-Voltage_Low)))*Sampling_rate);
%        Time_single_cycle=One_Cycle_Index_sub*length(One_Cycle_Index_sub)/20000;
%        Time_Matrix=[Time_Matrix; Time_single_cycle'];
%        Time_Matrix_Plot=reshape(Time_Matrix', numel(Time_Matrix),1);
% 
% end

% [X,Y,Z]=meshgrid(Time_Matrix_Plot,Voltage_matrix_Plot,Subtracted_current_matrix_Plot); 
% contourf(X,Y,Z,100,'lineStyle','none');

%%

summary=[Voltage_matrix,Subtracted_current_matrix];
fid=fopen('current_matrix1.txt','w');
fprintf(fid, 'Voltage\tPeak current\t\r\n');
[m,n]=size(summary);
for i=1:m
    fprintf(fid, '%f\t%f\t\r\n',summary(i,:));
end
fclose(fid);
%T=(Time)';


% dlmwrite('Voltage_Matrix_Dopamine_Plot_D4.csv',Voltage_Matrix_Dopamine_Plot);
% dlmwrite(' Current_Matrix_Dopamine_Plot_D4.csv', Current_Matrix_Dopamine_Plot*10^9);
% 
% dlmwrite('Voltage_Matrix_PBS_Plot_D4.csv',Voltage_Matrix_PBS_Plot);
% dlmwrite('Current_Matrix_PBS_Plot_D4.csv',Current_Matrix_PBS_Plot*10^9);
% 
% 
% dlmwrite('Voltage_single_cycle_Dopamine_D4.csv',Voltage_single_cycle_Dopamine');
% dlmwrite('Average_current_Dopamine_D4.csv',Average_current_Dopamine*10^9);
% dlmwrite('Voltage_single_cycle_PBS_D4.csv',Voltage_single_cycle_PBS);
% dlmwrite(' Average_current_PBS_D4.csv', Average_current_PBS*10^9);
% 
% dlmwrite('Time_peak_current_D4.csv',Time_peak_current);
% dlmwrite('Peak_current_matrix_D4.csv',Peak_current_matrix*10^9);
% 
%  dlmwrite('time_D4.csv',Time);
% dlmwrite('Substrated_current_D4.csv',Substrated_current);

    
