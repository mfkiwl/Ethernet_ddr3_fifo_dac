`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2019 11:38:50
// Design Name: 
// Module Name: deepfifo
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


module deepfifo
#(
   parameter base_addr              = 0,
   parameter addr_width             = 32,
   parameter log2_ram_size_addr     = 27,
   parameter log2_word_width        = 6,    //2^6=64bit,  2^7=128bit
   parameter log2_fifo_words        = 7,    //2^7=128, 2^9=512
   parameter log2_burst_words       = 4,
   parameter fifo_threshold         = 64,
   
   localparam log2_word_addr_size   = log2_word_width - 3, // Byte addressing
   localparam log2_words_in_ram     = log2_ram_size_addr - log2_word_addr_size,
   localparam log2_bursts_in_ram    = log2_words_in_ram - log2_burst_words,
   localparam word_width            = 1 << log2_word_width,
   localparam bursts_in_ram         = 1 << log2_bursts_in_ram,
   localparam burst_words           = 1 << log2_burst_words,
   localparam burst_addr_size       = 1 << (log2_burst_words + log2_word_addr_size),
   localparam fifo_words            = 1 << log2_fifo_words,
   localparam strobe_width          = 1 << (log2_word_width - 3)
) (
   input                            clk,
   input 			                reset, // Asynchronous reset, active high

   output reg 			            fifo_pre_rd_en,
   input 			                fifo_pre_empty,
   input [word_width-1:0] 	        fifo_pre_dout,
   input [log2_fifo_words:0] 	    fifo_pre_rd_count,

   output reg 			            fifo_post_wr_en,
   input 			                fifo_post_full,
   output reg [word_width-1:0] 	    fifo_post_din,
   input [log2_fifo_words:0] 	    fifo_post_wr_count,

   output reg			            axi_aresetn,
   output reg [addr_width-1:0] 	    axi_awaddr,
   output [7:0] 		            axi_awlen,
   output [2:0] 		            axi_awsize,
   output [1:0] 		            axi_awburst,
   output reg 			            axi_awvalid,
   input 			                axi_awready,
   output [word_width-1:0] 	        axi_wdata,
   output [strobe_width-1:0] 	    axi_wstrb,
   output reg 			            axi_wlast,
   output reg 			            axi_wvalid,
   input 			                axi_wready,

   input 			                axi_bvalid,
   output 			                axi_bready,

   output reg [addr_width-1:0] 	    axi_araddr,
   output [7:0] 		            axi_arlen,
   output [2:0] 		            axi_arsize,
   output [1:0] 		            axi_arburst,
   output reg 			            axi_arvalid,
   input 			                axi_arready,
   input [word_width-1:0] 	        axi_rdata,
   input 			                axi_rlast,
   input 			                axi_rvalid,
   output reg 			            axi_rready
  );

   reg 				                resetn_async;
   reg [2:0] 			            resetn_guard;
   reg 				                bypass_mode;
   reg 				                fifo_pre_fetch;
   reg 				                fifo_pre_valid;
   reg 				                beat_to_ram, beat_from_ram;
   reg 				                do_to_ram_burst, do_from_ram_burst;
   reg [log2_burst_words:0] 	    to_ram_increase, from_ram_decrease;
   reg [log2_words_in_ram:0] 	    next_beats_to_ram_left, beats_to_ram_left;
   reg [log2_bursts_in_ram:0] 	    next_bursts_from_ram_left, bursts_from_ram_left;
   reg [log2_burst_words-1:0] 	    next_wburst_count, wburst_count;
   reg [log2_bursts_in_ram:0] 	    bursts_allocated, bursts_stored;
   reg [log2_bursts_in_ram-1:0]     to_ram_burst_pos, from_ram_burst_pos;
   reg [log2_fifo_words:0] 	        min_pre_rd_count;
   reg [log2_fifo_words+1:0] 	    max_post_wr_count;
   reg 				                next_axi_wvalid, next_axi_wlast;
   reg 				                next_axi_rready;
   reg 				                from_ram_last;

   initial resetn_guard = 0;

   assign axi_bready = 1;
   assign axi_wstrb = { strobe_width{ 1'b1 } };
   assign axi_awlen = burst_words - 1;
   assign axi_arlen = burst_words - 1;
   assign axi_awsize = log2_word_width - 3;
   assign axi_arsize = log2_word_width - 3;
   assign axi_awburst = 2'b01; // Incrementing burst
   assign axi_arburst = 2'b01; // Incrementing burst
   assign axi_wdata = fifo_pre_dout;

   always @(*)
     begin
	fifo_pre_rd_en <= !fifo_pre_empty &&
			  (!fifo_pre_valid || fifo_pre_fetch);

	if (bypass_mode)
	  begin
	     fifo_pre_fetch <= fifo_post_wr_en;
	     fifo_post_wr_en <= fifo_pre_valid && !fifo_post_full;
	     fifo_post_din <= fifo_pre_dout;
	  end
	else
	  begin
	     fifo_pre_fetch <= beat_to_ram;
	     fifo_post_wr_en <= beat_from_ram;
	     fifo_post_din <= axi_rdata;
	  end

	// AXI to-RAM logic
	beat_to_ram <= axi_wvalid && axi_wready;
	to_ram_increase <= do_to_ram_burst ? burst_words : 0;

	do_to_ram_burst <= !axi_awvalid && !bypass_mode &&
			   (fifo_pre_rd_count >= min_pre_rd_count) &&
			   (bursts_allocated < bursts_in_ram);

	next_beats_to_ram_left <= beats_to_ram_left + to_ram_increase
				  - beat_to_ram;
	next_axi_wvalid <= (next_beats_to_ram_left != 0);

	if (bypass_mode)
	  next_wburst_count <= burst_words - 1; // Kind-of reset
	else if (!beat_to_ram)
	  next_wburst_count <= wburst_count;
	else if (wburst_count == 0)
	  next_wburst_count <= burst_words - 1;
	else
	  next_wburst_count <= wburst_count - 1;

	next_axi_wlast <= (next_wburst_count == 0);

	// AXI from-RAM logic
	beat_from_ram <= axi_rvalid && axi_rready;
	from_ram_last <= beat_from_ram && axi_rlast;

	from_ram_decrease <= do_from_ram_burst ? burst_words : 0;

	// max_post_wr_count can become "negative", in which case its MSb
	// is '1', and the comparison with fifo_post_wr_count as unsigned
	// numbers is always true. So require this MSb to be '0'.
	do_from_ram_burst <= !axi_arvalid && !bypass_mode &&
			     (fifo_post_wr_count <= max_post_wr_count) &&
			     !max_post_wr_count[log2_fifo_words+1] &&
			     (bursts_stored != 0);

	next_bursts_from_ram_left <= bursts_from_ram_left + do_from_ram_burst
				     - from_ram_last;

	next_axi_rready <= (next_bursts_from_ram_left != 0);
     end

   always @(posedge clk or posedge reset)
     if (reset)
       resetn_async <= 0;
     else
       resetn_async <= 1;

   always @(posedge clk)
     begin
	beats_to_ram_left <= next_beats_to_ram_left;
	axi_wvalid <= next_axi_wvalid;
	wburst_count <= next_wburst_count;
	axi_wlast <= next_axi_wlast;
	bursts_from_ram_left <= next_bursts_from_ram_left;
	axi_rready <= next_axi_rready;

	resetn_guard <= { resetn_guard, resetn_async };
	axi_aresetn <= resetn_guard[1] && resetn_guard[2];

	if (fifo_pre_rd_en)
	  fifo_pre_valid <= 1;
	else if (fifo_pre_fetch)
	  fifo_pre_valid <= 0;

	if (fifo_pre_rd_count >= fifo_threshold)
	  bypass_mode <= 0;
	else if ((bursts_allocated == 0) && !do_to_ram_burst)
	  bypass_mode <= 1;

	if (do_to_ram_burst)
	  begin
	     axi_awvalid <= 1;
	  end
	else if (axi_awvalid && axi_awready)
	  begin
	     axi_awvalid <= 0;

	     if (to_ram_burst_pos == (bursts_in_ram - 1))
	       begin
		  axi_awaddr <= base_addr;
		  to_ram_burst_pos <= 0;
	       end
	     else
	       begin
		  axi_awaddr <= axi_awaddr + burst_addr_size;
		  to_ram_burst_pos <= to_ram_burst_pos + 1;
	       end
	  end

	if (do_from_ram_burst)
	  begin
	     axi_arvalid <= 1;
	  end
	else if (axi_arvalid && axi_arready)
	  begin
	     axi_arvalid <= 0;

	     if (from_ram_burst_pos == (bursts_in_ram - 1))
	       begin
		  axi_araddr <= base_addr;
		  from_ram_burst_pos <= 0;
	       end
	     else
	       begin
		  axi_araddr <= axi_araddr + burst_addr_size;
		  from_ram_burst_pos <= from_ram_burst_pos + 1;
	       end
	  end

	bursts_allocated <= bursts_allocated + do_to_ram_burst
			    - from_ram_last;

	bursts_stored <= bursts_stored + axi_bvalid - do_from_ram_burst;

	min_pre_rd_count <= min_pre_rd_count + to_ram_increase
			    - beat_to_ram;

	max_post_wr_count <= max_post_wr_count + beat_from_ram
			     - from_ram_decrease;

	if (bypass_mode) // Resets RAM logic
	  begin
	     bursts_allocated <= 0;
	     bursts_stored <= 0;
	     min_pre_rd_count <= burst_words + 8;
	     max_post_wr_count <= fifo_words - burst_words - 8;
	     axi_awvalid <= 0;
	     axi_arvalid <= 0;
	     beats_to_ram_left <= 0;
	     bursts_from_ram_left <= 0;
	  end

	if (!axi_aresetn)
	  begin
	     bypass_mode <= 1;
	     fifo_pre_valid <= 0;
	     to_ram_burst_pos <= 0;
	     from_ram_burst_pos <= 0;
	     axi_awaddr <= 0;
	     axi_araddr <= 0;
	  end
     end
endmodule
