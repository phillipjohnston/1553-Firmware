----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:05:21 11/06/2012 
-- Design Name: 
-- Module Name:    SFR_Address_Decoder - Behavioral 
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

entity SFR_Address_Decoder is
    Port ( ADDR : in  STD_LOGIC_VECTOR (15 downto 0);
			  ALE : in STD_LOGIC;
			  WR : in STD_LOGIC;
			  RD : in STD_LOGIC;
           SEL : out  STD_LOGIC_VECTOR (15 downto 0)
			  
			  );
			  
end SFR_Address_Decoder;

architecture Behavioral of SFR_Address_Decoder is

	constant base_addr : STD_LOGIC_VECTOR(7 DOWNTO 0):= "01111111";
	SIGNAL ADDR_LATCHED : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	SIGNAL wrorrd_event : STD_LOGIC;
	
	COMPONENT Latch16Bit IS
		PORT(
			data    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			enable : IN STD_LOGIC;
			clk	: IN STD_LOGIC;
			q   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	

begin

	wrorrd_event <= WR OR RD;
	addr_L : Latch16Bit port map (data=>ADDR, enable => ALE, clk => wrorrd_event,q => ADDR_LATCHED);

	WITH ADDR_LATCHED SELECT
		SEL <= 	X"0001" 		WHEN base_addr & "00000000",
					X"0002" 		WHEN base_addr & "00000001",
					X"0004"		WHEN base_addr & "00000010",
					X"0008"		WHEN base_addr & "00000011",
					X"0010"		WHEN base_addr & "00000100",
					X"0020"		WHEN base_addr & "00000101",
					X"0040"		WHEN base_addr & "00000110",
					X"0080"		WHEN base_addr & "00000111",
					X"0100"		WHEN base_addr & "00001000",
					X"0200"		WHEN base_addr & "00001001",
					X"0400"		WHEN base_addr & "00001010",
					X"0800"		WHEN base_addr & "00001011",
					X"1000"		WHEN base_addr & "00001100",
					X"2000"		WHEN base_addr & "00001101",
					X"4000"		WHEN base_addr & "00001110",
					X"8000"		WHEN base_addr & "00001111",
					X"0000" 		WHEN OTHERS;
		

end Behavioral;

