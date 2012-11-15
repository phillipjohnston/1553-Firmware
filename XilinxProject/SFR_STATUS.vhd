----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:27:51 11/03/2012 
-- Design Name: 
-- Module Name:    sfr_8_input - Behavioral 
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

entity sfr_8_input is
    Port ( DOUT : out  STD_LOGIC_VECTOR (7 downto 0);
           RE : in  STD_LOGIC;
           CS : in  STD_LOGIC;
           clock : in  STD_LOGIC;
			  ACTIVE : IN STD_LOGIC;
			  MTPKRDY : IN STD_LOGIC;
			  READY : IN STD_LOGIC;
			  nRT1MC8 : IN STD_LOGIC
           --Q : in  STD_LOGIC_VECTOR(7 DOWNTO 0) 
			  );
end sfr_8_input;

architecture Behavioral of sfr_8_input is

	signal Q_internal : std_logic_vector(7 downto 0);
	signal Q : std_logic_vector(7 downto 0);
	signal re_cs : std_logic_vector(1 DOWNTO 0);

begin

	re_cs <= RE & CS;
	
	with re_cs select
			DOUT <= 	Q_internal when  "11",
						"ZZZZZZZZ" when others;
						
	Q(7) <= ACTIVE;
	Q(6) <= MTPKRDY;
	Q(5) <= READY;
	Q(4) <= nRT1MC8;

	process(clock)
	begin
	

			
		if (clock='1' and clock'event) then
		
			Q_internal <= Q;
			
		end if;
	end process;


end Behavioral;

