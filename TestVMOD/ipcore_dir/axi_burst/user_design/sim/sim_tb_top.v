//*****************************************************************************
// (c) Copyright 2009 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor             : Xilinx
// \   \   \/    Version            : 3.92
//  \   \        Application        : MIG
//  /   /        Filename           : sim_tb_top.v
// /___/   /\    Date Last Modified : $Date: 2011/06/02 07:16:56 $
// \   \  /  \   Date Created	    : Mon Mar 2 2009
//  \___\/\___\
//
// Device      : Spartan-6
// Design Name : DDR/DDR2/DDR3/LPDDR
// Purpose     : This is the simulation testbench which is used to verify the
//               design. The basic clocks and resets to the interface are
//               generated here. This also connects the memory interface to the
//               memory model.
//*****************************************************************************

`timescale 1ps/1ps
module sim_tb_top;

// ========================================================================== //
// Parameters                                                                 //
// ========================================================================== //
   parameter DEBUG_EN                = 0;
   localparam DBG_WR_STS_WIDTH       = 32;
   localparam DBG_RD_STS_WIDTH       = 32;
   localparam C1_P0_PORT_MODE             =  "BI_MODE";
   localparam C1_P1_PORT_MODE             =  "BI_MODE";
   localparam C1_P2_PORT_MODE             =  "RD_MODE";
   localparam C1_P3_PORT_MODE             =  "RD_MODE";
   localparam C1_P4_PORT_MODE             =  "NONE";
   localparam C1_P5_PORT_MODE             =  "NONE";
   localparam C1_PORT_ENABLE              = 6'b001111;
   localparam C1_PORT_CONFIG             =  "B32_B32_R32_R32_R32_R32";
   	parameter C1_MEMCLK_PERIOD     = 3000;
   parameter C1_RST_ACT_LOW        = 0;
   parameter C1_INPUT_CLK_TYPE     = "DIFFERENTIAL";
   parameter C1_NUM_DQ_PINS        = 8;
   parameter C1_MEM_ADDR_WIDTH     = 14;
   parameter C1_MEM_BANKADDR_WIDTH = 3;   
   parameter C1_MEM_ADDR_ORDER     = "ROW_BANK_COLUMN"; 
      parameter C1_P0_MASK_SIZE       = 4;
   parameter C1_P0_DATA_PORT_SIZE  = 32;  
   parameter C1_P1_MASK_SIZE       = 4;
   parameter C1_P1_DATA_PORT_SIZE  = 32;
   parameter C1_MEM_BURST_LEN	  = 4;
   parameter C1_MEM_NUM_COL_BITS   = 10;
   parameter C1_CALIB_SOFT_IP      = "TRUE";  
   parameter C1_SIMULATION      = "TRUE";
   parameter C1_HW_TESTING      = "FALSE";
   parameter C1_SMALL_DEVICE    = "FALSE";
   parameter C1_S0_AXI_STRICT_COHERENCY   =  0;
   parameter C1_S0_AXI_ENABLE_AP          =  0;
   parameter C1_S0_AXI_DATA_WIDTH         =  32;
   parameter C1_S0_AXI_SUPPORTS_NARROW_BURST  =  1;
   parameter C1_S0_AXI_ADDR_WIDTH         =  32;
   parameter C1_S0_AXI_ID_WIDTH           =  4;
   parameter C1_S1_AXI_STRICT_COHERENCY   =  0;
   parameter C1_S1_AXI_ENABLE_AP          =  0;
   parameter C1_S1_AXI_DATA_WIDTH         =  32;
   parameter C1_S1_AXI_SUPPORTS_NARROW_BURST  =  1;
   parameter C1_S1_AXI_ADDR_WIDTH         =  32;
   parameter C1_S1_AXI_ID_WIDTH           =  4;
   parameter C1_S2_AXI_STRICT_COHERENCY   =  0;
   parameter C1_S2_AXI_ENABLE_AP          =  0;
   parameter C1_S2_AXI_DATA_WIDTH         =  32;
   parameter C1_S2_AXI_SUPPORTS_NARROW_BURST  =  1;
   parameter C1_S2_AXI_ADDR_WIDTH         =  32;
   parameter C1_S2_AXI_ID_WIDTH           =  4;
   parameter C1_S3_AXI_STRICT_COHERENCY   =  0;
   parameter C1_S3_AXI_ENABLE_AP          =  0;
   parameter C1_S3_AXI_DATA_WIDTH         =  32;
   parameter C1_S3_AXI_SUPPORTS_NARROW_BURST  =  1;
   parameter C1_S3_AXI_ADDR_WIDTH         =  32;
   parameter C1_S3_AXI_ID_WIDTH           =  4;
   localparam C1_S4_AXI_STRICT_COHERENCY   =  0;
   localparam C1_S4_AXI_ENABLE_AP          =  0;
   localparam C1_S4_AXI_DATA_WIDTH         =  32;
   localparam C1_S4_AXI_SUPPORTS_NARROW_BURST  =  1;
   localparam C1_S4_AXI_ADDR_WIDTH         =  32;
   localparam C1_S4_AXI_ID_WIDTH           =  4;
   localparam C1_S5_AXI_STRICT_COHERENCY   =  0;
   localparam C1_S5_AXI_ENABLE_AP          =  0;
   localparam C1_S5_AXI_DATA_WIDTH         =  32;
   localparam C1_S5_AXI_SUPPORTS_NARROW_BURST  =  1;
   localparam C1_S5_AXI_ADDR_WIDTH         =  32;
   localparam C1_S5_AXI_ID_WIDTH           =  4;
   parameter C1_S0_AXI_SUPPORTS_READ	=0;
   parameter C1_S0_AXI_SUPPORTS_WRITE	=1;
   parameter C1_S1_AXI_SUPPORTS_READ	=1;
   parameter C1_S1_AXI_SUPPORTS_WRITE	=0;
   parameter C1_S2_AXI_SUPPORTS_READ	=1;
   parameter C1_S2_AXI_SUPPORTS_WRITE	=0;
   parameter C1_S3_AXI_SUPPORTS_READ	=1;
   parameter C1_S3_AXI_SUPPORTS_WRITE	=0;
   parameter C1_S0_AXI_ENABLE	=1;
   parameter C1_S1_AXI_ENABLE	=1;
   parameter C1_S2_AXI_ENABLE	=1;
   parameter C1_S3_AXI_ENABLE	=1;
   localparam C1_S4_AXI_SUPPORTS_READ	=0;
   localparam C1_S4_AXI_SUPPORTS_WRITE	=0;
   localparam C1_S5_AXI_SUPPORTS_READ	=0;
   localparam C1_S5_AXI_SUPPORTS_WRITE	=0;
   localparam C1_S4_AXI_ENABLE	=0;
   localparam C1_S5_AXI_ENABLE	=0;
   localparam C1_AXI_NBURST_SUPPORT                 = 1;
   localparam C1_BEGIN_ADDRESS                      = (C1_HW_TESTING == "TRUE") ? 32'h01000000:32'h00000700;
   localparam C1_END_ADDRESS                        = (C1_HW_TESTING == "TRUE") ? 32'h02ffffff:32'h000008ff;
   localparam C1_ENFORCE_RD_WR                      = 0;
   localparam C1_ENFORCE_RD_WR_CMD                  = 8'h11;
   localparam C1_ENFORCE_RD_WR_PATTERN              = 3'b000;
   localparam C1_EN_UPSIZER                         = (C1_S0_AXI_SUPPORTS_NARROW_BURST == 1) &&
						      (C1_S1_AXI_SUPPORTS_NARROW_BURST == 1) &&
						      (C1_S2_AXI_SUPPORTS_NARROW_BURST == 1) &&
						      (C1_S3_AXI_SUPPORTS_NARROW_BURST == 1) &&
						      (C1_S4_AXI_SUPPORTS_NARROW_BURST == 1) &&
						      (C1_S5_AXI_SUPPORTS_NARROW_BURST == 1);
   localparam C1_EN_WRAP_TRANS                      = 0;
   localparam C1_PRBS_EADDR_MASK_POS                = (C1_HW_TESTING == "TRUE") ? 32'hfc000000:32'hfffff000;
   localparam C1_PRBS_SADDR_MASK_POS                = (C1_HW_TESTING == "TRUE") ? 32'h01000000:32'h00000700;
// ========================================================================== //
// Signal Declarations                                                        //
// ========================================================================== //

// Clocks
		// Clocks
   reg                              c1_sys_clk;
   wire                             c1_sys_clk_p;
   wire                             c1_sys_clk_n;
// System Reset
   reg                              c1_sys_rst;
   wire                             c1_sys_rst_i;

// Design-Top Port Map
   wire                             c1_error;
   wire                             c1_calib_done;
   wire [31:0]                      c1_cmp_data;
   wire                             c1_cmp_error;

   wire [C1_MEM_ADDR_WIDTH-1:0]      mcb1_dram_a;
   wire [C1_MEM_BANKADDR_WIDTH-1:0]  mcb1_dram_ba;  
   wire                             mcb1_dram_ck;  
   wire                             mcb1_dram_ck_n;
   wire [C1_NUM_DQ_PINS-1:0]        mcb1_dram_dq;   
   wire                             mcb1_dram_dqs;  
   wire                             mcb1_dram_dqs_n;
   wire                             mcb1_dram_dm;
   wire                             mcb1_dram_ras_n; 
   wire                             mcb1_dram_cas_n; 
   wire                             mcb1_dram_we_n;  
   wire                             mcb1_dram_cke; 
   wire				                mcb1_dram_odt;

   wire [64 + (2*C1_P0_DATA_PORT_SIZE - 1):0]     c1_p0_error_status;
   wire [64 + (2*C1_P1_DATA_PORT_SIZE - 1):0]     c1_p1_error_status;
   wire [127 : 0]     c1_p2_error_status;
   wire [127 : 0]     c1_p3_error_status;
   wire [127 : 0]     c1_p4_error_status;
   wire [127 : 0]     c1_p5_error_status;

   
   wire                              c1_vio_modify_enable   = 1'b1;
   wire  [2:0]                       c1_vio_data_mode_value = 3'b010;
   wire  [2:0]                       c1_vio_addr_mode_value = 3'b011;

// User design  Sim
        wire                             c1_clk0;
   wire							 c1_rst0;

   reg                              c1_aresetn;
   wire                              c1_wrap_en;
   wire                              c1_cmd_err;
   wire                              c1_data_msmatch_err;
   wire                              c1_write_err;
   wire                              c1_read_err;
   wire                              c1_test_cmptd;
   wire                              c1_dbg_wr_sts_vld;
   wire                              c1_dbg_rd_sts_vld;
   wire  [DBG_WR_STS_WIDTH-1:0]                      c1_dbg_wr_sts;
   wire  [DBG_WR_STS_WIDTH-1:0]                      c1_dbg_rd_sts;
     wire		c1_s0_axi_aclk   ;
  wire		c1_s0_axi_aresetn;
  wire [C1_S0_AXI_ID_WIDTH - 1:0]	c1_s0_axi_awid   ;
  wire [C1_S0_AXI_ADDR_WIDTH - 1:0]	c1_s0_axi_awaddr ;
  wire [7:0]	c1_s0_axi_awlen  ;
  wire [2:0]	c1_s0_axi_awsize ;
  wire [1:0]	c1_s0_axi_awburst;
  wire [0:0]	c1_s0_axi_awlock ;
  wire [3:0]	c1_s0_axi_awcache;
  wire [2:0]	c1_s0_axi_awprot ;
  wire [3:0]	c1_s0_axi_awqos  ;
  wire		c1_s0_axi_awvalid;
  wire		c1_s0_axi_awready;
  wire [C1_S0_AXI_DATA_WIDTH - 1:0]	c1_s0_axi_wdata  ;
  wire [C1_S0_AXI_DATA_WIDTH/8 - 1:0]	c1_s0_axi_wstrb  ;
  wire		c1_s0_axi_wlast  ;
  wire		c1_s0_axi_wvalid ;
  wire		c1_s0_axi_wready ;
  wire [C1_S0_AXI_ID_WIDTH - 1:0]	c1_s0_axi_bid    ;
  wire [C1_S0_AXI_ID_WIDTH - 1:0]	c1_s0_axi_wid    ;
  wire [1:0]	c1_s0_axi_bresp  ;
  wire		c1_s0_axi_bvalid ;
  wire		c1_s0_axi_bready ;
  wire [C1_S0_AXI_ID_WIDTH - 1:0]	c1_s0_axi_arid   ;
  wire [C1_S0_AXI_ADDR_WIDTH - 1:0]	c1_s0_axi_araddr ;
  wire [7:0]	c1_s0_axi_arlen  ;
  wire [2:0]	c1_s0_axi_arsize ;
  wire [1:0]	c1_s0_axi_arburst;
  wire [0:0]	c1_s0_axi_arlock ;
  wire [3:0]	c1_s0_axi_arcache;
  wire [2:0]	c1_s0_axi_arprot ;
  wire [3:0]	c1_s0_axi_arqos  ;
  wire		c1_s0_axi_arvalid;
  wire		c1_s0_axi_arready;
  wire [C1_S0_AXI_ID_WIDTH - 1:0]	c1_s0_axi_rid    ;
  wire [C1_S0_AXI_DATA_WIDTH - 1:0]	c1_s0_axi_rdata  ;
  wire [1:0]	c1_s0_axi_rresp  ;
  wire		c1_s0_axi_rlast  ;
  wire		c1_s0_axi_rvalid ;
  wire		c1_s0_axi_rready ;
  wire		c1_s1_axi_aclk   ;
  wire		c1_s1_axi_aresetn;
  wire [C1_S1_AXI_ID_WIDTH - 1:0]	c1_s1_axi_awid   ;
  wire [C1_S1_AXI_ADDR_WIDTH - 1:0]	c1_s1_axi_awaddr ;
  wire [7:0]	c1_s1_axi_awlen  ;
  wire [2:0]	c1_s1_axi_awsize ;
  wire [1:0]	c1_s1_axi_awburst;
  wire [0:0]	c1_s1_axi_awlock ;
  wire [3:0]	c1_s1_axi_awcache;
  wire [2:0]	c1_s1_axi_awprot ;
  wire [3:0]	c1_s1_axi_awqos  ;
  wire		c1_s1_axi_awvalid;
  wire		c1_s1_axi_awready;
  wire [C1_S1_AXI_DATA_WIDTH - 1:0]	c1_s1_axi_wdata  ;
  wire [C1_S1_AXI_DATA_WIDTH/8 - 1:0]	c1_s1_axi_wstrb  ;
  wire		c1_s1_axi_wlast  ;
  wire		c1_s1_axi_wvalid ;
  wire		c1_s1_axi_wready ;
  wire [C1_S1_AXI_ID_WIDTH - 1:0]	c1_s1_axi_bid    ;
  wire [C1_S1_AXI_ID_WIDTH - 1:0]	c1_s1_axi_wid    ;
  wire [1:0]	c1_s1_axi_bresp  ;
  wire		c1_s1_axi_bvalid ;
  wire		c1_s1_axi_bready ;
  wire [C1_S1_AXI_ID_WIDTH - 1:0]	c1_s1_axi_arid   ;
  wire [C1_S1_AXI_ADDR_WIDTH - 1:0]	c1_s1_axi_araddr ;
  wire [7:0]	c1_s1_axi_arlen  ;
  wire [2:0]	c1_s1_axi_arsize ;
  wire [1:0]	c1_s1_axi_arburst;
  wire [0:0]	c1_s1_axi_arlock ;
  wire [3:0]	c1_s1_axi_arcache;
  wire [2:0]	c1_s1_axi_arprot ;
  wire [3:0]	c1_s1_axi_arqos  ;
  wire		c1_s1_axi_arvalid;
  wire		c1_s1_axi_arready;
  wire [C1_S1_AXI_ID_WIDTH - 1:0]	c1_s1_axi_rid    ;
  wire [C1_S1_AXI_DATA_WIDTH - 1:0]	c1_s1_axi_rdata  ;
  wire [1:0]	c1_s1_axi_rresp  ;
  wire		c1_s1_axi_rlast  ;
  wire		c1_s1_axi_rvalid ;
  wire		c1_s1_axi_rready ;
  wire		c1_s2_axi_aclk   ;
  wire		c1_s2_axi_aresetn;
  wire [C1_S2_AXI_ID_WIDTH - 1:0]	c1_s2_axi_awid   ;
  wire [C1_S2_AXI_ADDR_WIDTH - 1:0]	c1_s2_axi_awaddr ;
  wire [7:0]	c1_s2_axi_awlen  ;
  wire [2:0]	c1_s2_axi_awsize ;
  wire [1:0]	c1_s2_axi_awburst;
  wire [0:0]	c1_s2_axi_awlock ;
  wire [3:0]	c1_s2_axi_awcache;
  wire [2:0]	c1_s2_axi_awprot ;
  wire [3:0]	c1_s2_axi_awqos  ;
  wire		c1_s2_axi_awvalid;
  wire		c1_s2_axi_awready;
  wire [C1_S2_AXI_DATA_WIDTH - 1:0]	c1_s2_axi_wdata  ;
  wire [C1_S2_AXI_DATA_WIDTH/8 - 1:0]	c1_s2_axi_wstrb  ;
  wire		c1_s2_axi_wlast  ;
  wire		c1_s2_axi_wvalid ;
  wire		c1_s2_axi_wready ;
  wire [C1_S2_AXI_ID_WIDTH - 1:0]	c1_s2_axi_bid    ;
  wire [C1_S2_AXI_ID_WIDTH - 1:0]	c1_s2_axi_wid    ;
  wire [1:0]	c1_s2_axi_bresp  ;
  wire		c1_s2_axi_bvalid ;
  wire		c1_s2_axi_bready ;
  wire [C1_S2_AXI_ID_WIDTH - 1:0]	c1_s2_axi_arid   ;
  wire [C1_S2_AXI_ADDR_WIDTH - 1:0]	c1_s2_axi_araddr ;
  wire [7:0]	c1_s2_axi_arlen  ;
  wire [2:0]	c1_s2_axi_arsize ;
  wire [1:0]	c1_s2_axi_arburst;
  wire [0:0]	c1_s2_axi_arlock ;
  wire [3:0]	c1_s2_axi_arcache;
  wire [2:0]	c1_s2_axi_arprot ;
  wire [3:0]	c1_s2_axi_arqos  ;
  wire		c1_s2_axi_arvalid;
  wire		c1_s2_axi_arready;
  wire [C1_S2_AXI_ID_WIDTH - 1:0]	c1_s2_axi_rid    ;
  wire [C1_S2_AXI_DATA_WIDTH - 1:0]	c1_s2_axi_rdata  ;
  wire [1:0]	c1_s2_axi_rresp  ;
  wire		c1_s2_axi_rlast  ;
  wire		c1_s2_axi_rvalid ;
  wire		c1_s2_axi_rready ;
  wire		c1_s3_axi_aclk   ;
  wire		c1_s3_axi_aresetn;
  wire [C1_S3_AXI_ID_WIDTH - 1:0]	c1_s3_axi_awid   ;
  wire [C1_S3_AXI_ADDR_WIDTH - 1:0]	c1_s3_axi_awaddr ;
  wire [7:0]	c1_s3_axi_awlen  ;
  wire [2:0]	c1_s3_axi_awsize ;
  wire [1:0]	c1_s3_axi_awburst;
  wire [0:0]	c1_s3_axi_awlock ;
  wire [3:0]	c1_s3_axi_awcache;
  wire [2:0]	c1_s3_axi_awprot ;
  wire [3:0]	c1_s3_axi_awqos  ;
  wire		c1_s3_axi_awvalid;
  wire		c1_s3_axi_awready;
  wire [C1_S3_AXI_DATA_WIDTH - 1:0]	c1_s3_axi_wdata  ;
  wire [C1_S3_AXI_DATA_WIDTH/8 - 1:0]	c1_s3_axi_wstrb  ;
  wire		c1_s3_axi_wlast  ;
  wire		c1_s3_axi_wvalid ;
  wire		c1_s3_axi_wready ;
  wire [C1_S3_AXI_ID_WIDTH - 1:0]	c1_s3_axi_bid    ;
  wire [C1_S3_AXI_ID_WIDTH - 1:0]	c1_s3_axi_wid    ;
  wire [1:0]	c1_s3_axi_bresp  ;
  wire		c1_s3_axi_bvalid ;
  wire		c1_s3_axi_bready ;
  wire [C1_S3_AXI_ID_WIDTH - 1:0]	c1_s3_axi_arid   ;
  wire [C1_S3_AXI_ADDR_WIDTH - 1:0]	c1_s3_axi_araddr ;
  wire [7:0]	c1_s3_axi_arlen  ;
  wire [2:0]	c1_s3_axi_arsize ;
  wire [1:0]	c1_s3_axi_arburst;
  wire [0:0]	c1_s3_axi_arlock ;
  wire [3:0]	c1_s3_axi_arcache;
  wire [2:0]	c1_s3_axi_arprot ;
  wire [3:0]	c1_s3_axi_arqos  ;
  wire		c1_s3_axi_arvalid;
  wire		c1_s3_axi_arready;
  wire [C1_S3_AXI_ID_WIDTH - 1:0]	c1_s3_axi_rid    ;
  wire [C1_S3_AXI_DATA_WIDTH - 1:0]	c1_s3_axi_rdata  ;
  wire [1:0]	c1_s3_axi_rresp  ;
  wire		c1_s3_axi_rlast  ;
  wire		c1_s3_axi_rvalid ;
  wire		c1_s3_axi_rready ;
wire				c1_s4_axi_aclk   ;
wire				c1_s4_axi_aresetn;
wire[C1_S4_AXI_ID_WIDTH-1:0]	c1_s4_axi_awid   ;
wire[C1_S4_AXI_ADDR_WIDTH-1:0]	c1_s4_axi_awaddr ;
wire[7:0]			c1_s4_axi_awlen  ;
wire[2:0]			c1_s4_axi_awsize ;
wire[1:0]			c1_s4_axi_awburst;
wire[0:0]			c1_s4_axi_awlock ;
wire[3:0]			c1_s4_axi_awcache;
wire[2:0]			c1_s4_axi_awprot ;
wire[3:0]			c1_s4_axi_awqos  ;
wire				c1_s4_axi_awvalid;
wire				c1_s4_axi_awready;
wire[C1_S4_AXI_DATA_WIDTH-1:0]	c1_s4_axi_wdata  ;
wire[C1_S4_AXI_DATA_WIDTH/8-1:0]	c1_s4_axi_wstrb  ;
wire				c1_s4_axi_wlast  ;
wire				c1_s4_axi_wvalid ;
wire				c1_s4_axi_wready ;
wire[C1_S4_AXI_ID_WIDTH-1:0]	c1_s4_axi_bid    ;
wire[C1_S4_AXI_ID_WIDTH-1:0]	c1_s4_axi_wid    ;
wire[1:0]			c1_s4_axi_bresp  ;
wire				c1_s4_axi_bvalid ;
wire				c1_s4_axi_bready ;
wire[C1_S4_AXI_ID_WIDTH-1:0]	c1_s4_axi_arid   ;
wire[C1_S4_AXI_ADDR_WIDTH-1:0]	c1_s4_axi_araddr ;
wire[7:0]			c1_s4_axi_arlen  ;
wire[2:0]			c1_s4_axi_arsize ;
wire[1:0]			c1_s4_axi_arburst;
wire[0:0]			c1_s4_axi_arlock ;
wire[3:0]			c1_s4_axi_arcache;
wire[2:0]			c1_s4_axi_arprot ;
wire[3:0]			c1_s4_axi_arqos  ;
wire				c1_s4_axi_arvalid;
wire				c1_s4_axi_arready;
wire[C1_S4_AXI_ID_WIDTH-1:0]	c1_s4_axi_rid    ;
wire[C1_S4_AXI_DATA_WIDTH-1:0]	c1_s4_axi_rdata  ;
wire[1:0]			c1_s4_axi_rresp  ;
wire				c1_s4_axi_rlast  ;
wire				c1_s4_axi_rvalid ;
wire				c1_s4_axi_rready ;
wire				c1_s5_axi_aclk   ;
wire				c1_s5_axi_aresetn;
wire[C1_S5_AXI_ID_WIDTH-1:0]	c1_s5_axi_awid   ;
wire[C1_S5_AXI_ADDR_WIDTH-1:0]	c1_s5_axi_awaddr ;
wire[7:0]			c1_s5_axi_awlen  ;
wire[2:0]			c1_s5_axi_awsize ;
wire[1:0]			c1_s5_axi_awburst;
wire[0:0]			c1_s5_axi_awlock ;
wire[3:0]			c1_s5_axi_awcache;
wire[2:0]			c1_s5_axi_awprot ;
wire[3:0]			c1_s5_axi_awqos  ;
wire				c1_s5_axi_awvalid;
wire				c1_s5_axi_awready;
wire[C1_S5_AXI_DATA_WIDTH-1:0]	c1_s5_axi_wdata  ;
wire[C1_S5_AXI_DATA_WIDTH/8-1:0]	c1_s5_axi_wstrb  ;
wire				c1_s5_axi_wlast  ;
wire				c1_s5_axi_wvalid ;
wire				c1_s5_axi_wready ;
wire[C1_S5_AXI_ID_WIDTH-1:0]	c1_s5_axi_bid    ;
wire[C1_S5_AXI_ID_WIDTH-1:0]	c1_s5_axi_wid    ;
wire[1:0]			c1_s5_axi_bresp  ;
wire				c1_s5_axi_bvalid ;
wire				c1_s5_axi_bready ;
wire[C1_S5_AXI_ID_WIDTH-1:0]	c1_s5_axi_arid   ;
wire[C1_S5_AXI_ADDR_WIDTH-1:0]	c1_s5_axi_araddr ;
wire[7:0]			c1_s5_axi_arlen  ;
wire[2:0]			c1_s5_axi_arsize ;
wire[1:0]			c1_s5_axi_arburst;
wire[0:0]			c1_s5_axi_arlock ;
wire[3:0]			c1_s5_axi_arcache;
wire[2:0]			c1_s5_axi_arprot ;
wire[3:0]			c1_s5_axi_arqos  ;
wire				c1_s5_axi_arvalid;
wire				c1_s5_axi_arready;
wire[C1_S5_AXI_ID_WIDTH-1:0]	c1_s5_axi_rid    ;
wire[C1_S5_AXI_DATA_WIDTH-1:0]	c1_s5_axi_rdata  ;
wire[1:0]			c1_s5_axi_rresp  ;
wire				c1_s5_axi_rlast  ;
wire				c1_s5_axi_rvalid ;
wire				c1_s5_axi_rready ;


// Error & Calib Signals
   wire                             error;
   wire                             calib_done;
   wire				    rzq1;
        wire				    zio1;
     
   
// ========================================================================== //
// Clocks Generation                                                          //
// ========================================================================== //

   initial
      c1_sys_clk = 1'b0;
   always
      #(C1_MEMCLK_PERIOD/2) c1_sys_clk = ~c1_sys_clk;

   assign                c1_sys_clk_p = c1_sys_clk;
   assign                c1_sys_clk_n = ~c1_sys_clk;

// ========================================================================== //
// Reset Generation                                                           //
// ========================================================================== //
 
   initial begin
      c1_sys_rst = 1'b0;		
      #20000;
      c1_sys_rst = 1'b1;
   end
   assign c1_sys_rst_i = C1_RST_ACT_LOW ? c1_sys_rst : ~c1_sys_rst;

// ========================================================================== //
// Error Grouping                                                           //
// ========================================================================== //
assign error = c1_cmd_err | c1_data_msmatch_err | c1_write_err | c1_read_err;
assign calib_done = c1_calib_done;

   
assign c1_wrap_en = (C1_EN_WRAP_TRANS == 1) ? 1'b1 : 1'b0;
   
   // The PULLDOWN component is connected to the ZIO signal primarily to avoid the
// unknown state in simulation. In real hardware, ZIO should be a no connect(NC) pin.
   PULLDOWN zio_pulldown1 (.O(zio1));   PULLDOWN rzq_pulldown1 (.O(rzq1));
   

// ========================================================================== //
// DESIGN TOP INSTANTIATION                                                    //
// ========================================================================== //


assign c1_s0_axi_aclk = c1_clk0;
assign c1_s1_axi_aclk = c1_clk0;
assign c1_s2_axi_aclk = c1_clk0;
assign c1_s3_axi_aclk = c1_clk0;
assign c1_s4_axi_aclk = c1_clk0;
assign c1_s5_axi_aclk = c1_clk0;

assign c1_s0_axi_aresetn = c1_aresetn;
assign c1_s1_axi_aresetn = c1_aresetn;
assign c1_s2_axi_aresetn = c1_aresetn;
assign c1_s3_axi_aresetn = c1_aresetn;
assign c1_s4_axi_aresetn = c1_aresetn;
assign c1_s5_axi_aresetn = c1_aresetn;

axi_burst #(

.C1_P0_MASK_SIZE       (C1_P0_MASK_SIZE      ),
.C1_P0_DATA_PORT_SIZE  (C1_P0_DATA_PORT_SIZE ),
.C1_P1_MASK_SIZE       (C1_P1_MASK_SIZE      ),
.C1_P1_DATA_PORT_SIZE  (C1_P1_DATA_PORT_SIZE ),
.C1_MEMCLK_PERIOD      (C1_MEMCLK_PERIOD),
.C1_RST_ACT_LOW        (C1_RST_ACT_LOW),
.C1_INPUT_CLK_TYPE     (C1_INPUT_CLK_TYPE),

 
.DEBUG_EN              (DEBUG_EN),

.C1_MEM_ADDR_ORDER     (C1_MEM_ADDR_ORDER    ),
.C1_NUM_DQ_PINS        (C1_NUM_DQ_PINS       ),
.C1_MEM_ADDR_WIDTH     (C1_MEM_ADDR_WIDTH    ),
.C1_MEM_BANKADDR_WIDTH (C1_MEM_BANKADDR_WIDTH),

.C1_SIMULATION         (C1_SIMULATION),
.C1_CALIB_SOFT_IP      (C1_CALIB_SOFT_IP )
)
design_top (


    .c1_sys_clk_p           (c1_sys_clk_p),
  .c1_sys_clk_n           (c1_sys_clk_n),
  .c1_sys_rst_i           (c1_sys_rst_i),                        

  .mcb1_dram_dq           (mcb1_dram_dq),  
  .mcb1_dram_a            (mcb1_dram_a),  
  .mcb1_dram_ba           (mcb1_dram_ba),
  .mcb1_dram_ras_n        (mcb1_dram_ras_n),                        
  .mcb1_dram_cas_n        (mcb1_dram_cas_n),                        
  .mcb1_dram_we_n         (mcb1_dram_we_n),                          
  .mcb1_dram_odt          (mcb1_dram_odt),
  .mcb1_dram_cke          (mcb1_dram_cke),                          
  .mcb1_dram_ck           (mcb1_dram_ck),                          
  .mcb1_dram_ck_n         (mcb1_dram_ck_n),       
  .mcb1_dram_dqs          (mcb1_dram_dqs),                          
  .mcb1_dram_dqs_n        (mcb1_dram_dqs_n),
  
  .mcb1_dram_dm           (mcb1_dram_dm),
    .c1_clk0		        (c1_clk0),
  .c1_rst0		        (c1_rst0),
	
 
  .c1_calib_done          (c1_calib_done),
     .mcb1_rzq               (rzq1),
               
     .mcb1_zio               (zio1),
               
     .c1_s0_axi_aclk                         (c1_s0_axi_aclk   ),
   .c1_s0_axi_aresetn                      (c1_s0_axi_aresetn),
   .c1_s0_axi_awid                         (c1_s0_axi_awid   ),
   .c1_s0_axi_awaddr                       (c1_s0_axi_awaddr ),
   .c1_s0_axi_awlen                        (c1_s0_axi_awlen  ),
   .c1_s0_axi_awsize                       (c1_s0_axi_awsize ),
   .c1_s0_axi_awburst                      (c1_s0_axi_awburst),
   .c1_s0_axi_awlock                       (c1_s0_axi_awlock ),
   .c1_s0_axi_awcache                      (c1_s0_axi_awcache),
   .c1_s0_axi_awprot                       (c1_s0_axi_awprot ),
   .c1_s0_axi_awqos                        (c1_s0_axi_awqos  ),
   .c1_s0_axi_awvalid                      (c1_s0_axi_awvalid),
   .c1_s0_axi_awready                      (c1_s0_axi_awready),
   .c1_s0_axi_wdata                        (c1_s0_axi_wdata  ),
   .c1_s0_axi_wstrb                        (c1_s0_axi_wstrb  ),
   .c1_s0_axi_wlast                        (c1_s0_axi_wlast  ),
   .c1_s0_axi_wvalid                       (c1_s0_axi_wvalid ),
   .c1_s0_axi_wready                       (c1_s0_axi_wready ),
   .c1_s0_axi_bid                          (c1_s0_axi_bid    ),
   .c1_s0_axi_wid                          (c1_s0_axi_wid    ),
   .c1_s0_axi_bresp                        (c1_s0_axi_bresp  ),
   .c1_s0_axi_bvalid                       (c1_s0_axi_bvalid ),
   .c1_s0_axi_bready                       (c1_s0_axi_bready ),
   .c1_s0_axi_arid                         (c1_s0_axi_arid   ),
   .c1_s0_axi_araddr                       (c1_s0_axi_araddr ),
   .c1_s0_axi_arlen                        (c1_s0_axi_arlen  ),
   .c1_s0_axi_arsize                       (c1_s0_axi_arsize ),
   .c1_s0_axi_arburst                      (c1_s0_axi_arburst),
   .c1_s0_axi_arlock                       (c1_s0_axi_arlock ),
   .c1_s0_axi_arcache                      (c1_s0_axi_arcache),
   .c1_s0_axi_arprot                       (c1_s0_axi_arprot ),
   .c1_s0_axi_arqos                        (c1_s0_axi_arqos  ),
   .c1_s0_axi_arvalid                      (c1_s0_axi_arvalid),
   .c1_s0_axi_arready                      (c1_s0_axi_arready),
   .c1_s0_axi_rid                          (c1_s0_axi_rid    ),
   .c1_s0_axi_rdata                        (c1_s0_axi_rdata  ),
   .c1_s0_axi_rresp                        (c1_s0_axi_rresp  ),
   .c1_s0_axi_rlast                        (c1_s0_axi_rlast  ),
   .c1_s0_axi_rvalid                       (c1_s0_axi_rvalid ),
   .c1_s0_axi_rready                       (c1_s0_axi_rready ),
   .c1_s1_axi_aclk                         (c1_s1_axi_aclk   ),
   .c1_s1_axi_aresetn                      (c1_s1_axi_aresetn),
   .c1_s1_axi_awid                         (c1_s1_axi_awid   ),
   .c1_s1_axi_awaddr                       (c1_s1_axi_awaddr ),
   .c1_s1_axi_awlen                        (c1_s1_axi_awlen  ),
   .c1_s1_axi_awsize                       (c1_s1_axi_awsize ),
   .c1_s1_axi_awburst                      (c1_s1_axi_awburst),
   .c1_s1_axi_awlock                       (c1_s1_axi_awlock ),
   .c1_s1_axi_awcache                      (c1_s1_axi_awcache),
   .c1_s1_axi_awprot                       (c1_s1_axi_awprot ),
   .c1_s1_axi_awqos                        (c1_s1_axi_awqos  ),
   .c1_s1_axi_awvalid                      (c1_s1_axi_awvalid),
   .c1_s1_axi_awready                      (c1_s1_axi_awready),
   .c1_s1_axi_wdata                        (c1_s1_axi_wdata  ),
   .c1_s1_axi_wstrb                        (c1_s1_axi_wstrb  ),
   .c1_s1_axi_wlast                        (c1_s1_axi_wlast  ),
   .c1_s1_axi_wvalid                       (c1_s1_axi_wvalid ),
   .c1_s1_axi_wready                       (c1_s1_axi_wready ),
   .c1_s1_axi_bid                          (c1_s1_axi_bid    ),
   .c1_s1_axi_wid                          (c1_s1_axi_wid    ),
   .c1_s1_axi_bresp                        (c1_s1_axi_bresp  ),
   .c1_s1_axi_bvalid                       (c1_s1_axi_bvalid ),
   .c1_s1_axi_bready                       (c1_s1_axi_bready ),
   .c1_s1_axi_arid                         (c1_s1_axi_arid   ),
   .c1_s1_axi_araddr                       (c1_s1_axi_araddr ),
   .c1_s1_axi_arlen                        (c1_s1_axi_arlen  ),
   .c1_s1_axi_arsize                       (c1_s1_axi_arsize ),
   .c1_s1_axi_arburst                      (c1_s1_axi_arburst),
   .c1_s1_axi_arlock                       (c1_s1_axi_arlock ),
   .c1_s1_axi_arcache                      (c1_s1_axi_arcache),
   .c1_s1_axi_arprot                       (c1_s1_axi_arprot ),
   .c1_s1_axi_arqos                        (c1_s1_axi_arqos  ),
   .c1_s1_axi_arvalid                      (c1_s1_axi_arvalid),
   .c1_s1_axi_arready                      (c1_s1_axi_arready),
   .c1_s1_axi_rid                          (c1_s1_axi_rid    ),
   .c1_s1_axi_rdata                        (c1_s1_axi_rdata  ),
   .c1_s1_axi_rresp                        (c1_s1_axi_rresp  ),
   .c1_s1_axi_rlast                        (c1_s1_axi_rlast  ),
   .c1_s1_axi_rvalid                       (c1_s1_axi_rvalid ),
   .c1_s1_axi_rready                       (c1_s1_axi_rready ),
   .c1_s2_axi_aclk                         (c1_s2_axi_aclk   ),
   .c1_s2_axi_aresetn                      (c1_s2_axi_aresetn),
   .c1_s2_axi_awid                         (c1_s2_axi_awid   ),
   .c1_s2_axi_awaddr                       (c1_s2_axi_awaddr ),
   .c1_s2_axi_awlen                        (c1_s2_axi_awlen  ),
   .c1_s2_axi_awsize                       (c1_s2_axi_awsize ),
   .c1_s2_axi_awburst                      (c1_s2_axi_awburst),
   .c1_s2_axi_awlock                       (c1_s2_axi_awlock ),
   .c1_s2_axi_awcache                      (c1_s2_axi_awcache),
   .c1_s2_axi_awprot                       (c1_s2_axi_awprot ),
   .c1_s2_axi_awqos                        (c1_s2_axi_awqos  ),
   .c1_s2_axi_awvalid                      (c1_s2_axi_awvalid),
   .c1_s2_axi_awready                      (c1_s2_axi_awready),
   .c1_s2_axi_wdata                        (c1_s2_axi_wdata  ),
   .c1_s2_axi_wstrb                        (c1_s2_axi_wstrb  ),
   .c1_s2_axi_wlast                        (c1_s2_axi_wlast  ),
   .c1_s2_axi_wvalid                       (c1_s2_axi_wvalid ),
   .c1_s2_axi_wready                       (c1_s2_axi_wready ),
   .c1_s2_axi_bid                          (c1_s2_axi_bid    ),
   .c1_s2_axi_wid                          (c1_s2_axi_wid    ),
   .c1_s2_axi_bresp                        (c1_s2_axi_bresp  ),
   .c1_s2_axi_bvalid                       (c1_s2_axi_bvalid ),
   .c1_s2_axi_bready                       (c1_s2_axi_bready ),
   .c1_s2_axi_arid                         (c1_s2_axi_arid   ),
   .c1_s2_axi_araddr                       (c1_s2_axi_araddr ),
   .c1_s2_axi_arlen                        (c1_s2_axi_arlen  ),
   .c1_s2_axi_arsize                       (c1_s2_axi_arsize ),
   .c1_s2_axi_arburst                      (c1_s2_axi_arburst),
   .c1_s2_axi_arlock                       (c1_s2_axi_arlock ),
   .c1_s2_axi_arcache                      (c1_s2_axi_arcache),
   .c1_s2_axi_arprot                       (c1_s2_axi_arprot ),
   .c1_s2_axi_arqos                        (c1_s2_axi_arqos  ),
   .c1_s2_axi_arvalid                      (c1_s2_axi_arvalid),
   .c1_s2_axi_arready                      (c1_s2_axi_arready),
   .c1_s2_axi_rid                          (c1_s2_axi_rid    ),
   .c1_s2_axi_rdata                        (c1_s2_axi_rdata  ),
   .c1_s2_axi_rresp                        (c1_s2_axi_rresp  ),
   .c1_s2_axi_rlast                        (c1_s2_axi_rlast  ),
   .c1_s2_axi_rvalid                       (c1_s2_axi_rvalid ),
   .c1_s2_axi_rready                       (c1_s2_axi_rready ),
   .c1_s3_axi_aclk                         (c1_s3_axi_aclk   ),
   .c1_s3_axi_aresetn                      (c1_s3_axi_aresetn),
   .c1_s3_axi_awid                         (c1_s3_axi_awid   ),
   .c1_s3_axi_awaddr                       (c1_s3_axi_awaddr ),
   .c1_s3_axi_awlen                        (c1_s3_axi_awlen  ),
   .c1_s3_axi_awsize                       (c1_s3_axi_awsize ),
   .c1_s3_axi_awburst                      (c1_s3_axi_awburst),
   .c1_s3_axi_awlock                       (c1_s3_axi_awlock ),
   .c1_s3_axi_awcache                      (c1_s3_axi_awcache),
   .c1_s3_axi_awprot                       (c1_s3_axi_awprot ),
   .c1_s3_axi_awqos                        (c1_s3_axi_awqos  ),
   .c1_s3_axi_awvalid                      (c1_s3_axi_awvalid),
   .c1_s3_axi_awready                      (c1_s3_axi_awready),
   .c1_s3_axi_wdata                        (c1_s3_axi_wdata  ),
   .c1_s3_axi_wstrb                        (c1_s3_axi_wstrb  ),
   .c1_s3_axi_wlast                        (c1_s3_axi_wlast  ),
   .c1_s3_axi_wvalid                       (c1_s3_axi_wvalid ),
   .c1_s3_axi_wready                       (c1_s3_axi_wready ),
   .c1_s3_axi_bid                          (c1_s3_axi_bid    ),
   .c1_s3_axi_wid                          (c1_s3_axi_wid    ),
   .c1_s3_axi_bresp                        (c1_s3_axi_bresp  ),
   .c1_s3_axi_bvalid                       (c1_s3_axi_bvalid ),
   .c1_s3_axi_bready                       (c1_s3_axi_bready ),
   .c1_s3_axi_arid                         (c1_s3_axi_arid   ),
   .c1_s3_axi_araddr                       (c1_s3_axi_araddr ),
   .c1_s3_axi_arlen                        (c1_s3_axi_arlen  ),
   .c1_s3_axi_arsize                       (c1_s3_axi_arsize ),
   .c1_s3_axi_arburst                      (c1_s3_axi_arburst),
   .c1_s3_axi_arlock                       (c1_s3_axi_arlock ),
   .c1_s3_axi_arcache                      (c1_s3_axi_arcache),
   .c1_s3_axi_arprot                       (c1_s3_axi_arprot ),
   .c1_s3_axi_arqos                        (c1_s3_axi_arqos  ),
   .c1_s3_axi_arvalid                      (c1_s3_axi_arvalid),
   .c1_s3_axi_arready                      (c1_s3_axi_arready),
   .c1_s3_axi_rid                          (c1_s3_axi_rid    ),
   .c1_s3_axi_rdata                        (c1_s3_axi_rdata  ),
   .c1_s3_axi_rresp                        (c1_s3_axi_rresp  ),
   .c1_s3_axi_rlast                        (c1_s3_axi_rlast  ),
   .c1_s3_axi_rvalid                       (c1_s3_axi_rvalid ),
   .c1_s3_axi_rready                       (c1_s3_axi_rready )
);      


// Reset to the AXI shim
   always @(posedge c1_clk0) begin
     c1_aresetn <= ~c1_rst0;
   end

//****************************************************************************************************  
// This is the instance of the AXI4 Traffic Generator. There will be one instance per side of the MCB.
// The traffic generator will generate random length AXI4 traffic on all the enabled ports
//****************************************************************************************************
// Test bench top for the controllers - 1

s6_axi4_tg #(

// CONTROLLER 0 parameters

         .C_PORT_CONFIG                 (C1_PORT_CONFIG),
         .C_P0_PORT_MODE                (C1_P0_PORT_MODE),
         .C_P1_PORT_MODE                (C1_P1_PORT_MODE),
         .C_P2_PORT_MODE                (C1_P2_PORT_MODE),
         .C_P3_PORT_MODE                (C1_P3_PORT_MODE),
         .C_P4_PORT_MODE                (C1_P4_PORT_MODE),
         .C_P5_PORT_MODE                (C1_P5_PORT_MODE),
         .C_PORT_ENABLE                 (C1_PORT_ENABLE),
         .C_BEGIN_ADDRESS               (C1_BEGIN_ADDRESS),
         .C_END_ADDRESS                 (C1_END_ADDRESS),
         .C_PRBS_EADDR_MASK_POS         (C1_PRBS_EADDR_MASK_POS),
         .C_PRBS_SADDR_MASK_POS         (C1_PRBS_SADDR_MASK_POS),
         .C_AXI_NBURST_SUPPORT          (C1_AXI_NBURST_SUPPORT),
         .C_ENFORCE_RD_WR               (C1_ENFORCE_RD_WR),
         .C_ENFORCE_RD_WR_CMD           (C1_ENFORCE_RD_WR_CMD),
         .C_ENFORCE_RD_WR_PATTERN       (C1_ENFORCE_RD_WR_PATTERN),
         .C_EN_WRAP_TRANS               (C1_EN_WRAP_TRANS),
         .C_EN_UPSIZER                  (C1_EN_UPSIZER),
// Controller 0, port 0 parameters
         .C_P0_AXI_SUPPORTS_READ        (C1_S0_AXI_SUPPORTS_READ),
         .C_P0_AXI_SUPPORTS_WRITE       (C1_S0_AXI_SUPPORTS_WRITE),
         .C_P0_AXI_ID_WIDTH             (C1_S0_AXI_ID_WIDTH),
         .C_P0_AXI_ADDR_WIDTH           (C1_S0_AXI_ADDR_WIDTH),
         .C_P0_AXI_DATA_WIDTH           (C1_S0_AXI_DATA_WIDTH),
// Controller 0, port 1 parameters
         .C_P1_AXI_SUPPORTS_READ        (C1_S1_AXI_SUPPORTS_READ),
         .C_P1_AXI_SUPPORTS_WRITE       (C1_S1_AXI_SUPPORTS_WRITE),
         .C_P1_AXI_ID_WIDTH             (C1_S1_AXI_ID_WIDTH),
         .C_P1_AXI_ADDR_WIDTH           (C1_S1_AXI_ADDR_WIDTH),
         .C_P1_AXI_DATA_WIDTH           (C1_S1_AXI_DATA_WIDTH),
// Controller 0, port 2 parameters
         .C_P2_AXI_SUPPORTS_READ        (C1_S2_AXI_SUPPORTS_READ),
         .C_P2_AXI_SUPPORTS_WRITE       (C1_S2_AXI_SUPPORTS_WRITE),
         .C_P2_AXI_ID_WIDTH             (C1_S2_AXI_ID_WIDTH),
         .C_P2_AXI_ADDR_WIDTH           (C1_S2_AXI_ADDR_WIDTH),
         .C_P2_AXI_DATA_WIDTH           (C1_S2_AXI_DATA_WIDTH),
// Controller 0, port 3 parameters
         .C_P3_AXI_SUPPORTS_READ        (C1_S3_AXI_SUPPORTS_READ),
         .C_P3_AXI_SUPPORTS_WRITE       (C1_S3_AXI_SUPPORTS_WRITE),
         .C_P3_AXI_ID_WIDTH             (C1_S3_AXI_ID_WIDTH),
         .C_P3_AXI_ADDR_WIDTH           (C1_S3_AXI_ADDR_WIDTH),
         .C_P3_AXI_DATA_WIDTH           (C1_S3_AXI_DATA_WIDTH),
// Controller 0, port 4 parameters
         .C_P4_AXI_SUPPORTS_READ        (C1_S4_AXI_SUPPORTS_READ),
         .C_P4_AXI_SUPPORTS_WRITE       (C1_S4_AXI_SUPPORTS_WRITE),
         .C_P4_AXI_ID_WIDTH             (C1_S4_AXI_ID_WIDTH),
         .C_P4_AXI_ADDR_WIDTH           (C1_S4_AXI_ADDR_WIDTH),
         .C_P4_AXI_DATA_WIDTH           (C1_S4_AXI_DATA_WIDTH),
// Controller 0, port 5 parameters
         .C_P5_AXI_SUPPORTS_READ        (C1_S5_AXI_SUPPORTS_READ),
         .C_P5_AXI_SUPPORTS_WRITE       (C1_S5_AXI_SUPPORTS_WRITE),
         .C_P5_AXI_ID_WIDTH             (C1_S5_AXI_ID_WIDTH),
         .C_P5_AXI_ADDR_WIDTH           (C1_S5_AXI_ADDR_WIDTH),
         .C_P5_AXI_DATA_WIDTH           (C1_S5_AXI_DATA_WIDTH),
// Common parameters
         .DBG_WR_STS_WIDTH               (DBG_WR_STS_WIDTH),
         .DBG_RD_STS_WIDTH               (DBG_RD_STS_WIDTH)

  ) s6_axi4_tg_inst1
  (
         .aclk                          (c1_clk0),    // AXI input clock for controller 0
         .aresetn                       (c1_aresetn),    // Active low AXI reset signal for controller 0
// Input control signals
         .init_cmptd                    (c1_calib_done),  // Initialization completed
         .init_test                     (1'b0),
         .wdog_mask                     (1'b1),
         .wrap_en                       (c1_wrap_en),
// CONTROLLER 0 - interface signals
// PORT 0 - interface signals
// AXI write address channel signals (for controller 0 and port 0)
         .axi_wready_c_p0               (c1_s0_axi_awready),
         .axi_wid_c_p0                  (c1_s0_axi_awid),
         .axi_waddr_c_p0                (c1_s0_axi_awaddr),
         .axi_wlen_c_p0                 (c1_s0_axi_awlen),
         .axi_wsize_c_p0                (c1_s0_axi_awsize),
         .axi_wburst_c_p0               (c1_s0_axi_awburst),
         .axi_wlock_c_p0                (c1_s0_axi_awlock),
         .axi_wcache_c_p0               (c1_s0_axi_awcache),
         .axi_wprot_c_p0                (c1_s0_axi_awprot),
         .axi_wvalid_c_p0               (c1_s0_axi_awvalid),
// AXI write data channel signals (for controller 0 and port 0)
         .axi_wd_wready_c_p0            (c1_s0_axi_wready),
         .axi_wd_wid_c_p0               (c1_s0_axi_wid),
         .axi_wd_data_c_p0              (c1_s0_axi_wdata),
         .axi_wd_strb_c_p0              (c1_s0_axi_wstrb),
         .axi_wd_last_c_p0              (c1_s0_axi_wlast),
         .axi_wd_valid_c_p0             (c1_s0_axi_wvalid),
// AXI write response channel signals (for controller 0 for port 0)
         .axi_wd_bid_c_p0               (c1_s0_axi_bid),
         .axi_wd_bresp_c_p0             (c1_s0_axi_bresp),
         .axi_wd_bvalid_c_p0            (c1_s0_axi_bvalid),
         .axi_wd_bready_c_p0            (c1_s0_axi_bready),
// AXI read address channel signals (for controller 0 port 0)
         .axi_rready_c_p0               (c1_s0_axi_arready),
         .axi_rid_c_p0                  (c1_s0_axi_arid),
         .axi_raddr_c_p0                (c1_s0_axi_araddr),
         .axi_rlen_c_p0                 (c1_s0_axi_arlen),
         .axi_rsize_c_p0                (c1_s0_axi_arsize),
         .axi_rburst_c_p0               (c1_s0_axi_arburst),
         .axi_rlock_c_p0                (c1_s0_axi_arlock),
         .axi_rcache_c_p0               (c1_s0_axi_arcache),
         .axi_rprot_c_p0                (c1_s0_axi_arprot),
         .axi_rvalid_c_p0               (c1_s0_axi_arvalid),
// AXI read data channel signals (for controller 0 port 0)
         .axi_rd_bid_c_p0               (c1_s0_axi_rid),
         .axi_rd_rresp_c_p0             (c1_s0_axi_rresp),
         .axi_rd_rvalid_c_p0            (c1_s0_axi_rvalid),
         .axi_rd_data_c_p0              (c1_s0_axi_rdata),
         .axi_rd_last_c_p0              (c1_s0_axi_rlast),
         .axi_rd_rready_c_p0            (c1_s0_axi_rready),
// PORT 1 - interface signals
// AXI write address channel signals (for controller 0 and port 1)
         .axi_wready_c_p1               (c1_s1_axi_awready),
         .axi_wid_c_p1                  (c1_s1_axi_awid),
         .axi_waddr_c_p1                (c1_s1_axi_awaddr),
         .axi_wlen_c_p1                 (c1_s1_axi_awlen),
         .axi_wsize_c_p1                (c1_s1_axi_awsize),
         .axi_wburst_c_p1               (c1_s1_axi_awburst),
         .axi_wlock_c_p1                (c1_s1_axi_awlock),
         .axi_wcache_c_p1               (c1_s1_axi_awcache),
         .axi_wprot_c_p1                (c1_s1_axi_awprot),
         .axi_wvalid_c_p1               (c1_s1_axi_awvalid),
// AXI write data channel signals (for controller 0 and port 1)
         .axi_wd_wready_c_p1            (c1_s1_axi_wready),
         .axi_wd_wid_c_p1               (c1_s1_axi_wid),
         .axi_wd_data_c_p1              (c1_s1_axi_wdata),
         .axi_wd_strb_c_p1              (c1_s1_axi_wstrb),
         .axi_wd_last_c_p1              (c1_s1_axi_wlast),
         .axi_wd_valid_c_p1             (c1_s1_axi_wvalid),
// AXI write response channel signals (for controller 0 for port 1)
         .axi_wd_bid_c_p1               (c1_s1_axi_bid),
         .axi_wd_bresp_c_p1             (c1_s1_axi_bresp),
         .axi_wd_bvalid_c_p1            (c1_s1_axi_bvalid),
         .axi_wd_bready_c_p1            (c1_s1_axi_bready),
// AXI read address channel signals (for controller 0 port 1)
         .axi_rready_c_p1               (c1_s1_axi_arready),
         .axi_rid_c_p1                  (c1_s1_axi_arid),
         .axi_raddr_c_p1                (c1_s1_axi_araddr),
         .axi_rlen_c_p1                 (c1_s1_axi_arlen),
         .axi_rsize_c_p1                (c1_s1_axi_arsize),
         .axi_rburst_c_p1               (c1_s1_axi_arburst),
         .axi_rlock_c_p1                (c1_s1_axi_arlock),
         .axi_rcache_c_p1               (c1_s1_axi_arcache),
         .axi_rprot_c_p1                (c1_s1_axi_arprot),
         .axi_rvalid_c_p1               (c1_s1_axi_arvalid),
// AXI read data channel signals (for controller 0 port 1)
         .axi_rd_bid_c_p1               (c1_s1_axi_rid),
         .axi_rd_rresp_c_p1             (c1_s1_axi_rresp),
         .axi_rd_rvalid_c_p1            (c1_s1_axi_rvalid),
         .axi_rd_data_c_p1              (c1_s1_axi_rdata),
         .axi_rd_last_c_p1              (c1_s1_axi_rlast),
         .axi_rd_rready_c_p1            (c1_s1_axi_rready),
// PORT 2 - interface signals
// AXI write address channel signals (for controller 0 and port 2)
         .axi_wready_c_p2               (c1_s2_axi_awready),
         .axi_wid_c_p2                  (c1_s2_axi_awid),
         .axi_waddr_c_p2                (c1_s2_axi_awaddr),
         .axi_wlen_c_p2                 (c1_s2_axi_awlen),
         .axi_wsize_c_p2                (c1_s2_axi_awsize),
         .axi_wburst_c_p2               (c1_s2_axi_awburst),
         .axi_wlock_c_p2                (c1_s2_axi_awlock),
         .axi_wcache_c_p2               (c1_s2_axi_awcache),
         .axi_wprot_c_p2                (c1_s2_axi_awprot),
         .axi_wvalid_c_p2               (c1_s2_axi_awvalid),
// AXI write data channel signals (for controller 0 and port 2)
         .axi_wd_wready_c_p2            (c1_s2_axi_wready),
         .axi_wd_wid_c_p2               (c1_s2_axi_wid),
         .axi_wd_data_c_p2              (c1_s2_axi_wdata),
         .axi_wd_strb_c_p2              (c1_s2_axi_wstrb),
         .axi_wd_last_c_p2              (c1_s2_axi_wlast),
         .axi_wd_valid_c_p2             (c1_s2_axi_wvalid),
// AXI write response channel signals (for controller 0 for port 2)
         .axi_wd_bid_c_p2               (c1_s2_axi_bid),
         .axi_wd_bresp_c_p2             (c1_s2_axi_bresp),
         .axi_wd_bvalid_c_p2            (c1_s2_axi_bvalid),
         .axi_wd_bready_c_p2            (c1_s2_axi_bready),
// AXI read address channel signals (for controller 0 port 2)
         .axi_rready_c_p2               (c1_s2_axi_arready),
         .axi_rid_c_p2                  (c1_s2_axi_arid),
         .axi_raddr_c_p2                (c1_s2_axi_araddr),
         .axi_rlen_c_p2                 (c1_s2_axi_arlen),
         .axi_rsize_c_p2                (c1_s2_axi_arsize),
         .axi_rburst_c_p2               (c1_s2_axi_arburst),
         .axi_rlock_c_p2                (c1_s2_axi_arlock),
         .axi_rcache_c_p2               (c1_s2_axi_arcache),
         .axi_rprot_c_p2                (c1_s2_axi_arprot),
         .axi_rvalid_c_p2               (c1_s2_axi_arvalid),
// AXI read data channel signals (for controller 0 port 2)
         .axi_rd_bid_c_p2               (c1_s2_axi_rid),
         .axi_rd_rresp_c_p2             (c1_s2_axi_rresp),
         .axi_rd_rvalid_c_p2            (c1_s2_axi_rvalid),
         .axi_rd_data_c_p2              (c1_s2_axi_rdata),
         .axi_rd_last_c_p2              (c1_s2_axi_rlast),
         .axi_rd_rready_c_p2            (c1_s2_axi_rready),
// PORT 3 - interface signals
// AXI write address channel signals (for controller 0 and port 3)
         .axi_wready_c_p3               (c1_s3_axi_awready),
         .axi_wid_c_p3                  (c1_s3_axi_awid),
         .axi_waddr_c_p3                (c1_s3_axi_awaddr),
         .axi_wlen_c_p3                 (c1_s3_axi_awlen),
         .axi_wsize_c_p3                (c1_s3_axi_awsize),
         .axi_wburst_c_p3               (c1_s3_axi_awburst),
         .axi_wlock_c_p3                (c1_s3_axi_awlock),
         .axi_wcache_c_p3               (c1_s3_axi_awcache),
         .axi_wprot_c_p3                (c1_s3_axi_awprot),
         .axi_wvalid_c_p3               (c1_s3_axi_awvalid),
// AXI write data channel signals (for controller 0 and port 3)
         .axi_wd_wready_c_p3            (c1_s3_axi_wready),
         .axi_wd_wid_c_p3               (c1_s3_axi_wid),
         .axi_wd_data_c_p3              (c1_s3_axi_wdata),
         .axi_wd_strb_c_p3              (c1_s3_axi_wstrb),
         .axi_wd_last_c_p3              (c1_s3_axi_wlast),
         .axi_wd_valid_c_p3             (c1_s3_axi_wvalid),
// AXI write response channel signals (for controller 0 for port 3)
         .axi_wd_bid_c_p3               (c1_s3_axi_bid),
         .axi_wd_bresp_c_p3             (c1_s3_axi_bresp),
         .axi_wd_bvalid_c_p3            (c1_s3_axi_bvalid),
         .axi_wd_bready_c_p3            (c1_s3_axi_bready),
// AXI read address channel signals (for controller 0 port 3)
         .axi_rready_c_p3               (c1_s3_axi_arready),
         .axi_rid_c_p3                  (c1_s3_axi_arid),
         .axi_raddr_c_p3                (c1_s3_axi_araddr),
         .axi_rlen_c_p3                 (c1_s3_axi_arlen),
         .axi_rsize_c_p3                (c1_s3_axi_arsize),
         .axi_rburst_c_p3               (c1_s3_axi_arburst),
         .axi_rlock_c_p3                (c1_s3_axi_arlock),
         .axi_rcache_c_p3               (c1_s3_axi_arcache),
         .axi_rprot_c_p3                (c1_s3_axi_arprot),
         .axi_rvalid_c_p3               (c1_s3_axi_arvalid),
// AXI read data channel signals (for controller 0 port 3)
         .axi_rd_bid_c_p3               (c1_s3_axi_rid),
         .axi_rd_rresp_c_p3             (c1_s3_axi_rresp),
         .axi_rd_rvalid_c_p3            (c1_s3_axi_rvalid),
         .axi_rd_data_c_p3              (c1_s3_axi_rdata),
         .axi_rd_last_c_p3              (c1_s3_axi_rlast),
         .axi_rd_rready_c_p3            (c1_s3_axi_rready),
// PORT 4 - interface signals
// AXI write address channel signals (for controller 0 and port 4)
         .axi_wready_c_p4               (c1_s4_axi_awready),
         .axi_wid_c_p4                  (c1_s4_axi_awid),
         .axi_waddr_c_p4                (c1_s4_axi_awaddr),
         .axi_wlen_c_p4                 (c1_s4_axi_awlen),
         .axi_wsize_c_p4                (c1_s4_axi_awsize),
         .axi_wburst_c_p4               (c1_s4_axi_awburst),
         .axi_wlock_c_p4                (c1_s4_axi_awlock),
         .axi_wcache_c_p4               (c1_s4_axi_awcache),
         .axi_wprot_c_p4                (c1_s4_axi_awprot),
         .axi_wvalid_c_p4               (c1_s4_axi_awvalid),
// AXI write data channel signals (for controller 0 and port 4)
         .axi_wd_wready_c_p4            (c1_s4_axi_wready),
         .axi_wd_wid_c_p4               (c1_s4_axi_wid),
         .axi_wd_data_c_p4              (c1_s4_axi_wdata),
         .axi_wd_strb_c_p4              (c1_s4_axi_wstrb),
         .axi_wd_last_c_p4              (c1_s4_axi_wlast),
         .axi_wd_valid_c_p4             (c1_s4_axi_wvalid),
// AXI write response channel signals (for controller 0 for port 4)
         .axi_wd_bid_c_p4               (c1_s4_axi_bid),
         .axi_wd_bresp_c_p4             (c1_s4_axi_bresp),
         .axi_wd_bvalid_c_p4            (c1_s4_axi_bvalid),
         .axi_wd_bready_c_p4            (c1_s4_axi_bready),
// AXI read address channel signals (for controller 0 port 4)
         .axi_rready_c_p4               (c1_s4_axi_arready),
         .axi_rid_c_p4                  (c1_s4_axi_arid),
         .axi_raddr_c_p4                (c1_s4_axi_araddr),
         .axi_rlen_c_p4                 (c1_s4_axi_arlen),
         .axi_rsize_c_p4                (c1_s4_axi_arsize),
         .axi_rburst_c_p4               (c1_s4_axi_arburst),
         .axi_rlock_c_p4                (c1_s4_axi_arlock),
         .axi_rcache_c_p4               (c1_s4_axi_arcache),
         .axi_rprot_c_p4                (c1_s4_axi_arprot),
         .axi_rvalid_c_p4               (c1_s4_axi_arvalid),
// AXI read data channel signals (for controller 0 port 4)
         .axi_rd_bid_c_p4               (c1_s4_axi_rid),
         .axi_rd_rresp_c_p4             (c1_s4_axi_rresp),
         .axi_rd_rvalid_c_p4            (c1_s4_axi_rvalid),
         .axi_rd_data_c_p4              (c1_s4_axi_rdata),
         .axi_rd_last_c_p4              (c1_s4_axi_rlast),
         .axi_rd_rready_c_p4            (c1_s4_axi_rready),
// PORT 5 - interface signals
// AXI write address channel signals (for controller 0 and port 5)
         .axi_wready_c_p5               (c1_s5_axi_awready),
         .axi_wid_c_p5                  (c1_s5_axi_awid),
         .axi_waddr_c_p5                (c1_s5_axi_awaddr),
         .axi_wlen_c_p5                 (c1_s5_axi_awlen),
         .axi_wsize_c_p5                (c1_s5_axi_awsize),
         .axi_wburst_c_p5               (c1_s5_axi_awburst),
         .axi_wlock_c_p5                (c1_s5_axi_awlock),
         .axi_wcache_c_p5               (c1_s5_axi_awcache),
         .axi_wprot_c_p5                (c1_s5_axi_awprot),
         .axi_wvalid_c_p5               (c1_s5_axi_awvalid),
// AXI write data channel signals (for controller 0 and port 5)
         .axi_wd_wready_c_p5            (c1_s5_axi_wready),
         .axi_wd_wid_c_p5               (c1_s5_axi_wid),
         .axi_wd_data_c_p5              (c1_s5_axi_wdata),
         .axi_wd_strb_c_p5              (c1_s5_axi_wstrb),
         .axi_wd_last_c_p5              (c1_s5_axi_wlast),
         .axi_wd_valid_c_p5             (c1_s5_axi_wvalid),
// AXI write response channel signals (for controller 0 for port 5)
         .axi_wd_bid_c_p5               (c1_s5_axi_bid),
         .axi_wd_bresp_c_p5             (c1_s5_axi_bresp),
         .axi_wd_bvalid_c_p5            (c1_s5_axi_bvalid),
         .axi_wd_bready_c_p5            (c1_s5_axi_bready),
// AXI read address channel signals (for controller 0 port 5)
         .axi_rready_c_p5               (c1_s5_axi_arready),
         .axi_rid_c_p5                  (c1_s5_axi_arid),
         .axi_raddr_c_p5                (c1_s5_axi_araddr),
         .axi_rlen_c_p5                 (c1_s5_axi_arlen),
         .axi_rsize_c_p5                (c1_s5_axi_arsize),
         .axi_rburst_c_p5               (c1_s5_axi_arburst),
         .axi_rlock_c_p5                (c1_s5_axi_arlock),
         .axi_rcache_c_p5               (c1_s5_axi_arcache),
         .axi_rprot_c_p5                (c1_s5_axi_arprot),
         .axi_rvalid_c_p5               (c1_s5_axi_arvalid),
// AXI read data channel signals (for controller 0 port 5)
         .axi_rd_bid_c_p5               (c1_s5_axi_rid),
         .axi_rd_rresp_c_p5             (c1_s5_axi_rresp),
         .axi_rd_rvalid_c_p5            (c1_s5_axi_rvalid),
         .axi_rd_data_c_p5              (c1_s5_axi_rdata),
         .axi_rd_last_c_p5              (c1_s5_axi_rlast),
         .axi_rd_rready_c_p5            (c1_s5_axi_rready),

// Error status signals
         .cmd_err                       (c1_cmd_err),
         .data_msmatch_err              (c1_data_msmatch_err),
         .write_err                     (c1_write_err),
         .read_err                      (c1_read_err),
         .test_cmptd                    (c1_test_cmptd),
         .cmptd_one_wr_rd               (c1_cmptd_one_wr_rd),

// Debug status signals
         .dbg_wr_sts_vld                (c1_dbg_wr_sts_vld),
         .dbg_wr_sts                    (c1_dbg_wr_sts),
         .dbg_rd_sts_vld                (c1_dbg_rd_sts_vld),
         .dbg_rd_sts                    (c1_dbg_rd_sts)
);
   









// ========================================================================== //
// Memory model instances                                                     // 
// ========================================================================== //

   generate
      if(C1_NUM_DQ_PINS == 16) begin : MEM_INST1
     ddr2_model_c1 u_mem_c1(
        .ck         (mcb1_dram_ck),
        .ck_n       (mcb1_dram_ck_n),
        .cke        (mcb1_dram_cke),
        .cs_n       (1'b0),
        .ras_n      (mcb1_dram_ras_n),
        .cas_n      (mcb1_dram_cas_n),
        .we_n       (mcb1_dram_we_n),
        .dm_rdqs    ({mcb1_dram_udm,mcb1_dram_dm}),
        .ba         (mcb1_dram_ba),
        .addr       (mcb1_dram_a),
        .dq         (mcb1_dram_dq),
        .dqs        ({mcb1_dram_udqs,mcb1_dram_dqs}),
        .dqs_n      ({mcb1_dram_udqs_n,mcb1_dram_dqs_n}),
        .rdqs_n     (),
        .odt        (mcb1_dram_odt)
      );
      end else begin
     ddr2_model_c1 u_mem_c1(
        .ck         (mcb1_dram_ck),
        .ck_n       (mcb1_dram_ck_n),
        .cke        (mcb1_dram_cke),
        .cs_n       (1'b0),
        .ras_n      (mcb1_dram_ras_n),
        .cas_n      (mcb1_dram_cas_n),
        .we_n       (mcb1_dram_we_n),
        .dm_rdqs    (mcb1_dram_dm),
        .ba         (mcb1_dram_ba),
        .addr       (mcb1_dram_a),
        .dq         (mcb1_dram_dq),
        .dqs        (mcb1_dram_dqs),
        .dqs_n      (mcb1_dram_dqs_n),
        .rdqs_n     (),
        .odt        (mcb1_dram_odt)
      );
     end
   endgenerate

// ========================================================================== //
// Reporting the test case status 
// ========================================================================== //
   initial
   begin : Logging
      fork
         begin : calibration_done
            wait (calib_done);
            $display("Calibration Done");
            #50000000;
            if (!error) begin
               $display("TEST PASSED");
            end   
            else begin
               $display("TEST FAILED: DATA ERROR");		 
            end
            disable calib_not_done;
	    $finish;
         end	 
         
         begin : calib_not_done
            #200000000;
            if (!calib_done) begin
               $display("TEST FAILED: INITIALIZATION DID NOT COMPLETE");
            end
            disable calibration_done;
	    $finish;
         end
      join	 
   end      

endmodule
