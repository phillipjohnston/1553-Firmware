--------------------------------------------------------------------------------
-- Copyright (c) 1995-2011 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 13.4
--  \   \         Application : sch2hdl
--  /   /         Filename : MS1553_Controller_drc.vhf
-- /___/   /\     Timestamp : 11/07/2012 19:33:14
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx\13.4\ISE_DS\ISE\bin\nt\unwrapped\sch2hdl.exe -sympath C:/Users/Phillip/Dropbox/workspace/class_projects/MS1553_Interface/XilinxProject/ipcore_dir -intstyle ise -family spartan6 -flat -suppress -vhdl MS1553_Controller_drc.vhf -w C:/Users/Phillip/Dropbox/workspace/class_projects/MS1553_Interface/XilinxProject/MS1553_Controller.sch
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
end MS1553_Controller;

architecture BEHAVIORAL of MS1553_Controller is
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


