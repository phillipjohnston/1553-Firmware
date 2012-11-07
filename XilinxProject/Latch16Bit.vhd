----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:01:04 11/06/2012 
-- Design Name: 
-- Module Name:    Latch16Bit - Behavioral 
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

ENTITY Latch16Bit IS
   PORT
   (
		data    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      enable : IN STD_LOGIC;
      q               : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
   );
END Latch16Bit;


ARCHITECTURE Behavioral OF Latch16Bit IS
BEGIN

latch_p : PROCESS (enable, data)
      BEGIN
         IF (enable = '1') THEN
            q <= data;
         END IF;
      END PROCESS latch_p;
END Behavioral;


