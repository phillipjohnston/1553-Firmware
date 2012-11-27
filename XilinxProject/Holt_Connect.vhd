----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:48:00 11/27/2012 
-- Design Name: 
-- Module Name:    Holt_Connect - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Holt_Connect is
    Port ( ADDRESS_LATCHED : in  STD_LOGIC_VECTOR (15 downto 0);
           nWR_o : in  STD_LOGIC;
           nRD_o : in  STD_LOGIC;
           ALE_o : in  STD_LOGIC;
           DATA_i_o_0 : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA_i_o_1 : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA_i_vo_0 : in  STD_LOGIC;
           DATA_i_vo_1 : in  STD_LOGIC;
           DATA_h_ack : in  STD_LOGIC;
			  
           fast_clk : in  STD_LOGIC;
			  slow_clock: in STD_LOGIC;
           reset : in  STD_LOGIC;
			  
           DATA_h_o_0 : out  STD_LOGIC_VECTOR (7 downto 0);
           DATA_h_o_1 : out  STD_LOGIC_VECTOR (7 downto 0);
           DATA_h_vo_0 : out  STD_LOGIC;
           DATA_h_vo_1 : out  STD_LOGIC;
			  
			  --holt com busses
           ADDRESS_HOLT : out  STD_LOGIC_VECTOR (15 downto 0);
           DATA_HOLT : inout  STD_LOGIC_VECTOR (15 downto 0);
			  
			  --config signals
           BWID : out  STD_LOGIC;
           BTYPE : out  STD_LOGIC;
           WPOL : out  STD_LOGIC;
			  
			  --control signals
           nCE : out  STD_LOGIC;
           nWE : out  STD_LOGIC;
           nOE : out  STD_LOGIC;
           nMR : out  STD_LOGIC;
			  
           DATA_i_ack : out  STD_LOGIC;
			  
			  --unuzed
           ACK_IRQ : out  STD_LOGIC;
           nIRQ : in  STD_LOGIC);
end Holt_Connect;

architecture Behavioral of Holt_Connect is

		SIGNAL DATA_i8085_L_LAT : STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL DATA_i8085_H_LAT : STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL pre_ADDRESS_HOLT : STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL nSCLK : STD_LOGIC;

		COMPONENT Latch16Bit IS
		PORT(
			data    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			enable : IN STD_LOGIC;
			clk	: IN STD_LOGIC;
			q   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
		END COMPONENT;
		
		COMPONENT Latch8BitCE IS
		PORT(
			data    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			enable : IN STD_LOGIC;
			clk	: IN STD_LOGIC;
			q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
		END COMPONENT;

begin
	
	--set hard config signals
	--16 bit width
	BWID <= '1';
	--intel style com
	BTYPE <= '1';
	--active low wait signal
	WPOL <= '0';
	
	--Other Signal Defines
	nSCLK <= NOT SLOW_CLOCK;
	
	
	--Writes--
	
	--As data comes in from i8085_Connect, latch it onto the DATA_HOLT bus
	dat_input_i8085_L_lat: Latch8BitCE port map (data=>DATA_i_o_0, enable => DATA_i_vo_0, clk =>  nSCLK,q => DATA_i8085_L_LAT);
	dat_input_i8085_H_lat: Latch8BitCE port map (data=>DATA_i_o_1, enable => DATA_i_vo_1, clk =>  nSCLK,q => DATA_i8085_H_LAT);
	DATA_HOLT(7 DOWNTO 0) <= DATA_i8085_L_LAT;
	DATA_HOLT(15 DOWNTO 8) <= DATA_i8085_H_LAT;
	--Get first address and latch it onto the ADDRESS_HOLT bus
	adr_input_i8085_lat: Latch16Bit port map (data=>ADDRESS_LATCHED, enable => '1', clk => DATA_i_vo_0,q => pre_ADDRESS_HOLT);
	ADDRESS_HOLT(14 DOWNTO 1) <= pre_ADDRESS_HOLT(14 DOWNTO 1);
	ADDRESS_HOLT(15) <= '0';
	ADDRESS_HOLT(0) <= '0';
	
	

end Behavioral;

