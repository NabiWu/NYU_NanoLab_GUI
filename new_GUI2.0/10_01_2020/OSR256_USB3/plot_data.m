fileID=fopen('FSCV_VOLTAGE_CHR2.txt','r');
% fileID=fopen('data_aquire_400_6.txt','r');
data=fscanf(fileID,'%f\n');
fclose(fileID);

A=data;

figure
plot(A);