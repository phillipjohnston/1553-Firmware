--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:02:28 11/05/2012
-- Design Name:   
-- Module Name:   C:/Users/Phillip/Downloads/MS1553_Interface/MS1553_Interface/MS1553_master_TB.vhd
-- Project Name:  MS1553_Interface
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MS1553_master
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
 
ENTITY MS1553_master_TB IS
END MS1553_master_TB;
 
ARCHITECTURE behavior OF MS1553_master_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MS1553_master
    PORT(
         ADDRESS : IN  std_logic_vector(15 downto 0);
         ALE : IN  std_logic;
         nWR : IN  std_logic;
         nRD : IN  std_logic;
         nIOM : IN  std_logic;
         CLOCK : IN  std_logic;
         DATA_VALID : IN  std_logic;
         DATA_IN_0 : IN  std_logic_vector(7 downto 0);
         DATA_IN_1 : IN  std_logic_vector(7 downto 0);
         ADDRESS_TO_CHIP : OUT  std_logic_vector(15 downto 0);
         DATA_OUT_0 : OUT  std_logic_vector(7 downto 0);
         DATA_OUT_1 : OUT  std_logic_vector(7 downto 0);
         nREAD : OUT  std_logic;
         nWRITE : OUT  std_logic;
         RESET_IC : OUT  std_logic;
         IS_BIG_ENDIAN : OUT  std_logic;
         MEM_TEST_EN : OUT  std_logic;
         RAM_ERROR_CORR_EN : OUT  std_logic;
         IDATA : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ADDRESS : std_logic_vector(15 downto 0) := (others => '0');
   signal ALE : std_logic := '0';
   signal nWR : std_logic := '0';
   signal nRD : std_logic := '0';
   signal nIOM : std_logic := '0';
   signal CLOCK : std_logic := '0';
   signal DATA_VALID : std_logic := '0';
   signal DATA_IN_0 : std_logic_vector(7 downto 0) := (others => '0');
   signal DATA_IN_1 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal ADDRESS_TO_CHIP : std_logic_vector(15 downto 0);
   signal DATA_OUT_0 : std_logic_vector(7 downto 0);
   signal DATA_OUT_1 : std_logic_vector(7 downto 0);
   signal nREAD : std_logic;
   signal nWRITE : std_logic;
   signal RESET_IC : std_logic;
   signal IS_BIG_ENDIAN : std_logic;
   signal MEM_TEST_EN : std_logic;
   signal RAM_ERROR_CORR_EN : std_logic;
   signal IDATA : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MS1553_master PORT MAP (
          ADDRESS => ADDRESS,
          ALE => ALE,
          nWR => nWR,
          nRD => nRD,
          nIOM => nIOM,
          CLOCK => CLOCK,
          DATA_VALID => DATA_VALID,
          DATA_IN_0 => DATA_IN_0,
          DATA_IN_1 => DATA_IN_1,
          ADDRESS_TO_CHIP => ADDRESS_TO_CHIP,
          DATA_OUT_0 => DATA_OUT_0,
          DATA_OUT_1 => DATA_OUT_1,
          nREAD => nREAD,
          nWRITE => nWRITE,
          RESET_IC => RESET_IC,
          IS_BIG_ENDIAN => IS_BIG_ENDIAN,
          MEM_TEST_EN => MEM_TEST_EN,
          RAM_ERROR_CORR_EN => RAM_ERROR_CORR_EN,
          IDATA => IDATA
        );

   -- Clock process definitions
   CLOCK_process :process
   begin
		CLOCK <= '0';
		wait for CLOCK_period/2;
		CLOCK <= '1';
		wait for CLOCK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      ADDRESS <= "1111000011110000";
		ALE <= '1';
		
		wait for 150 ns;
		
		ALE <= '0';
		nWR <= '0';
		nRD <= '1';
		
		ADDRESS(7 DOWNTO 0) <= "00001111";
		
		wait for 1000 ns;
		
		ADDRESS <= "1111000011110001";
		ALE <= '1';
		nWR <= '1';
		
		wait for 150 ns;
		
		ALE <= '0';
		nWR <= '0';
		nRD <= '1';
		
		ADDRESS(7 DOWNTO 0) <= "10100101";
		
		wait for 1000 ns;
		
		ALE <= '0';
		nWR <= '1';
		nRD <= '1';
		
		ADDRESS(15 DOWNTO 0) <= "0000000000000000";
		
		DATA_IN_0 <= "11110000";
		DATA_IN_1 <= "00001111";
		DATA_VALID <= '1';
		
		wait for 1000 ns;
		
		DATA_VALID <= '0';
		DATA_IN_0 <= "00001111";

      wait;
   end process;

END;
