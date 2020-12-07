function [Code, p]=Code_To_Voltage(V_x,data,Fs,Span_center,Span_range,Duration) 

assignin('base', 'V_x', V_x)
assignin('base', 'data', data)
assignin('base', 'Fs', Fs)
assignin('base', 'Span_center',Span_center)
assignin('base', 'Span_range',Span_range)
assignin('base', 'Duration',Duration)


    Code=[]; 
    N_center=(Duration-Span_center)*Fs; 
    N_center1=Span_center*Fs; 
    N_span=(Span_range/2)*Fs; 
    tmp0=-diff(round(data)); 
    
    figure;
    plot(tmp0);
    %tmp0=-round(data);
    length_x=length(V_x); 
    [peaks, locs]=findpeaks(tmp0,'MinPeakDistance',round(Duration*Fs*0.9),'MinPeakHeight',1);
    length_locs = length(locs);
    disp(length_x);
    disp(length_locs);
    
    for i=1:length_x 
        if(i<length_x) 
            tmp=locs(i)-N_center; 
            tmp1=mean(data(floor(tmp-N_span):floor(tmp+N_span))); 
            Code=[Code; tmp1]; 
        else 
            tmp=locs(i-1)+N_center1; 
            tmp1=mean(data(floor(tmp-N_span):floor(tmp+N_span))); 
            Code=[Code; tmp1]; 
        end 
    end 
    p = polyfit(V_x,Code,1); 
    p = p';
    
end