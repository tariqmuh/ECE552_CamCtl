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
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 3.92
//  \   \         Application        : MIG
//  /   /         Filename           : axi_burst #.v
// /___/   /\     Date Last Modified : $Date: 2011/06/02 07:17:09 $
// \   \  /  \    Date Created       : Tue Feb 23 2010
//  \___\/\___\
//
//Device           : Spartan-6
//Design Name      : DDR/DDR2/DDR3/LPDDR 
//Purpose          : This is a template file for the design top module. This module contains 
//                   all the four memory controllers and the two infrastructures. However,
//                   only the enabled modules will be active and others inactive.
//Reference        :
//Revision History :
//*****************************************************************************
`timescale 1ns/1ps

(* X_CORE_INFO = "mig_v3_92_ddr2_ddr2_s6, Coregen 14.2" , CORE_GENERATION_INFO = "ddr2_ddr2_s6,mig_v3_92,{component_name=axi_burst, C1_MEM_INTERFACE_TYPE=DDR2_SDRAM, C1_CLK_PERIOD=3000, C1_MEMORY_PART=mt47h128m8xx-25, C1_MEMORY_DEVICE_WIDTH=8, C1_OUTPUT_DRV=FULL, C1_RTT_NOM=50OHMS, C1_DQS#_ENABLE=YES, C1_HIGH_TEMP_SR=NORMAL, C1_PORT_CONFIG=Two 32-bit bi-directional and four 32-bit unidirectional ports, C1_MEM_ADDR_ORDER=ROW_BANK_COLUMN, C1_PORT_ENABLE=Port0_Port1_Port2_Port3, C1_CLASS_ADDR=II, C1_CLASS_DATA=II, C1_INPUT_PIN_TERMINATION=CALIB_TERM, C1_DATA_TERMINATION=25 Ohms, C1_CLKFBOUT_MULT_F=2, C1_CLKOUT_DIVIDE=1, C1_DEBUG_PORT=0, INPUT_CLK_TYPE=Differential, LANGUAGE=Verilog, SYNTHESIS_TOOL=Foundation_ISE, NO_OF_CONTROLLERS=1}" *)
module axi_burst #
(
   parameter C1_P0_MASK_SIZE           = 4,
   parameter C1_P0_DATA_PORT_SIZE      = 32,
   parameter C1_P1_MASK_SIZE           = 4,
   parameter C1_P1_DATA_PORT_SIZE      = 32,
   parameter DEBUG_EN                = 0,       
                                       // # = 1, Enable debug signals/controls,
                                       //   = 0, Disable debug signals/controls.
   parameter C1_MEMCLK_PERIOD        = 3000,       
                                       // Memory data transfer clock period
   parameter C1_CALIB_SOFT_IP        = "TRUE",       
                                       // # = TRUE, Enables the soft calibration logic,
                                       // # = FALSE, Disables the soft calibration logic.
   parameter C1_SIMULATION           = "FALSE",       
                                       // # = TRUE, Simulating the design. Useful to reduce the simulation time,
                                       // # = FALSE, Implementing the design.
   parameter C1_RST_ACT_LOW          = 0,       
                                       // # = 1 for active low reset,
                                       // # = 0 for active high reset.
   parameter C1_INPUT_CLK_TYPE       = "DIFFERENTIAL",       
                                       // input clock type DIFFERENTIAL or SINGLE_ENDED
   parameter C1_MEM_ADDR_ORDER       = "ROW_BANK_COLUMN",       
                                       // The order in which user address is provided to the memory controller,
                                       // ROW_BANK_COLUMN or BANK_ROW_COLUMN
   parameter C1_NUM_DQ_PINS          = 8,       
                                       // External memory data width
   parameter C1_MEM_ADDR_WIDTH       = 14,       
                                       // External memory address width
    parameter  C1_MEM_BANKADDR_WIDTH  =  3,
					//  External  memory  bank  address  width
   parameter C1_S0_AXI_STRICT_COHERENCY   =  0,
   parameter C1_S0_AXI_ENABLE_AP          =  0,
   parameter C1_S0_AXI_DATA_WIDTH         =  32,
   parameter C1_S0_AXI_SUPPORTS_NARROW_BURST  =  1,
   parameter C1_S0_AXI_ADDR_WIDTH         =  32,
   parameter C1_S0_AXI_ID_WIDTH           =  4,
   parameter C1_S1_AXI_STRICT_COHERENCY   =  0,
   parameter C1_S1_AXI_ENABLE_AP          =  0,
   parameter C1_S1_AXI_DATA_WIDTH         =  32,
   parameter C1_S1_AXI_SUPPORTS_NARROW_BURST  =  1,
   parameter C1_S1_AXI_ADDR_WIDTH         =  32,
   parameter C1_S1_AXI_ID_WIDTH           =  4,
   parameter C1_S2_AXI_STRICT_COHERENCY   =  0,
   parameter C1_S2_AXI_ENABLE_AP          =  0,
   parameter C1_S2_AXI_DATA_WIDTH         =  32,
   parameter C1_S2_AXI_SUPPORTS_NARROW_BURST  =  1,
   parameter C1_S2_AXI_ADDR_WIDTH         =  32,
   parameter C1_S2_AXI_ID_WIDTH           =  4,
   parameter C1_S3_AXI_STRICT_COHERENCY   =  0,
   parameter C1_S3_AXI_ENABLE_AP          =  0,
   parameter C1_S3_AXI_DATA_WIDTH         =  32,
   parameter C1_S3_AXI_SUPPORTS_NARROW_BURST  =  1,
   parameter C1_S3_AXI_ADDR_WIDTH         =  32,
   parameter C1_S3_AXI_ID_WIDTH           =  4,
   parameter C1_S0_AXI_SUPPORTS_READ	=0,
   parameter C1_S0_AXI_SUPPORTS_WRITE	=1,
   parameter C1_S1_AXI_SUPPORTS_READ	=1,
   parameter C1_S1_AXI_SUPPORTS_WRITE	=0,
   parameter C1_S2_AXI_SUPPORTS_READ	=1,
   parameter C1_S2_AXI_SUPPORTS_WRITE	=0,
   parameter C1_S3_AXI_SUPPORTS_READ	=1,
   parameter C1_S3_AXI_SUPPORTS_WRITE	=0,
   parameter C1_S0_AXI_ENABLE	=1,
   parameter C1_S1_AXI_ENABLE	=1,
   parameter C1_S2_AXI_ENABLE	=1,
   parameter C1_S3_AXI_ENABLE	=1
)	

(

   inout  [C1_NUM_DQ_PINS-1:0]                      mcb1_dram_dq,
   output [C1_MEM_ADDR_WIDTH-1:0]                   mcb1_dram_a,
   output [C1_MEM_BANKADDR_WIDTH-1:0]               mcb1_dram_ba,
   output                                           mcb1_dram_ras_n,
   output                                           mcb1_dram_cas_n,
   output                                           mcb1_dram_we_n,
   output                                           mcb1_dram_odt,
   output                                           mcb1_dram_cke,
   output                                           mcb1_dram_dm,
   inout                                            mcb1_rzq,
   inout                                            mcb1_zio,
   input                                            c1_sys_clk_p,
   input                                            c1_sys_clk_n,
   input                                            c1_sys_rst_i,
   output                                           c1_calib_done,
   output                                           c1_clk0,
   output                                           c1_rst0,
   inout                                            mcb1_dram_dqs,
   inout                                            mcb1_dram_dqs_n,
   output                                           mcb1_dram_ck,
   output                                           mcb1_dram_ck_n,
      input		c1_s0_axi_aclk   ,
      input		c1_s0_axi_aresetn,
      input [C1_S0_AXI_ID_WIDTH - 1:0]	c1_s0_axi_awid   ,
      input [C1_S0_AXI_ADDR_WIDTH - 1:0]	c1_s0_axi_awaddr ,
      input [7:0]	c1_s0_axi_awlen  ,
      input [2:0]	c1_s0_axi_awsize ,
      input [1:0]	c1_s0_axi_awburst,
      input [0:0]	c1_s0_axi_awlock ,
      input [3:0]	c1_s0_axi_awcache,
      input [2:0]	c1_s0_axi_awprot ,
      input [3:0]	c1_s0_axi_awqos  ,
      input		c1_s0_axi_awvalid,
      output		c1_s0_axi_awready,
      input [C1_S0_AXI_DATA_WIDTH - 1:0]	c1_s0_axi_wdata  ,
      input [C1_S0_AXI_DATA_WIDTH/8 - 1:0]	c1_s0_axi_wstrb  ,
      input		c1_s0_axi_wlast  ,
      input		c1_s0_axi_wvalid ,
      output		c1_s0_axi_wready ,
      output [C1_S0_AXI_ID_WIDTH - 1:0]	c1_s0_axi_bid    ,
      output [C1_S0_AXI_ID_WIDTH - 1:0]	c1_s0_axi_wid    ,
      output [1:0]	c1_s0_axi_bresp  ,
      output		c1_s0_axi_bvalid ,
      input		c1_s0_axi_bready ,
      input [C1_S0_AXI_ID_WIDTH - 1:0]	c1_s0_axi_arid   ,
      input [C1_S0_AXI_ADDR_WIDTH - 1:0]	c1_s0_axi_araddr ,
      input [7:0]	c1_s0_axi_arlen  ,
      input [2:0]	c1_s0_axi_arsize ,
      input [1:0]	c1_s0_axi_arburst,
      input [0:0]	c1_s0_axi_arlock ,
      input [3:0]	c1_s0_axi_arcache,
      input [2:0]	c1_s0_axi_arprot ,
      input [3:0]	c1_s0_axi_arqos  ,
      input		c1_s0_axi_arvalid,
      output		c1_s0_axi_arready,
      output [C1_S0_AXI_ID_WIDTH - 1:0]	c1_s0_axi_rid    ,
      output [C1_S0_AXI_DATA_WIDTH - 1:0]	c1_s0_axi_rdata  ,
      output [1:0]	c1_s0_axi_rresp  ,
      output		c1_s0_axi_rlast  ,
      output		c1_s0_axi_rvalid ,
      input		c1_s0_axi_rready ,
      input		c1_s1_axi_aclk   ,
      input		c1_s1_axi_aresetn,
      input [C1_S1_AXI_ID_WIDTH - 1:0]	c1_s1_axi_awid   ,
      input [C1_S1_AXI_ADDR_WIDTH - 1:0]	c1_s1_axi_awaddr ,
      input [7:0]	c1_s1_axi_awlen  ,
      input [2:0]	c1_s1_axi_awsize ,
      input [1:0]	c1_s1_axi_awburst,
      input [0:0]	c1_s1_axi_awlock ,
      input [3:0]	c1_s1_axi_awcache,
      input [2:0]	c1_s1_axi_awprot ,
      input [3:0]	c1_s1_axi_awqos  ,
      input		c1_s1_axi_awvalid,
      output		c1_s1_axi_awready,
      input [C1_S1_AXI_DATA_WIDTH - 1:0]	c1_s1_axi_wdata  ,
      input [C1_S1_AXI_DATA_WIDTH/8 - 1:0]	c1_s1_axi_wstrb  ,
      input		c1_s1_axi_wlast  ,
      input		c1_s1_axi_wvalid ,
      output		c1_s1_axi_wready ,
      output [C1_S1_AXI_ID_WIDTH - 1:0]	c1_s1_axi_bid    ,
      output [C1_S1_AXI_ID_WIDTH - 1:0]	c1_s1_axi_wid    ,
      output [1:0]	c1_s1_axi_bresp  ,
      output		c1_s1_axi_bvalid ,
      input		c1_s1_axi_bready ,
      input [C1_S1_AXI_ID_WIDTH - 1:0]	c1_s1_axi_arid   ,
      input [C1_S1_AXI_ADDR_WIDTH - 1:0]	c1_s1_axi_araddr ,
      input [7:0]	c1_s1_axi_arlen  ,
      input [2:0]	c1_s1_axi_arsize ,
      input [1:0]	c1_s1_axi_arburst,
      input [0:0]	c1_s1_axi_arlock ,
      input [3:0]	c1_s1_axi_arcache,
      input [2:0]	c1_s1_axi_arprot ,
      input [3:0]	c1_s1_axi_arqos  ,
      input		c1_s1_axi_arvalid,
      output		c1_s1_axi_arready,
      output [C1_S1_AXI_ID_WIDTH - 1:0]	c1_s1_axi_rid    ,
      output [C1_S1_AXI_DATA_WIDTH - 1:0]	c1_s1_axi_rdata  ,
      output [1:0]	c1_s1_axi_rresp  ,
      output		c1_s1_axi_rlast  ,
      output		c1_s1_axi_rvalid ,
      input		c1_s1_axi_rready ,
      input		c1_s2_axi_aclk   ,
      input		c1_s2_axi_aresetn,
      input [C1_S2_AXI_ID_WIDTH - 1:0]	c1_s2_axi_awid   ,
      input [C1_S2_AXI_ADDR_WIDTH - 1:0]	c1_s2_axi_awaddr ,
      input [7:0]	c1_s2_axi_awlen  ,
      input [2:0]	c1_s2_axi_awsize ,
      input [1:0]	c1_s2_axi_awburst,
      input [0:0]	c1_s2_axi_awlock ,
      input [3:0]	c1_s2_axi_awcache,
      input [2:0]	c1_s2_axi_awprot ,
      input [3:0]	c1_s2_axi_awqos  ,
      input		c1_s2_axi_awvalid,
      output		c1_s2_axi_awready,
      input [C1_S2_AXI_DATA_WIDTH - 1:0]	c1_s2_axi_wdata  ,
      input [C1_S2_AXI_DATA_WIDTH/8 - 1:0]	c1_s2_axi_wstrb  ,
      input		c1_s2_axi_wlast  ,
      input		c1_s2_axi_wvalid ,
      output		c1_s2_axi_wready ,
      output [C1_S2_AXI_ID_WIDTH - 1:0]	c1_s2_axi_bid    ,
      output [C1_S2_AXI_ID_WIDTH - 1:0]	c1_s2_axi_wid    ,
      output [1:0]	c1_s2_axi_bresp  ,
      output		c1_s2_axi_bvalid ,
      input		c1_s2_axi_bready ,
      input [C1_S2_AXI_ID_WIDTH - 1:0]	c1_s2_axi_arid   ,
      input [C1_S2_AXI_ADDR_WIDTH - 1:0]	c1_s2_axi_araddr ,
      input [7:0]	c1_s2_axi_arlen  ,
      input [2:0]	c1_s2_axi_arsize ,
      input [1:0]	c1_s2_axi_arburst,
      input [0:0]	c1_s2_axi_arlock ,
      input [3:0]	c1_s2_axi_arcache,
      input [2:0]	c1_s2_axi_arprot ,
      input [3:0]	c1_s2_axi_arqos  ,
      input		c1_s2_axi_arvalid,
      output		c1_s2_axi_arready,
      output [C1_S2_AXI_ID_WIDTH - 1:0]	c1_s2_axi_rid    ,
      output [C1_S2_AXI_DATA_WIDTH - 1:0]	c1_s2_axi_rdata  ,
      output [1:0]	c1_s2_axi_rresp  ,
      output		c1_s2_axi_rlast  ,
      output		c1_s2_axi_rvalid ,
      input		c1_s2_axi_rready ,
      input		c1_s3_axi_aclk   ,
      input		c1_s3_axi_aresetn,
      input [C1_S3_AXI_ID_WIDTH - 1:0]	c1_s3_axi_awid   ,
      input [C1_S3_AXI_ADDR_WIDTH - 1:0]	c1_s3_axi_awaddr ,
      input [7:0]	c1_s3_axi_awlen  ,
      input [2:0]	c1_s3_axi_awsize ,
      input [1:0]	c1_s3_axi_awburst,
      input [0:0]	c1_s3_axi_awlock ,
      input [3:0]	c1_s3_axi_awcache,
      input [2:0]	c1_s3_axi_awprot ,
      input [3:0]	c1_s3_axi_awqos  ,
      input		c1_s3_axi_awvalid,
      output		c1_s3_axi_awready,
      input [C1_S3_AXI_DATA_WIDTH - 1:0]	c1_s3_axi_wdata  ,
      input [C1_S3_AXI_DATA_WIDTH/8 - 1:0]	c1_s3_axi_wstrb  ,
      input		c1_s3_axi_wlast  ,
      input		c1_s3_axi_wvalid ,
      output		c1_s3_axi_wready ,
      output [C1_S3_AXI_ID_WIDTH - 1:0]	c1_s3_axi_bid    ,
      output [C1_S3_AXI_ID_WIDTH - 1:0]	c1_s3_axi_wid    ,
      output [1:0]	c1_s3_axi_bresp  ,
      output		c1_s3_axi_bvalid ,
      input		c1_s3_axi_bready ,
      input [C1_S3_AXI_ID_WIDTH - 1:0]	c1_s3_axi_arid   ,
      input [C1_S3_AXI_ADDR_WIDTH - 1:0]	c1_s3_axi_araddr ,
      input [7:0]	c1_s3_axi_arlen  ,
      input [2:0]	c1_s3_axi_arsize ,
      input [1:0]	c1_s3_axi_arburst,
      input [0:0]	c1_s3_axi_arlock ,
      input [3:0]	c1_s3_axi_arcache,
      input [2:0]	c1_s3_axi_arprot ,
      input [3:0]	c1_s3_axi_arqos  ,
      input		c1_s3_axi_arvalid,
      output		c1_s3_axi_arready,
      output [C1_S3_AXI_ID_WIDTH - 1:0]	c1_s3_axi_rid    ,
      output [C1_S3_AXI_DATA_WIDTH - 1:0]	c1_s3_axi_rdata  ,
      output [1:0]	c1_s3_axi_rresp  ,
      output		c1_s3_axi_rlast  ,
      output		c1_s3_axi_rvalid ,
      input		c1_s3_axi_rready 
);
// The parameter CX_PORT_ENABLE shows all the active user ports in the design.
// For example, the value 6'b111100 tells that only port-2, port-3, port-4
// and port-5 are enabled. The other two ports are inactive. An inactive port
// can be a disabled port or an invisible logical port. Few examples to the 
// invisible logical port are port-4 and port-5 in the user port configuration,
// Config-2: Four 32-bit bi-directional ports and the ports port-2 through
// port-5 in Config-4: Two 64-bit bi-directional ports. Please look into the 
// Chapter-2 of ug388.pdf in the /docs directory for further details.
   localparam C1_PORT_ENABLE              = 6'b001111;
   localparam C1_PORT_CONFIG             =  "B32_B32_R32_R32_R32_R32";
   localparam C1_CLKOUT0_DIVIDE       = 1;       
   localparam C1_CLKOUT1_DIVIDE       = 1;       
   localparam C1_CLKOUT2_DIVIDE       = 16;       
   localparam C1_CLKOUT3_DIVIDE       = 8;       
   localparam C1_CLKFBOUT_MULT        = 2;       
   localparam C1_DIVCLK_DIVIDE        = 1;       
   localparam C1_ARB_ALGORITHM        = 0;       
   localparam C1_ARB_NUM_TIME_SLOTS   = 12;       
   localparam C1_ARB_TIME_SLOT_0      = 12'o0123;       
   localparam C1_ARB_TIME_SLOT_1      = 12'o1230;       
   localparam C1_ARB_TIME_SLOT_2      = 12'o2301;       
   localparam C1_ARB_TIME_SLOT_3      = 12'o3012;       
   localparam C1_ARB_TIME_SLOT_4      = 12'o0123;       
   localparam C1_ARB_TIME_SLOT_5      = 12'o1230;       
   localparam C1_ARB_TIME_SLOT_6      = 12'o2301;       
   localparam C1_ARB_TIME_SLOT_7      = 12'o3012;       
   localparam C1_ARB_TIME_SLOT_8      = 12'o0123;       
   localparam C1_ARB_TIME_SLOT_9      = 12'o1230;       
   localparam C1_ARB_TIME_SLOT_10     = 12'o2301;       
   localparam C1_ARB_TIME_SLOT_11     = 12'o3012;       
   localparam C1_MEM_TRAS             = 40000;       
   localparam C1_MEM_TRCD             = 15000;       
   localparam C1_MEM_TREFI            = 7800000;       
   localparam C1_MEM_TRFC             = 127500;       
   localparam C1_MEM_TRP              = 15000;       
   localparam C1_MEM_TWR              = 15000;       
   localparam C1_MEM_TRTP             = 7500;       
   localparam C1_MEM_TWTR             = 7500;       
   localparam C1_MEM_TYPE             = "DDR2";       
   localparam C1_MEM_DENSITY          = "1Gb";       
   localparam C1_MEM_BURST_LEN        = 4;       
   localparam C1_MEM_CAS_LATENCY      = 5;       
   localparam C1_MEM_NUM_COL_BITS     = 10;       
   localparam C1_MEM_DDR1_2_ODS       = "FULL";       
   localparam C1_MEM_DDR2_RTT         = "50OHMS";       
   localparam C1_MEM_DDR2_DIFF_DQS_EN  = "YES";       
   localparam C1_MEM_DDR2_3_PA_SR     = "FULL";       
   localparam C1_MEM_DDR2_3_HIGH_TEMP_SR  = "NORMAL";       
   localparam C1_MEM_DDR3_CAS_LATENCY  = 6;       
   localparam C1_MEM_DDR3_ODS         = "DIV6";       
   localparam C1_MEM_DDR3_RTT         = "DIV2";       
   localparam C1_MEM_DDR3_CAS_WR_LATENCY  = 5;       
   localparam C1_MEM_DDR3_AUTO_SR     = "ENABLED";       
   localparam C1_MEM_MOBILE_PA_SR     = "FULL";       
   localparam C1_MEM_MDDR_ODS         = "FULL";       
   localparam C1_MC_CALIB_BYPASS      = "NO";       
   localparam C1_MC_CALIBRATION_MODE  = "CALIBRATION";       
   localparam C1_MC_CALIBRATION_DELAY  = "HALF";       
   localparam C1_SKIP_IN_TERM_CAL     = 0;       
   localparam C1_SKIP_DYNAMIC_CAL     = 0;       
   localparam C1_LDQSP_TAP_DELAY_VAL  = 0;       
   localparam C1_LDQSN_TAP_DELAY_VAL  = 0;       
   localparam C1_UDQSP_TAP_DELAY_VAL  = 0;       
   localparam C1_UDQSN_TAP_DELAY_VAL  = 0;       
   localparam C1_DQ0_TAP_DELAY_VAL    = 0;       
   localparam C1_DQ1_TAP_DELAY_VAL    = 0;       
   localparam C1_DQ2_TAP_DELAY_VAL    = 0;       
   localparam C1_DQ3_TAP_DELAY_VAL    = 0;       
   localparam C1_DQ4_TAP_DELAY_VAL    = 0;       
   localparam C1_DQ5_TAP_DELAY_VAL    = 0;       
   localparam C1_DQ6_TAP_DELAY_VAL    = 0;       
   localparam C1_DQ7_TAP_DELAY_VAL    = 0;       
   localparam C1_DQ8_TAP_DELAY_VAL    = 0;       
   localparam C1_DQ9_TAP_DELAY_VAL    = 0;       
   localparam C1_DQ10_TAP_DELAY_VAL   = 0;       
   localparam C1_DQ11_TAP_DELAY_VAL   = 0;       
   localparam C1_DQ12_TAP_DELAY_VAL   = 0;       
   localparam C1_DQ13_TAP_DELAY_VAL   = 0;       
   localparam C1_DQ14_TAP_DELAY_VAL   = 0;       
   localparam C1_DQ15_TAP_DELAY_VAL   = 0;       
   localparam C1_MCB_USE_EXTERNAL_BUFPLL  = 1;       
   localparam C1_SMALL_DEVICE         = "FALSE";       // The parameter is set to TRUE for all packages of xc6slx9 device
                                                       // as most of them cannot fit the complete example design when the
                                                       // Chip scope modules are enabled
   localparam C1_INCLK_PERIOD         = ((C1_MEMCLK_PERIOD * C1_CLKFBOUT_MULT) / (C1_DIVCLK_DIVIDE * C1_CLKOUT0_DIVIDE * 2));       
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
   localparam C1_S4_AXI_SUPPORTS_READ	=0;
   localparam C1_S4_AXI_SUPPORTS_WRITE	=0;
   localparam C1_S5_AXI_SUPPORTS_READ	=0;
   localparam C1_S5_AXI_SUPPORTS_WRITE	=0;
   localparam C1_S4_AXI_ENABLE	=0;
   localparam C1_S5_AXI_ENABLE	=0;
   localparam DBG_WR_STS_WIDTH        = 32;
   localparam DBG_RD_STS_WIDTH        = 32;
   localparam C1_ARB_TIME0_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_0[11:9], C1_ARB_TIME_SLOT_0[8:6], C1_ARB_TIME_SLOT_0[5:3], C1_ARB_TIME_SLOT_0[2:0]};
   localparam C1_ARB_TIME1_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_1[11:9], C1_ARB_TIME_SLOT_1[8:6], C1_ARB_TIME_SLOT_1[5:3], C1_ARB_TIME_SLOT_1[2:0]};
   localparam C1_ARB_TIME2_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_2[11:9], C1_ARB_TIME_SLOT_2[8:6], C1_ARB_TIME_SLOT_2[5:3], C1_ARB_TIME_SLOT_2[2:0]};
   localparam C1_ARB_TIME3_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_3[11:9], C1_ARB_TIME_SLOT_3[8:6], C1_ARB_TIME_SLOT_3[5:3], C1_ARB_TIME_SLOT_3[2:0]};
   localparam C1_ARB_TIME4_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_4[11:9], C1_ARB_TIME_SLOT_4[8:6], C1_ARB_TIME_SLOT_4[5:3], C1_ARB_TIME_SLOT_4[2:0]};
   localparam C1_ARB_TIME5_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_5[11:9], C1_ARB_TIME_SLOT_5[8:6], C1_ARB_TIME_SLOT_5[5:3], C1_ARB_TIME_SLOT_5[2:0]};
   localparam C1_ARB_TIME6_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_6[11:9], C1_ARB_TIME_SLOT_6[8:6], C1_ARB_TIME_SLOT_6[5:3], C1_ARB_TIME_SLOT_6[2:0]};
   localparam C1_ARB_TIME7_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_7[11:9], C1_ARB_TIME_SLOT_7[8:6], C1_ARB_TIME_SLOT_7[5:3], C1_ARB_TIME_SLOT_7[2:0]};
   localparam C1_ARB_TIME8_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_8[11:9], C1_ARB_TIME_SLOT_8[8:6], C1_ARB_TIME_SLOT_8[5:3], C1_ARB_TIME_SLOT_8[2:0]};
   localparam C1_ARB_TIME9_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_9[11:9], C1_ARB_TIME_SLOT_9[8:6], C1_ARB_TIME_SLOT_9[5:3], C1_ARB_TIME_SLOT_9[2:0]};
   localparam C1_ARB_TIME10_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_10[11:9], C1_ARB_TIME_SLOT_10[8:6], C1_ARB_TIME_SLOT_10[5:3], C1_ARB_TIME_SLOT_10[2:0]};
   localparam C1_ARB_TIME11_SLOT  = {3'b000, 3'b000, C1_ARB_TIME_SLOT_11[11:9], C1_ARB_TIME_SLOT_11[8:6], C1_ARB_TIME_SLOT_11[5:3], C1_ARB_TIME_SLOT_11[2:0]};

  wire                              c1_sys_clk;
  wire                              c1_async_rst;
  wire                              c1_sysclk_2x;
  wire                              c1_sysclk_2x_180;
  wire                              c1_pll_ce_0;
  wire                              c1_pll_ce_90;
  wire                              c1_pll_lock;
  wire                              c1_mcb_drp_clk;
  wire                              c1_cmp_error;
  wire                              c1_vio_modify_enable;
  wire                              c1_wrap_en;
  wire                              c1_cmd_err;
  wire                              c1_data_msmatch_err;
  wire                              c1_write_err;
  wire                              c1_read_err;
  wire                              c1_test_cmptd;
  wire                              c1_cmptd_one_wr_rd;
  wire                              c1_dbg_wr_sts_vld;
  wire                              c1_dbg_rd_sts_vld;
  wire  [2:0]                      c1_vio_data_mode_value;
  wire  [2:0]                      c1_vio_addr_mode_value;
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



   reg   c1_aresetn;
   reg   c3_aresetn;
   reg   c4_aresetn;
   reg   c5_aresetn;



assign  c1_sys_clk = 1'b0;




// Infrastructure-1 instantiation
      infrastructure #
      (
         .C_INCLK_PERIOD                 (C1_INCLK_PERIOD),
         .C_RST_ACT_LOW                  (C1_RST_ACT_LOW),
         .C_INPUT_CLK_TYPE               (C1_INPUT_CLK_TYPE),
         .C_CLKOUT0_DIVIDE               (C1_CLKOUT0_DIVIDE),
         .C_CLKOUT1_DIVIDE               (C1_CLKOUT1_DIVIDE),
         .C_CLKOUT2_DIVIDE               (C1_CLKOUT2_DIVIDE),
         .C_CLKOUT3_DIVIDE               (C1_CLKOUT3_DIVIDE),
         .C_CLKFBOUT_MULT                (C1_CLKFBOUT_MULT),
         .C_DIVCLK_DIVIDE                (C1_DIVCLK_DIVIDE)
      )
      memc1_infrastructure_inst
      (
         .sys_clk_p                      (c1_sys_clk_p),  // [input] differential p type clock from board
         .sys_clk_n                      (c1_sys_clk_n),  // [input] differential n type clock from board
         .sys_clk                        (c1_sys_clk),    // [input] single ended input clock from board
         .sys_rst_i                      (c1_sys_rst_i),  
         .clk0                           (c1_clk0),       // [output] user clock which determines the operating frequency of user interface ports
         .rst0                           (c1_rst0),
         .async_rst                      (c1_async_rst),
         .sysclk_2x                      (c1_sysclk_2x),
         .sysclk_2x_180                  (c1_sysclk_2x_180),
         .pll_ce_0                       (c1_pll_ce_0),
         .pll_ce_90                      (c1_pll_ce_90),
         .pll_lock                       (c1_pll_lock),
         .mcb_drp_clk                    (c1_mcb_drp_clk)
      );
   

// Controller-1 instantiation
      memc_wrapper #
      (
         .C_MEMCLK_PERIOD                (C1_MEMCLK_PERIOD),   
         .C_CALIB_SOFT_IP                (C1_CALIB_SOFT_IP),
         //synthesis translate_off
         .C_SIMULATION                   (C1_SIMULATION),
         //synthesis translate_on
         .C_ARB_NUM_TIME_SLOTS           (C1_ARB_NUM_TIME_SLOTS),
         .C_ARB_TIME_SLOT_0              (C1_ARB_TIME0_SLOT),
         .C_ARB_TIME_SLOT_1              (C1_ARB_TIME1_SLOT),
         .C_ARB_TIME_SLOT_2              (C1_ARB_TIME2_SLOT),
         .C_ARB_TIME_SLOT_3              (C1_ARB_TIME3_SLOT),
         .C_ARB_TIME_SLOT_4              (C1_ARB_TIME4_SLOT),
         .C_ARB_TIME_SLOT_5              (C1_ARB_TIME5_SLOT),
         .C_ARB_TIME_SLOT_6              (C1_ARB_TIME6_SLOT),
         .C_ARB_TIME_SLOT_7              (C1_ARB_TIME7_SLOT),
         .C_ARB_TIME_SLOT_8              (C1_ARB_TIME8_SLOT),
         .C_ARB_TIME_SLOT_9              (C1_ARB_TIME9_SLOT),
         .C_ARB_TIME_SLOT_10             (C1_ARB_TIME10_SLOT),
         .C_ARB_TIME_SLOT_11             (C1_ARB_TIME11_SLOT),
         .C_ARB_ALGORITHM                (C1_ARB_ALGORITHM),
         .C_PORT_ENABLE                  (C1_PORT_ENABLE),
         .C_PORT_CONFIG                  (C1_PORT_CONFIG),
         .C_MEM_TRAS                     (C1_MEM_TRAS),
         .C_MEM_TRCD                     (C1_MEM_TRCD),
         .C_MEM_TREFI                    (C1_MEM_TREFI),
         .C_MEM_TRFC                     (C1_MEM_TRFC),
         .C_MEM_TRP                      (C1_MEM_TRP),
         .C_MEM_TWR                      (C1_MEM_TWR),
         .C_MEM_TRTP                     (C1_MEM_TRTP),
         .C_MEM_TWTR                     (C1_MEM_TWTR),
         .C_MEM_ADDR_ORDER               (C1_MEM_ADDR_ORDER),
         .C_NUM_DQ_PINS                  (C1_NUM_DQ_PINS),
         .C_MEM_TYPE                     (C1_MEM_TYPE),
         .C_MEM_DENSITY                  (C1_MEM_DENSITY),
         .C_MEM_BURST_LEN                (C1_MEM_BURST_LEN),
         .C_MEM_CAS_LATENCY              (C1_MEM_CAS_LATENCY),
         .C_MEM_ADDR_WIDTH               (C1_MEM_ADDR_WIDTH),
         .C_MEM_BANKADDR_WIDTH           (C1_MEM_BANKADDR_WIDTH),
         .C_MEM_NUM_COL_BITS             (C1_MEM_NUM_COL_BITS),
         .C_MEM_DDR1_2_ODS               (C1_MEM_DDR1_2_ODS),
         .C_MEM_DDR2_RTT                 (C1_MEM_DDR2_RTT),
         .C_MEM_DDR2_DIFF_DQS_EN         (C1_MEM_DDR2_DIFF_DQS_EN),
         .C_MEM_DDR2_3_PA_SR             (C1_MEM_DDR2_3_PA_SR),
         .C_MEM_DDR2_3_HIGH_TEMP_SR      (C1_MEM_DDR2_3_HIGH_TEMP_SR),
         .C_MEM_DDR3_CAS_LATENCY         (C1_MEM_DDR3_CAS_LATENCY),
         .C_MEM_DDR3_ODS                 (C1_MEM_DDR3_ODS),
         .C_MEM_DDR3_RTT                 (C1_MEM_DDR3_RTT),
         .C_MEM_DDR3_CAS_WR_LATENCY      (C1_MEM_DDR3_CAS_WR_LATENCY),
         .C_MEM_DDR3_AUTO_SR             (C1_MEM_DDR3_AUTO_SR),
         .C_MEM_MOBILE_PA_SR             (C1_MEM_MOBILE_PA_SR),
         .C_MEM_MDDR_ODS                 (C1_MEM_MDDR_ODS),
         .C_MC_CALIB_BYPASS              (C1_MC_CALIB_BYPASS),
         .C_MC_CALIBRATION_MODE          (C1_MC_CALIBRATION_MODE),
         .C_MC_CALIBRATION_DELAY         (C1_MC_CALIBRATION_DELAY),
         .C_SKIP_IN_TERM_CAL             (C1_SKIP_IN_TERM_CAL),
         .C_SKIP_DYNAMIC_CAL             (C1_SKIP_DYNAMIC_CAL),
         .LDQSP_TAP_DELAY_VAL            (C1_LDQSP_TAP_DELAY_VAL),
         .UDQSP_TAP_DELAY_VAL            (C1_UDQSP_TAP_DELAY_VAL),
         .LDQSN_TAP_DELAY_VAL            (C1_LDQSN_TAP_DELAY_VAL),
         .UDQSN_TAP_DELAY_VAL            (C1_UDQSN_TAP_DELAY_VAL),
         .DQ0_TAP_DELAY_VAL              (C1_DQ0_TAP_DELAY_VAL),
         .DQ1_TAP_DELAY_VAL              (C1_DQ1_TAP_DELAY_VAL),
         .DQ2_TAP_DELAY_VAL              (C1_DQ2_TAP_DELAY_VAL),
         .DQ3_TAP_DELAY_VAL              (C1_DQ3_TAP_DELAY_VAL),
         .DQ4_TAP_DELAY_VAL              (C1_DQ4_TAP_DELAY_VAL),
         .DQ5_TAP_DELAY_VAL              (C1_DQ5_TAP_DELAY_VAL),
         .DQ6_TAP_DELAY_VAL              (C1_DQ6_TAP_DELAY_VAL),
         .DQ7_TAP_DELAY_VAL              (C1_DQ7_TAP_DELAY_VAL),
         .DQ8_TAP_DELAY_VAL              (C1_DQ8_TAP_DELAY_VAL),
         .DQ9_TAP_DELAY_VAL              (C1_DQ9_TAP_DELAY_VAL),
         .DQ10_TAP_DELAY_VAL             (C1_DQ10_TAP_DELAY_VAL),
         .DQ11_TAP_DELAY_VAL             (C1_DQ11_TAP_DELAY_VAL),
         .DQ12_TAP_DELAY_VAL             (C1_DQ12_TAP_DELAY_VAL),
         .DQ13_TAP_DELAY_VAL             (C1_DQ13_TAP_DELAY_VAL),
         .DQ14_TAP_DELAY_VAL             (C1_DQ14_TAP_DELAY_VAL),
         .DQ15_TAP_DELAY_VAL             (C1_DQ15_TAP_DELAY_VAL),
         .C_P0_MASK_SIZE                 (C1_P0_MASK_SIZE),
         .C_P0_DATA_PORT_SIZE            (C1_P0_DATA_PORT_SIZE),
         .C_P1_MASK_SIZE                 (C1_P1_MASK_SIZE),
         .C_P1_DATA_PORT_SIZE            (C1_P1_DATA_PORT_SIZE),

         .C_MCB_USE_EXTERNAL_BUFPLL      (C1_MCB_USE_EXTERNAL_BUFPLL),
         .C_S0_AXI_ENABLE                (C1_S0_AXI_ENABLE),
         .C_S0_AXI_ID_WIDTH              (C1_S0_AXI_ID_WIDTH),
         .C_S0_AXI_ADDR_WIDTH            (C1_S0_AXI_ADDR_WIDTH),
         .C_S0_AXI_DATA_WIDTH            (C1_S0_AXI_DATA_WIDTH),
         .C_S0_AXI_SUPPORTS_READ         (C1_S0_AXI_SUPPORTS_READ),
         .C_S0_AXI_SUPPORTS_WRITE        (C1_S0_AXI_SUPPORTS_WRITE),
         .C_S0_AXI_STRICT_COHERENCY      (C1_S0_AXI_STRICT_COHERENCY),
         .C_S0_AXI_SUPPORTS_NARROW_BURST (C1_S0_AXI_SUPPORTS_NARROW_BURST),
         .C_S0_AXI_ENABLE_AP             (C1_S0_AXI_ENABLE_AP),
         .C_S1_AXI_ENABLE                (C1_S1_AXI_ENABLE),
         .C_S1_AXI_ID_WIDTH              (C1_S1_AXI_ID_WIDTH),
         .C_S1_AXI_ADDR_WIDTH            (C1_S1_AXI_ADDR_WIDTH),
         .C_S1_AXI_DATA_WIDTH            (C1_S1_AXI_DATA_WIDTH),
         .C_S1_AXI_SUPPORTS_READ         (C1_S1_AXI_SUPPORTS_READ),
         .C_S1_AXI_SUPPORTS_WRITE        (C1_S1_AXI_SUPPORTS_WRITE),
         .C_S1_AXI_STRICT_COHERENCY      (C1_S1_AXI_STRICT_COHERENCY),
         .C_S1_AXI_SUPPORTS_NARROW_BURST (C1_S1_AXI_SUPPORTS_NARROW_BURST),
         .C_S1_AXI_ENABLE_AP             (C1_S1_AXI_ENABLE_AP),
         .C_S2_AXI_ENABLE                (C1_S2_AXI_ENABLE),
         .C_S2_AXI_ID_WIDTH              (C1_S2_AXI_ID_WIDTH),
         .C_S2_AXI_ADDR_WIDTH            (C1_S2_AXI_ADDR_WIDTH),
         .C_S2_AXI_DATA_WIDTH            (C1_S2_AXI_DATA_WIDTH),
         .C_S2_AXI_SUPPORTS_READ         (C1_S2_AXI_SUPPORTS_READ),
         .C_S2_AXI_SUPPORTS_WRITE        (C1_S2_AXI_SUPPORTS_WRITE),
         .C_S2_AXI_STRICT_COHERENCY      (C1_S2_AXI_STRICT_COHERENCY),
         .C_S2_AXI_SUPPORTS_NARROW_BURST (C1_S2_AXI_SUPPORTS_NARROW_BURST),
         .C_S2_AXI_ENABLE_AP             (C1_S2_AXI_ENABLE_AP),
         .C_S3_AXI_ENABLE                (C1_S3_AXI_ENABLE),
         .C_S3_AXI_ID_WIDTH              (C1_S3_AXI_ID_WIDTH),
         .C_S3_AXI_ADDR_WIDTH            (C1_S3_AXI_ADDR_WIDTH),
         .C_S3_AXI_DATA_WIDTH            (C1_S3_AXI_DATA_WIDTH),
         .C_S3_AXI_SUPPORTS_READ         (C1_S3_AXI_SUPPORTS_READ),
         .C_S3_AXI_SUPPORTS_WRITE        (C1_S3_AXI_SUPPORTS_WRITE),
         .C_S3_AXI_STRICT_COHERENCY      (C1_S3_AXI_STRICT_COHERENCY),
         .C_S3_AXI_SUPPORTS_NARROW_BURST (C1_S3_AXI_SUPPORTS_NARROW_BURST),
         .C_S3_AXI_ENABLE_AP             (C1_S3_AXI_ENABLE_AP),
         .C_S4_AXI_ENABLE                (C1_S4_AXI_ENABLE),
         .C_S4_AXI_ID_WIDTH              (C1_S4_AXI_ID_WIDTH),
         .C_S4_AXI_ADDR_WIDTH            (C1_S4_AXI_ADDR_WIDTH),
         .C_S4_AXI_DATA_WIDTH            (C1_S4_AXI_DATA_WIDTH),
         .C_S4_AXI_SUPPORTS_READ         (C1_S4_AXI_SUPPORTS_READ),
         .C_S4_AXI_SUPPORTS_WRITE        (C1_S4_AXI_SUPPORTS_WRITE),
         .C_S4_AXI_STRICT_COHERENCY      (C1_S4_AXI_STRICT_COHERENCY),
         .C_S4_AXI_SUPPORTS_NARROW_BURST (C1_S4_AXI_SUPPORTS_NARROW_BURST),
         .C_S4_AXI_ENABLE_AP             (C1_S4_AXI_ENABLE_AP),
         .C_S5_AXI_ENABLE                (C1_S5_AXI_ENABLE),
         .C_S5_AXI_ID_WIDTH              (C1_S5_AXI_ID_WIDTH),
         .C_S5_AXI_ADDR_WIDTH            (C1_S5_AXI_ADDR_WIDTH),
         .C_S5_AXI_DATA_WIDTH            (C1_S5_AXI_DATA_WIDTH),
         .C_S5_AXI_SUPPORTS_READ         (C1_S5_AXI_SUPPORTS_READ),
         .C_S5_AXI_SUPPORTS_WRITE        (C1_S5_AXI_SUPPORTS_WRITE),
         .C_S5_AXI_STRICT_COHERENCY      (C1_S5_AXI_STRICT_COHERENCY),
         .C_S5_AXI_SUPPORTS_NARROW_BURST (C1_S5_AXI_SUPPORTS_NARROW_BURST),
         .C_S5_AXI_ENABLE_AP             (C1_S5_AXI_ENABLE_AP)
       )
      
      memc1_wrapper_inst
      (
         .mcbx_dram_addr                 (mcb1_dram_a), 
         .mcbx_dram_ba                   (mcb1_dram_ba),
         .mcbx_dram_ras_n                (mcb1_dram_ras_n), 
         .mcbx_dram_cas_n                (mcb1_dram_cas_n), 
         .mcbx_dram_we_n                 (mcb1_dram_we_n), 
         .mcbx_dram_cke                  (mcb1_dram_cke), 
         .mcbx_dram_clk                  (mcb1_dram_ck), 
         .mcbx_dram_clk_n                (mcb1_dram_ck_n), 
         .mcbx_dram_dq                   (mcb1_dram_dq),
         .mcbx_dram_dqs                  (mcb1_dram_dqs), 
         .mcbx_dram_dqs_n                (mcb1_dram_dqs_n), 
         .mcbx_dram_udqs                 (mcb1_dram_udqs), 
         .mcbx_dram_udqs_n               (mcb1_dram_udqs_n), 
         .mcbx_dram_udm                  (mcb1_dram_udm), 
         .mcbx_dram_ldm                  (mcb1_dram_dm), 
         .mcbx_dram_odt                  (mcb1_dram_odt), 
         .mcbx_dram_ddr3_rst             ( ), 
         .mcbx_rzq                       (mcb1_rzq),
         .mcbx_zio                       (mcb1_zio),
         .calib_done                     (c1_calib_done),
         .async_rst                      (c1_async_rst),
         .sysclk_2x                      (c1_sysclk_2x), 
         .sysclk_2x_180                  (c1_sysclk_2x_180), 
         .pll_ce_0                       (c1_pll_ce_0),
         .pll_ce_90                      (c1_pll_ce_90), 
         .pll_lock                       (c1_pll_lock),
         .mcb_drp_clk                    (c1_mcb_drp_clk), 
         .selfrefresh_enter              (1'b0), 
         .selfrefresh_mode               (c1_selfrefresh_mode),
      
         // The following port map shows all the six logical user ports. However, all
	 // of them may not be active in this design. A port should be enabled to 
	 // validate its port map. If it is not,the complete port is going to float 
	 // by getting disconnected from the lower level MCB modules. The port enable
	 // information of a controller can be obtained from the corresponding local
	 // parameter CX_PORT_ENABLE. In such a case, we can simply ignore its port map.
	 // The following comments will explain when a port is going to be active.
	 // Config-1: Two 32-bit bi-directional and four 32-bit unidirectional ports
	 // Config-2: Four 32-bit bi-directional ports
	 // Config-3: One 64-bit bi-directional and two 32-bit bi-directional ports
	 // Config-4: Two 64-bit bi-directional ports
	 // Config-5: One 128-bit bi-directional port

         // User Port-0 AXI interface will be active only when the port is enabled in the port
         // configurations Config-1, Config-2, Config-3, Config-4 and Config-5
         .s0_axi_aclk                    (c1_s0_axi_aclk),
         .s0_axi_aresetn                 (c1_s0_axi_aresetn),
         .s0_axi_awid                    (c1_s0_axi_awid), 
         .s0_axi_awaddr                  (c1_s0_axi_awaddr), 
         .s0_axi_awlen                   (c1_s0_axi_awlen), 
         .s0_axi_awsize                  (c1_s0_axi_awsize), 
         .s0_axi_awburst                 (c1_s0_axi_awburst), 
         .s0_axi_awlock                  (c1_s0_axi_awlock), 
         .s0_axi_awcache                 (c1_s0_axi_awcache), 
         .s0_axi_awprot                  (c1_s0_axi_awprot), 
         .s0_axi_awqos                   (c1_s0_axi_awqos), 
         .s0_axi_awvalid                 (c1_s0_axi_awvalid), 
         .s0_axi_awready                 (c1_s0_axi_awready), 
         .s0_axi_wdata                   (c1_s0_axi_wdata), 
         .s0_axi_wstrb                   (c1_s0_axi_wstrb), 
         .s0_axi_wlast                   (c1_s0_axi_wlast), 
         .s0_axi_wvalid                  (c1_s0_axi_wvalid), 
         .s0_axi_wready                  (c1_s0_axi_wready), 
         .s0_axi_bid                     (c1_s0_axi_bid), 
         .s0_axi_bresp                   (c1_s0_axi_bresp), 
         .s0_axi_bvalid                  (c1_s0_axi_bvalid), 
         .s0_axi_bready                  (c1_s0_axi_bready), 
         .s0_axi_arid                    (c1_s0_axi_arid), 
         .s0_axi_araddr                  (c1_s0_axi_araddr), 
         .s0_axi_arlen                   (c1_s0_axi_arlen), 
         .s0_axi_arsize                  (c1_s0_axi_arsize), 
         .s0_axi_arburst                 (c1_s0_axi_arburst), 
         .s0_axi_arlock                  (c1_s0_axi_arlock), 
         .s0_axi_arcache                 (c1_s0_axi_arcache), 
         .s0_axi_arprot                  (c1_s0_axi_arprot), 
         .s0_axi_arqos                   (c1_s0_axi_arqos), 
         .s0_axi_arvalid                 (c1_s0_axi_arvalid), 
         .s0_axi_arready                 (c1_s0_axi_arready), 
         .s0_axi_rid                     (c1_s0_axi_rid), 
         .s0_axi_rdata                   (c1_s0_axi_rdata), 
         .s0_axi_rresp                   (c1_s0_axi_rresp), 
         .s0_axi_rlast                   (c1_s0_axi_rlast), 
         .s0_axi_rvalid                  (c1_s0_axi_rvalid), 
         .s0_axi_rready                  (c1_s0_axi_rready),
      
         // User Port-1 AXI interface will be active only when the port is enabled in the port
         // configurations Config-1, Config-2, Config-3 and Config-4
         .s1_axi_aclk                    (c1_s1_axi_aclk),
         .s1_axi_aresetn                 (c1_s1_axi_aresetn),
         .s1_axi_awid                    (c1_s1_axi_awid), 
         .s1_axi_awaddr                  (c1_s1_axi_awaddr), 
         .s1_axi_awlen                   (c1_s1_axi_awlen), 
         .s1_axi_awsize                  (c1_s1_axi_awsize), 
         .s1_axi_awburst                 (c1_s1_axi_awburst), 
         .s1_axi_awlock                  (c1_s1_axi_awlock), 
         .s1_axi_awcache                 (c1_s1_axi_awcache), 
         .s1_axi_awprot                  (c1_s1_axi_awprot), 
         .s1_axi_awqos                   (c1_s1_axi_awqos), 
         .s1_axi_awvalid                 (c1_s1_axi_awvalid), 
         .s1_axi_awready                 (c1_s1_axi_awready), 
         .s1_axi_wdata                   (c1_s1_axi_wdata), 
         .s1_axi_wstrb                   (c1_s1_axi_wstrb), 
         .s1_axi_wlast                   (c1_s1_axi_wlast), 
         .s1_axi_wvalid                  (c1_s1_axi_wvalid), 
         .s1_axi_wready                  (c1_s1_axi_wready), 
         .s1_axi_bid                     (c1_s1_axi_bid), 
         .s1_axi_bresp                   (c1_s1_axi_bresp), 
         .s1_axi_bvalid                  (c1_s1_axi_bvalid), 
         .s1_axi_bready                  (c1_s1_axi_bready), 
         .s1_axi_arid                    (c1_s1_axi_arid), 
         .s1_axi_araddr                  (c1_s1_axi_araddr), 
         .s1_axi_arlen                   (c1_s1_axi_arlen), 
         .s1_axi_arsize                  (c1_s1_axi_arsize), 
         .s1_axi_arburst                 (c1_s1_axi_arburst), 
         .s1_axi_arlock                  (c1_s1_axi_arlock), 
         .s1_axi_arcache                 (c1_s1_axi_arcache), 
         .s1_axi_arprot                  (c1_s1_axi_arprot), 
         .s1_axi_arqos                   (c1_s1_axi_arqos), 
         .s1_axi_arvalid                 (c1_s1_axi_arvalid), 
         .s1_axi_arready                 (c1_s1_axi_arready), 
         .s1_axi_rid                     (c1_s1_axi_rid), 
         .s1_axi_rdata                   (c1_s1_axi_rdata), 
         .s1_axi_rresp                   (c1_s1_axi_rresp), 
         .s1_axi_rlast                   (c1_s1_axi_rlast), 
         .s1_axi_rvalid                  (c1_s1_axi_rvalid), 
         .s1_axi_rready                  (c1_s1_axi_rready),
      
         // User Port-2 AXI interface will be active only when the port is enabled in the port
         // configurations Config-1, Config-2 and Config-3
         .s2_axi_aclk                    (c1_s2_axi_aclk),
         .s2_axi_aresetn                 (c1_s2_axi_aresetn),
         .s2_axi_awid                    (c1_s2_axi_awid), 
         .s2_axi_awaddr                  (c1_s2_axi_awaddr), 
         .s2_axi_awlen                   (c1_s2_axi_awlen), 
         .s2_axi_awsize                  (c1_s2_axi_awsize), 
         .s2_axi_awburst                 (c1_s2_axi_awburst), 
         .s2_axi_awlock                  (c1_s2_axi_awlock), 
         .s2_axi_awcache                 (c1_s2_axi_awcache), 
         .s2_axi_awprot                  (c1_s2_axi_awprot), 
         .s2_axi_awqos                   (c1_s2_axi_awqos), 
         .s2_axi_awvalid                 (c1_s2_axi_awvalid), 
         .s2_axi_awready                 (c1_s2_axi_awready), 
         .s2_axi_wdata                   (c1_s2_axi_wdata), 
         .s2_axi_wstrb                   (c1_s2_axi_wstrb), 
         .s2_axi_wlast                   (c1_s2_axi_wlast), 
         .s2_axi_wvalid                  (c1_s2_axi_wvalid), 
         .s2_axi_wready                  (c1_s2_axi_wready), 
         .s2_axi_bid                     (c1_s2_axi_bid), 
         .s2_axi_bresp                   (c1_s2_axi_bresp), 
         .s2_axi_bvalid                  (c1_s2_axi_bvalid), 
         .s2_axi_bready                  (c1_s2_axi_bready), 
         .s2_axi_arid                    (c1_s2_axi_arid), 
         .s2_axi_araddr                  (c1_s2_axi_araddr), 
         .s2_axi_arlen                   (c1_s2_axi_arlen), 
         .s2_axi_arsize                  (c1_s2_axi_arsize), 
         .s2_axi_arburst                 (c1_s2_axi_arburst), 
         .s2_axi_arlock                  (c1_s2_axi_arlock), 
         .s2_axi_arcache                 (c1_s2_axi_arcache), 
         .s2_axi_arprot                  (c1_s2_axi_arprot), 
         .s2_axi_arqos                   (c1_s2_axi_arqos), 
         .s2_axi_arvalid                 (c1_s2_axi_arvalid), 
         .s2_axi_arready                 (c1_s2_axi_arready), 
         .s2_axi_rid                     (c1_s2_axi_rid), 
         .s2_axi_rdata                   (c1_s2_axi_rdata), 
         .s2_axi_rresp                   (c1_s2_axi_rresp), 
         .s2_axi_rlast                   (c1_s2_axi_rlast), 
         .s2_axi_rvalid                  (c1_s2_axi_rvalid), 
         .s2_axi_rready                  (c1_s2_axi_rready),
      
         // User Port-3 AXI interface will be active only when the port is enabled in the port
         // configurations Config-1 and Config-2
         .s3_axi_aclk                    (c1_s3_axi_aclk),
         .s3_axi_aresetn                 (c1_s3_axi_aresetn),
         .s3_axi_awid                    (c1_s3_axi_awid), 
         .s3_axi_awaddr                  (c1_s3_axi_awaddr), 
         .s3_axi_awlen                   (c1_s3_axi_awlen), 
         .s3_axi_awsize                  (c1_s3_axi_awsize), 
         .s3_axi_awburst                 (c1_s3_axi_awburst), 
         .s3_axi_awlock                  (c1_s3_axi_awlock), 
         .s3_axi_awcache                 (c1_s3_axi_awcache), 
         .s3_axi_awprot                  (c1_s3_axi_awprot), 
         .s3_axi_awqos                   (c1_s3_axi_awqos), 
         .s3_axi_awvalid                 (c1_s3_axi_awvalid), 
         .s3_axi_awready                 (c1_s3_axi_awready), 
         .s3_axi_wdata                   (c1_s3_axi_wdata), 
         .s3_axi_wstrb                   (c1_s3_axi_wstrb), 
         .s3_axi_wlast                   (c1_s3_axi_wlast), 
         .s3_axi_wvalid                  (c1_s3_axi_wvalid), 
         .s3_axi_wready                  (c1_s3_axi_wready), 
         .s3_axi_bid                     (c1_s3_axi_bid), 
         .s3_axi_bresp                   (c1_s3_axi_bresp), 
         .s3_axi_bvalid                  (c1_s3_axi_bvalid), 
         .s3_axi_bready                  (c1_s3_axi_bready), 
         .s3_axi_arid                    (c1_s3_axi_arid), 
         .s3_axi_araddr                  (c1_s3_axi_araddr), 
         .s3_axi_arlen                   (c1_s3_axi_arlen), 
         .s3_axi_arsize                  (c1_s3_axi_arsize), 
         .s3_axi_arburst                 (c1_s3_axi_arburst), 
         .s3_axi_arlock                  (c1_s3_axi_arlock), 
         .s3_axi_arcache                 (c1_s3_axi_arcache), 
         .s3_axi_arprot                  (c1_s3_axi_arprot), 
         .s3_axi_arqos                   (c1_s3_axi_arqos), 
         .s3_axi_arvalid                 (c1_s3_axi_arvalid), 
         .s3_axi_arready                 (c1_s3_axi_arready), 
         .s3_axi_rid                     (c1_s3_axi_rid), 
         .s3_axi_rdata                   (c1_s3_axi_rdata), 
         .s3_axi_rresp                   (c1_s3_axi_rresp), 
         .s3_axi_rlast                   (c1_s3_axi_rlast), 
         .s3_axi_rvalid                  (c1_s3_axi_rvalid), 
         .s3_axi_rready                  (c1_s3_axi_rready),
      
         // User Port-4 AXI interface will be active only when the port is enabled in the port
         // configuration Config-1
         .s4_axi_aclk                    (c1_s4_axi_aclk),
         .s4_axi_aresetn                 (c1_s4_axi_aresetn),
         .s4_axi_awid                    (c1_s4_axi_awid), 
         .s4_axi_awaddr                  (c1_s4_axi_awaddr), 
         .s4_axi_awlen                   (c1_s4_axi_awlen), 
         .s4_axi_awsize                  (c1_s4_axi_awsize), 
         .s4_axi_awburst                 (c1_s4_axi_awburst), 
         .s4_axi_awlock                  (c1_s4_axi_awlock), 
         .s4_axi_awcache                 (c1_s4_axi_awcache), 
         .s4_axi_awprot                  (c1_s4_axi_awprot), 
         .s4_axi_awqos                   (c1_s4_axi_awqos), 
         .s4_axi_awvalid                 (c1_s4_axi_awvalid), 
         .s4_axi_awready                 (c1_s4_axi_awready), 
         .s4_axi_wdata                   (c1_s4_axi_wdata), 
         .s4_axi_wstrb                   (c1_s4_axi_wstrb), 
         .s4_axi_wlast                   (c1_s4_axi_wlast), 
         .s4_axi_wvalid                  (c1_s4_axi_wvalid), 
         .s4_axi_wready                  (c1_s4_axi_wready), 
         .s4_axi_bid                     (c1_s4_axi_bid), 
         .s4_axi_bresp                   (c1_s4_axi_bresp), 
         .s4_axi_bvalid                  (c1_s4_axi_bvalid), 
         .s4_axi_bready                  (c1_s4_axi_bready), 
         .s4_axi_arid                    (c1_s4_axi_arid), 
         .s4_axi_araddr                  (c1_s4_axi_araddr), 
         .s4_axi_arlen                   (c1_s4_axi_arlen), 
         .s4_axi_arsize                  (c1_s4_axi_arsize), 
         .s4_axi_arburst                 (c1_s4_axi_arburst), 
         .s4_axi_arlock                  (c1_s4_axi_arlock), 
         .s4_axi_arcache                 (c1_s4_axi_arcache), 
         .s4_axi_arprot                  (c1_s4_axi_arprot), 
         .s4_axi_arqos                   (c1_s4_axi_arqos), 
         .s4_axi_arvalid                 (c1_s4_axi_arvalid), 
         .s4_axi_arready                 (c1_s4_axi_arready), 
         .s4_axi_rid                     (c1_s4_axi_rid), 
         .s4_axi_rdata                   (c1_s4_axi_rdata), 
         .s4_axi_rresp                   (c1_s4_axi_rresp), 
         .s4_axi_rlast                   (c1_s4_axi_rlast), 
         .s4_axi_rvalid                  (c1_s4_axi_rvalid), 
         .s4_axi_rready                  (c1_s4_axi_rready),
      
         // User Port-5 AXI interface will be active only when the port is enabled in the port
         // configuration Config-1
         .s5_axi_aclk                    (c1_s5_axi_aclk),
         .s5_axi_aresetn                 (c1_s5_axi_aresetn),
         .s5_axi_awid                    (c1_s5_axi_awid), 
         .s5_axi_awaddr                  (c1_s5_axi_awaddr), 
         .s5_axi_awlen                   (c1_s5_axi_awlen), 
         .s5_axi_awsize                  (c1_s5_axi_awsize), 
         .s5_axi_awburst                 (c1_s5_axi_awburst), 
         .s5_axi_awlock                  (c1_s5_axi_awlock), 
         .s5_axi_awcache                 (c1_s5_axi_awcache), 
         .s5_axi_awprot                  (c1_s5_axi_awprot), 
         .s5_axi_awqos                   (c1_s5_axi_awqos), 
         .s5_axi_awvalid                 (c1_s5_axi_awvalid), 
         .s5_axi_awready                 (c1_s5_axi_awready), 
         .s5_axi_wdata                   (c1_s5_axi_wdata), 
         .s5_axi_wstrb                   (c1_s5_axi_wstrb), 
         .s5_axi_wlast                   (c1_s5_axi_wlast), 
         .s5_axi_wvalid                  (c1_s5_axi_wvalid), 
         .s5_axi_wready                  (c1_s5_axi_wready), 
         .s5_axi_bid                     (c1_s5_axi_bid), 
         .s5_axi_bresp                   (c1_s5_axi_bresp), 
         .s5_axi_bvalid                  (c1_s5_axi_bvalid), 
         .s5_axi_bready                  (c1_s5_axi_bready), 
         .s5_axi_arid                    (c1_s5_axi_arid), 
         .s5_axi_araddr                  (c1_s5_axi_araddr), 
         .s5_axi_arlen                   (c1_s5_axi_arlen), 
         .s5_axi_arsize                  (c1_s5_axi_arsize), 
         .s5_axi_arburst                 (c1_s5_axi_arburst), 
         .s5_axi_arlock                  (c1_s5_axi_arlock), 
         .s5_axi_arcache                 (c1_s5_axi_arcache), 
         .s5_axi_arprot                  (c1_s5_axi_arprot), 
         .s5_axi_arqos                   (c1_s5_axi_arqos), 
         .s5_axi_arvalid                 (c1_s5_axi_arvalid), 
         .s5_axi_arready                 (c1_s5_axi_arready), 
         .s5_axi_rid                     (c1_s5_axi_rid), 
         .s5_axi_rdata                   (c1_s5_axi_rdata), 
         .s5_axi_rresp                   (c1_s5_axi_rresp), 
         .s5_axi_rlast                   (c1_s5_axi_rlast), 
         .s5_axi_rvalid                  (c1_s5_axi_rvalid), 
         .s5_axi_rready                  (c1_s5_axi_rready) 
      );
   






endmodule   

 
