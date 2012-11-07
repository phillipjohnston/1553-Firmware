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

ENTITY Latch IS
   PORT
   (
      data    : IN STD_LOGIC;
		enable : IN STD_LOGIC;
      q               : OUT STD_LOGIC
   );
END Latch;


ARCHITECTURE Behavioral OF Latch IS
BEGIN
latch_p : PROCESS (enable, data)
      BEGIN
         IF (enable = '1') THEN
            q <= data;
         END IF;
      END PROCESS latch_p;
END Behavioral;
