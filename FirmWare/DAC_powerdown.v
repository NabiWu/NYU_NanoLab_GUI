module DAC_powerdown
(
 reset,
 clk,
 clk_en,
 Din,
 Pattern,
 SYNC_bar,
 count1,
 count2,
 mark1
);

input       reset;
input       clk;
input       clk_en;
output      Din;
output      Pattern;
output      SYNC_bar;
output      count1;
output      count2;
//output      count3;
output      mark1;
//output      mark0;
//output      mark0_1;
//output      ind1;

reg  [31:0] Pattern;
reg  [15:0] Vbias_165;
reg  [15:0] Vbias_090;
//reg         SYNC_bar_reset;
reg         SYNC_bar;
//wire        SYNC_bar_1;
//reg         tmp1;
//reg  [5:0]  count1_reset;
reg  [5:0]  count1;
//wire [5:0]  count1_1;
//reg  [5:0]  tmp2;
//reg  [5:0]  count2_reset;
reg  [5:0]  count2;
//wire [5:0]  count2_1;
//reg  [5:0]  tmp3;
//reg  [5:0]  count3_reset;
//reg  [5:0]  count3;
//wire [5:0]  count3_1;
reg  [5:0]  count3_2;
//reg  [5:0]  tmp4;
//reg         mark0;
//reg         mark0_1;
//reg         mark1_reset;
reg         mark1;
//wire        mark1_1;
reg         Din;
wire        logic1;
wire        logic2;
wire        logic3;
wire        logic4;
wire        logic5;
//wire        reset_bar;

always@(posedge reset)
begin
  if(reset==1)
  begin
    Vbias_165       = 16'b0110100110011010;
    Vbias_090       = 16'b0011100110011010;
  end
end

assign logic1=(clk_en==1) && (mark1==0);
assign logic2=(count1==6'b000001);
assign logic3=(count1==6'b100010);
assign logic4=logic1 && logic2;
assign logic5=logic1 && logic3;
//assign reset_bar = ~reset;

always@(posedge clk or posedge reset)
begin
  if(reset==1)
  begin
    SYNC_bar = 1;
    count1   = 1;
  end
  else
  begin
    if(logic4)
    begin
      SYNC_bar = ~SYNC_bar;
    end
    if(logic5)
    begin
      count1 = 0;
    end
    if(logic1)
    begin
      count1 = count1+6'b000001;
    end
    if(mark1==1)
    begin
      SYNC_bar = 1;
    end
    if((count1 >= 6'd2) && (count1 < 6'd34))
    begin
      count3_2=33-count1;
      Din=Pattern[count3_2];
    end
  end
end

always@(posedge reset or posedge SYNC_bar)
begin
  if(reset==1)
  begin
    count2 = 1;
    mark1  = 0;
	 Pattern=32'b00001001000011000000000000000000;
  end
  else
  begin
    if(clk_en==1)
    begin
      case(count2)
        6'd1:Pattern={32'b00000100000000000000001111111111};
        //6'd1:Pattern={12'b000000110000,Vbias_165,4'b0000};
        //6'd2:Pattern={12'b000000110001,Vbias_165,4'b0000};
        //6'd3:Pattern={12'b000000110010,Vbias_165,4'b0000};
        //6'd4:Pattern={12'b000000110011,Vbias_165,4'b0000};
        //6'd5:Pattern={12'b000000110100,Vbias_165,4'b0000};
        //6'd6:Pattern={12'b000000110101,Vbias_165,4'b0000};
        //6'd7:Pattern={12'b000000110110,Vbias_165,4'b0000};
        //6'd8:Pattern={12'b000000110111,Vbias_165,4'b0000};
        default:Pattern=32'd0;
      endcase
      if(count2 > 6'd1)
      begin
        mark1=1;
      end
      else
      begin
        count2=count2+1;
      end
    end
  end
end
/*
always@(posedge clk)
begin
  if(clk_en==1)
  begin
    if(SYNC_bar==0)
    begin
      if((count1 >= 6'd2) && (count1 < 6'd34))
      begin
	     count3_2=count1 - 2;
        Din=Pattern[count3_2];
      end
    end
  end
end
*/
endmodule	