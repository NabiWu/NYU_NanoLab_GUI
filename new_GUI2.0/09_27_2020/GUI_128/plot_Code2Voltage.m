fileID=fopen('UNKNOWN_RESULT_CHL.txt','r'); 
data_L=fscanf(fileID,'%f\n'); 
fclose(fileID); 
fileID=fopen('UNKNOWN_RESULT_CHR.txt','r'); 
data_R=fscanf(fileID,'%f\n'); 
fclose(fileID); 

data=[data_L data_R]; 
[m,n] = size(data); 
V_set=(5:1:28)'/10; 
%V_set=V_set.'; 
Fs=16000; 
Duration=5; 
Span_center=3; 
Span_range=2; 
Code=[]; 
p=[]; 
Name={'Left', 'Right'}; 

for k=1:n 

    [Code_tmp, p_tmp]=Code_To_Voltage(V_set,data(:,k),Fs,Span_center,Span_range,Duration); 
    Code=[Code Code_tmp]; 
    p=[p p_tmp]; 

    figure 
    plot(V_set,(V_set*p(1,k)+p(2,k)),'r')
    hold on
    plot(V_set,round(Code(:,k)),'LineStyle','none','Marker','*','MarkerFaceColor','b','MarkerSize',10) 
    hold off
    xlabel('Voltage') 
    ylabel('Code') 
    title(Name(k))
    axis([-inf inf -inf inf])
    grid minor
    
end 