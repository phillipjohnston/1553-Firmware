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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
		
		--To Initializer Block
		RESET_IC: out STD_LOGIC;
		--IS_BIG_ENDIAN: out STD_LOGIC;
		--MEM_TEST_EN: out STD_LOGIC;
		--RAM_ERROR_CORR_EN: out STD_LOGIC;
		
		--To Processor
		IDATA : out STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
end MS1553_master;

architecture Behavioral of MS1553_master is
	signal ADDR_TEMP : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	signal PROC_DATA_0 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	signal PROC_DATA_1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	signal CHIP_DATA_0 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111111";
	signal CHIP_DATA_1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111111";
	signal ADDR_UPPER : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	signal ADDR_LOWER : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	signal nWR_INT, nRD_INT : STD_LOGIC := '0';
	signal pd0_en, pd1_en, au_en, al_en, nwr_en, nrd_en : STD_LOGIC := '0'; --cd0_en, cd1_en,
	
	SIGNAL RELEASE_DATA : STD_LOGIC := '0';
	SIGNAL DATA_WAS_VALID_1 : STD_LOGIC := '0';
	SIGNAL DATA_WAS_VALID_0 : STD_LOGIC := '0';
	
	SIGNAL ID_S : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	
	COMPONENT Latch8Bit IS
			Port(
				data   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				enable : IN STD_LOGIC;
				q      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
	END COMPONENT;
	
	COMPONENT Latch IS
		Port( data : IN STD_LOGIC;
				enable : IN STD_LOGIC;
					 q : out STD_LOGIC
					 );
	END COMPONENT;
	
	
	COMPONENT Latch16Bit IS
		PORT
		(
			data    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			enable : IN STD_LOGIC;
			q               : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
	
begin

	pd0_L : Latch8Bit port map (PROC_DATA_0, pd0_en, DATA_OUT_0);
	pd1_L : Latch8Bit port map (PROC_DATA_1, pd1_en, DATA_OUT_1);
	
	CHIP_DATA_0 <= DATA_IN_0 WHEN DATA_VALID_0 = '1';
	CHIP_DATA_1 <= DATA_IN_1 WHEN DATA_VALID_1 = '1';
	
	ADDR_TEMP <= ADDRESS WHEN ALE = '1';
	ADDRESS_TO_CHIP(15 DOWNTO 8) <= ADDR_UPPER WHEN au_en = '1';
	ADDRESS_TO_CHIP(7 DOWNTO 0) <= ADDR_LOWER WHEN al_en = '1';
	
	RESET_IC <= '1'; 
	
	nWRITE <= nWR;
	nREAD <= nRD;
	
	--For use aside from latched values
	--ADDR_TEMP <= ADDRESS WHEN ALE = '1';
	
	ADDR_UPPER <= ADDRESS(15 DOWNTO 8);
	ADDR_LOWER <= ADDRESS(7 DOWNTO 0);
	
	PROC_DATA_0 <= ADDRESS(7 DOWNTO 0);
	PROC_DATA_1 <= ADDRESS(7 DOWNTO 0);
	
	pd0_en <= '1' WHEN ALE = '0' AND ADDR_TEMP(15) = '1' and ADDR_TEMP(0) = '0' AND nWR = '0' ELSE '0';
	pd1_en <= '1' WHEN ALE = '0' AND ADDR_TEMP(15) = '1' AND ADDR_TEMP(0) = '1' AND nWR = '0' ELSE '0';
	
	--cd0_en <= '1' WHEN DATA_VALID_0 = '1' ELSE '0';
	--cd1_en <= '1' WHEN DATA_VALID_1 = '1' ELSE '0';
	
	--We only latch the upper address value
	au_en <= '1' WHEN ALE = '1' AND ADDR_TEMP(15) = '1' AND ADDR_TEMP(0) = '0' ELSE '0';
	al_en <= '1' WHEN ALE = '1' AND ADDR_TEMP(15) = '1' AND ADDR_TEMP(0) = '0' ELSE '0';
	
	--latch wr/rd on first addr.
	--nwr_en <= '1' WHEN ALE = '0' AND ADDR_TEMP(15) = '1' ELSE '0';
	--nrd_en <= '1' WHEN ALE = '0' AND ADDR_TEMP(15) = '1' ELSE '0';
	
	--ADD LOGIC FOR IDATA OUT
	IDATA <= CHIP_DATA_0 WHEN ADDR_TEMP(0) = '0' AND nRD = '0' ELSE --AND(DATA_VALID_0 = '1' OR DATA_WAS_VALID_0 = '1') ELSE
				CHIP_DATA_1 WHEN ADDR_TEMP(0) = '1' AND nRD = '0' ELSE --AND (DATA_VALID_1 = '1' OR DATA_WAS_VALID_1 = '1') ELSE
				"ZZZZZZZZ";
				
--	PROCESS(DATA_VALID_0, nRD, ADDR_TEMP, DATA_WAS_VALID_0)
--	BEGIN
--		IF(DATA_VALID_0 = '1' AND nRD = '0' AND ADDR_TEMP(0) = '0')
--		THEN
--			DATA_WAS_VALID_0 <= '1';
--		ELSIF(DATA_WAS_VALID_0 = '1' AND nRD = '0' AND ADDR_TEMP(0) = '0')
--		THEN
--			DATA_WAS_VALID_0 <= '1';
--		ELSE
--			DATA_WAS_VALID_0 <= '0';
--		END IF;	
--	END PROCESS;
--	
--	PROCESS(DATA_VALID_1, nRD, ADDR_TEMP, DATA_WAS_VALID_1)
--	BEGIN
--		IF(DATA_VALID_1 = '1' AND ADDR_TEMP(0) = '1')
--		THEN
--			DATA_WAS_VALID_1 <= '1';
--		ELSIF(DATA_VALID_1 = '1' AND ADDR_TEMP(0) = '0')
--		THEN
--			DATA_WAS_VALID_1 <= '1';
--		ELSIF(DATA_WAS_VALID_1 = '1' AND ADDR_TEMP(0) = '0')
--		THEN
--			DATA_WAS_VALID_1 <= '1';
--		ELSIF(DATA_WAS_VALID_1 = '1' AND ADDR_TEMP(0) = '1')
--		THEN
--			DATA_WAS_VALID_1 <= '1';
--		ELSIF(DATA_WAS_VALID_1 = '1' AND ALE = '0' AND nRD = '1')
--		THEN
--			DATA_WAS_VALID_1 <= '0';
--		ELSE
--			DATA_WAS_VALID_1 <= '0';
--		END IF;	
--	END PROCESS;
	

end Behavioral;

