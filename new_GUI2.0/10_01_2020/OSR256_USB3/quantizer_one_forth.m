function [data_out]=quantizer_one_forth(data_in)

data_out=zeros(length(data_in),1);
for i=1:length(data_in)
    data_out(i)=floor(data_in(i));
end

end
%{
function [data_out]=quantizer_one_forth(data_in)

data_out=zeros(length(data_in),1);
for i=1:length(data_in)
    data_ref=floor(data_in(i));
    delta_data=data_in(i)-data_ref;
    tmp0=round(8*delta_data);
    data_out(i)=data_ref+(tmp0/8);
end

end

function [data_out]=quantizer_one_forth(data_in)

data_out=zeros(length(data_in),1);
for i=1:length(data_in)
    data_ref=floor(data_in(i));
    delta_data=data_in(i)-data_ref;
    tmp0=round(4*delta_data);
    data_out(i)=data_ref+(tmp0/4);
end

end
%}