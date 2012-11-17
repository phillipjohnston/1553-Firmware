----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:12:30 11/04/2012 
-- Design Name: 
-- Module Name:    holt_initializer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This module controls the pins THAT WILL NOT CHANGE IN OPERATION
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

entity holt_initializer is
	Port(
		RESET: in STD_LOGIC;
		--IS_BIG_ENDIAN: in STD_LOGIC;
		--MEM_TEST_EN: in STD_LOGIC;
		--RAM_ERR_CORR_EN: in STD_LOGIC;
		
		nMR: out STD_LOGIC; --Master Reset signal
		--MTSTOFF: out STD_LOGIC;
		--AUTOEN: out STD_LOGIC;
		--EECOPY: out STD_LOGIC;
		--BENDI: out STD_LOGIC;
		--RAMEDC: out STD_LOGIC;
		BWID: out STD_LOGIC;
		BTYPE: out STD_LOGIC;
		WPOL : out STD_LOGIC
	);
end holt_initializer;

architecture Behavioral of holt_initializer is	
begin

	--AUTOEN <= '0';
	
	--MTSTOFF <= MEM_TEST_EN; --Disable RAM memory test

	--EECOPY <= '0';
	--BENDI <= IS_BIG_ENDIAN;   --BigEndian
	--RAMEDC <= RAM_ERR_CORR_EN;
	
	BWID <= '0'; --8-bit mode
	
	BTYPE <= '1'; --Intel Style Access
	
	WPOL <= '1'; --WAIT is active high!
	
	nMR <= NOT RESET;

end Behavioral;

