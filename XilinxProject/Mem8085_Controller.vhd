----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:47:14 11/07/2012 
-- Design Name: 
-- Module Name:    Mem8085_Controller - Behavioral 
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

entity Mem8085_Controller is
	PORT(
		ADDRESS_IN : STD_LOGIC_VECTOR(15 DOWNTO 0);
		ALE : IN STD_LOGIC;
		nWR : IN STD_LOGIC;
		nRD : IN STD_LOGIC;
		nIOM : IN STD_LOGIC;
		
		ADDRESS_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		DATA_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		ENA : OUT STD_LOGIC;
		WEA : OUT STD_LOGIC
	);
		
end Mem8085_Controller;

architecture Behavioral of Mem8085_Controller is

	SIGNAL ADDR : STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	SIGNAL ADDR_VALID : STD_LOGIC := '0';

	COMPONENT Latch8Bit IS
		PORT(
			data    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			enable : IN STD_LOGIC;
			q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
begin
	addrlow_L : Latch8Bit port map (ADDRESS_IN(7 DOWNTO 0), ALE, ADDR(7 DOWNTO 0));

	ADDR(15 DOWNTO 8) <= ADDRESS_IN(15 DOWNTO 8);
	
	DATA_OUT <= ADDRESS_IN(7 DOWNTO 0) WHEN ALE = '0' AND nIOM = '0' AND nWR = '0' AND ADDR_VALID = '1' ELSE "00000000";
	ADDRESS_OUT <= ADDR WHEN ALE = '0' AND nIOM = '0' AND ADDR_VALID = '1' ELSE "0000000000000000";
		
	
	ENA <= NOT nIOM WHEN ADDR_VALID = '1' ELSE '0';
	WEA <= '1' WHEN nWR = '0' ELSE '0';
	
	ADDR_VALID <= '1' WHEN	ADDR < "0111111100000000" AND nIOM = '0' AND ALE = '0' ELSE '0';
		
end Behavioral;

