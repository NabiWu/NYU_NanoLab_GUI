module diff_3rd
          (
           clk,
           reset,
           clk_enable,
           xin,
           yout
          );
			 
  input   clk;
  input   reset;
  input   clk_enable;
  input   signed [50:0] xin;  // sfix24
  output  signed [50:0] yout;  // sfix24


  reg signed [50:0] y1;  // sfix24
  reg signed [50:0] y2;  // sfix24
  reg signed [50:0] y3;  // sfix24
  reg signed [50:0] tmp1;  // sfix24
  reg signed [50:0] tmp2;  // sfix24
  reg signed [50:0] ud1;  // sfix24
  reg signed [50:0] ud2;  // sfix24
  reg signed [50:0] ud3;  // sfix24
  
  
  always @(posedge clk or posedge reset)
    begin
      if (reset == 1'b1) begin
        ud1 = 51'sb000000000000;
		  ud2 = 51'sb000000000000;
		  ud3 = 51'sb000000000000;
      end
      else begin
        if (clk_enable) begin
		    tmp1=3*ud1;
			 y1=xin-tmp1;
			 tmp2=3*ud2;
			 y2=y1+tmp2;
			 y3=y2-ud3;
			 ud3=ud2;
			 ud2=ud1;
			 ud1=xin;
        end
      end
    end
  
   assign yout = y3;
  
  endmodule
  