--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:33:03 11/27/2012
-- Design Name:   
-- Module Name:   C:/Users/cmulady/Documents/GitHub/1553-Firmware/XilinxProject/holt_connect_tb.vhd
-- Project Name:  MS1553_Interface
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Holt_Connect
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
 
ENTITY holt_connect_tb IS
END holt_connect_tb;
 
ARCHITECTURE behavior OF holt_connect_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Holt_Connect
    PORT(
         ADDRESS_LATCHED : IN  std_logic_vector(15 downto 0);
         nWR_o : IN  std_logic;
         nRD_o : IN  std_logic;
         ALE_o : IN  std_logic;
         DATA_i_o_0 : IN  std_logic_vector(7 downto 0);
         DATA_i_o_1 : IN  std_logic_vector(7 downto 0);
         DATA_i_vo_0 : IN  std_logic;
         DATA_i_vo_1 : IN  std_logic;
         DATA_h_ack : IN  std_logic;
         fast_clk : IN  std_logic;
         slow_clock : IN  std_logic;
         reset : IN  std_logic;
         DATA_h_o_0 : OUT  std_logic_vector(7 downto 0);
         DATA_h_o_1 : OUT  std_logic_vector(7 downto 0);
         DATA_h_vo_0 : OUT  std_logic;
         DATA_h_vo_1 : OUT  std_logic;
         ADDRESS_HOLT : OUT  std_logic_vector(15 downto 0);
         DATA_HOLT : INOUT  std_logic_vector(15 downto 0);
         BWID : OUT  std_logic;
         BTYPE : OUT  std_logic;
         WPOL : OUT  std_logic;
         nCE : OUT  std_logic;
         nWE : OUT  std_logic;
         nOE : OUT  std_logic;
         nMR : OUT  std_logic;
         DATA_i_ack : OUT  std_logic;
         ACK_IRQ : OUT  std_logic;
         nIRQ : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ADDRESS_LATCHED : std_logic_vector(15 downto 0) := (others => '0');
   signal nWR_o : std_logic := '0';
   signal nRD_o : std_logic := '0';
   signal ALE_o : std_logic := '0';
   signal DATA_i_o_0 : std_logic_vector(7 downto 0) := (others => '0');
   signal DATA_i_o_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal DATA_i_vo_0 : std_logic := '0';
   signal DATA_i_vo_1 : std_logic := '0';
   signal DATA_h_ack : std_logic := '0';
   signal fast_clk : std_logic := '0';
   signal slow_clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal nIRQ : std_logic := '0';

	--BiDirs
   signal DATA_HOLT : std_logic_vector(15 downto 0);

 	--Outputs
   signal DATA_h_o_0 : std_logic_vector(7 downto 0);
   signal DATA_h_o_1 : std_logic_vector(7 downto 0);
   signal DATA_h_vo_0 : std_logic;
   signal DATA_h_vo_1 : std_logic;
   signal ADDRESS_HOLT : std_logic_vector(15 downto 0);
   signal BWID : std_logic;
   signal BTYPE : std_logic;
   signal WPOL : std_logic;
   signal nCE : std_logic;
   signal nWE : std_logic;
   signal nOE : std_logic;
   signal nMR : std_logic;
   signal DATA_i_ack : std_logic;
   signal ACK_IRQ : std_logic;

   -- Clock period definitions
   constant fast_clk_period : time := 10 ns;
   constant slow_clock_period : time := 320 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Holt_Connect PORT MAP (
          ADDRESS_LATCHED => ADDRESS_LATCHED,
          nWR_o => nWR_o,
          nRD_o => nRD_o,
          ALE_o => ALE_o,
          DATA_i_o_0 => DATA_i_o_0,
          DATA_i_o_1 => DATA_i_o_1,
          DATA_i_vo_0 => DATA_i_vo_0,
          DATA_i_vo_1 => DATA_i_vo_1,
          DATA_h_ack => DATA_h_ack,
          fast_clk => fast_clk,
          slow_clock => slow_clock,
          reset => reset,
          DATA_h_o_0 => DATA_h_o_0,
          DATA_h_o_1 => DATA_h_o_1,
          DATA_h_vo_0 => DATA_h_vo_0,
          DATA_h_vo_1 => DATA_h_vo_1,
          ADDRESS_HOLT => ADDRESS_HOLT,
          DATA_HOLT => DATA_HOLT,
          BWID => BWID,
          BTYPE => BTYPE,
          WPOL => WPOL,
          nCE => nCE,
          nWE => nWE,
          nOE => nOE,
          nMR => nMR,
          DATA_i_ack => DATA_i_ack,
          ACK_IRQ => ACK_IRQ,
          nIRQ => nIRQ
        );

   -- Clock process definitions
   fast_clk_process :process
   begin
		fast_clk <= '0';
		wait for fast_clk_period/2;
		fast_clk <= '1';
		wait for fast_clk_period/2;
   end process;
 
   slow_clock_process :process
   begin
		slow_clock <= '0';
		wait for slow_clock_period/2;
		slow_clock <= '1';
		wait for slow_clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset<='1';
		
		--init signals
		signal ADDRESS_LATCHED : std_logic_vector(15 downto 0) := (others => '0');
		signal nWR_o : std_logic := '0';
		signal nRD_o : std_logic := '0';
		signal ALE_o : std_logic := '0';
		signal DATA_i_o_0 : std_logic_vector(7 downto 0) := (others => '0');
		signal DATA_i_o_1 : std_logic_vector(7 downto 0) := (others => '0');
		signal DATA_i_vo_0 : std_logic := '0';
		signal DATA_i_vo_1 : std_logic := '0';
		signal DATA_h_ack : std_logic := '0';
		signal fast_clk : std_logic := '0';
		signal slow_clock : std_logic := '0';
		signal reset : std_logic := '0';
		signal nIRQ : std_logic := '0';
		
      wait for 400 ns;	
		reset<='0';

      wait for fast_clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
