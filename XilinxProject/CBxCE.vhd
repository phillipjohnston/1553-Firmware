----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:15:27 11/27/2012 
-- Design Name: 
-- Module Name:    CBxCE - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cb4ce is
    Port ( 
		C : in  STD_LOGIC;
		CE : in  STD_LOGIC;
		CLR : in  STD_LOGIC;
		TC  : OUT STD_LOGIC;
		CEO : OUT STD_LOGIC
	 
	 );

end cb4ce;

architecture Behavioral of cb4ce is
	constant TERMINAL_COUNT : std_logic_vector(4-1 downto 0) := "1111";
	signal  Q : STD_LOGIC_VECTOR(4-1 downto 0);
	
	
	begin
		process(C, CLR)
			begin
			if (CLR='1') then
				Q <= (others => '0');
			elsif (C'event and C='1') then
				if (CE='1') then 
					Q <= Q+1;
				end if;
			end if;
		end process;
		
		process (Q)
			begin
			if (Q = TERMINAL_COUNT) then 
				TC <='1';
			else
				TC <='0';
			end if;
		end process;
		
		CEO<=TC and CE;
	
	end Behavioral;

