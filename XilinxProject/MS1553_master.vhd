----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:17:16 11/04/2012 
-- Design Name: 
-- Module Name:    MS1553_master - Behavioral 
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

entity MS1553_master is
	PORT(
		--From Processor
		ADDRESS: in STD_LOGIC_VECTOR(15 DOWNTO 0);
		ALE: in STD_LOGIC;
		nWR: in STD_LOGIC;
		nRD: in STD_LOGIC;
		nIOM: in STD_LOGIC;
		CLOCK: in STD_LOGIC;
		
		--From Mem Transfer Block
		DATA_VALID_0 : in STD_LOGIC;
		DATA_VALID_1 : in STD_LOGIC;
		DATA_IN_0 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
		DATA_IN_1 : in STD_LOGIC_VECTOR(7 DOWNTO 0);
		
		--To Mem Transfer Block
		ADDRESS_TO_CHIP : out STD_LOGIC_VECTOR(15 DOWNTO 0);
		DATA_OUT_0 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
		DATA_OUT_1 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
		nREAD : out STD_LOGIC;
		nWRITE : out STD_LOGIC;
		ALE_OUT : OUT STD_LOGIC;
		
		--To Initializer Block
		RESET_IC: out STD_LOGIC;
		
		--To Processor
		IDATA : out STD_LOGIC_VECTOR(7 DOWNTO 0)
		
	);
end MS1553_master;

architecture Behavioral of MS1553_master is
	signal ADDR_TEMP : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	signal CHIP_DATA_0 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	signal CHIP_DATA_1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	signal addr_en : STD_LOGIC := '0';
	
begin
	
	DATA_OUT_0 <= ADDRESS(7 DOWNTO 0);
	DATA_OUT_1 <= ADDRESS(7 DOWNTO 0);
	
	CHIP_DATA_0 <= DATA_IN_0 WHEN DATA_VALID_0 = '1';
	CHIP_DATA_1 <= DATA_IN_1 WHEN DATA_VALID_1 = '1';
	
	ADDR_TEMP <= ADDRESS WHEN ALE = '1';
	
	ALE_OUT <= ALE;
	
	ADDRESS_TO_CHIP <= ADDR_TEMP WHEN addr_en = '1';
	
	RESET_IC <= '1'; 
	
	nWRITE <= nWR WHEN ADDR_TEMP(15) = '1' ELSE '1';
	nREAD <= nRD WHEN ADDR_TEMP(15) = '1' ELSE '1';
	
	--We only latch the upper address value
	addr_en <= '1' WHEN ALE = '1' AND ADDRESS(15) = '1' ELSE '0'; --AND ADDRESS(0) = '0' ELSE '0';
	
	--ADD LOGIC FOR IDATA OUT
	IDATA <= CHIP_DATA_0 WHEN ADDR_TEMP(15) = '1' AND ADDR_TEMP(0) = '0' AND nRD = '0' ELSE --AND(DATA_VALID_0 = '1' OR DATA_WAS_VALID_0 = '1') ELSE
				CHIP_DATA_1 WHEN ADDR_TEMP(15) = '1' AND ADDR_TEMP(0) = '1' AND nRD = '0' ELSE --AND (DATA_VALID_1 = '1' OR DATA_WAS_VALID_1 = '1') ELSE
				"ZZZZZZZZ";	

end Behavioral;

