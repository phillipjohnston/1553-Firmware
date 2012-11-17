----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:25:30 11/07/2012 
-- Design Name: 
-- Module Name:    tri_buf_8 - Behavioral 
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

entity tri_buf_8 is
    Port ( DIN : in  STD_LOGIC_VECTOR (7 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (7 downto 0);
           EN : in  STD_LOGIC);
end tri_buf_8;

architecture Behavioral of tri_buf_8 is

begin

	with EN select
		DOUT <= 	"ZZZZZZZZ" 	WHEN '0',
					DIN			WHEN others;

end Behavioral;

