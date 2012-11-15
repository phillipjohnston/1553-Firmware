--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.1
--  \   \         Application : sch2hdl
--  /   /         Filename : System_drc.vhf
-- /___/   /\     Timestamp : 11/12/2012 16:23:21
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx\14.1\ISE_DS\ISE\bin\nt\unwrapped\sch2hdl.exe -sympath C:/Users/Phillip/Dropbox/workspace/class_projects/MS1553_Interface/XilinxProject/ipcore_dir -intstyle ise -family spartan6 -flat -suppress -vhdl System_drc.vhf -w C:/Users/Phillip/Dropbox/workspace/class_projects/MS1553_Interface/XilinxProject/System.sch
--Design Name: System
--Device: spartan6
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity MS1553_Controller_MUSER_System is
   port ( Address    : in    std_logic_vector (15 downto 0); 
          ALE        : in    std_logic; 
          FAST_CLOCK : in    std_logic; 
          HWAIT      : in    std_logic; 
          nIOM       : in    std_logic; 
          nRD        : in    std_logic; 
          nWR        : in    std_logic; 
          BTYPE      : out   std_logic; 
          BWID       : out   std_logic; 
          HOLT_ADDR  : out   std_logic_vector (15 downto 0); 
          IDATA      : out   std_logic_vector (7 downto 0); 
          nCE        : out   std_logic; 
          nMR        : out   std_logic; 
          nOE        : out   std_logic; 
          nWE        : out   std_logic; 
          WPOL       : out   std_logic; 
          DATA_CHIP  : inout std_logic_vector (7 downto 0));
end MS1553_Controller_MUSER_System;

architecture BEHAVIORAL of MS1553_Controller_MUSER_System is
   signal XLXN_1     : std_logic;
   signal XLXN_2     : std_logic;
   signal XLXN_11    : std_logic;
   signal XLXN_12    : std_logic;
   signal XLXN_13    : std_logic_vector (7 downto 0);
   signal XLXN_14    : std_logic_vector (7 downto 0);
   signal XLXN_15    : std_logic_vector (7 downto 0);
   signal XLXN_16    : std_logic_vector (7 downto 0);
   signal XLXN_17    : std_logic_vector (15 downto 0);
   signal XLXN_19    : std_logic;
   signal XLXN_20    : std_logic;
   component holt_initializer
      port ( RESET : in    std_logic; 
             nMR   : out   std_logic; 
             BWID  : out   std_logic; 
             BTYPE : out   std_logic; 
             WPOL  : out   std_logic);
   end component;
   
   component holt_mem_trans
      port ( nRD           : in    std_logic; 
             nWR           : in    std_logic; 
             clock         : in    std_logic; 
             HWAIT         : in    std_logic; 
             ADDRESS_IN    : in    std_logic_vector (15 downto 0); 
             DATA_IN_0     : in    std_logic_vector (7 downto 0); 
             DATA_IN_1     : in    std_logic_vector (7 downto 0); 
             DATA          : inout std_logic_vector (7 downto 0); 
             nOE           : out   std_logic; 
             nWE           : out   std_logic; 
             nCE           : out   std_logic; 
             DATA_VALID_0  : out   std_logic; 
             DATA_VALID_1  : out   std_logic; 
             ADDRESS_OUT   : out   std_logic_vector (15 downto 0); 
             DATA_RETURN_0 : out   std_logic_vector (7 downto 0); 
             DATA_RETURN_1 : out   std_logic_vector (7 downto 0));
   end component;
   
   component MS1553_master
      port ( ALE             : in    std_logic; 
             nWR             : in    std_logic; 
             nRD             : in    std_logic; 
             nIOM            : in    std_logic; 
             CLOCK           : in    std_logic; 
             DATA_VALID_0    : in    std_logic; 
             DATA_VALID_1    : in    std_logic; 
             ADDRESS         : in    std_logic_vector (15 downto 0); 
             DATA_IN_0       : in    std_logic_vector (7 downto 0); 
             DATA_IN_1       : in    std_logic_vector (7 downto 0); 
             nREAD           : out   std_logic; 
             nWRITE          : out   std_logic; 
             RESET_IC        : out   std_logic; 
             ADDRESS_TO_CHIP : out   std_logic_vector (15 downto 0); 
             DATA_OUT_0      : out   std_logic_vector (7 downto 0); 
             DATA_OUT_1      : out   std_logic_vector (7 downto 0); 
             IDATA           : out   std_logic_vector (7 downto 0));
   end component;
   
   component MS1553_Reset_Pulse_Gen
      port ( ResetGo  : in    std_logic; 
             clock    : in    std_logic; 
             ResetOut : out   std_logic);
   end component;
   
begin
   XLXI_2 : holt_initializer
      port map (RESET=>XLXN_2,
                BTYPE=>BTYPE,
                BWID=>BWID,
                nMR=>nMR,
                WPOL=>WPOL);
   
   XLXI_3 : holt_mem_trans
      port map (ADDRESS_IN(15 downto 0)=>XLXN_17(15 downto 0),
                clock=>FAST_CLOCK,
                DATA_IN_0(7 downto 0)=>XLXN_13(7 downto 0),
                DATA_IN_1(7 downto 0)=>XLXN_14(7 downto 0),
                HWAIT=>HWAIT,
                nRD=>XLXN_11,
                nWR=>XLXN_12,
                ADDRESS_OUT(15 downto 0)=>HOLT_ADDR(15 downto 0),
                DATA_RETURN_0(7 downto 0)=>XLXN_15(7 downto 0),
                DATA_RETURN_1(7 downto 0)=>XLXN_16(7 downto 0),
                DATA_VALID_0=>XLXN_19,
                DATA_VALID_1=>XLXN_20,
                nCE=>nCE,
                nOE=>nOE,
                nWE=>nWE,
                DATA(7 downto 0)=>DATA_CHIP(7 downto 0));
   
   XLXI_4 : MS1553_master
      port map (ADDRESS(15 downto 0)=>Address(15 downto 0),
                ALE=>ALE,
                CLOCK=>FAST_CLOCK,
                DATA_IN_0(7 downto 0)=>XLXN_15(7 downto 0),
                DATA_IN_1(7 downto 0)=>XLXN_16(7 downto 0),
                DATA_VALID_0=>XLXN_19,
                DATA_VALID_1=>XLXN_20,
                nIOM=>nIOM,
                nRD=>nRD,
                nWR=>nWR,
                ADDRESS_TO_CHIP(15 downto 0)=>XLXN_17(15 downto 0),
                DATA_OUT_0(7 downto 0)=>XLXN_13(7 downto 0),
                DATA_OUT_1(7 downto 0)=>XLXN_14(7 downto 0),
                IDATA(7 downto 0)=>IDATA(7 downto 0),
                nREAD=>XLXN_11,
                nWRITE=>XLXN_12,
                RESET_IC=>XLXN_1);
   
   XLXI_5 : MS1553_Reset_Pulse_Gen
      port map (clock=>FAST_CLOCK,
                ResetGo=>XLXN_1,
                ResetOut=>XLXN_2);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity System is
   port ( CPU_RESET        : in    std_logic; 
          HWAIT            : in    std_logic; 
          SYSCLK_N         : in    std_logic; 
          SYSCLK_P         : in    std_logic; 
          TEST_STATUS_DATA : in    std_logic_vector (7 downto 0); 
          ADDRESS          : out   std_logic_vector (15 downto 0); 
          BTYPE            : out   std_logic; 
          BWID             : out   std_logic; 
          nCE              : out   std_logic; 
          NET_GND          : out   std_logic; 
          nMR              : out   std_logic; 
          nOE              : out   std_logic; 
          nWE              : out   std_logic; 
          WPOL             : out   std_logic; 
          DATA             : inout std_logic_vector (7 downto 0));
end System;

architecture BEHAVIORAL of System is
   attribute BOX_TYPE         : string ;
   attribute IOSTANDARD       : string ;
   attribute IBUF_DELAY_VALUE : string ;
   attribute IFD_DELAY_VALUE  : string ;
   signal ADDR_OUT_8085    : std_logic_vector (15 downto 0);
   signal ALE              : std_logic;
   signal CPU_RESET_BUF    : std_logic;
   signal FASTCLK          : std_logic;
   signal FAST_CLOCK       : std_logic;
   signal HWAIT_BUF        : std_logic;
   signal IDATA            : std_logic_vector (7 downto 0);
   signal MEM_ADDR         : std_logic_vector (15 downto 0);
   signal MEM_DATA         : std_logic_vector (7 downto 0);
   signal MEM_DATA_IN      : std_logic_vector (7 downto 0);
   signal MEM_ENA          : std_logic;
   signal MEM_WEA          : std_logic;
   signal nIOM             : std_logic;
   signal nRD              : std_logic;
   signal nWR              : std_logic;
   signal RE               : std_logic;
   signal SEL_SFR          : std_logic_vector (15 downto 0);
   signal SFR_CONFIG       : std_logic_vector (7 downto 0);
   signal SFR_TRIG         : std_logic_vector (7 downto 0);
   signal SLOWCLK          : std_logic;
   signal SLOW_CLOCK       : std_logic;
   signal WE               : std_logic;
   signal XLXN_118         : std_logic;
   signal XLXN_120         : std_logic;
   signal XLXN_121         : std_logic;
   signal XLXN_122         : std_logic;
   signal XLXN_123         : std_logic;
   signal XLXN_124         : std_logic;
   signal XLXN_125         : std_logic;
   signal XLXN_126         : std_logic;
   component I8085_c
      port ( X1          : in    std_logic; 
             SID         : in    std_logic; 
             TRAP        : in    std_logic; 
             RST75       : in    std_logic; 
             RST65       : in    std_logic; 
             RST55       : in    std_logic; 
             INTR        : in    std_logic; 
             READY       : in    std_logic; 
             RESETINBAR  : in    std_logic; 
             HOLD        : in    std_logic; 
             ID          : in    std_logic_vector (7 downto 0); 
             RESETOUT    : out   std_logic; 
             SOD         : out   std_logic; 
             INTABAR     : out   std_logic; 
             S0          : out   std_logic; 
             ALE         : out   std_logic; 
             WRBAR       : out   std_logic; 
             RDBAR       : out   std_logic; 
             S1          : out   std_logic; 
             IOMBAR      : out   std_logic; 
             CLKOUT      : out   std_logic; 
             HLDA        : out   std_logic; 
             ADDRESS_OUT : out   std_logic_vector (15 downto 0));
   end component;
   
   component MS1553_Controller_MUSER_System
      port ( Address    : in    std_logic_vector (15 downto 0); 
             FAST_CLOCK : in    std_logic; 
             ALE        : in    std_logic; 
             nWR        : in    std_logic; 
             nRD        : in    std_logic; 
             nIOM       : in    std_logic; 
             HWAIT      : in    std_logic; 
             DATA_CHIP  : inout std_logic_vector (7 downto 0); 
             nMR        : out   std_logic; 
             BWID       : out   std_logic; 
             BTYPE      : out   std_logic; 
             WPOL       : out   std_logic; 
             IDATA      : out   std_logic_vector (7 downto 0); 
             nCE        : out   std_logic; 
             nWE        : out   std_logic; 
             nOE        : out   std_logic; 
             HOLT_ADDR  : out   std_logic_vector (15 downto 0));
   end component;
   
   component Clock
      port ( clk_in1_p : in    std_logic; 
             clk_in1_n : in    std_logic; 
             clk_out1  : out   std_logic; 
             clk_out2  : out   std_logic; 
             reset     : in    std_logic; 
             locked    : out   std_logic);
   end component;
   
   component Memory
      port ( addra : in    std_logic_vector (15 downto 0); 
             dina  : in    std_logic_vector (7 downto 0); 
             ena   : in    std_logic; 
             wea   : in    std_logic_vector (0 downto 0); 
             clka  : in    std_logic; 
             douta : out   std_logic_vector (7 downto 0));
   end component;
   
   component VCC
      port ( P : out   std_logic);
   end component;
   attribute BOX_TYPE of VCC : component is "BLACK_BOX";
   
   component GND
      port ( G : out   std_logic);
   end component;
   attribute BOX_TYPE of GND : component is "BLACK_BOX";
   
   component Mem8085_Controller
      port ( ALE         : in    std_logic; 
             nWR         : in    std_logic; 
             nRD         : in    std_logic; 
             nIOM        : in    std_logic; 
             ADDRESS_IN  : in    std_logic_vector (15 downto 0); 
             ENA         : out   std_logic; 
             WEA         : out   std_logic; 
             ADDRESS_OUT : out   std_logic_vector (15 downto 0); 
             DATA_OUT    : out   std_logic_vector (7 downto 0));
   end component;
   
   component tri_buf_8
      port ( EN   : in    std_logic; 
             DIN  : in    std_logic_vector (7 downto 0); 
             DOUT : out   std_logic_vector (7 downto 0));
   end component;
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component SFR_Address_Decoder
      port ( ADDR : in    std_logic_vector (15 downto 0); 
             SEL  : out   std_logic_vector (15 downto 0));
   end component;
   
   component sfr_8_output
      port ( RE    : in    std_logic; 
             WE    : in    std_logic; 
             clock : in    std_logic; 
             clear : in    std_logic; 
             CS    : in    std_logic; 
             DIN   : in    std_logic_vector (7 downto 0); 
             Q     : out   std_logic_vector (7 downto 0); 
             DOUT  : out   std_logic_vector (7 downto 0));
   end component;
   
   component sfr_8_input
      port ( RE    : in    std_logic; 
             CS    : in    std_logic; 
             clock : in    std_logic; 
             Q     : in    std_logic_vector (7 downto 0); 
             DOUT  : out   std_logic_vector (7 downto 0));
   end component;
   
   component sfr_8_output_pulse
      port ( RE    : in    std_logic; 
             WE    : in    std_logic; 
             clock : in    std_logic; 
             clear : in    std_logic; 
             CS    : in    std_logic; 
             DIN   : in    std_logic_vector (7 downto 0); 
             Q     : out   std_logic_vector (7 downto 0); 
             DOUT  : out   std_logic_vector (7 downto 0));
   end component;
   
   component IBUF
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute IOSTANDARD of IBUF : component is "DEFAULT";
   attribute IBUF_DELAY_VALUE of IBUF : component is "0";
   attribute IFD_DELAY_VALUE of IBUF : component is "AUTO";
   attribute BOX_TYPE of IBUF : component is "BLACK_BOX";
   
   component IBUFG
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute IOSTANDARD of IBUFG : component is "DEFAULT";
   attribute IBUF_DELAY_VALUE of IBUFG : component is "0";
   attribute BOX_TYPE of IBUFG : component is "BLACK_BOX";
   
begin
   XLXI_1 : I8085_c
      port map (HOLD=>XLXN_126,
                ID(7 downto 0)=>IDATA(7 downto 0),
                INTR=>XLXN_125,
                READY=>XLXN_118,
                RESETINBAR=>CPU_RESET_BUF,
                RST55=>XLXN_124,
                RST65=>XLXN_123,
                RST75=>XLXN_122,
                SID=>XLXN_120,
                TRAP=>XLXN_121,
                X1=>SLOW_CLOCK,
                ADDRESS_OUT(15 downto 0)=>ADDR_OUT_8085(15 downto 0),
                ALE=>ALE,
                CLKOUT=>open,
                HLDA=>open,
                INTABAR=>open,
                IOMBAR=>nIOM,
                RDBAR=>nRD,
                RESETOUT=>open,
                SOD=>open,
                S0=>open,
                S1=>open,
                WRBAR=>nWR);
   
   XLXI_2 : MS1553_Controller_MUSER_System
      port map (Address(15 downto 0)=>ADDR_OUT_8085(15 downto 0),
                ALE=>ALE,
                FAST_CLOCK=>FAST_CLOCK,
                HWAIT=>HWAIT_BUF,
                nIOM=>nIOM,
                nRD=>nRD,
                nWR=>nWR,
                BTYPE=>BTYPE,
                BWID=>BWID,
                HOLT_ADDR(15 downto 0)=>ADDRESS(15 downto 0),
                IDATA(7 downto 0)=>IDATA(7 downto 0),
                nCE=>nCE,
                nMR=>nMR,
                nOE=>nOE,
                nWE=>nWE,
                WPOL=>WPOL,
                DATA_CHIP(7 downto 0)=>DATA(7 downto 0));
   
   XLXI_8 : Clock
      port map (clk_in1_n=>SYSCLK_N,
                clk_in1_p=>SYSCLK_P,
                reset=>CPU_RESET_BUF,
                clk_out1=>FASTCLK,
                clk_out2=>SLOWCLK,
                locked=>open);
   
   XLXI_9 : Memory
      port map (addra(15 downto 0)=>MEM_ADDR(15 downto 0),
                clka=>SLOW_CLOCK,
                dina(7 downto 0)=>MEM_DATA_IN(7 downto 0),
                ena=>MEM_ENA,
                wea(0)=>MEM_WEA,
                douta(7 downto 0)=>MEM_DATA(7 downto 0));
   
   XLXI_10 : VCC
      port map (P=>XLXN_118);
   
   XLXI_12 : GND
      port map (G=>XLXN_120);
   
   XLXI_13 : GND
      port map (G=>XLXN_121);
   
   XLXI_14 : GND
      port map (G=>XLXN_122);
   
   XLXI_15 : GND
      port map (G=>XLXN_123);
   
   XLXI_16 : GND
      port map (G=>XLXN_124);
   
   XLXI_17 : GND
      port map (G=>XLXN_125);
   
   XLXI_18 : GND
      port map (G=>XLXN_126);
   
   XLXI_19 : Mem8085_Controller
      port map (ADDRESS_IN(15 downto 0)=>ADDR_OUT_8085(15 downto 0),
                ALE=>ALE,
                nIOM=>nIOM,
                nRD=>nRD,
                nWR=>nWR,
                ADDRESS_OUT(15 downto 0)=>MEM_ADDR(15 downto 0),
                DATA_OUT(7 downto 0)=>MEM_DATA_IN(7 downto 0),
                ENA=>MEM_ENA,
                WEA=>MEM_WEA);
   
   XLXI_68 : tri_buf_8
      port map (DIN(7 downto 0)=>MEM_DATA(7 downto 0),
                EN=>MEM_ENA,
                DOUT(7 downto 0)=>IDATA(7 downto 0));
   
   XLXI_92 : GND
      port map (G=>NET_GND);
   
   XLXI_93 : INV
      port map (I=>nWR,
                O=>WE);
   
   XLXI_94 : INV
      port map (I=>nRD,
                O=>RE);
   
   XLXI_96 : SFR_Address_Decoder
      port map (ADDR(15 downto 0)=>ADDR_OUT_8085(15 downto 0),
                SEL(15 downto 0)=>SEL_SFR(15 downto 0));
   
   XLXI_98 : sfr_8_output
      port map (clear=>CPU_RESET_BUF,
                clock=>SLOW_CLOCK,
                CS=>SEL_SFR(0),
                DIN(7 downto 0)=>ADDR_OUT_8085(7 downto 0),
                RE=>RE,
                WE=>WE,
                DOUT(7 downto 0)=>IDATA(7 downto 0),
                Q(7 downto 0)=>SFR_CONFIG(7 downto 0));
   
   XLXI_99 : sfr_8_input
      port map (clock=>SLOW_CLOCK,
                CS=>SEL_SFR(1),
                Q(7 downto 0)=>TEST_STATUS_DATA(7 downto 0),
                RE=>RE,
                DOUT(7 downto 0)=>IDATA(7 downto 0));
   
   XLXI_100 : sfr_8_output_pulse
      port map (clear=>CPU_RESET_BUF,
                clock=>SLOW_CLOCK,
                CS=>SEL_SFR(2),
                DIN(7 downto 0)=>ADDR_OUT_8085(7 downto 0),
                RE=>RE,
                WE=>WE,
                DOUT(7 downto 0)=>IDATA(7 downto 0),
                Q(7 downto 0)=>SFR_TRIG(7 downto 0));
   
   XLXI_101 : IBUF
      port map (I=>CPU_RESET,
                O=>CPU_RESET_BUF);
   
   XLXI_104 : IBUF
      port map (I=>HWAIT,
                O=>HWAIT_BUF);
   
   XLXI_105 : IBUFG
      port map (I=>FASTCLK,
                O=>FAST_CLOCK);
   
   XLXI_106 : IBUFG
      port map (I=>SLOWCLK,
                O=>SLOW_CLOCK);
   
end BEHAVIORAL;


