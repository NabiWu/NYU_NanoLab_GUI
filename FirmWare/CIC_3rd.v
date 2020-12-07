module CIC_3rd
          (
           clk,
           reset,
           clk_enable,
           xin,
           yout,
			  clk2,
			  clk_out,
			  yout_int
          );
			 
  input   clk;
  input   reset;
  input   clk_enable;
  input   signed [50:0] xin;  // sfix24
  output  signed [50:0] yout;  // sfix24
  output  clk2;
  output  clk_out;
  output  yout_int;

  wire signed [50:0] yout_int;
  wire signed [50:0] yout_diff;
  wire clk2;
  wire clk_out;
  
  assign clk2=~clk;

  integ_3rd x0(clk,reset,clk_enable,xin,yout_int);
  clk_div_v2 x2(clk2,reset,clk_out);
  diff_3rd x1(clk_out,reset,clk_enable,yout_int,yout_diff);


  assign yout=yout_diff;

endmodule
