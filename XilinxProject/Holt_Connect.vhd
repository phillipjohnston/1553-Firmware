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
library UNISIM;
use UNISIM.VComponents.all;

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
		SIGNAL DAT_L_VAL_LAT : STD_LOGIC;
		SIGNAL DAT_H_VAL_LAT : STD_LOGIC;
		SIGNAL DATA_i_ACK_int : STD_LOGIC;
		SIGNAL DATA_i_ACK_int_postlatch : STD_LOGIC;
		SIGNAL nDAT_L_VAL,nDAT_H_VAL : STD_LOGIC;

		COMPONENT Latch16Bit IS
		PORT(
			data    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			enable : IN STD_LOGIC;
			clk	: IN STD_LOGIC;
			q   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
		END COMPONENT;
		
		COMPONENT Latch8BitCER IS
		PORT(
			data    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			enable : IN STD_LOGIC;
			clk	: IN STD_LOGIC;
			rst : IN STD_LOGIC;
			q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
		END COMPONENT;
		
		COMPONENT FDCE IS
		PORT(
			D : in STD_LOGIC;
			CE : in STD_LOGIC;
			C : in STD_LOGIC;
			CLR : in STD_LOGIC;
			Q : out STD_LOGIC
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
	--latch in valid signal
	dataL_val_lat : FDCE port map(D =>'1', CE=>DATA_i_vo_0, C=>nSCLK, CLR=> DATA_i_ACK_int_postlatch, Q=>DAT_L_VAL_LAT);
	dataH_val_lat : FDCE port map(D =>'1', CE=>DATA_i_vo_1, C=>nSCLK, CLR=> DATA_i_ACK_int_postlatch, Q=>DAT_H_VAL_LAT);
	--use latched valid signal to latch data

	dat_input_i8085_L_lat: Latch8BitCER port map (data=>DATA_i_o_0, enable => DATA_i_vo_0, clk =>  DAT_L_VAL_LAT,rst => reset,q => DATA_i8085_L_LAT);
	dat_input_i8085_H_lat: Latch8BitCER port map (data=>DATA_i_o_1, enable => DATA_i_vo_1, clk =>  DAT_L_VAL_LAT,rst => reset,q => DATA_i8085_H_LAT);
	DATA_HOLT(7 DOWNTO 0) <= DATA_i8085_L_LAT;
	DATA_HOLT(15 DOWNTO 8) <= DATA_i8085_H_LAT;
	--ack once both valids are high
	data_ack_lat : FDCE port map(D =>DATA_i_ack_int, CE=>'1', C=>FAST_CLK, CLR=> reset, Q=>DATA_i_ACK_int_postlatch);
	DATA_i_ack_int <= DAT_H_VAL_LAT AND DAT_L_VAL_LAT;
	DATA_i_ACK <= DATA_i_ACK_int_postlatch;
	
	
	--Get first address and latch it onto the ADDRESS_HOLT bus
	adr_input_i8085_lat: Latch16Bit port map (data=>ADDRESS_LATCHED, enable => '1', clk => DATA_i_vo_0,q => pre_ADDRESS_HOLT);
	ADDRESS_HOLT(14 DOWNTO 1) <= pre_ADDRESS_HOLT(14 DOWNTO 1);
	ADDRESS_HOLT(15) <= '0';
	ADDRESS_HOLT(0) <= '0';
	
	

end Behavioral;

