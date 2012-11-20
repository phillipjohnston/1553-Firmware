----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:01:25 11/04/2012 
-- Design Name: 
-- Module Name:    holt_mem_trans - Behavioral 
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


entity holt_mem_trans is
	PORT(
			--From Master
			ADDRESS_IN: in STD_LOGIC_VECTOR(15 DOWNTO 0);
			DATA_IN_0: in STD_LOGIC_VECTOR (7 DOWNTO 0);
			DATA_IN_1: in STD_LOGIC_VECTOR(7 DOWNTO 0);
			nRD : in STD_LOGIC;
			nWR : in STD_LOGIC;
			ALE : in STD_LOGIC;
			
			clock : in STD_LOGIC;
			
			--From Holt
			HWAIT : in STD_LOGIC;
	
			--To HOLT
			ADDRESS_OUT: out STD_LOGIC_VECTOR(15 DOWNTO 0);
			DATA : inout STD_LOGIC_VECTOR(7 DOWNTO 0) := "ZZZZZZZZ";
			nOE : out STD_LOGIC;
			nWE : out STD_LOGIC;
			nCE : out STD_LOGIC;
			
			--To Master
			DATA_RETURN_0: out STD_LOGIC_VECTOR(7 DOWNTO 0);
			DATA_RETURN_1 : out STD_LOGIC_VECTOR(7 DOWNTO 0);
			DATA_VALID_0 : out STD_LOGIC;
			DATA_VALID_1 : OUT STD_LOGIC
		);
end holt_mem_trans;

architecture Behavioral of holt_mem_trans is
	SIGNAL addr : STD_LOGIC_VECTOR(15 DOWNTO 0);
	--SIGNAL data_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	SIGNAL rCE : STD_LOGIC := '0';
	SIGNAL wCE : STD_LOGIC := '0';
	SIGNAL WE : STD_LOGIC := '0';
	SIGNAL OE : STD_LOGIC := '0';
	
	SIGNAL PROC_DATA_0 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	SIGNAL PROC_DATA_1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	
	SIGNAL OK_TO_BEGIN_WR, OK_TO_BEGIN_RD : STD_LOGIC := '0';
	
	SIGNAL HOLT_ADDR : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	
	SIGNAL rADDR : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	SIGNAL wADDR : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	
	SIGNAL wDATA : STD_LOGIC_VECTOR(7 DOWNTO 0) := "ZZZZZZZZ";
	
	SIGNAL h_d0_en, h_d1_en, p_d0_en, p_d1_en, addr_en : STD_LOGIC := '1';
	
	--SIGNAL rd_int, wr_int : STD_LOGIC := '0';
	
	SIGNAL DATA_VALID_int : STD_LOGIC := '0';
	
	COMPONENT Latch IS
		Port( data : IN STD_LOGIC;
				enable : IN STD_LOGIC;
					 q : out STD_LOGIC
					 );
	END COMPONENT;
	
	COMPONENT Latch8Bit IS
		PORT
		(
			data    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			enable : IN STD_LOGIC;
			q               : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
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
	
	COMPONENT mem_trans_writer IS
		PORT(
			ADDRESS_IN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			DATA_0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			DATA_1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			OK_TO_BEGIN_WR : IN STD_LOGIC;
			nWR : IN STD_LOGIC;
			CLOCK : IN STD_LOGIC;
			
			ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			
			DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			WE : OUT STD_LOGIC;
			CE : OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT mem_trans_reader IS
		PORT(
			ADDRESS_IN : STD_LOGIC_VECTOR(15 DOWNTO 0);
			OK_TO_BEGIN_RD: IN STD_LOGIC;
			nRD : IN STD_LOGIC;
			CLOCK : IN STD_LOGIC;
			
			ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			D0_LATCH : OUT STD_LOGIC;
			D1_LATCH : OUT STD_LOGIC;
			OE : OUT STD_LOGIC;
			CE : OUT STD_LOGIC
		);
	END COMPONENT;
	
begin
	
	reader: mem_trans_reader port map(HOLT_ADDR, OK_TO_BEGIN_RD, nRD, CLOCK,
												 rADDR, h_d0_en, h_d1_en, OE, rCE);
	writer: mem_trans_writer port map (HOLT_ADDR, PROC_DATA_0, PROC_DATA_1, OK_TO_BEGIN_WR, nWR, CLOCK,
												  wADDR, wDATA, WE, wCE);
	
	DATA_RETURN_0 <= DATA;
	DATA_RETURN_1 <= DATA;

	p_data0_L : Latch8Bit port map(DATA_IN_0, p_d0_en, PROC_DATA_0);
	p_data1_L : Latch8Bit port map(DATA_IN_1, p_d1_en, PROC_DATA_1);
	addr_L : Latch16Bit port map(addr, addr_en, HOLT_ADDR);
	
	--rd_L : Latch port map(nRD, addr_en, rd_int);
	--wr_L : Latch port map(nWR, addr_en, wr_int);
	
	nCE <= NOT rCE WHEN nRD = '0' ELSE NOT wCE;
	ADDRESS_OUT <= rADDR WHEN nRD = '0' ELSE wADDR;
	
	--DATA <= rDATA when rd_int = '0' ELSE 
	DATA <= wDATA when nWR = '0' ELSE
			  "ZZZZZZZZ";
	
	DATA_VALID_0 <= h_d0_en;
	DATA_VALID_1 <= h_d1_en;
	
	nWE <= NOT WE;
	nOE <= NOT OE;
	
	addr(15) <= '0'; --always ground
	addr(0) <= '0';
	
	addr(14 DOWNTO 1) <= ADDRESS_IN(14 DOWNTO 1) WHEN ADDRESS_IN(15) = '1' ELSE "00000000000000";
	
	addr_en <= '1' WHEN ADDRESS_IN(15) = '1' AND ADDRESS_IN(0) = '0' ELSE '0';
	
	--OK_TO_BEGIN_WR <= '1' WHEN p_d1_en = '1' AND wr_int = '0' ELSE '0';
	OK_TO_BEGIN_WR <= '1' WHEN ADDRESS_IN(15) = '1' AND ADDRESS_IN(0) = '1'
								 AND nWR = '0' AND ALE = '0' ELSE '0';
	OK_TO_BEGIN_RD <= '1' WHEN ADDRESS_IN(15) = '1' AND ADDRESS_IN(0) = '0' AND nRD = '0' ELSE '0';
	
	--When to enable the latch for D-IN-2
	PROCESS(DATA_IN_0, nWR, ALE)
	BEGIN
		IF(ADDRESS_IN(15) = '1' AND ADDRESS_IN(0) = '0' AND nWR = '0' AND ALE = '0')
		THEN
			p_d0_en <= '1';
		ELSE
			p_d0_en <= '0';
		END IF;
	END PROCESS;
	
	--When to enable the latch for D-IN-1
	PROCESS(DATA_IN_1, nWR, ALE)
	BEGIN
		IF(ADDRESS_IN(15) = '1' AND ADDRESS_IN(0) = '1' AND nWR = '0' AND ALE = '0')
		THEN
			p_d1_en <= '1';
		ELSE
			p_d1_en <= '0';
		END IF;
	END PROCESS;

	
end Behavioral;

