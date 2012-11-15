----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:49:43 11/05/2012 
-- Design Name: 
-- Module Name:    MUX_8w_4d - Behavioral 
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

entity MUX_8w_4d is
    Port ( EN_A : in  STD_LOGIC;
			  EN_B : in  STD_LOGIC;
			  EN_C : in  STD_LOGIC;
			  EN_D : in  STD_LOGIC;
           PORTA : in  STD_LOGIC_VECTOR (7 downto 0);
           PORTB : in  STD_LOGIC_VECTOR (7 downto 0);
           PORTC : in  STD_LOGIC_VECTOR (7 downto 0);
			  PORTD : in  STD_LOGIC_VECTOR (7 downto 0);
           DOUT : out  STD_LOGIC_VECTOR (7 downto 0));
end MUX_8w_4d;

architecture Behavioral of MUX_8w_4d is
		
		signal dsel : std_logic_vector(3 downto 0);

begin

	dsel(0) <= EN_A;
	dsel(1) <= EN_B;
	dsel(2) <= EN_C;
	dsel(3) <= EN_D;

	with dsel select
		DOUT <= 	PORTA when "0001",
					PORTB when "0010",
					PORTC when "0100",
					PORTC when "1000",
					"ZZZZZZZZ" when others;


end Behavioral;

