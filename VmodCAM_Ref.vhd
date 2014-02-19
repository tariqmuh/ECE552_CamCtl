----------------------------------------------------------------------------------
-- Company: Digilent Ro
-- Engineer: Elod Gyorgy
-- 
-- Create Date:    12:50:18 04/21/2011 
-- Design Name:		VmodCAM Reference Design 2
-- Module Name:    	VmodCAM_Ref - Behavioral
-- Project Name: 		
-- Target Devices: 
-- Tool versions: 
-- Description: The design shows off the video feed from two cameras located on
-- a VmodCAM add-on board connected to an Atlys. The video feeds are displayed on
-- a DVI-capable flat panel at 1600x900@60Hz resolution. Each of the video feeds
-- is written to a frame buffer port to different locations in the RAM. Switch 7
-- can change the display from one feed to the other.
--
-- Dependencies:
-- digilent VHDL library (Video, VideoTimingCtl, TWICtl, TMDSEncoder,
-- DVITransmitter, SerializerN_1...)
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.Video.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity VmodCAM_Ref is
Generic (
		C3_NUM_DQ_PINS          : integer := 16; 
		C3_MEM_ADDR_WIDTH       : integer := 13; 
		C3_MEM_BANKADDR_WIDTH   : integer := 3;
		COLORDEPTH					: integer := 16
	);
   Port (	
		SW_I : in STD_LOGIC_VECTOR(7 downto 0);
		LED_O : out STD_LOGIC_VECTOR(7 downto 0);
		START : in  STD_LOGIC_VECTOR(31 downto 0);
		RESET_I : in  STD_LOGIC;
		
		CamClk : in STD_LOGIC;

		CamClk_180 : in STD_LOGIC;
----------------------------------------------------------------------------------
-- Camera Board signals
----------------------------------------------------------------------------------
		CAMA_SDA : inout  STD_LOGIC;
		CAMA_SCL : inout  STD_LOGIC;
		
		CAMA_D_I : inout  STD_LOGIC_VECTOR (7 downto 0); -- inout Workaround for IN_TERM bug AR# 	40818
		CAMA_PCLK_I : inout  STD_LOGIC; -- inout Workaround for IN_TERM bug AR# 	40818
		CAMA_MCLK_O : out STD_LOGIC;		
		CAMA_LV_I : inout STD_LOGIC; -- inout Workaround for IN_TERM bug AR# 	40818
		CAMA_FV_I : inout STD_LOGIC; -- inout Workaround for IN_TERM bug AR# 	40818
		CAMA_RST_O : out STD_LOGIC; --Reset active LOW
		CAMA_PWDN_O : out STD_LOGIC; --Power-down active HIGH

		CAMX_VDDEN_O : out STD_LOGIC; -- common power supply enable (can do power cycle)
		
		CAMB_SDA : inout  STD_LOGIC;
		CAMB_SCL : inout  STD_LOGIC;
		CAMB_D_I : inout  STD_LOGIC_VECTOR (7 downto 0); -- inout Workaround for IN_TERM bug AR# 	40818
		CAMB_PCLK_I : inout  STD_LOGIC; -- inout Workaround for IN_TERM bug AR# 	40818
		CAMB_MCLK_O : out STD_LOGIC;		
		CAMB_LV_I : inout STD_LOGIC; -- inout Workaround for IN_TERM bug AR# 	40818
		CAMB_FV_I : inout STD_LOGIC; -- inout Workaround for IN_TERM bug AR# 	40818
		CAMB_RST_O : out STD_LOGIC; --Reset active LOW
		CAMB_PWDN_O : out STD_LOGIC; --Power-down active HIGH

		ENB : out STD_LOGIC;
		DIB : out STD_LOGIC_VECTOR (COLORDEPTH - 1 downto 0);
		CLKB : out STD_LOGIC;
		
		ENA : out STD_LOGIC;
		DIA : out STD_LOGIC_VECTOR (COLORDEPTH - 1 downto 0);
		CLKA : out STD_LOGIC
	);
end VmodCAM_Ref;

architecture Behavioral of VmodCAM_Ref is
signal SysClk, PClk, PClkX2, SysRst, SerClk, SerStb : std_logic;
signal MSel : std_logic_vector(0 downto 0);

signal VtcHs, VtcVs, VtcVde, VtcRst : std_logic;
signal VtcHCnt, VtcVCnt : NATURAL;

signal  CamAPClk, CamBPClk, CamADV, CamBDV, CamAVddEn, CamBVddEn : std_logic;
signal CamAD, CamBD : std_logic_vector(15 downto 0);
signal dummy_t, int_CAMA_PCLK_I, int_CAMA_FV_I, int_CAMA_LV_I,
int_CAMB_PCLK_I, int_CAMB_FV_I, int_CAMB_LV_I : std_logic;
signal int_CAMA_D_I, int_CAMB_D_I : std_logic_vector(7 downto 0);

signal CAMA_SDA_I, CAMA_SDA_O, CAMA_SDA_T : std_logic;
signal CAMA_SCL_I, CAMA_SCL_O, CAMA_SCL_T : std_logic;
signal CAMB_SDA_I, CAMB_SDA_O, CAMB_SDA_T : std_logic;
signal CAMB_SCL_I, CAMB_SCL_O, CAMB_SCL_T : std_logic;

attribute S: string;
attribute S of CAMA_PCLK_I: signal is "TRUE";
attribute S of CAMA_FV_I: signal is "TRUE";
attribute S of CAMA_LV_I: signal is "TRUE";
attribute S of CAMA_D_I: signal is "TRUE";
attribute S of CAMB_PCLK_I: signal is "TRUE";
attribute S of CAMB_FV_I: signal is "TRUE";
attribute S of CAMB_LV_I: signal is "TRUE";
attribute S of CAMB_D_I: signal is "TRUE";
attribute S of dummy_t: signal is "TRUE";
attribute S of CAMA_SDA_I: signal is "TRUE";
attribute S of CAMB_SDA_I: signal is "TRUE";
attribute S of CAMA_SCL_I: signal is "TRUE";
attribute S of CAMB_SCL_I: signal is "TRUE";
attribute S of CAMA_SDA_O: signal is "TRUE";
attribute S of CAMB_SDA_O: signal is "TRUE";
attribute S of CAMA_SCL_O: signal is "TRUE";
attribute S of CAMB_SCL_O: signal is "TRUE";
attribute S of CAMA_SDA_T: signal is "TRUE";
attribute S of CAMA_SCL_T: signal is "TRUE";
attribute S of CAMB_SDA_T: signal is "TRUE";
attribute S of CAMB_SCL_T: signal is "TRUE";


signal int_FVA, int_FVB : std_logic;
signal test : std_logic;


begin

--LED_O <= VtcHs & VtcHs & VtcVde & async_rst & MSel(0) & "000";
--LED_O <= CAMA_SDA & CAMA_SCL & CAMB_SDA & CAMB_SCL & "0000";

--LED_O <= CamAD(15 downto 8);

test <= not RESET_I;

----------------------------------------------------------------------------------
-- Camera A Controller
----------------------------------------------------------------------------------
	Inst_camctlA: entity work.camctl
	PORT MAP (
		D_O => CamAD,
		PCLK_O => CamAPClk,
		DV_O => CamADV,
		RST_I => test,
		CLK => CamClk,
		CLK_180 => CamClk_180,
		--SDA => CAMA_SDA,
		--SCL => CAMA_SCL,
		SDA_I => CAMA_SDA_I,
		SCL_I => CAMA_SCL_I,
		SDA_O => CAMA_SDA_O,
		SCL_O => CAMA_SCL_O,
		SDA_T => CAMA_SDA_T,
		SCL_T => CAMA_SCL_T,
		D_I => int_CAMA_D_I,
		PCLK_I => int_CAMA_PCLK_I,
		MCLK_O => CAMA_MCLK_O,
		LV_I => int_CAMA_LV_I,
		FV_I => int_CAMA_FV_I,
		RST_O => CAMA_RST_O,
		PWDN_O => CAMA_PWDN_O,
		VDDEN_O => CamAVddEn
	);
----------------------------------------------------------------------------------
-- Camera B Controller
----------------------------------------------------------------------------------
	Inst_camctlB: entity work.camctl
	PORT MAP (
		D_O => CamBD,
		PCLK_O => CamBPClk,
		DV_O => CamBDV,
		RST_I => test,
		CLK => CamClk,
		CLK_180 => CamClk_180,
		SDA_I => CAMB_SDA_I,
		SCL_I => CAMB_SCL_I,
		SDA_O => CAMB_SDA_O,
		SCL_O => CAMB_SCL_O,
		SDA_T => CAMB_SDA_T,
		SCL_T => CAMB_SCL_T,
		D_I => int_CAMB_D_I,
		PCLK_I => int_CAMB_PCLK_I,
		MCLK_O => CAMB_MCLK_O,
		LV_I => int_CAMB_LV_I,
		FV_I => int_CAMB_FV_I,
		RST_O => CAMB_RST_O,
		PWDN_O => CAMB_PWDN_O,
		VDDEN_O => CamBVddEn
	);
	CAMX_VDDEN_O <= CamAVddEn and CamBVddEn;
	
	process(START) begin
		if(START = X"00000000") then
			ENA <= '0';
			ENB <= '0';
		else 
			ENA <= CamADV;
			ENB <= CamBDV;
		end if;
	end process;
	
	DIA <= CamAD;
	DIB <= CamBD;
	

	
	CLKA <= CamAPClk;
	CLKB <= CamBPClk;
	
----------------------------------------------------------------------------------
-- Workaround for IN_TERM bug AR# 	40818
----------------------------------------------------------------------------------
   Inst_IOBUF_CAMA_PCLK : IOBUF
   generic map (
      DRIVE => 12,
      IOSTANDARD => "DEFAULT",
      SLEW => "SLOW")
   port map (
      O => int_CAMA_PCLK_I,     -- Buffer output
      IO => CAMA_PCLK_I,   -- Buffer inout port (connect directly to top-level port)
      I => '0',     -- Buffer input
      T => dummy_t      -- 3-state enable input, high=input, low=output 
   );
   Inst_IOBUF_CAMA_FV : IOBUF
   generic map (
      DRIVE => 12,
      IOSTANDARD => "DEFAULT",
      SLEW => "SLOW")
   port map (
      O => int_CAMA_FV_I,     -- Buffer output
      IO => CAMA_FV_I,   -- Buffer inout port (connect directly to top-level port)
      I => '0',     -- Buffer input
      T => dummy_t      -- 3-state enable input, high=input, low=output 
   );	
	Inst_IOBUF_CAMA_LV : IOBUF
   generic map (
      DRIVE => 12,
      IOSTANDARD => "DEFAULT",
      SLEW => "SLOW")
   port map (
      O => int_CAMA_LV_I,     -- Buffer output
      IO => CAMA_LV_I,   -- Buffer inout port (connect directly to top-level port)
      I => '0',     -- Buffer input
      T => dummy_t      -- 3-state enable input, high=input, low=output 
   );	
Gen_IOBUF_CAMA_D: for i in 7 downto 0 generate
   Inst_IOBUF_CAMA_D : IOBUF
   generic map (
      DRIVE => 12,
      IOSTANDARD => "DEFAULT",
      SLEW => "SLOW")
   port map (
      O => int_CAMA_D_I(i),     -- Buffer output
      IO => CAMA_D_I(i),   -- Buffer inout port (connect directly to top-level port)
      I => '0',     -- Buffer input
      T => dummy_t      -- 3-state enable input, high=input, low=output 
   );
end generate;

   Inst_IOBUF_CAMB_PCLK : IOBUF
   generic map (
      DRIVE => 12,
      IOSTANDARD => "DEFAULT",
      SLEW => "SLOW")
   port map (
      O => int_CAMB_PCLK_I,     -- Buffer output
      IO => CAMB_PCLK_I,   -- Buffer inout port (connect directly to top-level port)
      I => '0',     -- Buffer input
      T => dummy_t      -- 3-state enable input, high=input, low=output 
   );	
   Inst_IOBUF_CAMB_FV : IOBUF
   generic map (
      DRIVE => 12,
      IOSTANDARD => "DEFAULT",
      SLEW => "SLOW")
   port map (
      O => int_CAMB_FV_I,     -- Buffer output
      IO => CAMB_FV_I,   -- Buffer inout port (connect directly to top-level port)
      I => '0',     -- Buffer input
      T => dummy_t      -- 3-state enable input, high=input, low=output 
   );	
	Inst_IOBUF_CAMB_LV : IOBUF
   generic map (
      DRIVE => 12,
      IOSTANDARD => "DEFAULT",
      SLEW => "SLOW")
   port map (
      O => int_CAMB_LV_I,     -- Buffer output
      IO => CAMB_LV_I,   -- Buffer inout port (connect directly to top-level port)
      I => '0',     -- Buffer input
      T => dummy_t      -- 3-state enable input, high=input, low=output 
   );	
Gen_IOBUF_CAMB_D: for i in 7 downto 0 generate
   Inst_IOBUF_CAMB_D : IOBUF
   generic map (
      DRIVE => 12,
      IOSTANDARD => "DEFAULT",
      SLEW => "SLOW")
   port map (
      O => int_CAMB_D_I(i),     -- Buffer output
      IO => CAMB_D_I(i),   -- Buffer inout port (connect directly to top-level port)
      I => '0',     -- Buffer input
      T => dummy_t      -- 3-state enable input, high=input, low=output 
   );
end generate;	
dummy_t <= '1';


   i_i2c_cama_scl_iobuf : IOBUF
   generic map 
   (
      DRIVE 		=> 12,
      IBUF_DELAY_VALUE 	=> "0",
      IFD_DELAY_VALUE 	=> "AUTO",
      IOSTANDARD 	=> "DEFAULT",
      SLEW 		=> "SLOW"
   )
   port map 
   (
      O 		=> CAMA_SCL_I,
      IO		=> CAMA_SCL,
      I 		=> CAMA_SCL_O,
      T 		=> CAMA_SCL_T
   );

   i_i2c_cama_sda_iobuf : IOBUF
   generic map 
   (
      DRIVE 		=> 12,
      IBUF_DELAY_VALUE 	=> "0",
      IFD_DELAY_VALUE 	=> "AUTO",
      IOSTANDARD 	=> "DEFAULT",
      SLEW 		=> "SLOW"
   )
   port map 
   (
      O 		=> CAMA_SDA_I,
      IO 		=> CAMA_SDA,
      I 		=> CAMA_SDA_O,
      T 		=> CAMA_SDA_T
   );
	
	   i_i2c_camb_scl_iobuf : IOBUF
   generic map 
   (
      DRIVE 		=> 12,
      IBUF_DELAY_VALUE 	=> "0",
      IFD_DELAY_VALUE 	=> "AUTO",
      IOSTANDARD 	=> "DEFAULT",
      SLEW 		=> "SLOW"
   )
   port map 
   (
      O 		=> CAMB_SCL_I,
      IO		=> CAMB_SCL,
      I 		=> CAMB_SCL_O,
      T 		=> CAMB_SCL_T
   );

   i_i2c_camb_sda_iobuf : IOBUF
   generic map 
   (
      DRIVE 		=> 12,
      IBUF_DELAY_VALUE 	=> "0",
      IFD_DELAY_VALUE 	=> "AUTO",
      IOSTANDARD 	=> "DEFAULT",
      SLEW 		=> "SLOW"
   )
   port map 
   (
      O 		=> CAMB_SDA_I,
      IO 		=> CAMB_SDA,
      I 		=> CAMB_SDA_O,
      T 		=> CAMB_SDA_T
   );

end Behavioral;

