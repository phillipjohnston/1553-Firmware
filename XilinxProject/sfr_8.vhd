----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Curtis Mulady
-- 
-- Create Date:    17:50:41 11/02/2012 
-- Design Name: 
-- Module Name:    sfr_8 - Behavioral 
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

entity sfr_8 is
    Port ( DIO : inout  STD_LOGIC_VECTOR (7 downto 0);
           RE : in  STD_LOGIC;
           WE : in  STD_LOGIC;
			  CS : in STD_LOGIC;
			  clock : in STD_LOGIC;
			  clear : in STD_LOGIC;
			  Q : out STD_LOGIC_VECTOR (7 downto 0));
end sfr_8;

architecture Behavioral of sfr_8 is

	signal Q_internal : std_logic_vector(7 downto 0);
	signal Din_internal : std_logic_vector(7 downto 0);
	signal Dout_internal : std_logic_vector(7 downto 0);

begin

	process(clock, clear)
	begin
		if clear = '1' then
			Q_internal <= "00000000";
			
		elsif (clock='1' and clock'event) then
			
			IF RE = '1' AND CS = '1' THEN 
				DIO <= Q_internal;
			ELSE
				DIO <= "ZZZZZZZZ";
			END IF;
			
			IF WE = '1' AND CS = '1' THEN
				Q_internal <= DIO;
			END IF;
		
			
			
		end if;
	end process;

	Q <= Q_internal;

end Behavioral;

