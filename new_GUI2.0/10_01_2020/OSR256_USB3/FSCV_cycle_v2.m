function [data_FSCV, N_FSCV]=FSCV_cycle_v2(data, Fs, Period, ScanRate, Vr_H, Vr_L, tolerance_range, N_ok, p)

tmp_i0=(0.5/(abs(p(1))));
N_FSCV=ceil(((Vr_H-Vr_L)/ScanRate)*Fs);
N_period=round(Period*Fs);
[peaks_org, locs_org]=findpeaks(-diff(data), 'MinPeakHeight', tmp_i0, 'MinPeakDistance', round(N_period*0.9));
%N_cycle=round(Fs*Period); 
%Comp_Low=round(tolerance_range*N_cycle); 
%Comp_High=round((2-tolerance_range)*N_cycle);
locs_sync=locs_org(2:(length(locs_org)-1));
%peaks_sync=peaks_org(2:(length(locs_org)-1));
data_FSCV=[];
if length(locs_org)<3
    data_FSCV=[];
else
    for j=1:length(locs_sync)
        if data(locs_sync(j))<3.3
            data_FSCV=[data_FSCV (((data((locs_sync(j)-N_FSCV):(locs_sync(j)+N_FSCV)))-0)/1)];
        else
            data_FSCV=data_FSCV;
        end
    end
end

end