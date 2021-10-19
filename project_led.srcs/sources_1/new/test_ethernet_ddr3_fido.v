`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.05.2019 07:41:46
// Design Name: 
// Module Name: test_ethernet_ddr3_fido
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


module test_ethernet_ddr3_fido
(
    input               sys_clk,
    input               sys_rst_n,
    output              led_1,
    
    //Ethernet PHY RTL8211
    inout               PHY_MDIO,             
    output              PHY_MDC,
    input               PHY_RXC,    
    input               PHY_RXDV,    
    input               PHY_RXER,
    input  [7:0]        PHY_RXD,
    input               PHY_TXC,           
    output              PHY_GTXC,   
    output              PHY_TXEN, 
    output              PHY_TXER,                     
    output [7:0]        PHY_TXD,
    output reg          PHY_RESET_N,
    
    //DDR3
    inout [15:0]        ddr3_dq,
    inout [1:0]         ddr3_dqs_n,
    inout [1:0]         ddr3_dqs_p,
    output [13:0]       ddr3_addr,
    output [2:0]        ddr3_ba,
    output              ddr3_ras_n,
    output              ddr3_cas_n,
    output              ddr3_we_n,
    output              ddr3_reset_n, 
    output [0:0]        ddr3_ck_p,
    output [0:0]        ddr3_ck_n,
    output [0:0]        ddr3_cke,
    output [1:0]        ddr3_dm,
    output [0:0]        ddr3_odt,
    
    //ADC & DAC module
    output              ADC_CLK,
    output              DAC_CLK,
    input  [7:0]        ADC_DATA,
    output reg [7:0]    DAC_DATA  
);


wire            fifo_pre_rd_en;
wire            fifo_pre_empty;
wire [63:0]     fifo_pre_dout;
wire [7:0] 	    fifo_pre_rd_count;
wire [9:0] 	    fifo_pre_wr_count;

wire 	        fifo_post_wr_en;
wire 	        fifo_post_full;
wire [63:0]     fifo_post_din;
wire [7:0] 	    fifo_post_wr_count;
wire [9:0]      fifo_post_rd_count;

wire 	        axi_clk;
wire 	        axi_aresetn;
wire [31:0] 	axi_awaddr;
wire [7:0] 	    axi_awlen;
wire [2:0] 	    axi_awsize;
wire [1:0] 	    axi_awburst;
wire 	        axi_awvalid;
wire 	        axi_awready;
wire [63:0]     axi_wdata;
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
wire [63:0]     axi_rdata;
wire 	        axi_rlast;
wire 	        axi_rvalid;
wire 	        axi_rready;

wire            clk_10Mhz;
wire            clk_50Mhz;
wire            clk_125Mhz;
wire            clk_200Mhz;

wire ddr3_done;
wire fifo_post_empty;
wire fifo_pre_full;

reg r_led;
reg [31:0] count;
reg wr_en;
reg rd_en;

reg  clk_1024Hz;
reg  clk_1Mhz;
reg  clk_5Mhz;
reg  dac_clk;
reg  rd_data;
reg  rd_lock;

wire [7:0]  data_read_from_memory;
reg  [7:0]  data_to_write = 8'd0;
reg  [31:0] fifo_wr_cnt = 32'd0;
reg  [31:0] fifo_rd_cnt = 32'd0;
reg  [31:0] dac_cnt;
reg  [31:0] pause_cnt;
reg  [31:0] byte_cnt;
reg  [7:0]  test_byte;


initial begin
    r_led       <=1'b1;
    count       <=32'd0;
    wr_en       <=1'b0;
    rd_en       <=1'b0;
    dac_clk     <=1'b0;
    dac_cnt     <=32'd0;
    pause_cnt   <=32'd0;
    byte_cnt    <=32'd0;
    rd_data     <=1'b0;
    rd_lock     <=1'b0;
    test_byte   <=8'd0;
end

localparam IDLE       = 3'd0;
localparam WRITE      = 3'd1;
localparam READ       = 3'd2;
localparam PAUSE      = 3'd3;
reg [2:0] state       = IDLE;
reg [2:0] dac_state   = IDLE;


assign led_1            = r_led;
//assign PHY_RESET_N      = 1'b1; 
assign PHY_MDC          = 1'b1;
assign PHY_MDIO         = 1'b1;
assign PHY_GTXC         = ~clk_125Mhz;
assign DAC_CLK          = clk_50Mhz;//dac_clk;



//DDR3 core requires 200MHz input clock
pll pll_inst(   
    .clk_in1(sys_clk),      //50Mhz
    .reset(~sys_rst_n),     //Active high
    .clk_out1(clk_10Mhz),
    .clk_out2(clk_125Mhz),
    .clk_out3(clk_200Mhz),
    .clk_out4(clk_50Mhz)
);

deepfifo#(
    .log2_ram_size_addr(27),    //134Mbytes
    .log2_word_width(6),        //2^6=64bit,  2^7=128bit
    .log2_fifo_words(7),        //2^7=128, 2^9=512
    .fifo_threshold(64) 
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
    .s_axi_wdata                    (axi_wdata),        // input [63:0]	    s_axi_wdata
    .s_axi_wstrb                    (axi_wstrb),        // input [15:0]		s_axi_wstrb
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
    .s_axi_rdata                    (axi_rdata),        // output [63:0]	s_axi_rdata
    .s_axi_rresp                    (),                 // output [1:0]		s_axi_rresp
    .s_axi_rlast                    (axi_rlast),        // output			s_axi_rlast
    .s_axi_rvalid                   (axi_rvalid),       // output			s_axi_rvalid
    .s_axi_rready                   (axi_rready),       // input			s_axi_rready
    
    // System Clock Ports
    .sys_clk_i                      (clk_200Mhz),       // input 200Mhz
    .sys_rst                        (sys_rst_n)         // Active low
);

wire fifo_dac_wr_clk;
wire fifo_dac_wr_en;
wire [7:0] fifo_dac_data;

//FIFO in--> 8bit 1024words out--> 64bit 128 words
fifo_pre fifo_pre_512
(
    .wr_clk(fifo_dac_wr_clk),//user_clk clk_125Mhz
    .rd_clk(axi_clk),
    .rst(~sys_rst_n),
    .din(fifo_dac_data), //8bit
    .wr_en(fifo_dac_wr_en),
    .rd_en(fifo_pre_rd_en),
    .dout(fifo_pre_dout),
    .full(fifo_pre_full),
    .rd_data_count(fifo_pre_rd_count),
    .wr_data_count(),
    .empty(fifo_pre_empty)
);

//FIFO in--> 64bit 128 words out--> 8bit 1024words 
fifo_post fifo_post_512
(
    .wr_clk(axi_clk),
    .rd_clk(clk_50Mhz),//user_clk
    .rst(~sys_rst_n),
    .din(fifo_post_din),
    .wr_en(fifo_post_wr_en),
    .rd_en(rd_en),
    .dout(data_read_from_memory),//8bit
    .full(fifo_post_full),
    .rd_data_count(fifo_post_rd_count),
    .wr_data_count(fifo_post_wr_count),
    .empty(fifo_post_empty)
);

//ila_0 ila_dbg(
//    .clk(clk_50Mhz),
//    .probe0(state),
//    .probe1(ddr3_done),
//    .probe2(rd_en),
//    .probe3(fifo_post_empty),
//    .probe4(fifo_post_full),
//    .probe5(clk_50Mhz),
//    .probe6(DAC_DATA)              //8bit
//    //.probe7(data_read_from_memory)  //8bit
//    //.probe8(fifo_post_rd_data_count)
//);

/****************************************************************************************************/

wire  [31:0] crcnext;
wire  [31:0] crc32;
wire  crcreset;
wire  crcen;
wire  data_ok;

wire [7:0]   IP4_type;
wire [31:0]  IP4_src;
wire [511:0] ICMP_data;
wire [567:0] UDP_data;

wire [15:0] len_IPv4;
wire [15:0] len_ICMP;
wire [15:0] len_UDP;

wire [15:0]  UDP_SP;
wire [15:0]  UDP_DP;
wire [15:0]  UDP_DATA_LEN;

wire [47:0]  pc_mac;   
wire [47:0]  eth_dest;
wire [47:0]  eth_src;
wire [15:0]  eth_type;
wire [47:0]  sender_mac;
wire [31:0]  sender_ip;
wire [31:0]  target_ip;

ipsend ipsend_inst
(
	.clk(clk_125Mhz),
	.txen(PHY_TXEN),
	.txer(PHY_TXER),
	.dataout(PHY_TXD),
	.e_rxdv(PHY_RXDV),
	.datain(),
	
	.crc(crc32),
	.crcen(crcen),
	.crcre(crcreset),
	
	.tx_state(),
	.tx_data_length(16'd1032),
	.tx_total_length(16'd1052),
	.data_ok(data_ok),

	.eth_dest(eth_dest),
	.eth_src(eth_src),
	.eth_type(eth_type),
	.sender_mac(sender_mac),
	.sender_ip(sender_ip),
	.target_ip(target_ip),
	
	.IP4_type(IP4_type),
	.IP4_src(IP4_src),
	.len_IPv4(len_IPv4),
	.len_ICMP(len_ICMP),
	.ICMP_data(ICMP_data),
	.len_UDP(len_UDP),
	.UDP_data(UDP_data),
	.UDP_SP(UDP_SP),
    .UDP_DP(UDP_DP),
    .UDP_DATA_LEN(UDP_DATA_LEN) 
);


crc	crc_inst
(
	.Clk(clk_125Mhz),
	.Reset(crcreset),
	.Enable(crcen),
	.Data_in(PHY_TXD),
	.Crc(crc32),
	.CrcNext(crcnext)
);

iprecieve iprecieve_inst
(
	.clk(PHY_RXC),
	.datain(PHY_RXD),
	.e_rxdv(PHY_RXDV),	
	.clr(sys_rst_n),                                    
	.rx_state(),
	.tx_en(PHY_TXEN),

	.eth_dest(eth_dest),
	.eth_src(eth_src),
	.eth_type(eth_type),
	.sender_mac(sender_mac),
	.sender_ip(sender_ip),
	.target_ip(target_ip),
	
	.PHYSR(),
	.data_ok(data_ok),
	.IP4_type(IP4_type),
	.IP4_src(IP4_src),
	.len_IPv4(len_IPv4),
	
	.len_ICMP(len_ICMP),
	.ICMP_data(ICMP_data),
	
	.len_UDP(len_UDP),
	.UDP_data(UDP_data),
	.UDP_SP(UDP_SP),
    .UDP_DP(UDP_DP),
    .UDP_DATA_LEN(UDP_DATA_LEN),
    
    .fifo_dac_wr_clk(fifo_dac_wr_clk),
    .fifo_dac_wr_en(fifo_dac_wr_en),
    .fifo_dac_data(fifo_dac_data)
);


/****************************************************************************************************/
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


/****************************************************************************************************/
//TEST Write DATA to DDR3
/*always@(posedge clk_125Mhz) begin
    case (state)
      IDLE: begin
        if (ddr3_done) begin
          fifo_wr_cnt<=32'd0; 
          wr_en<=1'b1;
          state<=WRITE;
        end
      end

      WRITE: begin
        if (fifo_wr_cnt<32'd50000) begin
          fifo_wr_cnt<=fifo_wr_cnt+1'b1;
          test_byte<=test_byte+1'b1;
          data_to_write<=test_byte;
        end else begin
            wr_en<=1'b0;
            state<=PAUSE;
        end
      end
      
      PAUSE: begin
        if (pause_cnt<32'd124950000) begin
            pause_cnt<=pause_cnt+1'b1;
        end else begin
            state<=IDLE;
            pause_cnt<=32'd0;
        end
      end

      default: state<=IDLE;
    endcase
end*/



//Read DATA from DDR3 & write to DAC
always@(posedge clk_50Mhz) begin
    if(~fifo_post_empty) begin
        rd_en<=1'b1;
        if(data_read_from_memory[7]==1'b0)
            DAC_DATA <= data_read_from_memory + 8'd127;    
        else
            DAC_DATA <= data_read_from_memory - 8'd127;
    end else begin
        rd_en<=1'b0;
    end       
end

endmodule
