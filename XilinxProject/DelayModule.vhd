----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:16:38 11/05/2012 
-- Design Name: 
-- Module Name:    DelayModule - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DelayModule is
    Port ( 
			  delay_en : in STD_LOGIC;
			  clock : in  STD_LOGIC;
           delay : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           flag : out  STD_LOGIC
			 );
end DelayModule;

architecture Behavioral of DelayModule is
	signal count : integer := 0;
begin

	PROCESS(clock, delay_en, count, delay)
	BEGIN
		if(clock'EVENT AND clock = '1' AND delay_en = '1')
		THEN
			count <= count + 1;
		END IF;

		IF(count = conv_integer(delay) AND delay_en = '1')
		THEN
			count <= 0;
			flag <= '1';
		ELSE
			flag <= '0';
		END IF;
	END PROCESS;

end Behavioral;

