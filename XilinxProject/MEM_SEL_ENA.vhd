----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:26:34 11/07/2012 
-- Design Name: 
-- Module Name:    MEM_SEL_ENA - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM_SEL_ENA is
    Port ( ADDR : in  STD_LOGIC_VECTOR (15 downto 0);
           MEM_ENA : out  STD_LOGIC);
end MEM_SEL_ENA;

architecture Behavioral of MEM_SEL_ENA is


begin

	MEM_ENA <= 	'0' WHEN std_match("1-------",ADDR(15 DOWNTO 8)) ELSE
					'0' WHEN std_match("01111111",ADDR(15 DOWNTO 8)) ELSE
					'1';



end Behavioral;

