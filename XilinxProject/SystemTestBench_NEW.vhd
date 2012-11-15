-- Vhdl test bench created from schematic C:\Users\Phillip\Dropbox\workspace\class_projects\MS1553_Interface\XilinxProject\System.sch - Thu Nov 15 14:04:58 2012
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY System_System_sch_tb IS
END System_System_sch_tb;
ARCHITECTURE behavioral OF System_System_sch_tb IS 

   COMPONENT System
   PORT( CPU_RESET	:	IN	STD_LOGIC; 
          nMR	:	OUT	STD_LOGIC; 
          BWID	:	OUT	STD_LOGIC; 
          BTYPE	:	OUT	STD_LOGIC; 
          WPOL	:	OUT	STD_LOGIC; 
          nCE	:	OUT	STD_LOGIC; 
          nWE	:	OUT	STD_LOGIC; 
          nOE	:	OUT	STD_LOGIC; 
          ADDRESS	:	OUT	STD_LOGIC_VECTOR (15 DOWNTO 0); 
          DATA	:	INOUT	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          HWAIT	:	IN	STD_LOGIC; 
          NET_GND	:	OUT	STD_LOGIC; 
          SYSCLK_P	:	IN	STD_LOGIC; 
          SYSCLK_N	:	IN	STD_LOGIC; 
          CHIPSCOPE_CLK	:	OUT	STD_LOGIC; 
          MTRUN	:	OUT	STD_LOGIC; 
          BCTRIG	:	OUT	STD_LOGIC; 
          TEST	:	OUT	STD_LOGIC; 
          BCENA	:	OUT	STD_LOGIC; 
          RT1ENA	:	OUT	STD_LOGIC; 
          RT1SSF	:	OUT	STD_LOGIC; 
          TXINHA	:	OUT	STD_LOGIC; 
          TXINHB	:	OUT	STD_LOGIC; 
          ACTIVE	:	IN	STD_LOGIC; 
          MTPKRDY	:	IN	STD_LOGIC; 
          READY	:	IN	STD_LOGIC; 
          nRT1MC8	:	IN	STD_LOGIC);
   END COMPONENT;

   SIGNAL CPU_RESET	:	STD_LOGIC;
   SIGNAL nMR	:	STD_LOGIC;
   SIGNAL BWID	:	STD_LOGIC;
   SIGNAL BTYPE	:	STD_LOGIC;
   SIGNAL WPOL	:	STD_LOGIC;
   SIGNAL nCE	:	STD_LOGIC;
   SIGNAL nWE	:	STD_LOGIC;
   SIGNAL nOE	:	STD_LOGIC;
   SIGNAL ADDRESS	:	STD_LOGIC_VECTOR (15 DOWNTO 0);
   SIGNAL DATA	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL HWAIT	:	STD_LOGIC;
   SIGNAL NET_GND	:	STD_LOGIC;
   SIGNAL SYSCLK_P	:	STD_LOGIC;
   SIGNAL SYSCLK_N	:	STD_LOGIC;
   SIGNAL CHIPSCOPE_CLK	:	STD_LOGIC;
   SIGNAL MTRUN	:	STD_LOGIC;
   SIGNAL BCTRIG	:	STD_LOGIC;
   SIGNAL TEST	:	STD_LOGIC;
   SIGNAL BCENA	:	STD_LOGIC;
   SIGNAL RT1ENA	:	STD_LOGIC;
   SIGNAL RT1SSF	:	STD_LOGIC;
   SIGNAL TXINHA	:	STD_LOGIC;
   SIGNAL TXINHB	:	STD_LOGIC;
   SIGNAL ACTIVE	:	STD_LOGIC;
   SIGNAL MTPKRDY	:	STD_LOGIC;
   SIGNAL READY	:	STD_LOGIC;
   SIGNAL nRT1MC8	:	STD_LOGIC;

BEGIN

   UUT: System PORT MAP(
		CPU_RESET => CPU_RESET, 
		nMR => nMR, 
		BWID => BWID, 
		BTYPE => BTYPE, 
		WPOL => WPOL, 
		nCE => nCE, 
		nWE => nWE, 
		nOE => nOE, 
		ADDRESS => ADDRESS, 
		DATA => DATA, 
		HWAIT => HWAIT, 
		NET_GND => NET_GND, 
		SYSCLK_P => SYSCLK_P, 
		SYSCLK_N => SYSCLK_N, 
		CHIPSCOPE_CLK => CHIPSCOPE_CLK, 
		MTRUN => MTRUN, 
		BCTRIG => BCTRIG, 
		TEST => TEST, 
		BCENA => BCENA, 
		RT1ENA => RT1ENA, 
		RT1SSF => RT1SSF, 
		TXINHA => TXINHA, 
		TXINHB => TXINHB, 
		ACTIVE => ACTIVE, 
		MTPKRDY => MTPKRDY, 
		READY => READY, 
		nRT1MC8 => nRT1MC8
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
