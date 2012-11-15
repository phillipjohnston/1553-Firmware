-- Vhdl test bench created from schematic C:\Users\Phillip\Dropbox\workspace\class_projects\MS1553_Interface\XilinxProject\System.sch - Mon Nov 12 09:44:49 2012
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
          SYSCLK_P	:	IN	STD_LOGIC; 
          SYSCLK_N	:	IN	STD_LOGIC; 
          NET_GND	:	OUT	STD_LOGIC; 
          TEST_STATUS_DATA	:	IN	STD_LOGIC_VECTOR (7 DOWNTO 0));
   END COMPONENT;
	
	COMPONENT OBUFDS 
	  port (
		 I  : IN STD_LOGIC; -- Buffer output
		 O  : OUT STD_LOGIC;
		 OB : OUT STD_LOGIC
	  );
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
   SIGNAL SYSCLK_P	:	STD_LOGIC := '0';
   SIGNAL SYSCLK_N	:	STD_LOGIC := '1';
   SIGNAL NET_GND	:	STD_LOGIC;
   SIGNAL TEST_STATUS_DATA	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
	
	SIGNAL CLOCK_200MHZ : STD_LOGIC;

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
		SYSCLK_P => SYSCLK_P, 
		SYSCLK_N => SYSCLK_N, 
		NET_GND => NET_GND, 
		TEST_STATUS_DATA => TEST_STATUS_DATA
   );
	
	DIFF_CLOCK_GEN: OBUFDS 
	  port map(
		 I  => CLOCK_200MHZ, -- Buffer output
		 O  => SYSCLK_P,
		 OB => SYSCLK_N
	  );
	

	clocking : PROCESS
	BEGIN
		CLOCK_200MHZ <= '0';
		wait for 2.5 ns;
		CLOCK_200MHZ <= '1';
		wait for 2.5 ns;
	END PROCESS;

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
		CPU_RESET <= '0';
		
		wait for 200 ns;
		
		CPU_RESET <= '1';
	
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
