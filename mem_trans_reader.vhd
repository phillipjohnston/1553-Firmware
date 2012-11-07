----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:56:14 11/06/2012 
-- Design Name: 
-- Module Name:    mem_trans_reader - Behavioral 
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

entity mem_trans_reader is
	PORT(
		ADDRESS_IN : STD_LOGIC_VECTOR(15 DOWNTO 0);
		OK_TO_BEGIN_RD: IN STD_LOGIC;
		nRD : IN STD_LOGIC;
		CLOCK : IN STD_LOGIC;
		
		ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		D0_LATCH : OUT STD_LOGIC;
		D1_LATCH : OUT STD_LOGIC;
		OE : OUT STD_LOGIC;
		CE : OUT STD_LOGIC
		--DATA_0_VALID : OUT STD_LOGIC;
		
	);
end mem_trans_reader;

architecture Behavioral of mem_trans_reader is

	SIGNAL flag : std_logic := '0';
	SIGNAL delay_en : STD_LOGIC := '0';
	SIGNAL delay_needed : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000001100100"; -- 100 counts
	
	SIGNAL READING_STATE : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
	
	SIGNAL OE_int : STD_LOGIC := '0';
	
	CONSTANT TINACT : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000011"; --Roughly 25-30ns with 100MHz Clock
	CONSTANT TSRS : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000111"; --Roughly 55-65ns with 100MHz Clock
	CONSTANT TNSR : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000010000"; --Roughly 110ns with 100MHz Clock

	component DelayModule IS
		port (delay_en, clock : in STD_LOGIC;
			   delay: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				flag : OUT STD_LOGIC
				);
	end component;
begin
	
	delay_inst : DelayModule port map(delay_en, clock, delay_needed,flag);
	
	OE <= OE_int;

	--Reading Block
	PROCESS(OK_TO_BEGIN_RD, READING_STATE, flag)
	BEGIN
		CASE READING_STATE IS
			WHEN "000" =>
				--Not doing anything
				READING_STATE <= "000";
				CE <= '0';
				OE_int <= '0';
				delay_en <= '0';
				ADDRESS <= "ZZZZZZZZZZZZZZZZ";
				--DATA_VALID <= '0';
				DATA <= "ZZZZZZZZ";
				
				IF(OK_TO_BEGIN_RD = '1')
				THEN
					READING_STATE <= "001";
				ELSE
					READING_STATE <= "000";
				END IF;
			
			WHEN "001" =>
				ADDRESS <= ADDRESS_IN;
				CE <= '1';
				OE_int <= '1';
				delay_en <= '1';
				delay_needed <= TNSR;
				--DATA_VALID <= '0';
				READING_STATE <= "010";
				DATA <= "ZZZZZZZZ";

			WHEN "010" =>
				IF(flag = '1') THEN
					CE <= '1';
					OE_int <= '0';
					ADDRESS(15 DOWNTO 1) <= ADDRESS_IN(15 DOWNTO 1);
					ADDRESS(0) <= '1';
					delay_en <= '1';
					delay_needed <= TINACT;
					--DATA_VALID <= '0';					
					READING_STATE <= "011";
				ELSE
					ADDRESS <= ADDRESS_IN;
					CE <= '1';
					OE_int <= '1';
					delay_en <= '1';
					delay_needed <= TNSR;
					--DATA_VALID <= '0';
					READING_STATE <= "010";
				END IF;
			
			WHEN "011" =>
				IF(flag = '1')
				THEN
					CE <= '1';
					OE_int <= '1';
					ADDRESS(15 DOWNTO 1) <= ADDRESS_IN(15 DOWNTO 1);
					ADDRESS(0) <= '1';
					delay_en <= '1';
					delay_needed <= TSRS;
					--DATA_VALID <= '0';					
					READING_STATE <= "100";
				ELSE
					CE <= '1';
					OE_int <= '0';
					ADDRESS(15 DOWNTO 1) <= ADDRESS_IN(15 DOWNTO 1);
					ADDRESS(0) <= '1';
					delay_en <= '1';
					--DATA_VALID <= '0';
					delay_needed <= TINACT;	
					READING_STATE <= "011";
				END IF;
				
			WHEN "100" =>
				IF(flag = '1')
				THEN
					ADDRESS <= "0000000000000000";
					DATA <= "ZZZZZZZZ";
					CE <= '0';
					OE_int <= '0';
					delay_en <= '0';
					--DATA_VALID <= '1';
					delay_needed <= "0000000000000000";
					READING_STATE <= "110";
				ELSE
					CE <= '1';
					OE_int <= '1';
					ADDRESS(15 DOWNTO 1) <= ADDRESS_IN(15 DOWNTO 1);
					ADDRESS(0) <= '1';
					delay_en <= '1';
					delay_needed <= TSRS;
					--DATA_VALID <= '0';					
					READING_STATE <= "100";
				END IF;
				
			WHEN "110" =>
				IF(nRD = '0')
				THEN
					ADDRESS <= "0000000000000000";
					DATA <= "ZZZZZZZZ";
					CE <= '0';
					OE_int <= '0';
					delay_en <= '0';
					--DATA_VALID <= '0';
					delay_needed <= "0000000000000000";
					READING_STATE <= "110";
				ELSE
					ADDRESS <= "0000000000000000";
					DATA <= "ZZZZZZZZ";
					CE <= '0';
					OE_int <= '0';
					delay_en <= '0';
					--DATA_VALID <= '1';
					delay_needed <= "0000000000000000";
					READING_STATE <= "000";
				END IF;
				
			WHEN OTHERS =>
				ADDRESS <= "0000000000000000";
				DATA <= "ZZZZZZZZ";
				CE <= '0';
				OE_int <= '0';
				delay_en <= '0';
				--DATA_VALID <= '0';
				delay_needed <= "0000000000000000";
				READING_STATE <= "000";
		END CASE;	
	END PROCESS;
	
	
	
	PROCESS(OE_int, READING_STATE) IS
		VARIABLE OE_int_LAST : STD_LOGIC := '0';
	BEGIN
		
		IF(OE_int_LAST = '1' AND OE_int = '0')
		THEN
			--D0_LATCH logic
			--D1_LATCH logic
			IF(READING_STATE = "011")
			THEN
				D0_LATCH <= '1';
				D1_LATCH <= '0';
			ELSIF(READING_STATE = "110")
			THEN
				D0_LATCH <= '0';
				D1_LATCH <= '1';			
			ELSE
				D0_LATCH <= '0';
				D1_LATCH <= '0';
			END IF;
		ELSE
			D0_LATCH <= '0';
			D1_LATCH <= '0';
		END IF;
		
		OE_int_LAST := OE_int;
	END PROCESS;

end Behavioral;

