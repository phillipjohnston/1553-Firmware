--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:15:41 11/05/2012
-- Design Name:   
-- Module Name:   C:/Users/Phillip/Downloads/MS1553_Interface/MS1553_Interface/MS1553_Reset_Pulse_Gen_TB.vhd
-- Project Name:  MS1553_Interface
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MS1553_Reset_Pulse_Gen
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
 
ENTITY MS1553_Reset_Pulse_Gen_TB IS
END MS1553_Reset_Pulse_Gen_TB;
 
ARCHITECTURE behavior OF MS1553_Reset_Pulse_Gen_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MS1553_Reset_Pulse_Gen
    PORT(
         ResetGo : IN  std_logic;
         clock : IN  std_logic;
         ResetOut : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ResetGo : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal ResetOut : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MS1553_Reset_Pulse_Gen PORT MAP (
          ResetGo => ResetGo,
          clock => clock,
          ResetOut => ResetOut
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
		
		ResetGo <= '1';
		
		wait for 500ns;
		
		ResetGo <= '0';
		
		wait for 100 ns;
		
		ResetGo <= '1';

      wait;
   end process;

END;
