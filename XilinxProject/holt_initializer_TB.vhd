--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:37:00 11/05/2012
-- Design Name:   
-- Module Name:   C:/Users/Phillip/Downloads/MS1553_Interface/MS1553_Interface/holt_initializer_TB.vhd
-- Project Name:  MS1553_Interface
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: holt_initializer
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
 
ENTITY holt_initializer_TB IS
END holt_initializer_TB;
 
ARCHITECTURE behavior OF holt_initializer_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT holt_initializer
    PORT(
         RESET : IN  std_logic;
         IS_BIG_ENDIAN : IN  std_logic;
         MEM_TEST_EN : IN  std_logic;
         RAM_ERR_CORR_EN : IN  std_logic;
         clock : IN  std_logic;
         nMR : OUT  std_logic;
         TXINHA : OUT  std_logic;
         TXINHB : OUT  std_logic;
         MTSTOFF : OUT  std_logic;
         AUTOEN : OUT  std_logic;
         EECOPY : OUT  std_logic;
         BENDI : OUT  std_logic;
         RAMEDC : OUT  std_logic;
         TEST : OUT  std_logic;
         BWID : OUT  std_logic;
         BTYPE : OUT  std_logic;
         WPOL : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RESET : std_logic := '0';
   signal IS_BIG_ENDIAN : std_logic := '0';
   signal MEM_TEST_EN : std_logic := '0';
   signal RAM_ERR_CORR_EN : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal nMR : std_logic;
   signal TXINHA : std_logic;
   signal TXINHB : std_logic;
   signal MTSTOFF : std_logic;
   signal AUTOEN : std_logic;
   signal EECOPY : std_logic;
   signal BENDI : std_logic;
   signal RAMEDC : std_logic;
   signal TEST : std_logic;
   signal BWID : std_logic;
   signal BTYPE : std_logic;
   signal WPOL : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: holt_initializer PORT MAP (
          RESET => RESET,
          IS_BIG_ENDIAN => IS_BIG_ENDIAN,
          MEM_TEST_EN => MEM_TEST_EN,
          RAM_ERR_CORR_EN => RAM_ERR_CORR_EN,
          clock => clock,
          nMR => nMR,
          TXINHA => TXINHA,
          TXINHB => TXINHB,
          MTSTOFF => MTSTOFF,
          AUTOEN => AUTOEN,
          EECOPY => EECOPY,
          BENDI => BENDI,
          RAMEDC => RAMEDC,
          TEST => TEST,
          BWID => BWID,
          BTYPE => BTYPE,
          WPOL => WPOL
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
		RESET <= '0';
      wait for 100 ns;	

		RESET <= '1';
      wait for clock_period*10;
		RESET <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
