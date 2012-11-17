----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:48:32 11/04/2012 
-- Design Name: 
-- Module Name:    MS1553_Reset_Pulse_Gen - Behavioral 
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


entity MS1553_Reset_Pulse_Gen is
    Port ( 
		ResetGo : in  STD_LOGIC;
		clock: in STD_LOGIC;
		ResetOut : out  STD_LOGIC
	 );
end MS1553_Reset_Pulse_Gen;

architecture Behavioral of MS1553_Reset_Pulse_Gen is
	signal HAVE_WE_RESET : STD_LOGIC := '0';
	SIGNAL WE_ARE_RESETTING : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	SIGNAL flag : std_logic := '0';
	SIGNAL delay_en : STD_LOGIC := '0';
	SIGNAL delay_needed : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000010000";
	
	COMPONENT DelayModule IS
		Port(
			delay_en, clock : in STD_LOGIC;
			   delay: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				flag : OUT STD_LOGIC
		);
	END COMPONENT;
	
begin
	--Handle resetting the chip
	delay_inst2 : DelayModule port map(delay_en, clock,delay_needed,flag);

	delay_needed <= "0000000000010000";

	ResetOut <= reset;

	PROCESS(ResetGo, HAVE_WE_RESET, WE_ARE_RESETTING, flag) IS
	BEGIN
		IF(ResetGo = '1' AND HAVE_WE_RESET = '0')
		THEN
			reset <= '1';
			delay_en <= '1';
			WE_ARE_RESETTING <= '1';
		ELSIF(WE_ARE_RESETTING = '1' AND HAVE_WE_RESET = '0')
		THEN
			reset <= '1';
			delay_en <= '1';
			WE_ARE_RESETTING <= '1';
		ELSE
			reset <= '0';
			delay_en <= '0';
			WE_ARE_RESETTING <= '0';
		END IF;
		
		IF(flag = '1' and flag'event AND WE_ARE_RESETTING = '1') --AND HAVE_WE_RESET = '0') --and clock = '1' and clock'event)
		THEN
			HAVE_WE_RESET <= '1';
		END IF;
	END PROCESS;
	
end Behavioral;

