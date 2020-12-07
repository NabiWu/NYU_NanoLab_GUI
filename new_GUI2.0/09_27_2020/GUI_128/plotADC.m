fileID = fopen('FSCV_VOLTAGE_CHR2.txt','r');

formatSpec = '%f';
%sizeA = [2 Inf];
A = fscanf(fileID,formatSpec);
fclose(fileID);
plot(A)