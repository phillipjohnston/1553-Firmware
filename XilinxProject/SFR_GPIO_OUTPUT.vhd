----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:42:23 11/03/2012 
-- Design Name: 
-- Module Name:    sfr_8_output - Behavioral 
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

entity sfr_GPIO_OUTPUT is
    Port ( DIN: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
           RE : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           CS : in  STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (7 downto 0);
			  Q : out STD_LOGIC_VECTOR (7 DOWNTO 0)
			  );
end sfr_GPIO_OUTPUT;

architecture Behavioral of sfr_GPIO_OUTPUT is

	signal Q_internal : std_logic_vector(7 downto 0);
	signal re_cs : std_logic_vector(1 downto 0);
	constant initial_state : std_logic_vector(7 downto 0) := "00000000";

begin

	
	re_cs <= RE & CS;
	
	with re_cs select
		DOUT <= Q_internal when "11",
					"ZZZZZZZZ" when others;
	
	Q <= Q_internal;
	
	

	process(WE,clear)
		begin
		
		if clear = '1' then
			Q_internal <= initial_state;
			
		elsIF WE = '0'  AND WE'EVENT AND CS = '1' THEN
			Q_internal <= DIN;
				
		
			
			
		end if;
	end process;
	

end Behavioral;

