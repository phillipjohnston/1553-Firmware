----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:59:52 11/03/2012 
-- Design Name: 
-- Module Name:    sfr_8_output_pulse - Behavioral 
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

entity sfr_8_output_pulse is
    Port ( 	DIN : in STD_LOGIC_VECTOR(7 DOWNTO 0);
				RE : in  STD_LOGIC;
				WE : in  STD_LOGIC;
				clock : in  STD_LOGIC;
				clear : in  STD_LOGIC;
				CS : in  STD_LOGIC;
				--Q : OUT  STD_LOGIC_VECTOR (7 downto 0);
				MTRUN : out std_logic;
				BCTRIG : out std_logic;
				TEST : out std_logic;
				DOUT : out  STD_LOGIC_VECTOR (7 downto 0));
end sfr_8_output_pulse;

architecture Behavioral of sfr_8_output_pulse is

	signal Q_internal : std_logic_vector(7 downto 0);
	signal re_cs : std_logic_vector(1 downto 0);

begin

	re_cs <= RE & CS;
	
	with re_cs select
		DOUT <= 	"00000000" when "11",
					"ZZZZZZZZ" when others;
	
	MTRUN <= Q_internal(7);	
	BCTRIG <= Q_internal(6);	
	TEST <= Q_internal(4);	
	

process(WE, clear, CS)
	begin
		if clear = '1' then
			Q_internal <= "00000000";
			
		elsif (WE = '0' and WE'event) then
				if(CS='1') then
					Q_internal <= DIN;
				end if;
				
		elsif (CS = '0' and CS'event) then
				Q_internal <= "00000000";

		

			
		
		
			
			--Use WE line to pulse output
			--IF WE = '1' AND CS = '1' THEN 
			--	Q_internal <= DIO;
			--ELSE
			--	Q_internal <= "00000000";
			--END IF;
		
			
			
		end if;
	end process;




end Behavioral;

