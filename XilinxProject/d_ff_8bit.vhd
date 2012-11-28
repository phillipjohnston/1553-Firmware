----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:08:18 11/27/2012 
-- Design Name: 
-- Module Name:    d_ff_8bit - Behavioral 
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

entity d_ff_8bit is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           d_ff_out : out  STD_LOGIC_VECTOR (7 downto 0));
end d_ff_8bit;

architecture Behavioral of d_ff_8bit is

	signal q_sig : std_logic_vector (7 downto 0);

begin

	process(clk)
	begin 
		if (rising_edge(clk) and en = '1') then
			q_sig <= a;
		end if;
	end process;
	
	d_ff_out <= q_sig;
	
end Behavioral;

