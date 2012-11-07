--------------------------------------------------------------------------------
-- Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 13.4
--  \   \         Application : sch2hdl
--  /   /         Filename : MS1553_Controller_drc.vhf
-- /___/   /\     Timestamp : 11/06/2012 19:15:02
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx\13.4\ISE_DS\ISE\bin\nt\unwrapped\sch2hdl.exe -intstyle ise -family spartan6 -flat -suppress -vhdl MS1553_Controller_drc.vhf -w C:/Users/Phillip/Downloads/MS1553_Interface/MS1553_Interface/MS1553_Controller.sch
--Design Name: MS1553_Controller
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

entity MS1553_Controller is
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
          TEST       : out   std_logic; 
          TXINHA     : out   std_logic; 
          TXINHB     : out   std_logic; 
          WPOL       : out   std_logic; 
          DATA_CHIP  : inout std_logic_vector (7 downto 0));
end MS1553_Controller;

architecture BEHAVIORAL of MS1553_Controller is
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
             TXINHA          : out   std_logic; 
             TXINHB          : out   std_logic; 
             MTSTOFF         : out   std_logic; 
             AUTOEN          : out   std_logic; 
             EECOPY          : out   std_logic; 
             BENDI           : out   std_logic; 
             RAMEDC          : out   std_logic; 
             TEST            : out   std_logic; 
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
                TEST=>TEST,
                TXINHA=>TXINHA,
                TXINHB=>TXINHB,
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


