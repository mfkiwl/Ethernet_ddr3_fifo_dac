`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2019 11:33:33
// Design Name: 
// Module Name: test_ddr3_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_ddr3_fifo 
(
    // Inouts
    input                              sys_clk,     //50Mhz
    input                              sys_rst_n,   //Active low
    
    inout [15:0]                       ddr3_dq,
    inout [1:0]                        ddr3_dqs_n,
    inout [1:0]                        ddr3_dqs_p,
    
    // Outputs
    output [13:0]                      ddr3_addr,
    output [2:0]                       ddr3_ba,
    output                             ddr3_ras_n,
    output                             ddr3_cas_n,
    output                             ddr3_we_n,
    output                             ddr3_reset_n, 
    output [0:0]                       ddr3_ck_p,
    output [0:0]                       ddr3_ck_n,
    output [0:0]                       ddr3_cke,
    output [1:0]                       ddr3_dm,
    output [0:0]                       ddr3_odt,
    
    output                             led_1,
    output                             ADC_CLK,
    output                             DAC_CLK,
    input  [7:0]                       ADC_DATA,
    output reg [7:0]                   DAC_DATA  
);


wire            fifo_pre_rd_en;
wire            fifo_pre_empty;
wire [127:0]    fifo_pre_dout;
wire [9:0] 	    fifo_pre_rd_count;

wire 	        fifo_post_wr_en;
wire 	        fifo_post_full;
wire [127:0]    fifo_post_din;
wire [9:0] 	    fifo_post_wr_count;
wire [9:0]      fifo_post_rd_data_count;

wire 	        axi_clk;
wire 	        axi_aresetn;
wire [31:0] 	axi_awaddr;
wire [7:0] 	    axi_awlen;
wire [2:0] 	    axi_awsize;
wire [1:0] 	    axi_awburst;
wire 	        axi_awvalid;
wire 	        axi_awready;
wire [127:0]    axi_wdata;
wire [15:0] 	axi_wstrb;//63..0
wire 	        axi_wlast;
wire 	        axi_wvalid;
wire 	        axi_wready;
wire 	        axi_bvalid;
wire 	        axi_bready;
wire [31:0] 	axi_araddr;
wire [7:0] 	    axi_arlen;
wire [2:0] 	    axi_arsize;
wire [1:0] 	    axi_arburst;
wire 	        axi_arvalid;
wire 	        axi_arready;
wire [127:0]    axi_rdata;
wire 	        axi_rlast;
wire 	        axi_rvalid;
wire 	        axi_rready;

/*****************************************************/
wire            clk_10Mhz;
wire            clk_125Mhz;
wire            clk_200Mhz;

wire ddr3_done;
wire fifo_post_empty;
wire fifo_pre_full;

reg r_led;
reg [31:0] count;
reg data_valid;
reg wr_en;
reg rd_en;

//reg  [127:0] data_to_write = {32'hcafebabe, 32'h12345678, 32'hAA55AA55, 32'h55AA55AA};
//reg  [127:0] data_to_write = {32'h7F6F5F4F, 32'h3F2F1F0F, 32'hFFEFDFCF, 32'hBFAF9F8F};
reg  [127:0] data_to_write = {32'h7F005F00, 32'h3F001F00, 32'h1F003F00, 32'h5F007F00};

wire [15:0]  data_read_from_memory;
reg  [127:0] dac_wr_data;
reg  [31:0] fifo_wr_cnt = 32'd0;
reg  [31:0] fifo_rd_cnt = 32'd0;

reg  dac_clk;
reg  [31:0] dac_cnt;
reg  [31:0] pause_cnt;
reg  [31:0] byte_cnt;
reg  rd_data;
reg  rd_lock;

initial begin
    r_led       <=1'b1;
    count       <=32'd0;
    data_valid  <=1'b0;
    wr_en       <=1'b0;
    rd_en       <=1'b0;
    dac_clk     <=1'b0;
    dac_cnt     <=32'd0;
    pause_cnt   <=32'd0;
    byte_cnt    <=32'd0;
    rd_data     <=1'b0;
    rd_lock     <=1'b0;
end

localparam IDLE       = 3'd0;
localparam WRITE      = 3'd1;
localparam READ       = 3'd2;
localparam PAUSE      = 3'd3;
reg [2:0] state       = IDLE;
reg [2:0] dac_state   = IDLE;

assign led_1 = r_led;
assign DAC_CLK = dac_clk;

//DDR3 core requires 200MHz input clock
pll pll_inst(   
    .clk_in1(sys_clk),      //50Mhz
    .reset(~sys_rst_n),     //Active high
    .clk_out1(clk_10Mhz),
    .clk_out2(clk_125Mhz),
    .clk_out3(clk_200Mhz)
);

deepfifo#(
    .log2_ram_size_addr(27),    //134Mbytes
    .log2_word_width(7),        //128bit
    .log2_fifo_words(9),        //512
    .fifo_threshold(256) 
) deepfifo_inst(
    .clk				    (axi_clk),
    .reset				    (~sys_rst_n), //Active high
    
    .fifo_pre_rd_en			(fifo_pre_rd_en),
    .fifo_pre_empty			(fifo_pre_empty),
    .fifo_pre_dout			(fifo_pre_dout),
    .fifo_pre_rd_count		(fifo_pre_rd_count),
    
    .fifo_post_wr_en		(fifo_post_wr_en),
    .fifo_post_din			(fifo_post_din),
    .fifo_post_full			(fifo_post_full),
    .fifo_post_wr_count		(fifo_post_wr_count),
    
    .axi_aresetn			(axi_aresetn),
    .axi_awaddr			    (axi_awaddr),
    .axi_awlen			    (axi_awlen),
    .axi_awvalid			(axi_awvalid),
    .axi_awready			(axi_awready),
    .axi_awsize			    (axi_awsize),
    .axi_awburst			(axi_awburst),
    
    .axi_wdata			    (axi_wdata),
    .axi_wstrb			    (axi_wstrb),
    .axi_wlast			    (axi_wlast),
    .axi_wvalid			    (axi_wvalid),
    
    .axi_bvalid			    (axi_bvalid),
    .axi_bready			    (axi_bready),
    
    .axi_araddr			    (axi_araddr),
    .axi_arlen			    (axi_arlen),
    .axi_arvalid			(axi_arvalid),
    .axi_arready			(axi_arready),
    .axi_arsize			    (axi_arsize),
    .axi_arburst			(axi_arburst),
    
    .axi_wready			    (axi_wready),
    .axi_rdata			    (axi_rdata),
    .axi_rready			    (axi_rready),
    .axi_rlast			    (axi_rlast),
    .axi_rvalid			    (axi_rvalid)
);

ddr3 ddr3_inst
(  
    // Memory interface ports
    .ddr3_addr                      (ddr3_addr),        // output [13:0]	ddr3_addr
    .ddr3_ba                        (ddr3_ba),          // output [2:0]		ddr3_ba
    .ddr3_cas_n                     (ddr3_cas_n),       // output			ddr3_cas_n
    .ddr3_ck_n                      (ddr3_ck_n),        // output [0:0]		ddr3_ck_n
    .ddr3_ck_p                      (ddr3_ck_p),        // output [0:0]		ddr3_ck_p
    .ddr3_cke                       (ddr3_cke),         // output [0:0]		ddr3_cke
    .ddr3_ras_n                     (ddr3_ras_n),       // output			ddr3_ras_n
    .ddr3_reset_n                   (ddr3_reset_n),     // output			ddr3_reset_n
    .ddr3_we_n                      (ddr3_we_n),        // output			ddr3_we_n
    .ddr3_dq                        (ddr3_dq),          // inout [15:0]		ddr3_dq
    .ddr3_dqs_n                     (ddr3_dqs_n),       // inout [7:0]		ddr3_dqs_n
    .ddr3_dqs_p                     (ddr3_dqs_p),       // inout [7:0]		ddr3_dqs_p
    .ddr3_dm                        (ddr3_dm),          // output [7:0]		ddr3_dm
    .ddr3_odt                       (ddr3_odt),         // output [0:0]		ddr3_odt
    .init_calib_complete            (ddr3_done),        // output			init_calib_complete
    
    // Application interface ports
    .ui_clk                         (axi_clk),          // output			ui_clk
    .ui_clk_sync_rst                (),                 // output			ui_clk_sync_rst
    .mmcm_locked                    (),                 // output			mmcm_locked
    .aresetn                        (axi_aresetn),      // input			aresetn
    .app_sr_req                     (1'b0),             // input			app_sr_req
    .app_ref_req                    (1'b0),             // input			app_ref_req
    .app_zq_req                     (1'b0),             // input			app_zq_req
    .app_sr_active                  (),                 // output			app_sr_active
    .app_ref_ack                    (),                 // output			app_ref_ack
    .app_zq_ack                     (),                 // output			app_zq_ack
    
    // Slave Interface Write Address Ports
    .s_axi_awid                     (4'd0),             // input [3:0]		s_axi_awid
    .s_axi_awaddr                   (axi_awaddr),       // input [29:0]		s_axi_awaddr
    .s_axi_awlen                    (axi_awlen),        // input [7:0]		s_axi_awlen
    .s_axi_awsize                   (axi_awsize),       // input [2:0]		s_axi_awsize
    .s_axi_awburst                  (axi_awburst),      // input [1:0]		s_axi_awburst
    .s_axi_awlock                   (1'b0),             // input [0:0]		s_axi_awlock
    .s_axi_awcache                  (4'd0),             // input [3:0]		s_axi_awcache
    .s_axi_awprot                   (3'd0),             // input [2:0]		s_axi_awprot
    .s_axi_awqos                    (4'd0),             // input [3:0]		s_axi_awqos
    .s_axi_awvalid                  (axi_awvalid),      // input			s_axi_awvalid
    .s_axi_awready                  (axi_awready),      // output			s_axi_awready
    
    // Slave Interface Write Data Ports
    .s_axi_wdata                    (axi_wdata),        // input [127:0]	s_axi_wdata
    .s_axi_wstrb                    (axi_wstrb),        // input [63:0]		s_axi_wstrb
    .s_axi_wlast                    (axi_wlast),        // input			s_axi_wlast
    .s_axi_wvalid                   (axi_wvalid),       // input			s_axi_wvalid
    .s_axi_wready                   (axi_wready),       // output			s_axi_wready
    
    // Slave Interface Write Response Ports
    .s_axi_bid                      (),                 // output [3:0]		s_axi_bid
    .s_axi_bresp                    (),                 // output [1:0]		s_axi_bresp
    .s_axi_bvalid                   (axi_bvalid),       // output			s_axi_bvalid
    .s_axi_bready                   (axi_bready),       // input			s_axi_bready
    
    // Slave Interface Read Address Ports
    .s_axi_arid                     (4'd0),             // input [3:0]		s_axi_arid
    .s_axi_araddr                   (axi_araddr),       // input [31:0]		s_axi_araddr
    .s_axi_arlen                    (axi_arlen),        // input [7:0]		s_axi_arlen
    .s_axi_arsize                   (axi_arsize),       // input [2:0]		s_axi_arsize
    .s_axi_arburst                  (axi_arburst),      // input [1:0]		s_axi_arburst
    .s_axi_arlock                   (1'b0),             // input [0:0]		s_axi_arlock
    .s_axi_arcache                  (4'd0),             // input [3:0]		s_axi_arcache
    .s_axi_arprot                   (3'd0),             // input [2:0]		s_axi_arprot
    .s_axi_arqos                    (4'd0),             // input [3:0]		s_axi_arqos
    .s_axi_arvalid                  (axi_arvalid),      // input			s_axi_arvalid
    .s_axi_arready                  (axi_arready),      // output			s_axi_arready
    
    // Slave Interface Read Data Ports
    .s_axi_rid                      (),                 // output [3:0]		s_axi_rid
    .s_axi_rdata                    (axi_rdata),        // output [127:0]	s_axi_rdata
    .s_axi_rresp                    (),                 // output [1:0]		s_axi_rresp
    .s_axi_rlast                    (axi_rlast),        // output			s_axi_rlast
    .s_axi_rvalid                   (axi_rvalid),       // output			s_axi_rvalid
    .s_axi_rready                   (axi_rready),       // input			s_axi_rready
    
    // System Clock Ports
    .sys_clk_i                      (clk_200Mhz),       // input 200Mhz
    .sys_rst                        (sys_rst_n)         // Active low
);

fifo_pre fifo_pre_512
(
    .wr_clk(clk_125Mhz),//user_clk
    .rd_clk(axi_clk),
    .rst(~sys_rst_n),
    .din(data_to_write),
    .wr_en(wr_en),
    .rd_en(fifo_pre_rd_en),
    .dout(fifo_pre_dout),
    .full(fifo_pre_full),
    .rd_data_count(fifo_pre_rd_count),
    .wr_data_count(),
    .empty(fifo_pre_empty)
);

fifo_post fifo_post_512
(
    .wr_clk(axi_clk),
    .rd_clk(dac_clk),//user_clk
    .rst(~sys_rst_n),
    .din(fifo_post_din),
    .wr_en(fifo_post_wr_en),
    .rd_en(rd_en),
    .dout(data_read_from_memory),
    .full(fifo_post_full),
    .rd_data_count(fifo_post_rd_data_count),
    .wr_data_count(fifo_post_wr_count),
    .empty(fifo_post_empty)
);

ila_0 ila_dbg(
    .clk(clk_10Mhz),
    .probe0(state),
    .probe1(ddr3_done),
    .probe2(rd_en),
    .probe3(fifo_post_empty),
    .probe4(fifo_post_full),
    .probe5(dac_clk),
    .probe6(DAC_DATA),              //8bit
    .probe7(data_read_from_memory), //16bit
    .probe8(fifo_post_rd_data_count)
);



always@(posedge clk_10Mhz) begin
    //Indicate process
    count=count+32'd1;
    case (count)
        32'd2000000: begin r_led<=~r_led; count=32'd0; end
    endcase   
    
    //Clock 50kHz for DAC 
    dac_cnt=dac_cnt+32'd1;
    case (dac_cnt)
        32'd100: begin dac_clk<=~dac_clk; dac_cnt=32'd0; end
    endcase    
end

//Write DATA to DDR3
always@(posedge clk_125Mhz) begin
    case (state)
      IDLE: begin
        if (ddr3_done) begin
          fifo_wr_cnt<=32'd0; 
          wr_en<=1'b1;
          state<=WRITE;
        end
      end

      WRITE: begin
        if (fifo_wr_cnt<32'd12500) begin//6250
          fifo_wr_cnt<=fifo_wr_cnt+1'b1;
        end else begin
            wr_en<=1'b0;
            state<=PAUSE;
        end
      end
      
      PAUSE: begin
        if (pause_cnt<32'd124987500) begin
            pause_cnt<=pause_cnt+1'b1;
        end else begin
            state<=IDLE;
            pause_cnt<=32'd0;
        end
      end

      default: state<=IDLE;
    endcase
end



//Read DATA from DDR3 & write to DAC
always@(posedge dac_clk) begin

    if(~fifo_post_empty) begin
        rd_en<=1'b1;
        DAC_DATA <= data_read_from_memory[15:8];
    end else begin
        rd_en<=1'b0;
    end
    
    /*if(fifo_dac_dout[7]==1'b0)
        DAC_DATA <= fifo_dac_dout + 8'd127;    
    else
        DAC_DATA <= fifo_dac_dout - 8'd127;*/
        
end
endmodule















/*
always@(posedge clk_125Mhz) begin
    
    if( (rd_data) && (!rd_lock) ) begin
        rd_lock<=1'b1;
        dac_state<=3'd1;
    end else begin
        rd_lock<=1'b0;
        dac_state<=3'd0;
    end
    
    case (dac_state)
        3'd0: begin
        end
        
        3'd1: begin
            rd_en<=1'b1;
            dac_state<=3'd2;
        end
        
        3'd2: begin
            dac_state<=3'd3;
        end

        3'd3: begin
            rd_en<=1'b0;
            dac_wr_data<=data_read_from_memory;
            dac_state<=3'd0;
        end

        default: dac_state<=3'd0;
    endcase    
end*/





    /*case (byte_cnt)
        32'd0:  begin DAC_DATA <= data_read_from_memory[127:120]; byte_cnt<=byte_cnt+1'b1; rd_data<=1'b1; end
        32'd1:  begin DAC_DATA <= data_read_from_memory[119:112]; byte_cnt<=byte_cnt+1'b1; rd_data<=1'b0; end
        32'd2:  begin DAC_DATA <= data_read_from_memory[111:104]; byte_cnt<=byte_cnt+1'b1;  end
        32'd3:  begin DAC_DATA <= data_read_from_memory[103:96];  byte_cnt<=byte_cnt+1'b1;  end
        32'd4:  begin DAC_DATA <= data_read_from_memory[95:88];   byte_cnt<=byte_cnt+1'b1;  end
        32'd5:  begin DAC_DATA <= data_read_from_memory[87:80];   byte_cnt<=byte_cnt+1'b1;  end
        32'd6:  begin DAC_DATA <= data_read_from_memory[79:72];   byte_cnt<=byte_cnt+1'b1;  end
        32'd7:  begin DAC_DATA <= data_read_from_memory[71:64];   byte_cnt<=byte_cnt+1'b1;  end
        32'd8:  begin DAC_DATA <= data_read_from_memory[63:26];   byte_cnt<=byte_cnt+1'b1;  end
        32'd9:  begin DAC_DATA <= data_read_from_memory[55:48];   byte_cnt<=byte_cnt+1'b1;  end
        32'd10: begin DAC_DATA <= data_read_from_memory[47:40];   byte_cnt<=byte_cnt+1'b1;  end
        32'd11: begin DAC_DATA <= data_read_from_memory[39:32];   byte_cnt<=byte_cnt+1'b1;  end
        32'd12: begin DAC_DATA <= data_read_from_memory[31:24];   byte_cnt<=byte_cnt+1'b1;  end
        32'd13: begin DAC_DATA <= data_read_from_memory[23:16];   byte_cnt<=byte_cnt+1'b1;  end
        32'd14: begin DAC_DATA <= data_read_from_memory[15:8];    byte_cnt<=byte_cnt+1'b1;  end
        32'd15: begin DAC_DATA <= data_read_from_memory[7:0];     byte_cnt<=32'd0;          end
    endcase*/



/*
ila_0 ila_dbg(
    .clk(clk_10Mhz),
    .probe0(state),
    .probe1(ddr3_done),
    .probe2(wr_en),
    .probe3(fifo_pre_rd_en),
    .probe4(fifo_pre_dout), //128bit
    .probe5(fifo_pre_full),
    .probe6(fifo_pre_rd_count), //10bit
    .probe7(fifo_pre_empty),
    .probe8(fifo_post_empty)
    //.probe9(data_read_from_memory) //128bit
);*/


/*
module test_ddr3_fifo 
(
// Inouts
   inout [15:0]                       ddr3_dq,
   inout [1:0]                        ddr3_dqs_n,
   inout [1:0]                        ddr3_dqs_p,

   // Outputs
   output [13:0]                      ddr3_addr,
   output [2:0]                       ddr3_ba,
   output                             ddr3_ras_n,
   output                             ddr3_cas_n,
   output                             ddr3_we_n,
   output                             ddr3_reset_n,
   output [0:0]                       ddr3_ck_p,
   output [0:0]                       ddr3_ck_n,
   output [0:0]                       ddr3_cke,
   output [1:0]                       ddr3_dm,
   output [0:0]                       ddr3_odt,
  

   //output                             tg_compare_error,
   //output                             init_calib_complete,

   input                              sys_clk,
   input                              sys_rst_n,
   output                             led_1
);



wire clk_200Mhz;
wire clk_10Mhz;

reg  [27:0] app_addr = 0;
reg  [2:0]  app_cmd = 0;
reg  app_en;
wire app_rdy;

reg  [127:0] app_wdf_data;
wire app_wdf_end = 1;
reg  app_wdf_wren;
wire app_wdf_rdy;

wire [127:0] app_rd_data;
wire [15:0]  app_wdf_mask = 0;
wire app_rd_data_end;
wire app_rd_data_valid;

wire app_sr_req = 0;
wire app_ref_req = 0;
wire app_zq_req = 0;
wire app_sr_active;
wire app_ref_ack;
wire app_zq_ack;

wire ui_clk;
wire ui_clk_sync_rst;

wire [11:0] device_temp;
wire init_calib_complete;

reg [127:0] data_to_write = {32'hcafebabe, 32'h12345678, 32'hAA55AA55, 32'h55AA55AA};
reg [127:0] data_read_from_memory = 128'd0;

reg r_led;
reg [31:0] count;
reg data_valid;

initial begin
    r_led<=1'b1;
    count<=32'd0;
    data_valid<=1'b0;
end


assign led_1 = r_led;


// DDR3 core requires 200MHz input clock
pll pll_inst(   
    .clk_in1(sys_clk),
    .reset(1'b0), 
    .clk_out1(clk_200Mhz),
    .clk_out2(clk_10Mhz)
);
   
ddr3 ddr3_inst
(  
// Memory interface ports
       .ddr3_addr                      (ddr3_addr),
       .ddr3_ba                        (ddr3_ba),
       .ddr3_cas_n                     (ddr3_cas_n),
       .ddr3_ck_n                      (ddr3_ck_n),
       .ddr3_ck_p                      (ddr3_ck_p),
       .ddr3_cke                       (ddr3_cke),
       .ddr3_ras_n                     (ddr3_ras_n),
       .ddr3_we_n                      (ddr3_we_n),
       .ddr3_dq                        (ddr3_dq),
       .ddr3_dqs_n                     (ddr3_dqs_n),
       .ddr3_dqs_p                     (ddr3_dqs_p),
       .ddr3_reset_n                   (ddr3_reset_n),
       .init_calib_complete            (init_calib_complete),
       .ddr3_dm                        (ddr3_dm),
       .ddr3_odt                       (ddr3_odt),
       
// Application interface ports
       .app_addr                       (app_addr),
       .app_cmd                        (app_cmd),
       .app_en                         (app_en),
       .app_wdf_data                   (app_wdf_data),
       .app_wdf_end                    (app_wdf_end),
       .app_wdf_wren                   (app_wdf_wren),
       .app_rd_data                    (app_rd_data),
       .app_rd_data_end                (app_rd_data_end),
       .app_rd_data_valid              (app_rd_data_valid),
       .app_rdy                        (app_rdy),
       .app_wdf_rdy                    (app_wdf_rdy),
       .app_sr_req                     (1'b0),
       .app_ref_req                    (1'b0),
       .app_zq_req                     (1'b0),
       .app_sr_active                  (app_sr_active),
       .app_ref_ack                    (app_ref_ack),
       .app_zq_ack                     (app_zq_ack),
       
       .ui_clk                         (ui_clk),
       .ui_clk_sync_rst                (ui_clk_sync_rst),
       
       .app_wdf_mask                   (app_wdf_mask),
       
// System Clock Ports
       .sys_clk_i                      (clk_200Mhz),//300mhz
//     .device_temp                    (device_temp),
       .sys_rst                        (1'b1)
);


localparam IDLE       = 3'd0;
localparam WRITE      = 3'd1;
localparam WRITE_DONE = 3'd2;
localparam READ       = 3'd3;
localparam READ_DONE  = 3'd4;
localparam PARK       = 3'd5;
reg [2:0] state = IDLE;

localparam CMD_WRITE = 3'b000;
localparam CMD_READ  = 3'b001;


always@(posedge clk_10Mhz) begin
    count = count+32'd1;
    case (count)
        32'd2000000: begin r_led <= ~r_led; count =32'd0; end
    endcase   
end


ila_0 ila_dbg(
    .clk(ui_clk),
    .probe0(state),
    .probe1(init_calib_complete),
    .probe2(data_valid),
    .probe3(data_read_from_memory)
);

always@(posedge ui_clk) begin
  if (ui_clk_sync_rst) begin
    state <= IDLE;
    app_en <= 0;
    app_wdf_wren <= 0;
  end else begin

    case (state)
      IDLE: begin
        if (init_calib_complete) begin
          state <= WRITE;
        end
      end

      WRITE: begin
        if (app_rdy & app_wdf_rdy) begin
          state <= WRITE_DONE;
          app_en <= 1;
          app_wdf_wren <= 1;
          app_addr <= 0;
          app_cmd <= CMD_WRITE;
          app_wdf_data <= data_to_write;
        end
      end

      WRITE_DONE: begin
        if (app_rdy & app_en) begin
          app_en <= 0;
        end

        if (app_wdf_rdy & app_wdf_wren) begin
          app_wdf_wren <= 0;
        end

        if (~app_en & ~app_wdf_wren) begin
          state <= READ;
        end
      end

      READ: begin
        if (app_rdy) begin
          app_en <= 1;
          app_addr <= 0;
          app_cmd <= CMD_READ;
          state <= READ_DONE;
        end
      end

      READ_DONE: begin
        if (app_rdy & app_en) begin
          app_en <= 0;
        end

        if (app_rd_data_valid) begin
          data_read_from_memory <= app_rd_data;
          state <= PARK;
        end
      end

      PARK: begin
        if (data_to_write == data_read_from_memory) begin
          data_valid<=1'b1;
        end else if (data_to_write != data_read_from_memory) begin
          data_valid<=1'b0;
        end
        state <= IDLE;
      end

      default: state <= IDLE;
    endcase
  end
end

endmodule*/



