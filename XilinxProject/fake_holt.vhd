----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:11:12 11/28/2012 
-- Design Name: 
-- Module Name:    fake_holt - Behavioral 
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

entity fake_holt is
    Port ( ADDR : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
           nOE : in  STD_LOGIC;
           nCE : in  STD_LOGIC;
           hWAIT : out  STD_LOGIC);
end fake_holt;

architecture Behavioral of fake_holt is

begin


end Behavioral;

