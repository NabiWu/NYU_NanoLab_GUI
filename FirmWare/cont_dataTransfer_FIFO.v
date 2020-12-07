module cont_dataTransfer_FIFO
(
input  wire        RST,
input  wire        CLK_W,
input  wire        CLK_R,
input  wire [15:0] DATA_IN,
output wire [15:0] DATA_OUT,
input  wire        EP_READ,
//output reg         RST_X0,
//output reg         RST_X1,
//output reg         WE_X0,
//output reg         WE_X1,
//output wire        RE_X0,
//output wire        RE_X1,
//output wire [15:0] DOUT_X0,
//output wire        FULL_X0,
//output wire        EMPTY_X0,
//output wire [15:0] DOUT_X1,
//output wire        FULL_X1,
//output wire        EMPTY_X1,
//output reg  [2:0]  COUNT_INT,
//output reg         INCREMENT_INT,
//output reg         INT_STOP,
//output reg  [12:0] COUNT_FIFO,
//output reg         INCREMENT_FIFO,
//output reg         SWAP_CYCLE,
//output reg  [9:0]  COUNT_CYCLE,
//output reg  [9:0]  TOTAL_CYCLE 
//output reg         EN_WE_COUNT0,
//output reg         EN_WE_COUNT1,
//output reg  [2:0]  COUNT_POST_WE_X0,
//output reg  [2:0]  COUNT_POST_WE_X1,
//output reg         INCREMENT_POST_WE_X0,
//output reg         INCREMENT_POST_WE_X1,
//output reg         TMP_R0,
//output reg         TMP_R1,
//output reg         EP_READY_X0,
//output reg         EP_READY_X1,
output wire        EP_READY
//output wire        EP_READ_X0_POSSYNC,
//output wire        EP_READ_X1_POSSYNC
);


parameter   cycle = 236;//must be even number


wire        RST_BAR;
reg         STATUS;

reg         RST_X0;
reg         RST_X1;
reg         WE_X0;
reg         WE_X1;
wire        RE_X0;
wire        RE_X1;
wire [15:0] DOUT_X0;
wire        FULL_X0;
wire        EMPTY_X0;
wire [15:0] DOUT_X1;
wire        FULL_X1;
wire        EMPTY_X1;
reg         RE_X0_TMP0;
reg         RE_X1_TMP0;
wire        RE_X0_TMP1;
wire        RE_X1_TMP1;
reg         RE_X0_TMP2;
reg         RE_X1_TMP2;
reg  [2:0]  COUNT_INT;
reg         INCREMENT_INT;
reg         INT_STOP;
reg  [12:0] COUNT_FIFO;
reg         INCREMENT_FIFO;
reg         SWAP_CYCLE;
reg  [9:0]  COUNT_CYCLE;
reg  [9:0]  TOTAL_CYCLE;

reg         EN_WE_COUNT0;
reg         EN_WE_COUNT1;
reg  [2:0]  COUNT_POST_WE_X0;
reg  [2:0]  COUNT_POST_WE_X1;
reg         INCREMENT_POST_WE_X0;
reg         INCREMENT_POST_WE_X1;
reg         TMP_R0;
reg         TMP_R1;
reg         EP_READY_X0;
reg         EP_READY_X1;
//wire        EP_READY;
wire        EP_READ_X0_POSSYNC;
wire        EP_READ_X1_POSSYNC;

reg         EP_READ_POSSYNC;        

Asyn_FIFO X0
(
.rst(RST_X0),
.wr_clk(CLK_W),
.rd_clk(~CLK_R),
.din(DATA_IN),
.wr_en(WE_X0),
.rd_en(RE_X0),
.dout(DOUT_X0),
.full(FULL_X0),
.empty(EMPTY_X0)
);

Asyn_FIFO X1
(
.rst(RST_X1),
.wr_clk(CLK_W),
.rd_clk(~CLK_R),
.din(DATA_IN),
.wr_en(WE_X1),
.rd_en(RE_X1),
.dout(DOUT_X1),
.full(FULL_X1),
.empty(EMPTY_X1)
);

assign RST_BAR = ~ RST;
assign DATA_OUT = (WE_X0 == 0)? DOUT_X0 : DOUT_X1;

always@(posedge WE_X0 or posedge RST)
begin
  if(RST)
  begin
    COUNT_CYCLE    = 10'd0;
  end
  else
  begin
    COUNT_CYCLE = COUNT_CYCLE + 10'd2;
  end
end

always@(negedge CLK_W or negedge RST_BAR)//Reset Generate 
begin 
  if(RST_BAR == 0) 
  begin 
    STATUS         = 1'b0; 
    RST_X0         = 1'b0; 
    RST_X1         = 1'b0; 
    WE_X0          = 1'b0; 
    WE_X1          = 1'b0; 
    COUNT_INT      = 3'd0; 
    INCREMENT_INT  = 1'b1; 
    INT_STOP       = 1'b0; 
    COUNT_FIFO     = 13'd0; 
    INCREMENT_FIFO = 1'b1; 
    SWAP_CYCLE     = 1'b0; 
    //COUNT_CYCLE    = 10'd0; 
    TOTAL_CYCLE    = cycle; 
  end 
  else 
  begin 
    COUNT_INT = COUNT_INT + INCREMENT_INT; 
    if(COUNT_INT == 7) 
    begin 
      COUNT_INT     = 3'd0; 
      INCREMENT_INT = 1'b0; 
      INT_STOP      = 1'b1; 
    end 
    else 
    begin 
      if(INT_STOP == 1) 
      begin 
        if(COUNT_CYCLE <= TOTAL_CYCLE) 
        begin 
          STATUS     = 1'b0; 
          COUNT_FIFO = COUNT_FIFO + INCREMENT_FIFO; 
          if(SWAP_CYCLE == 0) 
          begin 
            case (COUNT_FIFO) 
              13'd1    : 
              begin 
                RST_X0 = 1'b1; 
              end 
              13'd6    : 
              begin 
                RST_X0 = 1'b0; 
              end 
              13'd11   : 
              begin 
                WE_X0 = 1'b1; 
                WE_X1 = 1'b0; 
              end 
              13'd4096 : 
              begin 
                RST_X1     = 1'b1; 
                SWAP_CYCLE = 1'b1; 
                COUNT_FIFO = 13'd1; 
              end 
              default  : STATUS = 1'b0; 
            endcase 
          end 
          else//SWAP_CYCLE == 1
          begin 
            case (COUNT_FIFO) 
              13'd6    : 
              begin 
                RST_X1 = 1'b0; 
              end 
              13'd11   : 
              begin 
                WE_X0 = 1'b0; 
                WE_X1 = 1'b1; 
              end 
              13'd4096 : 
              begin 
                RST_X0     = 1'b1; 
                SWAP_CYCLE = 1'b0; 
                COUNT_FIFO = 13'd1; 
              end 
              default  : STATUS = 1'b1; 
            endcase 
          end 
        end//100 cycles 
        else//end 100 cycles 
        begin
          STATUS = 1'b0;
			 WE_X0  = 1'b0; 
          WE_X1  = 1'b0;
        end
      end   
      else
      begin
        STATUS =1'b0; 
      end//INT_STOP session
    end//COUNT_INT session end 
  end//reset session end 
end//end always

always@(posedge RST or posedge WE_X0)
begin
  if(RST)
  begin
    EN_WE_COUNT0 = 1'b0;
  end
  else
  begin
    EN_WE_COUNT0 = 1'b1;
  end
end

always@(posedge RST or posedge WE_X1)
begin
  if(RST)
  begin
    EN_WE_COUNT1 = 1'b0;
  end
  else
  begin
    EN_WE_COUNT1 = 1'b1;
  end
end

always@(negedge CLK_W or negedge RST_BAR)
begin
  if(RST_BAR == 0) 
  begin
    COUNT_POST_WE_X0     =3'd0;
    //COUNT_POST_WE_X1     =3'd0;
    INCREMENT_POST_WE_X0 =1'b1;
    //INCREMENT_POST_WE_X1 =1'b1;
    TMP_R0               =1'b0;
    //TMP_R1               =1'b0;
    EP_READY_X0          =1'b0;
    //EP_READY_X1          =1'b0;
  end
  else
  begin
    if(EN_WE_COUNT0 == 1)
    begin
      if(WE_X0 == 0)
      begin
        COUNT_POST_WE_X0 = COUNT_POST_WE_X0 + INCREMENT_POST_WE_X0;
        if(COUNT_POST_WE_X0 == 5)
        begin
          COUNT_POST_WE_X0     = 3'd0;
          INCREMENT_POST_WE_X0 = 1'b0;
          EP_READY_X0          = 1'b1;
        end
        else
        begin
          TMP_R0               = 1'b0;
        end
      end
      else
      begin
        TMP_R0               = 1'b0;
        EP_READY_X0          = 1'b0;
        INCREMENT_POST_WE_X0 = 1'b1;
      end
    end
    else
    begin
      TMP_R0 = 1'b1;
    end
  end
end

always@(negedge CLK_W or negedge RST_BAR)
begin
  if(RST_BAR == 0) 
  begin
    //COUNT_POST_WE_X0     =3'd0;
    COUNT_POST_WE_X1     =3'd0;
    //INCREMENT_POST_WE_X0 =1'b1;
    INCREMENT_POST_WE_X1 =1'b1;
    //TMP_R0               =1'b0;
    TMP_R1               =1'b0;
    //EP_READY_X0          =1'b0;
    EP_READY_X1          =1'b0;
  end
  else
  begin
    if(EN_WE_COUNT1 == 1)
    begin
      if(WE_X1 == 0)
      begin
        COUNT_POST_WE_X1 = COUNT_POST_WE_X1 + INCREMENT_POST_WE_X1;
        if(COUNT_POST_WE_X1 == 5)
        begin
          COUNT_POST_WE_X1     = 3'd0;
          INCREMENT_POST_WE_X1 = 1'b0;
          EP_READY_X1          = 1'b1;
        end
        else
        begin
          TMP_R1               = 1'b0;
        end
      end
      else
      begin
        TMP_R1               = 1'b0;
        EP_READY_X1          = 1'b0;
        INCREMENT_POST_WE_X1 = 1'b1;
      end
    end
    else
    begin
      TMP_R1 = 1'b1;
    end
  end
end

assign EP_READY = EP_READY_X0 || EP_READY_X1;

always@(posedge RST or posedge CLK_R)
begin
  if(RST)
  begin
    EP_READ_POSSYNC = 1'b0;
  end
  else
  begin
    if(EP_READ == 1)
	 begin
	   EP_READ_POSSYNC = 1'b1;
    end
	 else
	 begin
	   EP_READ_POSSYNC = 1'b0;
	 end
  end
end

assign EP_READ_X0_POSSYNC = EP_READ_POSSYNC && WE_X1;
assign EP_READ_X1_POSSYNC = EP_READ_POSSYNC && WE_X0;

always@(negedge RST_BAR or negedge CLK_R)
begin
  if(RST_BAR == 0)
  begin
    RE_X0_TMP0 = 1'b0;
	 RE_X1_TMP0 = 1'b0;
  end
  else
  begin
    if(EP_READ_X0_POSSYNC == 1)
	 begin
	   RE_X0_TMP0 = 1'b1;
    end
	 else
	 begin
	   RE_X0_TMP0 = 1'b0;
	 end
	 if(EP_READ_X1_POSSYNC == 1)
	 begin
	   RE_X1_TMP0 = 1'b1;
    end
	 else
	 begin
	   RE_X1_TMP0 = 1'b0;
	 end
  end
end

assign RE_X0_TMP1 = EP_READ_X0_POSSYNC || RE_X0_TMP0;
assign RE_X1_TMP1 = EP_READ_X1_POSSYNC || RE_X1_TMP0;

always@(posedge RST or posedge CLK_R)
begin
  if(RST)
  begin
    RE_X0_TMP2 = 1'b0;
	 RE_X1_TMP2 = 1'b0;
  end
  else
  begin
    if(RE_X0_TMP0 == 1)
	 begin
	   RE_X0_TMP2 = 1'b1;
    end
	 else
	 begin
	   RE_X0_TMP2 = 1'b0;
	 end
	 if(RE_X1_TMP0 == 1)
	 begin
	   RE_X1_TMP2 = 1'b1;
    end
	 else
	 begin
	   RE_X1_TMP2 = 1'b0;
	 end
  end
end

assign RE_X0 = RE_X0_TMP1 || RE_X0_TMP2;
assign RE_X1 = RE_X1_TMP1 || RE_X1_TMP2;

endmodule
