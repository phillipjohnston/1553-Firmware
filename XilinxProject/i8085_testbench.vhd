-- Vhdl test bench created from schematic C:\Users\cmulady\Documents\XILINX\i8085_test\top_level.sch - Sun Nov 04 19:39:53 2012
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
ENTITY top_level_top_level_sch_tb IS
END top_level_top_level_sch_tb;
ARCHITECTURE behavioral OF top_level_top_level_sch_tb IS 

   COMPONENT top_level
   PORT( SIG_CLK	:	IN	STD_LOGIC; 
          SIG_MR	:	IN	STD_LOGIC; 
          SIG_ADDRDAT	:	OUT	STD_LOGIC_VECTOR (15 DOWNTO 0); 
          RD	:	OUT	STD_LOGIC; 
          WR	:	OUT	STD_LOGIC; 
          ALE	:	OUT	STD_LOGIC; 
          MEM_ADDR	:	OUT	STD_LOGIC_VECTOR (15 DOWNTO 0); 
          ID	:	OUT	STD_LOGIC_VECTOR (7 DOWNTO 0);
			 SFR_CONFIG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			 TEST_STATUS_DATA : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			 SFR_TRIG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			 );
   END COMPONENT;

   SIGNAL SIG_CLK	:	STD_LOGIC;
   SIGNAL SIG_MR	:	STD_LOGIC;
   SIGNAL SIG_ADDRDAT	:	STD_LOGIC_VECTOR (15 DOWNTO 0);
   SIGNAL RD	:	STD_LOGIC;
   SIGNAL WR	:	STD_LOGIC;
   SIGNAL ALE	:	STD_LOGIC;
   SIGNAL MEM_ADDR	:	STD_LOGIC_VECTOR (15 DOWNTO 0);
   SIGNAL ID	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL SFR_CONFIG : STD_LOGIC_VECTOR ( 7 DOWNTO 0);
	SIGNAL TEST_STATUS_DATA : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL SFR_TRIG : STD_LOGIC_VECTOR (7 DOWNTO 0);
	
	   -- Clock period definitions
   constant clock_period : time := 333 ns;

BEGIN

   UUT: top_level PORT MAP(
		SIG_CLK => SIG_CLK, 
		SIG_MR => SIG_MR, 
		SIG_ADDRDAT => SIG_ADDRDAT, 
		RD => RD, 
		WR => WR, 
		ALE => ALE, 
		MEM_ADDR => MEM_ADDR, 
		ID => ID,
		SFR_CONFIG => SFR_CONFIG,
		TEST_STATUS_DATA => TEST_STATUS_DATA,
		SFR_TRIG => SFR_TRIG
   );

   -- Clock process definitions
   clock_process :process
   begin
		SIG_CLK <= '0';
		wait for clock_period/2;
		SIG_CLK <= '1';
		wait for clock_period/2;
   end process;
	
	
	-- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

     --Initial State
		SIG_MR <= '0';
		TEST_STATUS_DATA <= "10011010";
		
		wait for 1 us;

		SIG_MR <= '1';



      wait;
   end process;

END;
