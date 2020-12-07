function []=dataSave_FSCV(Rfeedback_L,Rfeedback_R,ReducedRate,Iref,ScanRate,Vcom,Vr_H,Vr_L,cycle_org,period)

%%  START DAQ SETUP  
daqreset;
FilePath=['/Users/apple/Desktop/Data_analysis'];

daqSession = daq.createSession('ni');
daqSession.IsContinuous = 1;
%addAnalogOutputChannel(daqSession,'Dev1',0,'Voltage');
addAnalogOutputChannel(daqSession,'Dev1',0:2,'Voltage');
ch0 = addAnalogInputChannel(daqSession,'Dev1',0,'voltage');
ch0.TerminalConfig = 'SingleEnded';
ch1 = addAnalogInputChannel(daqSession,'Dev1',1,'voltage');
ch1.TerminalConfig = 'SingleEnded';
daqSession.Rate=50000;
%daqSession.DurationInSeconds=3;
Sampling_rate=50000;
%sin_freq=10;
%sin_Vpp=1.8;
%sin_Voff=1.65;

%% generating sine wave output
%{
N = Sampling_rate/sin_freq;
VDAC = (sin_Vpp/2)*sin(((2*pi/N)*(1:(Sampling_rate/0.2))-(2*pi/N)))'+sin_Voff;
%VDAC = 10*ones((Sampling_rate/0.2),1);
queueOutputData(daqSession,VDAC);
%}

%% generating ramp signal

%ScanRate=0.1;%Unit:V/s
%Vcom=1.8;
%Vr=[-0.2 0.8];

%Lowest voltage
Vr_LL = Vr_L -(Vr_H-Vr_L)/2

%Voltage list
Vr=[Vr_L Vr_H Vr_LL];
%period=2*((Vr(2)-Vr(1))/ScanRate);%FSCV Ramp Period



%Seperate to three part with different time duration 
Ramp_duration1=((Vr(2)-Vr(1))/ScanRate)*1000;
Ramp_duration2=((Vr(2)-Vr(3))/ScanRate)*1000;
Ramp_duration3=((Vr(1)-Vr(3))/ScanRate)*1000;
total_duration = Ramp_duration1 +Ramp_duration2 + Ramp_duration3;

%three voltages on ramp1
ramp1_s=Vr(1)+Vcom;
ramp1_t=Vr(2)+Vcom;
ramp1_l=Vr(3)+Vcom;

%three voltages on ramp2
ramp2_s=2*Vr(1)+Vcom;
ramp2_t=2*Vr(2)+Vcom;
ramp2_l=2*Vr(3)+Vcom;


%Number of points in each part of ramp
N      =round((Ramp_duration1/1000)*Sampling_rate);
N2     =round((Ramp_duration2/1000)*Sampling_rate);
N3     =round((Ramp_duration3/1000)*Sampling_rate);
N_dc   =round(((1000*period-total_duration)/1000)*Sampling_rate);




%Voltage diff betweeen two points in ramp1 and ramp2
ramp1_step  =(ramp1_t-ramp1_s)/N;
ramp2_step  =(ramp2_t-ramp2_s)/N;




%Voltage background subtraction
V_sub  =(Iref/(10^9))*(Rfeedback_L*(10^6))*(1-1/ReducedRate);



%ramp1 and ramp2 performed in one cycle
ramp1=[linspace(ramp1_s,ramp1_t,(N+1)) linspace((ramp1_t-ramp1_step),ramp1_l, N2+1) linspace((ramp1_l-ramp1_step),ramp1_s,N3)  (Vcom+Vr(1))*ones(1,N_dc)]';
ramp2=[(linspace(ramp2_s,ramp2_t,(N+1))+V_sub) (linspace((ramp2_t-ramp2_step),ramp2_l,N2+1)-V_sub)  (linspace((ramp2_l-ramp2_step),ramp2_s,N3)-V_sub)   (Vcom+2*Vr(1))*ones(1,N_dc)]';








%VDAC = zeros(1,(Sampling_rate/0.1))';
ramp1tmp=ramp1;
ramp2tmp=ramp2;
%cycle_org=20;
cycle=cycle_org+2;
for(k1=1:(cycle-1))
    ramp1tmp=[ramp1tmp;ramp1];
    ramp2tmp=[ramp2tmp;ramp2];
end
Out1=[zeros(1*Sampling_rate,1);ramp1tmp;zeros(5*Sampling_rate,1)];
Out2=[zeros(1*Sampling_rate,1);ramp2tmp;zeros(5*Sampling_rate,1)];
Out3=[zeros(1*Sampling_rate,1);Vcom*ones((cycle*(N+N2+N3+N_dc+2)),1);zeros(5*Sampling_rate,1)];
VDAC = [Out1 Out2 Out3];
queueOutputData(daqSession,VDAC);
%startBackground(daqSession);
%trigger_static = 1;
%pause(1000*(2*N+N_dc)/Sampling_rate);
%daqSession.stop();

%% Continuous Data collection
%pause(5);
h = daqSession.addlistener('DataAvailable', @(src,event) SavePlot_FSCV(event));
daqSession.startBackground();
%wait(daqSession);
pause((round(cycle_org*period)+6));
daqSession.stop(); 

%% Clean up and release hardware

delete(h);
daqSession.release();
delete(daqSession);
clear daqSession;
%% plot data

pause(1);

fileID=fopen([FilePath 'data_aquire_L_FSCV.txt'],'r');
data_L=fscanf(fileID,'%f\n');
fclose(fileID);

fileID=fopen([FilePath 'data_aquire_R_FSCV.txt'],'r');
data_R=fscanf(fileID,'%f\n');
fclose(fileID);

fileID=fopen([FilePath 'ramp1_FSCV.txt'],'w');
fprintf(fileID,'%f\n', VDAC((1:length(data_L)),1));
fclose(fileID);

fileID=fopen([FilePath 'ramp2_FSCV.txt'],'w');
fprintf(fileID,'%f\n', VDAC((1:length(data_L)),2));
fclose(fileID);
%{
figure
plot((1:length(data_L))/Sampling_rate,data_L)

figure
plot((1:length(data_R))/Sampling_rate,data_R)
%}
figure
subplot(2,1,1)
plot((1:length(data_L))/Sampling_rate,data_L,(1:length(data_L))/Sampling_rate,VDAC((1:length(data_L)),1),(1:length(data_L))/Sampling_rate,VDAC((1:length(data_L)),2))
title('Left Channel Ramp & TIA1L')
xlabel('time(s)')
ylabel('Voltage')
subplot(2,1,2)
plot((1:length(data_R))/Sampling_rate,data_R,(1:length(data_R))/Sampling_rate,VDAC((1:length(data_R)),1),(1:length(data_R))/Sampling_rate,VDAC((1:length(data_R)),2))
title('Right Channel Ramp & TIA1R')
xlabel('time(s)')
ylabel('Voltage')

figure
subplot(2,1,1)
plot((1:length(data_L))/Sampling_rate,(((data_L-Vcom)/Rfeedback_L)*1000))
title('Left Channel Ramp & TIA1L')
xlabel('time(s)')
ylabel('TIA1 Current(nA)')
subplot(2,1,2)
plot((1:length(data_R))/Sampling_rate,(((data_R-Vcom)/Rfeedback_R)*1000))
title('Right Channel TIA1R')
xlabel('time(s)')
ylabel('TIA1 Current(nA)')
%% Plot Left Channel
%{
figure
plot((1:length(data_L))/Sampling_rate,data_L,(1:length(data_L))/Sampling_rate,VDAC((1:length(data_L)),1),(1:length(data_L))/Sampling_rate,VDAC((1:length(data_L)),2))
title('Left Channel Ramp & TIA2L')
xlabel('time(s)')
ylabel('Voltage')

figure
plot((1:length(data_L))/Sampling_rate,(((data_L-Vcom)/Rfeedback_L)*1000))
title('Left Channel Ramp & TIA2L')
xlabel('time(s)')
ylabel('TIA2 Current(nA)')
%% Plot Right Channel
figure
plot((1:length(data_R))/Sampling_rate,data_R,(1:length(data_R))/Sampling_rate,VDAC((1:length(data_R)),1),(1:length(data_R))/Sampling_rate,VDAC((1:length(data_R)),2))
title('Right Channel Ramp & TIA2R')
xlabel('time(s)')
ylabel('Voltage')

figure
plot((1:length(data_R))/Sampling_rate,(((data_R-Vcom)/Rfeedback_R)*1000))
title('Right Channel TIA2L')
xlabel('time(s)')
ylabel('TIA2 Current(nA)')
%}