----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:56:02 11/06/2012 
-- Design Name: 
-- Module Name:    mem_trans_writer - Behavioral 
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

entity mem_trans_writer is
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
end mem_trans_writer;

architecture Behavioral of mem_trans_writer is

	SIGNAL flag : std_logic := '0';
	SIGNAL delay_en : STD_LOGIC := '0';
	SIGNAL delay_needed : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000001100100"; -- 100 counts
	
	SIGNAL WRITING_STATE : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
	
	CONSTANT TWR : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000111"; --Roughly 55-65ns with 100MHz Clock
	CONSTANT TINACT : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000011"; --Roughly 25-30ns with 100MHz Clock
	
	component DelayModule IS
		port (delay_en, clock : in STD_LOGIC;
			   delay: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				flag : OUT STD_LOGIC
				);
	end component;
begin

	delay_inst : DelayModule port map(delay_en, clock, delay_needed,flag);

	--Writing Block
	PROCESS(OK_TO_BEGIN_WR, WRITING_STATE, flag) IS
	BEGIN
		CASE WRITING_STATE IS
			WHEN "000" =>
				--Not Begun
				ADDRESS <= "0000000000000000";
				WRITING_STATE <= "000";
				CE <= '0';
				WE <= '0';
				delay_en <= '0';
				delay_needed <= "0000000000000000";
				DATA <= "ZZZZZZZZ";
				
				IF(OK_TO_BEGIN_WR = '1')
				THEN
					WRITING_STATE <= "001";
				ELSE
					WRITING_STATE <= "000";
				END IF;
				
			WHEN "001" =>
				--First Write
				ADDRESS<= ADDRESS_IN;
				DATA <= DATA_0;
				delay_needed <= TWR;
				delay_en <= '1';
				CE <= '1';
				WE <= '1';
				WRITING_STATE <= "010";
				
			WHEN "010" =>
				--Tinact
				IF(flag = '1')
				THEN
					ADDRESS(15 DOWNTO 1) <= ADDRESS_IN(15 DOWNTO 1);
					ADDRESS(0) <= '1';
					delay_needed <= TINACT;
					delay_en <= '1';
					CE <= '1';
					WE <= '0';
					DATA <= "ZZZZZZZZ";
					WRITING_STATE <= "011";
				ELSE
					ADDRESS <= ADDRESS_IN;
					DATA <= DATA_0;
					delay_needed <= TWR;
					delay_en <= '1';
					CE <= '1';
					WE <= '1';
					WRITING_STATE <= "010";
				END IF;
			
			WHEN "011" =>
				--Second Write
				IF(flag = '1')
				THEN
					ADDRESS(15 DOWNTO 1) <= ADDRESS_IN(15 DOWNTO 1);
					ADDRESS(0) <= '1';
					delay_needed <= TWR;
					delay_en <= '1';
					CE <= '1';
					WE <= '1';
					DATA <= DATA_1;
					WRITING_STATE <= "100";
				ELSE
					ADDRESS(15 DOWNTO 1) <= ADDRESS_IN(15 DOWNTO 1);
					ADDRESS(0) <= '1';
					delay_needed <= TINACT;
					delay_en <= '1';
					CE <= '1';
					WE <= '0';
					DATA <= "ZZZZZZZZ";
					WRITING_STATE <= "011";
				END IF;
				
			WHEN "100" =>
				--Done writing
				IF(flag = '1')
				THEN
					ADDRESS <= "0000000000000000";
					DATA <= "ZZZZZZZZ";
					CE <= '0';
					WE <= '0';
					delay_en <= '0';
					delay_needed <= "0000000000000000";
					WRITING_STATE <= "110";
				ELSE
					ADDRESS(15 DOWNTO 1) <= ADDRESS_IN(15 DOWNTO 1);
					ADDRESS(0) <= '1';
					delay_needed <= TWR;
					delay_en <= '1';
					CE <= '1';
					WE <= '1';
					DATA <= DATA_1;
					WRITING_STATE <= "100";
				END IF;
			WHEN "110" =>
				IF(nWR = '0')
				THEN
					ADDRESS <= "0000000000000000";
					DATA <= "ZZZZZZZZ";
					CE <= '0';
					WE <= '0';
					delay_en <= '0';
					delay_needed <= "0000000000000000";
					WRITING_STATE <= "110";
				ELSE
					ADDRESS <= "0000000000000000";
					DATA <= "ZZZZZZZZ";
					CE <= '0';
					WE <= '0';
					delay_en <= '0';
					delay_needed <= "0000000000000000";
					WRITING_STATE <= "000";
				END IF;
				
			WHEN OTHERS =>
				ADDRESS <= "0000000000000000";
				DATA <= "ZZZZZZZZ";
				WRITING_STATE <= "000";
				CE <= '0';
				WE <= '0';
				delay_en <= '0';
				delay_needed <= "0000000000000000";
		END CASE;
	END PROCESS;
	
end Behavioral;

