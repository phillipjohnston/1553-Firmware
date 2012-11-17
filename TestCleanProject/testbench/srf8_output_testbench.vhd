--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:04:17 11/07/2012
-- Design Name:   
-- Module Name:   C:/Users/cmulady/Documents/XILINX/i8085_test/srf8_output_testbench.vhd
-- Project Name:  i8085_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sfr_8_output
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY srf8_output_testbench IS
END srf8_output_testbench;
 
ARCHITECTURE behavior OF srf8_output_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sfr_8_output
    PORT(
         DIN : IN  std_logic_vector(7 downto 0);
         RE : IN  std_logic;
         WE : IN  std_logic;
         clock : IN  std_logic;
         clear : IN  std_logic;
         CS : IN  std_logic;
         Q : OUT  std_logic_vector(7 downto 0);
         DOUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DIN : std_logic_vector(7 downto 0) := (others => '0');
   signal RE : std_logic := '0';
   signal WE : std_logic := '0';
   signal clock : std_logic := '0';
   signal clear : std_logic := '0';
   signal CS : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(7 downto 0);
   signal DOUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 333 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sfr_8_output PORT MAP (
          DIN => DIN,
          RE => RE,
          WE => WE,
          clock => clock,
          clear => clear,
          CS => CS,
          Q => Q,
          DOUT => DOUT
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

     --Initial State
		clear <= '1';
		DIN <= "ZZZZZZZZ";
		RE <= '0';
		WE <= '0';
		CS <= '0';
		
		wait for 1 us;

		clear <= '0';
		
		wait for 2 us;
		RE <= '1';
		wait for 1 us;
		RE <= '0';
		
		wait for 2 us;
		RE <= '1';
		CS <= '1';
		wait for 1 us;
		RE <= '0';
		CS <= '0';
		
		wait for 1 us;
		DIN <= x"76";
		
		wait for 5 us;
		WE <= '1';
		wait for 1 us;
		WE <= '0';
		
		wait for 2 us;
		RE <= '1';
		CS <= '1';
		wait for 1 us;
		RE <= '0';
		CS <= '0';
		
		wait for 5 us;
		WE <= '1';
		CS <= '1';
		wait for 1 us;
		WE <= '0';
		CS <= '0';
		
		wait for 2 us;
		RE <= '1';
		CS <= '1';
		wait for 1 us;
		RE <= '0';
		CS <= '0';

		

      wait;
   end process;

END;
