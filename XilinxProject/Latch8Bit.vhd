----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:16:08 11/05/2012 
-- Design Name: 
-- Module Name:    Latch8Bit - Behavioral 
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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:11:37 11/05/2012 
-- Design Name: 
-- Module Name:    Latch - Behavioral 
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

ENTITY Latch8Bit IS
   PORT
   (
		data    : IN STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111111";
      enable : IN STD_LOGIC := '1';
      q               : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111111"
   );
END Latch8Bit;


ARCHITECTURE Behavioral OF Latch8Bit IS
BEGIN

latch_p : PROCESS (enable, data)
      BEGIN
         IF (enable = '1') THEN
            q <= data;
         END IF;
      END PROCESS latch_p;
END Behavioral;


