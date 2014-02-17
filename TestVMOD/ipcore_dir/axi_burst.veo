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
//  /   /        Filename           : axi_burst.veo
// /___/   /\    Date Last Modified : $Date: 2011/06/02 07:19:03 $
// \   \  /  \   Date Created       : Fri Aug 7 2009
//  \___\/\___\
//
// Purpose     : Template file containing code that can be used as a model
//               for instantiating a CORE Generator module in a HDL design.
// Revision History:
//*****************************************************************************

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG

 axi_burst # (
    .C1_P0_MASK_SIZE(4),
    .C1_P0_DATA_PORT_SIZE(32),
    .C1_P1_MASK_SIZE(4),
    .C1_P1_DATA_PORT_SIZE(32),
    .DEBUG_EN(0),
    .C1_MEMCLK_PERIOD(3000),
    .C1_CALIB_SOFT_IP("TRUE"),
    .C1_SIMULATION("FALSE"),
    .C1_RST_ACT_LOW(0),
    .C1_INPUT_CLK_TYPE("DIFFERENTIAL"),
    .C1_MEM_ADDR_ORDER("ROW_BANK_COLUMN"),
    .C1_NUM_DQ_PINS(8),
    .C1_MEM_ADDR_WIDTH(14),
    .C1_MEM_BANKADDR_WIDTH(3),
    .C1_S0_AXI_STRICT_COHERENCY(0),
    .C1_S0_AXI_ENABLE_AP(0),
    .C1_S0_AXI_DATA_WIDTH(32),
    .C1_S0_AXI_SUPPORTS_NARROW_BURST(1),
    .C1_S0_AXI_ADDR_WIDTH(32),
    .C1_S0_AXI_ID_WIDTH(4),
    .C1_S1_AXI_STRICT_COHERENCY(0),
    .C1_S1_AXI_ENABLE_AP(0),
    .C1_S1_AXI_DATA_WIDTH(32),
    .C1_S1_AXI_SUPPORTS_NARROW_BURST(1),
    .C1_S1_AXI_ADDR_WIDTH(32),
    .C1_S1_AXI_ID_WIDTH(4),
    .C1_S2_AXI_STRICT_COHERENCY(0),
    .C1_S2_AXI_ENABLE_AP(0),
    .C1_S2_AXI_DATA_WIDTH(32),
    .C1_S2_AXI_SUPPORTS_NARROW_BURST(1),
    .C1_S2_AXI_ADDR_WIDTH(32),
    .C1_S2_AXI_ID_WIDTH(4),
    .C1_S3_AXI_STRICT_COHERENCY(0),
    .C1_S3_AXI_ENABLE_AP(0),
    .C1_S3_AXI_DATA_WIDTH(32),
    .C1_S3_AXI_SUPPORTS_NARROW_BURST(1),
    .C1_S3_AXI_ADDR_WIDTH(32),
    .C1_S3_AXI_ID_WIDTH(4)
)
u_axi_burst (

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

// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file axi_burst.v when simulating
// the core, axi_burst. When compiling the wrapper file, be sure to
// reference the XilinxCoreLib Verilog simulation library. For detailed
// instructions, please refer to the "CORE Generator Help".

