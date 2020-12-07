module CHIP4_ADC_CONT//OSR = 64; Fin = 1.024 MHz; Fout = 16 kHz
(
	input      hi_in,
	output     hi_out,
	inout      hi_inout,
	output     hi_muxsel,
	//input        clk1,//sample clock
   input        clk1,//sample clock
	input        clk2,//USB clock
	//input        clk3, //DAC clock
	input        CKO_R,
	input        CKO_L,
	input        DOUT_R,
	input        DOUT_L,
	//output       sync_DC
	//output       SCLK_DC,
	output       DAC_CLK,                                                                                                  
	output       CLR_BAR,
	output       SYNC_BAR_DC,
	output       DIN_DC,
	output       CLR_BAR_ramp,
	output       SYNC_BAR_ramp,
	output       DIN_ramp,	
	output       ch_selL0,
	output       ch_selL1,
	output       bfet_selL0,
	output       bfet_selL1,
	output       tstenL,
	output       tia_enL1,
	output       pga_enL,
	output       tia_enL2,
	output       pgaL0,
	output       pgaL1,
	output       tia_enL3,
	output       adc_enL,
	output       ck_enL,
	output       iref_enL,
	output       ch_selR0,
	output       ch_selR1,
	output       bfet_selR0,
	output       bfet_selR1,
	output       tstenR,
	output       tia_enR1,
	output       pga_enR,
	output       tia_enR2,
	output       pgaR0,
	output       pgaR1,
	output       tia_enR3,
	output       adc_enR,
	output       ck_enR,
	output       iref_enR
	//output       clk_chipADC_R,
   //output       clk_chipADC_L
);

wire [7:0]  hi_in;
wire [1:0]  hi_out;
wire [15:0] hi_inout;
wire        hi_muxsel;

assign      hi_muxsel=1'b0;
// Opal Kelly Module Interface Connections
wire        ti_clk;
wire [30:0] ok1;
wire [16:0] ok2;

// Endpoint connections:
wire [15:0]  ep00wire;
wire [15:0]  ep01wire;
wire [15:0]  ep02wire;
wire [15:0]  ep03wire;
wire [15:0]  ep04wire;
wire [15:0]  ep05wire;
wire [15:0]  ep06wire;
wire [15:0]  ep07wire;
wire [15:0]  ep08wire;
wire [15:0]  ep09wire;
wire [15:0]  ep0Awire;
wire [15:0]  ep0Bwire;
wire [15:0]  ep0Cwire;
wire [15:0]  ep0Dwire;
wire [15:0]  ep0Ewire;
wire [15:0]  ep0Fwire;
wire [15:0]  ep10wire;
wire [15:0]  ep11wire;
wire [15:0]  ep12wire;
wire [15:0]  ep13wire;
wire [15:0]  ep14wire;
wire [15:0]  ep15wire;
wire [15:0]  ep16wire;
wire [15:0]  ep17wire;
wire [15:0]  ep18wire;
wire [15:0]  ep19wire;
wire [15:0]  ep1Awire;
wire [15:0]  ep1Bwire;
wire [15:0]  ep1Cwire;
wire [15:0]  ep1Dwire;
wire [15:0]  ep1Ewire;
wire [15:0]  ep1Fwire;

//wire [15:0]  ep20wire;
//wire [15:0]  ep21wire;
//wire [15:0]  ep22wire;
//wire [15:0]  ep23wire;
//wire [15:0]  ep24wire;

wire [15:0]  epA0pipe;
wire         epA0read;
wire         epA0_blockSTROBE;
wire         epA0_ready;
wire [15:0]  epA1pipe;
wire         epA1read;
wire         epA1_blockSTROBE;
wire         epA1_ready;

wire         reset;
//wire         ch_selL0;
wire         reset_FIFO;
wire         enable;
wire         enable_ramp;
wire         din_ramp;
wire         sync_bar_ramp;
wire         sync_bar_DC;
reg  [15:0]  data_in;
reg  [15:0]  data_in1;
reg  [15:0]  data_in2;
reg  [15:0]  data_in3;
//wire [15:0]  data_test;
wire [31:0] Pattern_ramp;
wire [31:0] Pattern_DC;
//wire [15:0] Vramp1;
//wire [15:0] Vramp2;
//wire [5:0]  count1;
//wire [5:0]  count2;
//wire [9:0]  count3;
reg         SYNC2;
reg  [5:0]  count_sync;
wire [5:0]  countDC1;
wire [5:0]  countDC2;
wire        mark1DC;

wire signed [50:0] data_in_L;
wire signed [50:0] data_in_R;
wire signed [50:0] data_out_L;
wire signed [50:0] data_out_R;
wire signed [50:0] inter_out1;
wire signed [50:0] inter_out2;
wire               clk2_tmp1;
wire               clk2_tmp2;
wire               cic_clk_L;
wire               cic_clk_R;
wire               cic_clk_L_bar;
wire               cic_clk_R_bar;
wire        [2:0]  ep_read1_L;
wire        [2:0]  ep_read2_L;
wire        [2:0]  ep_read1_R;
wire        [2:0]  ep_read2_R;
wire        [2:0]  ep_ready_L;
wire        [2:0]  ep_ready_R;
wire               Tri1_L;
wire               Tri2_L;
wire               Tri1_R;
wire               Tri2_R;
wire        [9:0]  counter_w1_L;
wire        [9:0]  counter_w4_L;
wire        [9:0]  counter_w1_R;
wire        [9:0]  counter_w4_R;
wire               select_L;
wire               select_R;

assign reset      = ep00wire[0];
assign reset_FIFO = ep01wire[0];
assign enable     = ep02wire[0];
assign ch_selL0   = ep03wire[0];
assign ch_selL1   = ep04wire[0];
assign bfet_selL0 = ep05wire[0];
assign bfet_selL1 = ep06wire[0];
assign tstenL     = ep07wire[0];
assign tia_enL1   = ep08wire[0];
assign pga_enL    = ep09wire[0];
assign tia_enL2   = ep0Awire[0];
assign pgaL0      = ep0Bwire[0];
assign pgaL1      = ep0Cwire[0];
assign tia_enL3   = ep0Dwire[0];
assign adc_enL    = ep0Ewire[0];
assign ck_enL     = ep0Fwire[0];
assign iref_enL   = ep10wire[0];
assign ch_selR0   = ep11wire[0];
assign ch_selR1   = ep12wire[0];
assign bfet_selR0 = ep13wire[0];
assign bfet_selR1 = ep14wire[0];
assign tstenR     = ep15wire[0];
assign tia_enR1   = ep16wire[0];
assign pga_enR    = ep17wire[0];
assign tia_enR2   = ep18wire[0];
assign pgaR0      = ep19wire[0];
assign pgaR1      = ep1Awire[0];
assign tia_enR3   = ep1Bwire[0];
assign adc_enR    = ep1Cwire[0];
assign ck_enR     = ep1Dwire[0];
assign iref_enR   = ep1Ewire[0];
assign enable_ramp= ep1Fwire[0];

//assign ep20wire  = data_in;
//assign data_test = 16'h1238;
//assign sync_DC    = sync_bar_DC;
//assign DAC_CLK        = clk3;
assign SYNC_BAR_DC    = sync_bar_DC;
assign DIN_DC         = din_DC;
assign CLR_BAR        = 1'b1;
assign CLR_BAR_ramp   = 1'b1;
assign SYNC_BAR_ramp  = sync_bar_ramp;
assign DIN_ramp       = din_ramp;
assign data_in_L      = {50'd0,DOUT_L};
assign data_in_R      = {50'd0,DOUT_R};
//assign CIC_clk_R      = cic_clk_R;
assign cic_clk_L_bar  = ~ cic_clk_L;
assign cic_clk_R_bar  = ~ cic_clk_R;
//assign clk_chipADC_R  = clk1;
//assign clk_chipADC_L  = clk1;
assign DAC_CLK        = clk1;

/*
DAC_powerdown U0
(
 .reset(reset),
 .clk(DAC_CLK),
 .clk_en(enable_ramp),
 .Din(din_ramp),
 .Pattern(Pattern_ramp),
 .SYNC_bar(sync_bar_ramp)
 );


DAC_dc3 U0
(
 .reset(reset),
 .clk(DAC_CLK),
 .clk_en(enable_ramp),
 .Din(din_ramp),
 .Pattern(Pattern_ramp),
 .SYNC_bar(sync_bar_ramp)
 );
*/
DAC_dc U1
(
 .reset(reset),
 .clk(DAC_CLK),
 .clk_en(enable),
 .Din(din_DC),
 .Pattern(Pattern_DC),
 .SYNC_bar(sync_bar_DC),
 .count1(countDC1),
 .count2(countDC1),
 .mark1(mark1DC)
);

CIC_3rd U2
(
.clk(CKO_L),
.reset(reset),
.clk_enable(enable),
.xin(data_in_L),
.yout(data_out_L),
.clk2(clk2_tmp1),
.clk_out(cic_clk_L),
.yout_int(inter_out1)
);

CIC_3rd U3
(
.clk(CKO_R),
.reset(reset),
.clk_enable(enable),
.xin(data_in_R),
.yout(data_out_R),
.clk2(clk2_tmp2),
.clk_out(cic_clk_R),
.yout_int(inter_out2)
);



cont_dataTransfer_FIFO X0
(
.RST(reset_FIFO),
.CLK_W(cic_clk_L_bar),
.CLK_R(clk2),
.DATA_IN(data_out_L[23:8]),
.DATA_OUT(epA0pipe),
.EP_READ(epA0read),
.EP_READY(epA0_ready)
);

cont_dataTransfer_FIFO X1
(
.RST(reset_FIFO),
.CLK_W(cic_clk_R_bar),
.CLK_R(clk2),
.DATA_IN(data_out_R[23:8]),
.DATA_OUT(epA1pipe),
.EP_READ(epA1read),
.EP_READY(epA1_ready)
);

// Instantiate the okHost and connect endpoints

wire [17*2-1:0]  ok2x;
okHost okHI(
	.hi_in(hi_in), .hi_out(hi_out), .hi_inout(hi_inout), .ti_clk(ti_clk),
	.ok1(ok1), .ok2(ok2));

okWireOR # (.N(2)) wireOR (.ok2(ok2), .ok2s(ok2x));

okWireIn     ep00 (.ok1(ok1),                          .ep_addr(8'h00), .ep_dataout(ep00wire));
okWireIn     ep01 (.ok1(ok1),                          .ep_addr(8'h01), .ep_dataout(ep01wire));
okWireIn     ep02 (.ok1(ok1),                          .ep_addr(8'h02), .ep_dataout(ep02wire));
okWireIn     ep03 (.ok1(ok1),                          .ep_addr(8'h03), .ep_dataout(ep03wire));
okWireIn     ep04 (.ok1(ok1),                          .ep_addr(8'h04), .ep_dataout(ep04wire));
okWireIn     ep05 (.ok1(ok1),                          .ep_addr(8'h05), .ep_dataout(ep05wire));
okWireIn     ep06 (.ok1(ok1),                          .ep_addr(8'h06), .ep_dataout(ep06wire));
okWireIn     ep07 (.ok1(ok1),                          .ep_addr(8'h07), .ep_dataout(ep07wire));
okWireIn     ep08 (.ok1(ok1),                          .ep_addr(8'h08), .ep_dataout(ep08wire));
okWireIn     ep09 (.ok1(ok1),                          .ep_addr(8'h09), .ep_dataout(ep09wire));
okWireIn     ep0A (.ok1(ok1),                          .ep_addr(8'h0A), .ep_dataout(ep0Awire));
okWireIn     ep0B (.ok1(ok1),                          .ep_addr(8'h0B), .ep_dataout(ep0Bwire));
okWireIn     ep0C (.ok1(ok1),                          .ep_addr(8'h0C), .ep_dataout(ep0Cwire));
okWireIn     ep0D (.ok1(ok1),                          .ep_addr(8'h0D), .ep_dataout(ep0Dwire));
okWireIn     ep0E (.ok1(ok1),                          .ep_addr(8'h0E), .ep_dataout(ep0Ewire));
okWireIn     ep0F (.ok1(ok1),                          .ep_addr(8'h0F), .ep_dataout(ep0Fwire));
okWireIn     ep10 (.ok1(ok1),                          .ep_addr(8'h10), .ep_dataout(ep10wire));
okWireIn     ep11 (.ok1(ok1),                          .ep_addr(8'h11), .ep_dataout(ep11wire));
okWireIn     ep12 (.ok1(ok1),                          .ep_addr(8'h12), .ep_dataout(ep12wire));
okWireIn     ep13 (.ok1(ok1),                          .ep_addr(8'h13), .ep_dataout(ep13wire));
okWireIn     ep14 (.ok1(ok1),                          .ep_addr(8'h14), .ep_dataout(ep14wire));
okWireIn     ep15 (.ok1(ok1),                          .ep_addr(8'h15), .ep_dataout(ep15wire));
okWireIn     ep16 (.ok1(ok1),                          .ep_addr(8'h16), .ep_dataout(ep16wire));
okWireIn     ep17 (.ok1(ok1),                          .ep_addr(8'h17), .ep_dataout(ep17wire));
okWireIn     ep18 (.ok1(ok1),                          .ep_addr(8'h18), .ep_dataout(ep18wire));
okWireIn     ep19 (.ok1(ok1),                          .ep_addr(8'h19), .ep_dataout(ep19wire));
okWireIn     ep1A (.ok1(ok1),                          .ep_addr(8'h1A), .ep_dataout(ep1Awire));
okWireIn     ep1B (.ok1(ok1),                          .ep_addr(8'h1B), .ep_dataout(ep1Bwire));
okWireIn     ep1C (.ok1(ok1),                          .ep_addr(8'h1C), .ep_dataout(ep1Cwire));
okWireIn     ep1D (.ok1(ok1),                          .ep_addr(8'h1D), .ep_dataout(ep1Dwire));
okWireIn     ep1E (.ok1(ok1),                          .ep_addr(8'h1E), .ep_dataout(ep1Ewire));
okWireIn     ep1F (.ok1(ok1),                          .ep_addr(8'h1F), .ep_dataout(ep1Fwire));

okBTPipeOut  BTpipeOutpA0 (.ok1(ok1), .ok2(ok2x[ 0*17 +: 17 ]), .ep_addr(8'ha0), .ep_read(epA0read), .ep_datain(epA0pipe), .ep_blockstrobe(epA0_blockSTROBE), .ep_ready(epA0_ready));
okBTPipeOut  BTpipeOutpA1 (.ok1(ok1), .ok2(ok2x[ 1*17 +: 17 ]), .ep_addr(8'ha1), .ep_read(epA1read), .ep_datain(epA1pipe), .ep_blockstrobe(epA1_blockSTROBE), .ep_ready(epA1_ready));
//okBTPipeOut  BTpipeOutpA2 (.ok1(ok1), .ok2(ok2x[ 2*17 +: 17 ]), .ep_addr(8'ha2), .ep_read(epA2read), .ep_datain(epA2pipe), .ep_blockstrobe(epA2_blockSTROBE), .ep_ready(epA2_ready));
//okBTPipeOut  BTpipeOutpA3 (.ok1(ok1), .ok2(ok2x[ 3*17 +: 17 ]), .ep_addr(8'ha3), .ep_read(epA3read), .ep_datain(epA3pipe), .ep_blockstrobe(epA3_blockSTROBE), .ep_ready(epA3_ready));
//okBTPipeOut  BTpipeOutpA4 (.ok1(ok1), .ok2(ok2x[ 4*17 +: 17 ]), .ep_addr(8'ha4), .ep_read(epA4read), .ep_datain(epA4pipe), .ep_blockstrobe(epA4_blockSTROBE), .ep_ready(epA4_ready));
//okBTPipeOut  BTpipeOutpA5 (.ok1(ok1), .ok2(ok2x[ 5*17 +: 17 ]), .ep_addr(8'ha5), .ep_read(epA5read), .ep_datain(epA5pipe), .ep_blockstrobe(epA5_blockSTROBE), .ep_ready(epA5_ready));
//okWireOut    ep20 (.ok1(ok1), .ok2(ok2x[ 4*17 +: 17 ]), .ep_addr(8'h20), .ep_datain(ep20wire));
//okWireOut    ep21 (.ok1(ok1), .ok2(ok2x[ 5*17 +: 17 ]), .ep_addr(8'h21), .ep_datain(ep21wire));
//okWireOut    ep22 (.ok1(ok1), .ok2(ok2x[ 6*17 +: 17 ]), .ep_addr(8'h22), .ep_datain(ep22wire));
//okWireOut    ep23 (.ok1(ok1), .ok2(ok2x[ 7*17 +: 17 ]), .ep_addr(8'h23), .ep_datain(ep23wire));
//okWireOut    ep24 (.ok1(ok1), .ok2(ok2x[ 8*17 +: 17 ]), .ep_addr(8'h24), .ep_datain(ep24wire));

endmodule
