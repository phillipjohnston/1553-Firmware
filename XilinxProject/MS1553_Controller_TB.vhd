-- Vhdl test bench created from schematic C:\Users\Phillip\Dropbox\workspace\class_projects\MS1553_Interface\XilinxProject\MS1553_Controller.sch - Wed Nov 07 21:46:05 2012
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
ENTITY MS1553_Controller_MS1553_Controller_sch_tb IS
END MS1553_Controller_MS1553_Controller_sch_tb;
ARCHITECTURE behavioral OF MS1553_Controller_MS1553_Controller_sch_tb IS 

   COMPONENT MS1553_Controller
   PORT( nMR	:	OUT	STD_LOGIC; 
          BWID	:	OUT	STD_LOGIC; 
          Address	:	IN	STD_LOGIC_VECTOR (15 DOWNTO 0); 
          BTYPE	:	OUT	STD_LOGIC; 
          WPOL	:	OUT	STD_LOGIC; 
          FAST_CLOCK	:	IN	STD_LOGIC; 
          ALE	:	IN	STD_LOGIC; 
          nWR	:	IN	STD_LOGIC; 
          nRD	:	IN	STD_LOGIC; 
          nIOM	:	IN	STD_LOGIC; 
          IDATA	:	OUT	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          HWAIT	:	IN	STD_LOGIC; 
          nCE	:	OUT	STD_LOGIC; 
          nWE	:	OUT	STD_LOGIC; 
          nOE	:	OUT	STD_LOGIC; 
          DATA_CHIP	:	INOUT	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          HOLT_ADDR	:	OUT	STD_LOGIC_VECTOR (15 DOWNTO 0));
   END COMPONENT;

   SIGNAL nMR	:	STD_LOGIC;
   SIGNAL BWID	:	STD_LOGIC;
   SIGNAL Address	:	STD_LOGIC_VECTOR (15 DOWNTO 0);
   SIGNAL BTYPE	:	STD_LOGIC;
   SIGNAL WPOL	:	STD_LOGIC;
   SIGNAL FAST_CLOCK	:	STD_LOGIC;
   SIGNAL ALE	:	STD_LOGIC;
   SIGNAL nWR	:	STD_LOGIC;
   SIGNAL nRD	:	STD_LOGIC;
   SIGNAL nIOM	:	STD_LOGIC;
   SIGNAL IDATA	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL HWAIT	:	STD_LOGIC;
   SIGNAL nCE	:	STD_LOGIC;
   SIGNAL nWE	:	STD_LOGIC;
   SIGNAL nOE	:	STD_LOGIC;
   SIGNAL DATA_CHIP	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL HOLT_ADDR	:	STD_LOGIC_VECTOR (15 DOWNTO 0);
	
	
		
	-- Clock period definitions
   constant clock_period : time := 10 ns;	

BEGIN

   UUT: MS1553_Controller PORT MAP(
		nMR => nMR, 
		BWID => BWID, 
		Address => Address, 
		BTYPE => BTYPE, 
		WPOL => WPOL, 
		FAST_CLOCK => FAST_CLOCK, 
		ALE => ALE, 
		nWR => nWR, 
		nRD => nRD, 
		nIOM => nIOM, 
		IDATA => IDATA, 
		HWAIT => HWAIT, 
		nCE => nCE, 
		nWE => nWE, 
		nOE => nOE, 
		DATA_CHIP => DATA_CHIP, 
		HOLT_ADDR => HOLT_ADDR
   );
	
	-- Clock process definitions
   CLOCK_process :process
   begin
		FAST_CLOCK <= '0';
		wait for CLOCK_period/2;
		FAST_CLOCK <= '1';
		wait for CLOCK_period/2;
   end process;

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
		DATA_CHIP <= "ZZZZZZZZ";
	
		wait for 100ns;
		ADDRESS <= "1111000011110000";
		ALE <= '1';
		
		wait for 100 ns;
		
		ALE <= '0';
		nWR <= '0';
		nRD <= '1';
		
		ADDRESS(7 DOWNTO 0) <= "00001111";
		
		wait for 300 ns;
		
		ADDRESS <= "1111000011110001";
		ALE <= '1';
		nWR <= '1';
		
		wait for 100 ns;
		
		ALE <= '0';
		nWR <= '0';
		nRD <= '1';
		
		ADDRESS(7 DOWNTO 0) <= "10100101";
		
		wait for 300 ns;
		
		ALE <= '0';
		nWR <= '1';
		nRD <= '1';
		
		ADDRESS(15 DOWNTO 0) <= "0000000000000000";
		
		
		---READ COMMAND TEST
		
		wait for 600 ns;
		ADDRESS <= "1111000011110000";
		ALE <= '1';
		
		wait for 225 ns;
		DATA_CHIP <= "10101010";
		
		wait for 100 ns;
		
		ALE <= '0';
		nWR <= '1';
		nRD <= '0';
		
		wait for 200 ns;
		DATA_CHIP <= "00111100";

		wait for 300 ns;
		
		ADDRESS <= "1111000011110001";
		ALE <= '1';
		nRD <= '1';
		
		wait for 100 ns;
		
		ALE <= '0';
		nWR <= '1';
		nRD <= '0';
		
		wait for 300 ns;
		
		ALE <= '0';
		nWR <= '1';
		nRD <= '1';
		
		ADDRESS(15 DOWNTO 0) <= "0000000000000000";
		
		--DATA_CHIP <= "ZZZZZZZZ";
		
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
