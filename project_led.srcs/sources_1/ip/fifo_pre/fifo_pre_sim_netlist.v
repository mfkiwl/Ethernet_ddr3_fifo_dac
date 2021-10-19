// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Thu Jul 29 10:54:35 2021
// Host        : pc running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/master/Work/test_ethernet_ddr3_fifo/project_led.srcs/sources_1/ip/fifo_pre/fifo_pre_sim_netlist.v
// Design      : fifo_pre
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tftg256-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fifo_pre,fifo_generator_v13_2_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v13_2_5,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module fifo_pre
   (rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en,
    dout,
    full,
    empty,
    rd_data_count,
    wr_data_count,
    wr_rst_busy,
    rd_rst_busy);
  input rst;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 write_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME write_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input wr_clk;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 read_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME read_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input rd_clk;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_DATA" *) input [7:0]din;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *) input wr_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *) input rd_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_DATA" *) output [63:0]dout;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *) output full;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ EMPTY" *) output empty;
  output [6:0]rd_data_count;
  output [9:0]wr_data_count;
  output wr_rst_busy;
  output rd_rst_busy;

  wire [7:0]din;
  wire [63:0]dout;
  wire empty;
  wire full;
  wire rd_clk;
  wire [6:0]rd_data_count;
  wire rd_en;
  wire rd_rst_busy;
  wire rst;
  wire wr_clk;
  wire [9:0]wr_data_count;
  wire wr_en;
  wire wr_rst_busy;
  wire NLW_U0_almost_empty_UNCONNECTED;
  wire NLW_U0_almost_full_UNCONNECTED;
  wire NLW_U0_axi_ar_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_overflow_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_full_UNCONNECTED;
  wire NLW_U0_axi_ar_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_underflow_UNCONNECTED;
  wire NLW_U0_axi_aw_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_overflow_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_full_UNCONNECTED;
  wire NLW_U0_axi_aw_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_underflow_UNCONNECTED;
  wire NLW_U0_axi_b_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_overflow_UNCONNECTED;
  wire NLW_U0_axi_b_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_b_prog_full_UNCONNECTED;
  wire NLW_U0_axi_b_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_underflow_UNCONNECTED;
  wire NLW_U0_axi_r_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_overflow_UNCONNECTED;
  wire NLW_U0_axi_r_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_r_prog_full_UNCONNECTED;
  wire NLW_U0_axi_r_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_underflow_UNCONNECTED;
  wire NLW_U0_axi_w_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_overflow_UNCONNECTED;
  wire NLW_U0_axi_w_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_w_prog_full_UNCONNECTED;
  wire NLW_U0_axi_w_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_underflow_UNCONNECTED;
  wire NLW_U0_axis_dbiterr_UNCONNECTED;
  wire NLW_U0_axis_overflow_UNCONNECTED;
  wire NLW_U0_axis_prog_empty_UNCONNECTED;
  wire NLW_U0_axis_prog_full_UNCONNECTED;
  wire NLW_U0_axis_sbiterr_UNCONNECTED;
  wire NLW_U0_axis_underflow_UNCONNECTED;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_m_axi_arvalid_UNCONNECTED;
  wire NLW_U0_m_axi_awvalid_UNCONNECTED;
  wire NLW_U0_m_axi_bready_UNCONNECTED;
  wire NLW_U0_m_axi_rready_UNCONNECTED;
  wire NLW_U0_m_axi_wlast_UNCONNECTED;
  wire NLW_U0_m_axi_wvalid_UNCONNECTED;
  wire NLW_U0_m_axis_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_tvalid_UNCONNECTED;
  wire NLW_U0_overflow_UNCONNECTED;
  wire NLW_U0_prog_empty_UNCONNECTED;
  wire NLW_U0_prog_full_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_s_axis_tready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire NLW_U0_underflow_UNCONNECTED;
  wire NLW_U0_valid_UNCONNECTED;
  wire NLW_U0_wr_ack_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_wr_data_count_UNCONNECTED;
  wire [9:0]NLW_U0_data_count_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_araddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_arburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_arlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_aruser_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_awaddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_awburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_awlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awuser_UNCONNECTED;
  wire [63:0]NLW_U0_m_axi_wdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_wstrb_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wuser_UNCONNECTED;
  wire [7:0]NLW_U0_m_axis_tdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tdest_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tid_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tkeep_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tstrb_UNCONNECTED;
  wire [3:0]NLW_U0_m_axis_tuser_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_buser_UNCONNECTED;
  wire [63:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_ruser_UNCONNECTED;

  (* C_ADD_NGC_CONSTRAINT = "0" *) 
  (* C_APPLICATION_TYPE_AXIS = "0" *) 
  (* C_APPLICATION_TYPE_RACH = "0" *) 
  (* C_APPLICATION_TYPE_RDCH = "0" *) 
  (* C_APPLICATION_TYPE_WACH = "0" *) 
  (* C_APPLICATION_TYPE_WDCH = "0" *) 
  (* C_APPLICATION_TYPE_WRCH = "0" *) 
  (* C_AXIS_TDATA_WIDTH = "8" *) 
  (* C_AXIS_TDEST_WIDTH = "1" *) 
  (* C_AXIS_TID_WIDTH = "1" *) 
  (* C_AXIS_TKEEP_WIDTH = "1" *) 
  (* C_AXIS_TSTRB_WIDTH = "1" *) 
  (* C_AXIS_TUSER_WIDTH = "4" *) 
  (* C_AXIS_TYPE = "0" *) 
  (* C_AXI_ADDR_WIDTH = "32" *) 
  (* C_AXI_ARUSER_WIDTH = "1" *) 
  (* C_AXI_AWUSER_WIDTH = "1" *) 
  (* C_AXI_BUSER_WIDTH = "1" *) 
  (* C_AXI_DATA_WIDTH = "64" *) 
  (* C_AXI_ID_WIDTH = "1" *) 
  (* C_AXI_LEN_WIDTH = "8" *) 
  (* C_AXI_LOCK_WIDTH = "1" *) 
  (* C_AXI_RUSER_WIDTH = "1" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_AXI_WUSER_WIDTH = "1" *) 
  (* C_COMMON_CLOCK = "0" *) 
  (* C_COUNT_TYPE = "0" *) 
  (* C_DATA_COUNT_WIDTH = "10" *) 
  (* C_DEFAULT_VALUE = "BlankString" *) 
  (* C_DIN_WIDTH = "8" *) 
  (* C_DIN_WIDTH_AXIS = "1" *) 
  (* C_DIN_WIDTH_RACH = "32" *) 
  (* C_DIN_WIDTH_RDCH = "64" *) 
  (* C_DIN_WIDTH_WACH = "1" *) 
  (* C_DIN_WIDTH_WDCH = "64" *) 
  (* C_DIN_WIDTH_WRCH = "2" *) 
  (* C_DOUT_RST_VAL = "0" *) 
  (* C_DOUT_WIDTH = "64" *) 
  (* C_ENABLE_RLOCS = "0" *) 
  (* C_ENABLE_RST_SYNC = "1" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_ERROR_INJECTION_TYPE = "0" *) 
  (* C_ERROR_INJECTION_TYPE_AXIS = "0" *) 
  (* C_ERROR_INJECTION_TYPE_RACH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WACH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WRCH = "0" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_FULL_FLAGS_RST_VAL = "1" *) 
  (* C_HAS_ALMOST_EMPTY = "0" *) 
  (* C_HAS_ALMOST_FULL = "0" *) 
  (* C_HAS_AXIS_TDATA = "1" *) 
  (* C_HAS_AXIS_TDEST = "0" *) 
  (* C_HAS_AXIS_TID = "0" *) 
  (* C_HAS_AXIS_TKEEP = "0" *) 
  (* C_HAS_AXIS_TLAST = "0" *) 
  (* C_HAS_AXIS_TREADY = "1" *) 
  (* C_HAS_AXIS_TSTRB = "0" *) 
  (* C_HAS_AXIS_TUSER = "1" *) 
  (* C_HAS_AXI_ARUSER = "0" *) 
  (* C_HAS_AXI_AWUSER = "0" *) 
  (* C_HAS_AXI_BUSER = "0" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_AXI_RD_CHANNEL = "1" *) 
  (* C_HAS_AXI_RUSER = "0" *) 
  (* C_HAS_AXI_WR_CHANNEL = "1" *) 
  (* C_HAS_AXI_WUSER = "0" *) 
  (* C_HAS_BACKUP = "0" *) 
  (* C_HAS_DATA_COUNT = "0" *) 
  (* C_HAS_DATA_COUNTS_AXIS = "0" *) 
  (* C_HAS_DATA_COUNTS_RACH = "0" *) 
  (* C_HAS_DATA_COUNTS_RDCH = "0" *) 
  (* C_HAS_DATA_COUNTS_WACH = "0" *) 
  (* C_HAS_DATA_COUNTS_WDCH = "0" *) 
  (* C_HAS_DATA_COUNTS_WRCH = "0" *) 
  (* C_HAS_INT_CLK = "0" *) 
  (* C_HAS_MASTER_CE = "0" *) 
  (* C_HAS_MEMINIT_FILE = "0" *) 
  (* C_HAS_OVERFLOW = "0" *) 
  (* C_HAS_PROG_FLAGS_AXIS = "0" *) 
  (* C_HAS_PROG_FLAGS_RACH = "0" *) 
  (* C_HAS_PROG_FLAGS_RDCH = "0" *) 
  (* C_HAS_PROG_FLAGS_WACH = "0" *) 
  (* C_HAS_PROG_FLAGS_WDCH = "0" *) 
  (* C_HAS_PROG_FLAGS_WRCH = "0" *) 
  (* C_HAS_RD_DATA_COUNT = "1" *) 
  (* C_HAS_RD_RST = "0" *) 
  (* C_HAS_RST = "1" *) 
  (* C_HAS_SLAVE_CE = "0" *) 
  (* C_HAS_SRST = "0" *) 
  (* C_HAS_UNDERFLOW = "0" *) 
  (* C_HAS_VALID = "0" *) 
  (* C_HAS_WR_ACK = "0" *) 
  (* C_HAS_WR_DATA_COUNT = "1" *) 
  (* C_HAS_WR_RST = "0" *) 
  (* C_IMPLEMENTATION_TYPE = "2" *) 
  (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) 
  (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_RDCH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WACH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WRCH = "1" *) 
  (* C_INIT_WR_PNTR_VAL = "0" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_MEMORY_TYPE = "1" *) 
  (* C_MIF_FILE_NAME = "BlankString" *) 
  (* C_MSGON_VAL = "1" *) 
  (* C_OPTIMIZATION_MODE = "0" *) 
  (* C_OVERFLOW_LOW = "0" *) 
  (* C_POWER_SAVING_MODE = "0" *) 
  (* C_PRELOAD_LATENCY = "1" *) 
  (* C_PRELOAD_REGS = "0" *) 
  (* C_PRIM_FIFO_TYPE = "1kx18" *) 
  (* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) 
  (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_RDCH = "1kx36" *) 
  (* C_PRIM_FIFO_TYPE_WACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_WDCH = "1kx36" *) 
  (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL = "2" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "3" *) 
  (* C_PROG_EMPTY_TYPE = "0" *) 
  (* C_PROG_EMPTY_TYPE_AXIS = "0" *) 
  (* C_PROG_EMPTY_TYPE_RACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL = "1021" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
  (* C_PROG_FULL_THRESH_NEGATE_VAL = "1020" *) 
  (* C_PROG_FULL_TYPE = "0" *) 
  (* C_PROG_FULL_TYPE_AXIS = "0" *) 
  (* C_PROG_FULL_TYPE_RACH = "0" *) 
  (* C_PROG_FULL_TYPE_RDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WACH = "0" *) 
  (* C_PROG_FULL_TYPE_WDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WRCH = "0" *) 
  (* C_RACH_TYPE = "0" *) 
  (* C_RDCH_TYPE = "0" *) 
  (* C_RD_DATA_COUNT_WIDTH = "7" *) 
  (* C_RD_DEPTH = "128" *) 
  (* C_RD_FREQ = "1" *) 
  (* C_RD_PNTR_WIDTH = "7" *) 
  (* C_REG_SLICE_MODE_AXIS = "0" *) 
  (* C_REG_SLICE_MODE_RACH = "0" *) 
  (* C_REG_SLICE_MODE_RDCH = "0" *) 
  (* C_REG_SLICE_MODE_WACH = "0" *) 
  (* C_REG_SLICE_MODE_WDCH = "0" *) 
  (* C_REG_SLICE_MODE_WRCH = "0" *) 
  (* C_SELECT_XPM = "0" *) 
  (* C_SYNCHRONIZER_STAGE = "2" *) 
  (* C_UNDERFLOW_LOW = "0" *) 
  (* C_USE_COMMON_OVERFLOW = "0" *) 
  (* C_USE_COMMON_UNDERFLOW = "0" *) 
  (* C_USE_DEFAULT_SETTINGS = "0" *) 
  (* C_USE_DOUT_RST = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_ECC_AXIS = "0" *) 
  (* C_USE_ECC_RACH = "0" *) 
  (* C_USE_ECC_RDCH = "0" *) 
  (* C_USE_ECC_WACH = "0" *) 
  (* C_USE_ECC_WDCH = "0" *) 
  (* C_USE_ECC_WRCH = "0" *) 
  (* C_USE_EMBEDDED_REG = "0" *) 
  (* C_USE_FIFO16_FLAGS = "0" *) 
  (* C_USE_FWFT_DATA_COUNT = "0" *) 
  (* C_USE_PIPELINE_REG = "0" *) 
  (* C_VALID_LOW = "0" *) 
  (* C_WACH_TYPE = "0" *) 
  (* C_WDCH_TYPE = "0" *) 
  (* C_WRCH_TYPE = "0" *) 
  (* C_WR_ACK_LOW = "0" *) 
  (* C_WR_DATA_COUNT_WIDTH = "10" *) 
  (* C_WR_DEPTH = "1024" *) 
  (* C_WR_DEPTH_AXIS = "1024" *) 
  (* C_WR_DEPTH_RACH = "16" *) 
  (* C_WR_DEPTH_RDCH = "1024" *) 
  (* C_WR_DEPTH_WACH = "16" *) 
  (* C_WR_DEPTH_WDCH = "1024" *) 
  (* C_WR_DEPTH_WRCH = "16" *) 
  (* C_WR_FREQ = "1" *) 
  (* C_WR_PNTR_WIDTH = "10" *) 
  (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
  (* C_WR_PNTR_WIDTH_RACH = "4" *) 
  (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WACH = "4" *) 
  (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
  (* C_WR_RESPONSE_LATENCY = "1" *) 
  (* is_du_within_envelope = "true" *) 
  fifo_pre_fifo_generator_v13_2_5 U0
       (.almost_empty(NLW_U0_almost_empty_UNCONNECTED),
        .almost_full(NLW_U0_almost_full_UNCONNECTED),
        .axi_ar_data_count(NLW_U0_axi_ar_data_count_UNCONNECTED[4:0]),
        .axi_ar_dbiterr(NLW_U0_axi_ar_dbiterr_UNCONNECTED),
        .axi_ar_injectdbiterr(1'b0),
        .axi_ar_injectsbiterr(1'b0),
        .axi_ar_overflow(NLW_U0_axi_ar_overflow_UNCONNECTED),
        .axi_ar_prog_empty(NLW_U0_axi_ar_prog_empty_UNCONNECTED),
        .axi_ar_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_ar_prog_full(NLW_U0_axi_ar_prog_full_UNCONNECTED),
        .axi_ar_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_ar_rd_data_count(NLW_U0_axi_ar_rd_data_count_UNCONNECTED[4:0]),
        .axi_ar_sbiterr(NLW_U0_axi_ar_sbiterr_UNCONNECTED),
        .axi_ar_underflow(NLW_U0_axi_ar_underflow_UNCONNECTED),
        .axi_ar_wr_data_count(NLW_U0_axi_ar_wr_data_count_UNCONNECTED[4:0]),
        .axi_aw_data_count(NLW_U0_axi_aw_data_count_UNCONNECTED[4:0]),
        .axi_aw_dbiterr(NLW_U0_axi_aw_dbiterr_UNCONNECTED),
        .axi_aw_injectdbiterr(1'b0),
        .axi_aw_injectsbiterr(1'b0),
        .axi_aw_overflow(NLW_U0_axi_aw_overflow_UNCONNECTED),
        .axi_aw_prog_empty(NLW_U0_axi_aw_prog_empty_UNCONNECTED),
        .axi_aw_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_aw_prog_full(NLW_U0_axi_aw_prog_full_UNCONNECTED),
        .axi_aw_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_aw_rd_data_count(NLW_U0_axi_aw_rd_data_count_UNCONNECTED[4:0]),
        .axi_aw_sbiterr(NLW_U0_axi_aw_sbiterr_UNCONNECTED),
        .axi_aw_underflow(NLW_U0_axi_aw_underflow_UNCONNECTED),
        .axi_aw_wr_data_count(NLW_U0_axi_aw_wr_data_count_UNCONNECTED[4:0]),
        .axi_b_data_count(NLW_U0_axi_b_data_count_UNCONNECTED[4:0]),
        .axi_b_dbiterr(NLW_U0_axi_b_dbiterr_UNCONNECTED),
        .axi_b_injectdbiterr(1'b0),
        .axi_b_injectsbiterr(1'b0),
        .axi_b_overflow(NLW_U0_axi_b_overflow_UNCONNECTED),
        .axi_b_prog_empty(NLW_U0_axi_b_prog_empty_UNCONNECTED),
        .axi_b_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_b_prog_full(NLW_U0_axi_b_prog_full_UNCONNECTED),
        .axi_b_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_b_rd_data_count(NLW_U0_axi_b_rd_data_count_UNCONNECTED[4:0]),
        .axi_b_sbiterr(NLW_U0_axi_b_sbiterr_UNCONNECTED),
        .axi_b_underflow(NLW_U0_axi_b_underflow_UNCONNECTED),
        .axi_b_wr_data_count(NLW_U0_axi_b_wr_data_count_UNCONNECTED[4:0]),
        .axi_r_data_count(NLW_U0_axi_r_data_count_UNCONNECTED[10:0]),
        .axi_r_dbiterr(NLW_U0_axi_r_dbiterr_UNCONNECTED),
        .axi_r_injectdbiterr(1'b0),
        .axi_r_injectsbiterr(1'b0),
        .axi_r_overflow(NLW_U0_axi_r_overflow_UNCONNECTED),
        .axi_r_prog_empty(NLW_U0_axi_r_prog_empty_UNCONNECTED),
        .axi_r_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_r_prog_full(NLW_U0_axi_r_prog_full_UNCONNECTED),
        .axi_r_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_r_rd_data_count(NLW_U0_axi_r_rd_data_count_UNCONNECTED[10:0]),
        .axi_r_sbiterr(NLW_U0_axi_r_sbiterr_UNCONNECTED),
        .axi_r_underflow(NLW_U0_axi_r_underflow_UNCONNECTED),
        .axi_r_wr_data_count(NLW_U0_axi_r_wr_data_count_UNCONNECTED[10:0]),
        .axi_w_data_count(NLW_U0_axi_w_data_count_UNCONNECTED[10:0]),
        .axi_w_dbiterr(NLW_U0_axi_w_dbiterr_UNCONNECTED),
        .axi_w_injectdbiterr(1'b0),
        .axi_w_injectsbiterr(1'b0),
        .axi_w_overflow(NLW_U0_axi_w_overflow_UNCONNECTED),
        .axi_w_prog_empty(NLW_U0_axi_w_prog_empty_UNCONNECTED),
        .axi_w_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_w_prog_full(NLW_U0_axi_w_prog_full_UNCONNECTED),
        .axi_w_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_w_rd_data_count(NLW_U0_axi_w_rd_data_count_UNCONNECTED[10:0]),
        .axi_w_sbiterr(NLW_U0_axi_w_sbiterr_UNCONNECTED),
        .axi_w_underflow(NLW_U0_axi_w_underflow_UNCONNECTED),
        .axi_w_wr_data_count(NLW_U0_axi_w_wr_data_count_UNCONNECTED[10:0]),
        .axis_data_count(NLW_U0_axis_data_count_UNCONNECTED[10:0]),
        .axis_dbiterr(NLW_U0_axis_dbiterr_UNCONNECTED),
        .axis_injectdbiterr(1'b0),
        .axis_injectsbiterr(1'b0),
        .axis_overflow(NLW_U0_axis_overflow_UNCONNECTED),
        .axis_prog_empty(NLW_U0_axis_prog_empty_UNCONNECTED),
        .axis_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axis_prog_full(NLW_U0_axis_prog_full_UNCONNECTED),
        .axis_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axis_rd_data_count(NLW_U0_axis_rd_data_count_UNCONNECTED[10:0]),
        .axis_sbiterr(NLW_U0_axis_sbiterr_UNCONNECTED),
        .axis_underflow(NLW_U0_axis_underflow_UNCONNECTED),
        .axis_wr_data_count(NLW_U0_axis_wr_data_count_UNCONNECTED[10:0]),
        .backup(1'b0),
        .backup_marker(1'b0),
        .clk(1'b0),
        .data_count(NLW_U0_data_count_UNCONNECTED[9:0]),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .int_clk(1'b0),
        .m_aclk(1'b0),
        .m_aclk_en(1'b0),
        .m_axi_araddr(NLW_U0_m_axi_araddr_UNCONNECTED[31:0]),
        .m_axi_arburst(NLW_U0_m_axi_arburst_UNCONNECTED[1:0]),
        .m_axi_arcache(NLW_U0_m_axi_arcache_UNCONNECTED[3:0]),
        .m_axi_arid(NLW_U0_m_axi_arid_UNCONNECTED[0]),
        .m_axi_arlen(NLW_U0_m_axi_arlen_UNCONNECTED[7:0]),
        .m_axi_arlock(NLW_U0_m_axi_arlock_UNCONNECTED[0]),
        .m_axi_arprot(NLW_U0_m_axi_arprot_UNCONNECTED[2:0]),
        .m_axi_arqos(NLW_U0_m_axi_arqos_UNCONNECTED[3:0]),
        .m_axi_arready(1'b0),
        .m_axi_arregion(NLW_U0_m_axi_arregion_UNCONNECTED[3:0]),
        .m_axi_arsize(NLW_U0_m_axi_arsize_UNCONNECTED[2:0]),
        .m_axi_aruser(NLW_U0_m_axi_aruser_UNCONNECTED[0]),
        .m_axi_arvalid(NLW_U0_m_axi_arvalid_UNCONNECTED),
        .m_axi_awaddr(NLW_U0_m_axi_awaddr_UNCONNECTED[31:0]),
        .m_axi_awburst(NLW_U0_m_axi_awburst_UNCONNECTED[1:0]),
        .m_axi_awcache(NLW_U0_m_axi_awcache_UNCONNECTED[3:0]),
        .m_axi_awid(NLW_U0_m_axi_awid_UNCONNECTED[0]),
        .m_axi_awlen(NLW_U0_m_axi_awlen_UNCONNECTED[7:0]),
        .m_axi_awlock(NLW_U0_m_axi_awlock_UNCONNECTED[0]),
        .m_axi_awprot(NLW_U0_m_axi_awprot_UNCONNECTED[2:0]),
        .m_axi_awqos(NLW_U0_m_axi_awqos_UNCONNECTED[3:0]),
        .m_axi_awready(1'b0),
        .m_axi_awregion(NLW_U0_m_axi_awregion_UNCONNECTED[3:0]),
        .m_axi_awsize(NLW_U0_m_axi_awsize_UNCONNECTED[2:0]),
        .m_axi_awuser(NLW_U0_m_axi_awuser_UNCONNECTED[0]),
        .m_axi_awvalid(NLW_U0_m_axi_awvalid_UNCONNECTED),
        .m_axi_bid(1'b0),
        .m_axi_bready(NLW_U0_m_axi_bready_UNCONNECTED),
        .m_axi_bresp({1'b0,1'b0}),
        .m_axi_buser(1'b0),
        .m_axi_bvalid(1'b0),
        .m_axi_rdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_rid(1'b0),
        .m_axi_rlast(1'b0),
        .m_axi_rready(NLW_U0_m_axi_rready_UNCONNECTED),
        .m_axi_rresp({1'b0,1'b0}),
        .m_axi_ruser(1'b0),
        .m_axi_rvalid(1'b0),
        .m_axi_wdata(NLW_U0_m_axi_wdata_UNCONNECTED[63:0]),
        .m_axi_wid(NLW_U0_m_axi_wid_UNCONNECTED[0]),
        .m_axi_wlast(NLW_U0_m_axi_wlast_UNCONNECTED),
        .m_axi_wready(1'b0),
        .m_axi_wstrb(NLW_U0_m_axi_wstrb_UNCONNECTED[7:0]),
        .m_axi_wuser(NLW_U0_m_axi_wuser_UNCONNECTED[0]),
        .m_axi_wvalid(NLW_U0_m_axi_wvalid_UNCONNECTED),
        .m_axis_tdata(NLW_U0_m_axis_tdata_UNCONNECTED[7:0]),
        .m_axis_tdest(NLW_U0_m_axis_tdest_UNCONNECTED[0]),
        .m_axis_tid(NLW_U0_m_axis_tid_UNCONNECTED[0]),
        .m_axis_tkeep(NLW_U0_m_axis_tkeep_UNCONNECTED[0]),
        .m_axis_tlast(NLW_U0_m_axis_tlast_UNCONNECTED),
        .m_axis_tready(1'b0),
        .m_axis_tstrb(NLW_U0_m_axis_tstrb_UNCONNECTED[0]),
        .m_axis_tuser(NLW_U0_m_axis_tuser_UNCONNECTED[3:0]),
        .m_axis_tvalid(NLW_U0_m_axis_tvalid_UNCONNECTED),
        .overflow(NLW_U0_overflow_UNCONNECTED),
        .prog_empty(NLW_U0_prog_empty_UNCONNECTED),
        .prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full(NLW_U0_prog_full_UNCONNECTED),
        .prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_assert({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_negate({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .rd_clk(rd_clk),
        .rd_data_count(rd_data_count),
        .rd_en(rd_en),
        .rd_rst(1'b0),
        .rd_rst_busy(rd_rst_busy),
        .rst(rst),
        .s_aclk(1'b0),
        .s_aclk_en(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arid(1'b0),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlock(1'b0),
        .s_axi_arprot({1'b0,1'b0,1'b0}),
        .s_axi_arqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_aruser(1'b0),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awid(1'b0),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlock(1'b0),
        .s_axi_awprot({1'b0,1'b0,1'b0}),
        .s_axi_awqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awuser(1'b0),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_buser(NLW_U0_s_axi_buser_UNCONNECTED[0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[63:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_ruser(NLW_U0_s_axi_ruser_UNCONNECTED[0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wid(1'b0),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wuser(1'b0),
        .s_axi_wvalid(1'b0),
        .s_axis_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tdest(1'b0),
        .s_axis_tid(1'b0),
        .s_axis_tkeep(1'b0),
        .s_axis_tlast(1'b0),
        .s_axis_tready(NLW_U0_s_axis_tready_UNCONNECTED),
        .s_axis_tstrb(1'b0),
        .s_axis_tuser({1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .sleep(1'b0),
        .srst(1'b0),
        .underflow(NLW_U0_underflow_UNCONNECTED),
        .valid(NLW_U0_valid_UNCONNECTED),
        .wr_ack(NLW_U0_wr_ack_UNCONNECTED),
        .wr_clk(wr_clk),
        .wr_data_count(wr_data_count),
        .wr_en(wr_en),
        .wr_rst(1'b0),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "1" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "10" *) (* XPM_MODULE = "TRUE" *) 
(* is_du_within_envelope = "true" *) (* keep_hierarchy = "true" *) (* xpm_cdc = "GRAY" *) 
module fifo_pre_xpm_cdc_gray
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [9:0]src_in_bin;
  input dest_clk;
  output [9:0]dest_out_bin;

  wire [9:0]async_path;
  wire [8:0]binval;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [9:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [9:0]\dest_graysync_ff[1] ;
  wire [9:0]dest_out_bin;
  wire [8:0]gray_enc;
  wire src_clk;
  wire [9:0]src_in_bin;

  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[5]),
        .Q(\dest_graysync_ff[0] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[6]),
        .Q(\dest_graysync_ff[0] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[7]),
        .Q(\dest_graysync_ff[0] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[8]),
        .Q(\dest_graysync_ff[0] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[9]),
        .Q(\dest_graysync_ff[0] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [5]),
        .Q(\dest_graysync_ff[1] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [6]),
        .Q(\dest_graysync_ff[1] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [7]),
        .Q(\dest_graysync_ff[1] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [8]),
        .Q(\dest_graysync_ff[1] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [9]),
        .Q(\dest_graysync_ff[1] [9]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin_ff[0]_i_1 
       (.I0(\dest_graysync_ff[1] [0]),
        .I1(\dest_graysync_ff[1] [2]),
        .I2(binval[4]),
        .I3(\dest_graysync_ff[1] [3]),
        .I4(\dest_graysync_ff[1] [1]),
        .O(binval[0]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin_ff[1]_i_1 
       (.I0(\dest_graysync_ff[1] [1]),
        .I1(\dest_graysync_ff[1] [3]),
        .I2(binval[4]),
        .I3(\dest_graysync_ff[1] [2]),
        .O(binval[1]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin_ff[2]_i_1 
       (.I0(\dest_graysync_ff[1] [2]),
        .I1(binval[4]),
        .I2(\dest_graysync_ff[1] [3]),
        .O(binval[2]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin_ff[3]_i_1 
       (.I0(\dest_graysync_ff[1] [3]),
        .I1(binval[4]),
        .O(binval[3]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin_ff[4]_i_1 
       (.I0(\dest_graysync_ff[1] [4]),
        .I1(\dest_graysync_ff[1] [6]),
        .I2(\dest_graysync_ff[1] [8]),
        .I3(\dest_graysync_ff[1] [9]),
        .I4(\dest_graysync_ff[1] [7]),
        .I5(\dest_graysync_ff[1] [5]),
        .O(binval[4]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin_ff[5]_i_1 
       (.I0(\dest_graysync_ff[1] [5]),
        .I1(\dest_graysync_ff[1] [7]),
        .I2(\dest_graysync_ff[1] [9]),
        .I3(\dest_graysync_ff[1] [8]),
        .I4(\dest_graysync_ff[1] [6]),
        .O(binval[5]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin_ff[6]_i_1 
       (.I0(\dest_graysync_ff[1] [6]),
        .I1(\dest_graysync_ff[1] [8]),
        .I2(\dest_graysync_ff[1] [9]),
        .I3(\dest_graysync_ff[1] [7]),
        .O(binval[6]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin_ff[7]_i_1 
       (.I0(\dest_graysync_ff[1] [7]),
        .I1(\dest_graysync_ff[1] [9]),
        .I2(\dest_graysync_ff[1] [8]),
        .O(binval[7]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin_ff[8]_i_1 
       (.I0(\dest_graysync_ff[1] [8]),
        .I1(\dest_graysync_ff[1] [9]),
        .O(binval[8]));
  FDRE \dest_out_bin_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[0]),
        .Q(dest_out_bin[0]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[1]),
        .Q(dest_out_bin[1]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[2]),
        .Q(dest_out_bin[2]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[3]),
        .Q(dest_out_bin[3]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[4]),
        .Q(dest_out_bin[4]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[5]),
        .Q(dest_out_bin[5]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[6]),
        .Q(dest_out_bin[6]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[7]),
        .Q(dest_out_bin[7]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[8]),
        .Q(dest_out_bin[8]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [9]),
        .Q(dest_out_bin[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[0]),
        .O(gray_enc[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[1]),
        .O(gray_enc[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[2]),
        .O(gray_enc[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[3]),
        .O(gray_enc[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[4]_i_1 
       (.I0(src_in_bin[5]),
        .I1(src_in_bin[4]),
        .O(gray_enc[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[5]_i_1 
       (.I0(src_in_bin[6]),
        .I1(src_in_bin[5]),
        .O(gray_enc[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[6]_i_1 
       (.I0(src_in_bin[7]),
        .I1(src_in_bin[6]),
        .O(gray_enc[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[7]_i_1 
       (.I0(src_in_bin[8]),
        .I1(src_in_bin[7]),
        .O(gray_enc[7]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[8]_i_1 
       (.I0(src_in_bin[9]),
        .I1(src_in_bin[8]),
        .O(gray_enc[8]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[4]),
        .Q(async_path[4]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[5] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[5]),
        .Q(async_path[5]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[6] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[6]),
        .Q(async_path[6]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[7] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[7]),
        .Q(async_path[7]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[8] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[8]),
        .Q(async_path[8]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[9] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[9]),
        .Q(async_path[9]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "1" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "7" *) (* XPM_MODULE = "TRUE" *) 
(* is_du_within_envelope = "true" *) (* keep_hierarchy = "true" *) (* xpm_cdc = "GRAY" *) 
module fifo_pre_xpm_cdc_gray__parameterized1
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [6:0]src_in_bin;
  input dest_clk;
  output [6:0]dest_out_bin;

  wire [6:0]async_path;
  wire [5:0]binval;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [6:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [6:0]\dest_graysync_ff[1] ;
  wire [6:0]dest_out_bin;
  wire [5:0]gray_enc;
  wire src_clk;
  wire [6:0]src_in_bin;

  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[5]),
        .Q(\dest_graysync_ff[0] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[6]),
        .Q(\dest_graysync_ff[0] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [5]),
        .Q(\dest_graysync_ff[1] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [6]),
        .Q(\dest_graysync_ff[1] [6]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin_ff[0]_i_1 
       (.I0(\dest_graysync_ff[1] [0]),
        .I1(binval[1]),
        .O(binval[0]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin_ff[1]_i_1 
       (.I0(\dest_graysync_ff[1] [1]),
        .I1(\dest_graysync_ff[1] [3]),
        .I2(\dest_graysync_ff[1] [5]),
        .I3(\dest_graysync_ff[1] [6]),
        .I4(\dest_graysync_ff[1] [4]),
        .I5(\dest_graysync_ff[1] [2]),
        .O(binval[1]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin_ff[2]_i_1 
       (.I0(\dest_graysync_ff[1] [2]),
        .I1(\dest_graysync_ff[1] [4]),
        .I2(\dest_graysync_ff[1] [6]),
        .I3(\dest_graysync_ff[1] [5]),
        .I4(\dest_graysync_ff[1] [3]),
        .O(binval[2]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin_ff[3]_i_1 
       (.I0(\dest_graysync_ff[1] [3]),
        .I1(\dest_graysync_ff[1] [5]),
        .I2(\dest_graysync_ff[1] [6]),
        .I3(\dest_graysync_ff[1] [4]),
        .O(binval[3]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin_ff[4]_i_1 
       (.I0(\dest_graysync_ff[1] [4]),
        .I1(\dest_graysync_ff[1] [6]),
        .I2(\dest_graysync_ff[1] [5]),
        .O(binval[4]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin_ff[5]_i_1 
       (.I0(\dest_graysync_ff[1] [5]),
        .I1(\dest_graysync_ff[1] [6]),
        .O(binval[5]));
  FDRE \dest_out_bin_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[0]),
        .Q(dest_out_bin[0]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[1]),
        .Q(dest_out_bin[1]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[2]),
        .Q(dest_out_bin[2]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[3]),
        .Q(dest_out_bin[3]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[4]),
        .Q(dest_out_bin[4]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[5]),
        .Q(dest_out_bin[5]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [6]),
        .Q(dest_out_bin[6]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[0]),
        .O(gray_enc[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[1]),
        .O(gray_enc[1]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[2]),
        .O(gray_enc[2]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[3]),
        .O(gray_enc[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[4]_i_1 
       (.I0(src_in_bin[5]),
        .I1(src_in_bin[4]),
        .O(gray_enc[4]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[5]_i_1 
       (.I0(src_in_bin[6]),
        .I1(src_in_bin[5]),
        .O(gray_enc[5]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[4]),
        .Q(async_path[4]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[5] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[5]),
        .Q(async_path[5]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[6] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[6]),
        .Q(async_path[6]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "5" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_single" *) 
(* SIM_ASSERT_CHK = "0" *) (* SRC_INPUT_REG = "0" *) (* VERSION = "0" *) 
(* XPM_MODULE = "TRUE" *) (* is_du_within_envelope = "true" *) (* keep_hierarchy = "true" *) 
(* xpm_cdc = "SINGLE" *) 
module fifo_pre_xpm_cdc_single
   (src_clk,
    src_in,
    dest_clk,
    dest_out);
  input src_clk;
  input src_in;
  input dest_clk;
  output dest_out;

  wire dest_clk;
  wire src_in;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SINGLE" *) wire [4:0]syncstages_ff;

  assign dest_out = syncstages_ff[4];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_in),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[3]),
        .Q(syncstages_ff[4]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "5" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_single" *) 
(* SIM_ASSERT_CHK = "0" *) (* SRC_INPUT_REG = "0" *) (* VERSION = "0" *) 
(* XPM_MODULE = "TRUE" *) (* is_du_within_envelope = "true" *) (* keep_hierarchy = "true" *) 
(* xpm_cdc = "SINGLE" *) 
module fifo_pre_xpm_cdc_single__2
   (src_clk,
    src_in,
    dest_clk,
    dest_out);
  input src_clk;
  input src_in;
  input dest_clk;
  output dest_out;

  wire dest_clk;
  wire src_in;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SINGLE" *) wire [4:0]syncstages_ff;

  assign dest_out = syncstages_ff[4];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_in),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[3]),
        .Q(syncstages_ff[4]),
        .R(1'b0));
endmodule

(* DEF_VAL = "1'b1" *) (* DEST_SYNC_FF = "5" *) (* INIT = "1" *) 
(* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_sync_rst" *) (* SIM_ASSERT_CHK = "0" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* is_du_within_envelope = "true" *) 
(* keep_hierarchy = "true" *) (* xpm_cdc = "SYNC_RST" *) 
module fifo_pre_xpm_cdc_sync_rst
   (src_rst,
    dest_clk,
    dest_rst);
  input src_rst;
  input dest_clk;
  output dest_rst;

  wire dest_clk;
  wire src_rst;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SYNC_RST" *) wire [4:0]syncstages_ff;

  assign dest_rst = syncstages_ff[4];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_rst),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[3]),
        .Q(syncstages_ff[4]),
        .R(1'b0));
endmodule

(* DEF_VAL = "1'b1" *) (* DEST_SYNC_FF = "5" *) (* INIT = "1" *) 
(* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_sync_rst" *) (* SIM_ASSERT_CHK = "0" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* is_du_within_envelope = "true" *) 
(* keep_hierarchy = "true" *) (* xpm_cdc = "SYNC_RST" *) 
module fifo_pre_xpm_cdc_sync_rst__2
   (src_rst,
    dest_clk,
    dest_rst);
  input src_rst;
  input dest_clk;
  output dest_rst;

  wire dest_clk;
  wire src_rst;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SYNC_RST" *) wire [4:0]syncstages_ff;

  assign dest_rst = syncstages_ff[4];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_rst),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b1)) 
    \syncstages_ff_reg[4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[3]),
        .Q(syncstages_ff[4]),
        .R(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
QGLtnqZzRetDH6gCWT4Js6wuLlZfrNx/VJp3sfR2NF+cxypO5AxN0oDKLJJtmdrtE/ueNDg+Qf7Z
TqBNRojORA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
B6Ger3hRvfjHkaJ+W8639Kl3TzC9TogLuklOXEiMNdc4Im+DjEUzxb3DKlzu0VW3zxZqjJ3+wsW/
LnRmPCESi5Y9eRJaLFXg79EMfoj4X+nTdHAP6yCfltBADKegZ12gpnB/8ey5yn2KA74LUtPC7jna
iyjqSfsWLGnz6UdXzwk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BX+DxgMPRyZbYojCUR9Sk8Lq+3ZigBz4yMFHQkmurfdfDzyTPJCE827eGiPyTenK1QPVhEtf9g06
0BFXq/0COPuU1BWJwdkz1c4dE6/exDwhvEh+hPx3vRY6z8fDEf6aGVIXrHDvrmddehe7yMSIpo+k
aXHR06EEdfHCFY4TggYwhcJVXjkE+ApsVuyfmEfPmYjo8hCWyQyBsUWIOY03q1+MvUjjsmTwgs9g
fh5MY9ToaLfoJxPKdCpsqrBX4LJ+VDGFlAqIcqHTE2jCmPiToZAFXB7fzf1wDjFCBlJyFVDBGi0i
m+CouLSb7X1mvVhdDZgNrZDJMV688Bu3o54vew==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DaIU/Ddc8USbZ2mURzujJDWDH1JbHl5tFVOOQ2aVaUPIA71yyE38OXVLEtF8rNmujYH30nEeQ+FV
LVJ16aaHw+iiuaqorTM3K5KLohVlN+WlcEtSXHuPNHjw8ddqtzpaX7pH1zqZH+YmfCL5oaNLqDH4
rkBnUl0/Gm/hzSwKjYhXGQFYQ+gGP99OjXakzrAqZzp/Iq4gt+Z5902/JV9thd/isHQImJ0QyK8M
EKM579iPAfXGes2mbiNYHcvDmSPYmW1zlhOE++N1EKeea7j/msnKeyhlC+hGE4Xfn4TVvqgQexCT
rp/wS/MosY6WH1aKFQlFH2hEppA7KXUaQlvG+w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
XmWoAt4X8hrCJ5yTyug4ajJW5UhfkLNibzjihWzZ4Cr9hQSvWZoTc8rjGsLPbz6Le+/9iI5KxecS
eR0wiAO+G2IkwhZgVBeZdKoFnlnTVAyLjk9wMAFXNyJZM6b1NDbfXlPcUsC6JePvPlwwdWknkSsC
r3KvgkWAS+O3xvRmaNw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hw3Y+rShKrXiUViyNU1/O2qv6TgheLHBnFMj1i9MUGrHYqh9pLfLYUgWR7S2vj4jv4S+Ks0BpP4p
dKEqVAFmTCfQNEUHaVcFPkOHgig6L4mhLY6HUUKJoRgiQepgLi/W3V+ZZPQSQFkB3CU4MsJzhXvR
yLcpDriZy8cnAHD87Zi5DrNGBzj3kigJeM0du6lCQbxtF5aEdoaNP+YTnIFtcqYhoYnswQlYt0sV
HKgFA8VzqzL5WYnpH7+1IKmFkJBHkyqHCa9wPK0qCKnxkuDj70YzPVqQ+cocdKU+/gNdpCOdZlci
F2HTxrgfrXndJru3TiDqu4UavqAe0MNuFp3t0w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XPVggoWL6aXz+MpODTOZhEUQDa0vfEnUDaYeEHXm2vGyqKJujN2c/FFAFBeBYdJATLsIsQ+BqoPc
pBbcFYXDBfOtFIW2dH6Y1OoD65KyJ/hAq8coa21kFgq4hFat5vzZ2iIfkCpTUr4vDZO7Xne8cZO9
WsHffoTCt5rS59wWm2b8I5R8Eh2TUbQg3RCyrcnD66cvcEnlXe1CNMQ4/loVJpA4IBinBf820Wjc
vw2fZbGI0jXC+ACSHOviH63Xwmn+aRV5Ppkup7IYoon/ieKapRQeASu3TTY37xSBXiInSdtMTzJ6
+4GfO4eSHVriCk/sWbuTBzfRzoSShrnHjzz5LA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L78XuiswVcgO2gtebzL7SA9BC/jJGAM0v6S9pzmyqL+QYzRneiYeGyDmsW33jEVVSTuNjTXkBLY7
yTOKQruatwe4V0OLi6174saSAmPgerSV1GyLP7KhmusLV/N61avC9TPam+tekhKeE0tds4EnJ3et
4JdLh+SE4Z4pcuqCjB5MFneIYKKWDx7siU6oesAQtoSJOesfMchX63MhOjOHFP/ch+1gHv3T45hg
IGF7V7TrdREVE4f9631tlVJ1o2Dypsmo/76Itz5WCGlTMjAnWXN8IXxKN+PZ3dyt1wjrZm2P/td+
xiGszFnSLrRvw/HferwtSmRx8q0fiHZ88roGTw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kDX5kq2QEe25429T6vQqBCFvV1McKTJRYfK99ymVNK2GGvGLXSzgwJHwB2fj9rM0wme3zYYY0vQR
x+9F4L7KLlOVY6qY3LB59uDzyXBI3mMZaS905HXHJkdZHWtQWpfHhl27LqL+8FSluaD6F+KFfYOV
CwIOVuCIp/XjxFXpNBik7YiPt4kHOlDA97IXNLnYUn/g1csGqeNWce4UTne50ggWvLYGbTFGmTjT
N67TpUiGRVRCSv8Tax72GWFIMFZk3Tlp68ZUSQEybZMWX1U9XdMdtxfvNGhf8mi5jQJ2SupSzKu4
T/+53IN9T8aLePAiGBKKG1ZBj4y1ZyYA7XYvjw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128080)
`pragma protect data_block
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
eg==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
