----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:58:41 11/05/2012 
-- Design Name: 
-- Module Name:    ibuf7 - Behavioral 
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

entity ibuf7 is
    Port ( I : in  STD_LOGIC_VECTOR (6 downto 0);
           O : out  STD_LOGIC_VECTOR (6 downto 0));
end ibuf7;

architecture Behavioral of ibuf7 is

begin

	O <= I;

end Behavioral;

