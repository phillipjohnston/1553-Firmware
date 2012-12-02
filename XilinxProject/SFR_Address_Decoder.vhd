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


entity SFR_Address_Decoder is
    Port ( ADDR : in  STD_LOGIC_VECTOR (15 downto 0);
			  ALE : in STD_LOGIC;
			  WR : in STD_LOGIC;
			  RD : in STD_LOGIC;
           SEL : out  STD_LOGIC_VECTOR (15 downto 0);
			  RESET : IN STD_LOGIC
			  );
			  
end SFR_Address_Decoder;

architecture Behavioral of SFR_Address_Decoder is

	constant base_addr : STD_LOGIC_VECTOR(7 DOWNTO 0):= "01111111";
	SIGNAL ADDR_LATCHED : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	SIGNAL wrorrd_event : STD_LOGIC;
	SIGNAL activate : STD_LOGIC;
	
--	COMPONENT Latch16Bit IS
--		PORT(
--			data    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--			enable : IN STD_LOGIC;
--			clk	: IN STD_LOGIC;
--			q   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
--		);
--	END COMPONENT;
	
	COMPONENT d_ff_16bit is
		Port (  a : in  STD_LOGIC_VECTOR (15 downto 0);
				  en : in  STD_LOGIC;
				  clk : in  STD_LOGIC;
				  rst : in STD_LOGIC;
				  d_ff_out : out  STD_LOGIC_VECTOR (15 downto 0));
		end COMPONENT;
	
	
	

begin

	wrorrd_event <= WR OR RD; -- Latch data in when 
	activate <= NOT ((ALE AND (NOT RD AND NOT WR))); -- Data is not valid when ALE is high and RD or WR are low, valid otherwise
--	addr_L : Latch16Bit port map (data=>ADDR, enable => ALE, clk => wrorrd_event,q => ADDR_LATCHED);
	addr_L : d_ff_16bit port map (a=>ADDR, en => ALE, clk => wrorrd_event,rst => reset, d_ff_out => ADDR_LATCHED);

	--Activate the proper SFR line, depending on the address received
	--Only activate if data is valid
	WITH ADDR_LATCHED&activate SELECT
		SEL <= 	X"0001" 		WHEN base_addr & "00000000" & '1',
					X"0002" 		WHEN base_addr & "00000001" & '1',
					X"0004"		WHEN base_addr & "00000010" & '1',
					X"0008"		WHEN base_addr & "00000011" & '1',
					X"0010"		WHEN base_addr & "00000100" & '1',
					X"0020"		WHEN base_addr & "00000101" & '1',
					X"0040"		WHEN base_addr & "00000110" & '1',
					X"0080"		WHEN base_addr & "00000111" & '1',
					X"0100"		WHEN base_addr & "00001000" & '1',
					X"0200"		WHEN base_addr & "00001001" & '1',
					X"0400"		WHEN base_addr & "00001010" & '1',
					X"0800"		WHEN base_addr & "00001011" & '1',
					X"1000"		WHEN base_addr & "00001100" & '1',
					X"2000"		WHEN base_addr & "00001101" & '1',
					X"4000"		WHEN base_addr & "00001110" & '1',
					X"8000"		WHEN base_addr & "00001111" & '1',
					X"0000" 		WHEN OTHERS;
		

end Behavioral;

