--------------------------------------------------------------------------------
-- Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 13.4
--  \   \         Application : sch2hdl
--  /   /         Filename : System.vhf
-- /___/   /\     Timestamp : 11/06/2012 20:19:40
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl C:/Users/Phillip/Downloads/MS1553_Interface/MS1553_Interface/System.vhf -w C:/Users/Phillip/Downloads/MS1553_Interface/MS1553_Interface/System.sch
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
          AUTOEN     : out   std_logic; 
          BENDI      : out   std_logic; 
          BTYPE      : out   std_logic; 
          BWID       : out   std_logic; 
          EECOPY     : out   std_logic; 
          HOLT_ADDR  : out   std_logic_vector (15 downto 0); 
          IDATA      : out   std_logic_vector (7 downto 0); 
          MTSTOFF    : out   std_logic; 
          nCE        : out   std_logic; 
          nMR        : out   std_logic; 
          nOE        : out   std_logic; 
          nWE        : out   std_logic; 
          RAMEDC     : out   std_logic; 
          WPOL       : out   std_logic; 
          DATA_CHIP  : inout std_logic_vector (7 downto 0));
end MS1553_Controller_MUSER_System;

architecture BEHAVIORAL of MS1553_Controller_MUSER_System is
   signal XLXN_1     : std_logic;
   signal XLXN_2     : std_logic;
   signal XLXN_6     : std_logic;
   signal XLXN_7     : std_logic;
   signal XLXN_8     : std_logic;
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
      port ( RESET           : in    std_logic; 
             IS_BIG_ENDIAN   : in    std_logic; 
             MEM_TEST_EN     : in    std_logic; 
             RAM_ERR_CORR_EN : in    std_logic; 
             nMR             : out   std_logic; 
             MTSTOFF         : out   std_logic; 
             AUTOEN          : out   std_logic; 
             EECOPY          : out   std_logic; 
             BENDI           : out   std_logic; 
             RAMEDC          : out   std_logic; 
             BWID            : out   std_logic; 
             BTYPE           : out   std_logic; 
             WPOL            : out   std_logic);
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
             ADDRESS_OUT   : out   std_logic_vector (15 downto 0); 
             DATA_RETURN_0 : out   std_logic_vector (7 downto 0); 
             DATA_RETURN_1 : out   std_logic_vector (7 downto 0); 
             DATA_VALID_0  : out   std_logic; 
             DATA_VALID_1  : out   std_logic);
   end component;
   
   component MS1553_master
      port ( ALE               : in    std_logic; 
             nWR               : in    std_logic; 
             nRD               : in    std_logic; 
             nIOM              : in    std_logic; 
             CLOCK             : in    std_logic; 
             ADDRESS           : in    std_logic_vector (15 downto 0); 
             DATA_IN_0         : in    std_logic_vector (7 downto 0); 
             DATA_IN_1         : in    std_logic_vector (7 downto 0); 
             nREAD             : out   std_logic; 
             nWRITE            : out   std_logic; 
             RESET_IC          : out   std_logic; 
             IS_BIG_ENDIAN     : out   std_logic; 
             MEM_TEST_EN       : out   std_logic; 
             RAM_ERROR_CORR_EN : out   std_logic; 
             ADDRESS_TO_CHIP   : out   std_logic_vector (15 downto 0); 
             DATA_OUT_0        : out   std_logic_vector (7 downto 0); 
             DATA_OUT_1        : out   std_logic_vector (7 downto 0); 
             IDATA             : out   std_logic_vector (7 downto 0); 
             DATA_VALID_0      : in    std_logic; 
             DATA_VALID_1      : in    std_logic);
   end component;
   
   component MS1553_Reset_Pulse_Gen
      port ( ResetGo  : in    std_logic; 
             clock    : in    std_logic; 
             ResetOut : out   std_logic);
   end component;
   
begin
   XLXI_2 : holt_initializer
      port map (IS_BIG_ENDIAN=>XLXN_6,
                MEM_TEST_EN=>XLXN_7,
                RAM_ERR_CORR_EN=>XLXN_8,
                RESET=>XLXN_2,
                AUTOEN=>AUTOEN,
                BENDI=>BENDI,
                BTYPE=>BTYPE,
                BWID=>BWID,
                EECOPY=>EECOPY,
                MTSTOFF=>MTSTOFF,
                nMR=>nMR,
                RAMEDC=>RAMEDC,
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
                IS_BIG_ENDIAN=>XLXN_6,
                MEM_TEST_EN=>XLXN_7,
                nREAD=>XLXN_11,
                nWRITE=>XLXN_12,
                RAM_ERROR_CORR_EN=>XLXN_8,
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
   port ( FAST_CLOCK    : in    std_logic; 
          HWAIT         : in    std_logic; 
          AUTOEN        : out   std_logic; 
          BENDI         : out   std_logic; 
          BTYPE         : out   std_logic; 
          BWID          : out   std_logic; 
          EECOPY        : out   std_logic; 
          HOLT_ADDR_BUS : out   std_logic_vector (15 downto 0); 
          MTSTOFF       : out   std_logic; 
          nCE           : out   std_logic; 
          nMR           : out   std_logic; 
          nOE           : out   std_logic; 
          nWE           : out   std_logic; 
          RAMEDC        : out   std_logic; 
          WPOL          : out   std_logic; 
          HOLT_DATA_BUS : inout std_logic_vector (7 downto 0));
end System;

architecture BEHAVIORAL of System is
   signal XLXN_1                       : std_logic;
   signal XLXN_2                       : std_logic;
   signal XLXN_3                       : std_logic;
   signal XLXN_4                       : std_logic;
   signal XLXN_5                       : std_logic_vector (15 downto 0);
   signal XLXN_14                      : std_logic_vector (7 downto 0);
   signal XLXI_1_HOLD_openSignal       : std_logic;
   signal XLXI_1_INTR_openSignal       : std_logic;
   signal XLXI_1_READY_openSignal      : std_logic;
   signal XLXI_1_RESETINBAR_openSignal : std_logic;
   signal XLXI_1_RST55_openSignal      : std_logic;
   signal XLXI_1_RST65_openSignal      : std_logic;
   signal XLXI_1_RST75_openSignal      : std_logic;
   signal XLXI_1_SID_openSignal        : std_logic;
   signal XLXI_1_TRAP_openSignal       : std_logic;
   signal XLXI_1_X1_openSignal         : std_logic;
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
             MTSTOFF    : out   std_logic; 
             AUTOEN     : out   std_logic; 
             EECOPY     : out   std_logic; 
             BENDI      : out   std_logic; 
             RAMEDC     : out   std_logic; 
             BWID       : out   std_logic; 
             BTYPE      : out   std_logic; 
             WPOL       : out   std_logic; 
             IDATA      : out   std_logic_vector (7 downto 0); 
             nCE        : out   std_logic; 
             nWE        : out   std_logic; 
             nOE        : out   std_logic; 
             HOLT_ADDR  : out   std_logic_vector (15 downto 0));
   end component;
   
begin
   XLXI_1 : I8085_c
      port map (HOLD=>XLXI_1_HOLD_openSignal,
                ID(7 downto 0)=>XLXN_14(7 downto 0),
                INTR=>XLXI_1_INTR_openSignal,
                READY=>XLXI_1_READY_openSignal,
                RESETINBAR=>XLXI_1_RESETINBAR_openSignal,
                RST55=>XLXI_1_RST55_openSignal,
                RST65=>XLXI_1_RST65_openSignal,
                RST75=>XLXI_1_RST75_openSignal,
                SID=>XLXI_1_SID_openSignal,
                TRAP=>XLXI_1_TRAP_openSignal,
                X1=>XLXI_1_X1_openSignal,
                ADDRESS_OUT(15 downto 0)=>XLXN_5(15 downto 0),
                ALE=>XLXN_1,
                CLKOUT=>open,
                HLDA=>open,
                INTABAR=>open,
                IOMBAR=>XLXN_4,
                RDBAR=>XLXN_3,
                RESETOUT=>open,
                SOD=>open,
                S0=>open,
                S1=>open,
                WRBAR=>XLXN_2);
   
   XLXI_2 : MS1553_Controller_MUSER_System
      port map (Address(15 downto 0)=>XLXN_5(15 downto 0),
                ALE=>XLXN_1,
                FAST_CLOCK=>FAST_CLOCK,
                HWAIT=>HWAIT,
                nIOM=>XLXN_4,
                nRD=>XLXN_3,
                nWR=>XLXN_2,
                AUTOEN=>AUTOEN,
                BENDI=>BENDI,
                BTYPE=>BTYPE,
                BWID=>BWID,
                EECOPY=>EECOPY,
                HOLT_ADDR(15 downto 0)=>HOLT_ADDR_BUS(15 downto 0),
                IDATA(7 downto 0)=>XLXN_14(7 downto 0),
                MTSTOFF=>MTSTOFF,
                nCE=>nCE,
                nMR=>nMR,
                nOE=>nOE,
                nWE=>nWE,
                RAMEDC=>RAMEDC,
                WPOL=>WPOL,
                DATA_CHIP(7 downto 0)=>HOLT_DATA_BUS(7 downto 0));
   
end BEHAVIORAL;


