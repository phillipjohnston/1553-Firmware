----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:48:00 11/27/2012 
-- Design Name: 
-- Module Name:    Holt_Connect - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Holt_Connect is
    Port ( ADDRESS_LATCHED : in  STD_LOGIC_VECTOR (15 downto 0);
           nWR_o : in  STD_LOGIC;
           nRD_o : in  STD_LOGIC;
           ALE_o : in  STD_LOGIC;
           DATA_i_o_0 : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA_i_o_1 : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA_i_vo_0 : in  STD_LOGIC;
           DATA_i_vo_1 : in  STD_LOGIC;
           DATA_h_ack : in  STD_LOGIC;
			  
           fast_clk : in  STD_LOGIC;
			  slow_clock: in STD_LOGIC;
           reset : in  STD_LOGIC;
			  
           DATA_h_o_0 : out  STD_LOGIC_VECTOR (7 downto 0);
           DATA_h_o_1 : out  STD_LOGIC_VECTOR (7 downto 0);
           DATA_h_vo_0 : out  STD_LOGIC;
           DATA_h_vo_1 : out  STD_LOGIC;
			  
			  --holt com busses
           ADDRESS_HOLT : out  STD_LOGIC_VECTOR (15 downto 0);
           DATA_HOLT : inout  STD_LOGIC_VECTOR (15 downto 0);
			  
			  --config signals
           BWID : out  STD_LOGIC;
           BTYPE : out  STD_LOGIC;
           WPOL : out  STD_LOGIC;
			  
			  --control signals
           nCE : out  STD_LOGIC;
           nWE : out  STD_LOGIC;
           nOE : out  STD_LOGIC;
           nMR : out  STD_LOGIC;
			  hWAIT : IN STD_LOGIC;
			  
           DATA_i_ack : out  STD_LOGIC;
			  
			  --unuzed
           ACK_IRQ : out  STD_LOGIC;
           nIRQ : in  STD_LOGIC);
end Holt_Connect;




architecture Behavioral of Holt_Connect is

		--Addressing
		SIGNAL pre_ADDRESS_HOLT : STD_LOGIC_VECTOR(15 DOWNTO 0);

		--Writing
		SIGNAL DATA_i8085_L_LAT : STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL DATA_i8085_H_LAT : STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL DAT_L_VAL_LAT : STD_LOGIC;
		SIGNAL DAT_H_VAL_LAT : STD_LOGIC;
		SIGNAL DATA_i_ACK_int,DATA_i_ACK_int_post_lat : STD_LOGIC;
		SIGNAL DATA_i_ACK_en : STD_LOGIC;
		SIGNAL nDAT_L_VAL,nDAT_H_VAL : STD_LOGIC;
		SIGNAL dat_in_L_en,dat_in_H_en : STD_LOGIC;
		SIGNAL data_tri_out : STD_LOGIC;
		SIGNAL nCEw : STD_LOGIC;
		
		--statemachine regs
		SIGNAL wr_reset : STD_LOGIC;

		--Read or Write regs
		SIGNAL wrnotrd_status,wrnotrd_en,wrnotrd_status_lat : STD_LOGIC;
		
		--Reading
		SIGNAL DATA_HOLT_FULL_LAT : STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL dat_input_holt_lat_en : STD_LOGIC;
		SIGNAL nCEr : STD_LOGIC;
		SIGNAL rd_reset : STD_LOGIC;
		SIGNAL nOE_int : STD_LOGIC;
		SIGNAL dat_valid_holt_lat0_val, dat_valid_holt_lat0_en : STD_LOGIC;
		SIGNAL dat_valid_holt_lat1_val, dat_valid_holt_lat1_en : STD_LOGIC;
		SIGNAL DATA_h_vo_0_int,DATA_h_vo_1_int : STD_LOGIC;
		
		
		
		--COMPONENTS
		COMPONENT d_ff_8bit is
		Port (  a : in  STD_LOGIC_VECTOR (7 downto 0);
				  en : in  STD_LOGIC;
				  clk : in  STD_LOGIC;
				  d_ff_out : out  STD_LOGIC_VECTOR (7 downto 0));
		end COMPONENT;
		
		COMPONENT d_ff_16bit is
		Port (  a : in  STD_LOGIC_VECTOR (15 downto 0);
				  en : in  STD_LOGIC;
				  clk : in  STD_LOGIC;
				  d_ff_out : out  STD_LOGIC_VECTOR (15 downto 0));
		end COMPONENT;
		
		COMPONENT d_ff_1bit is
		Port ( a : in  STD_LOGIC;
           en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           d_ff_out : out  STD_LOGIC);
		end COMPONENT;
		
		component DelayModule IS
		port (delay_en, clock : in STD_LOGIC;
			   delay: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				flag : OUT STD_LOGIC
				);
		end component;
			

begin




	
	--set hard config signals
	--16 bit width
	BWID <= '1';
	--intel style com
	BTYPE <= '1';
	--active high wait signal
	WPOL <= '1';
	
	nMR <= NOT reset;
	ACK_IRQ <= '0';
	nCE <= nCEw and nCEr;
	nOE <= nOE_int;
	
	
	
	
	
	--CLOCKING IN THE READ OR WRITE STATUS
	
	--Read or Write Status
	wrnotrd_status <= NOT nWR_o and nRD_o;--wr=1 rd=0
	wrnotrd_en <= NOT (nWR_o and nRD_o);
	wrnotrd_dff : d_ff_1bit port map(a =>wrnotrd_status, en=>wrnotrd_en, clk=>fast_clk, d_ff_out=>wrnotrd_status_lat);
	
	
	
	
	
	--CLOCKING IN THE ADDRESS

	--Get first address and latch it onto the ADDRESS_HOLT bus
	adr_input_i8085_lat: d_ff_16bit port map (a=>ADDRESS_LATCHED, en => ALE_o, clk => fast_clk,d_ff_out => pre_ADDRESS_HOLT);
	ADDRESS_HOLT(14 DOWNTO 1) <= pre_ADDRESS_HOLT(14 DOWNTO 1);
	ADDRESS_HOLT(15) <= '0';
	ADDRESS_HOLT(0) <= '0';
	
	
	
	
	--WRITING LOGIC--
	
	--use  valid signal to en latch data
	dat_in_L_en <= DATA_i_vo_0;-- and ADDRESS_LATCHED(15) and NOT ADDRESS_LATCHED(0);
	dat_input_i8085_L_lat: d_ff_8bit port map (a=>DATA_i_o_0, en => dat_in_L_en, clk => fast_clk,d_ff_out => DATA_i8085_L_LAT);
	dat_in_H_en <= DATA_i_vo_1; --and ADDRESS_LATCHED(15) and ADDRESS_LATCHED(1);
	dat_input_i8085_H_lat: d_ff_8bit port map (a=>DATA_i_o_1, en => dat_in_H_en, clk => fast_clk,d_ff_out => DATA_i8085_H_LAT);
	DATA_HOLT(15 DOWNTO 8) <= DATA_i8085_H_LAT WHEN data_tri_out='1' ELSE "ZZZZZZZZ";
	DATA_HOLT(7 DOWNTO 0) <= DATA_i8085_L_LAT WHEN data_tri_out='1' ELSE "ZZZZZZZZ";
		
	
	--ack once both valids are high
	data_ack_lat : d_ff_1bit port map(a =>DATA_i_ack_int, en=>DATA_i_ack_en, clk=>fast_clk, d_ff_out=>DATA_i_ACK_int_post_lat);
	DATA_i_ack_en <= '1';
	DATA_i_ack_int <= DATA_i_vo_0 AND DATA_i_vo_1; 
	DATA_i_ACK <= DATA_i_ACK_int_post_lat;

	

	--UGLY delay module for writing
	wr_reset <= DATA_i_ack_int;
	write_holt_p : PROCESS(fast_clk, wr_reset)
		variable WR_STATE : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1111";
	BEGIN
		--Reset State and data validity
		IF(wr_reset = '1') THEN 
			WR_STATE := "0000";
		END IF;
		
			--As soon as read is ready take it and wait for the next, setting valid bit as it is sent out
		CASE WR_STATE IS
			WHEN "0000" => --
					nCEw <= '1';
					nWE <= '1';
					data_tri_out <= '1';
					WR_STATE := "0001";
			WHEN "0001" => --
					nCEw <= '1';
					nWE <= '1';
					data_tri_out <= '1';
					WR_STATE := "0010";
			WHEN "0010" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "0011";
			WHEN "0011" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "0100";
			WHEN "0100" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "0101";
			WHEN "0101" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "0110";
			WHEN "0110" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "0111";
			WHEN "0111" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "1000";
			WHEN "1000" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "1001";
			WHEN "1001" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "1010";
			WHEN "1010" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "1011";
			WHEN "1011" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "1100";
			WHEN "1100" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "1101";
			WHEN "1101" => --
					nCEw <= '0';
					nWE <= '0';
					data_tri_out <= '1';
					WR_STATE := "1110";
			WHEN "1110" => --
					nCEw <= '1';
					nWE <= '1';
					data_tri_out <= '1';
					WR_STATE := "1111";
			WHEN OTHERS => --Hold Here
					nCEw <= '1';
					nWE <= '1';
					data_tri_out <= '0';
					WR_STATE := "1111";
		END CASE;
	
	END PROCESS write_holt_p;
	
	
	
	
	
	--READING LOGIC
	
	--Reads
	dat_input_holt_lat_en <= NOT nOE_int and NOT hWAIT;
	dat_input_holt_lat: d_ff_16bit port map(a=>DATA_HOLT, en => dat_input_holt_lat_en, clk => fast_clk,d_ff_out => DATA_HOLT_FULL_LAT);
	DATA_h_o_0 <= DATA_HOLT_FULL_LAT(7 downto 0);
	DATA_h_o_1 <= DATA_HOLT_FULL_LAT(15 downto 8);
	
	--raise valid lines
	dat_valid_holt_lat0_val <= NOT DATA_h_ack;
	dat_valid_holt_lat0_en <= dat_input_holt_lat_en OR DATA_h_vo_0_int;
	dat_valid_holt_lat1_val <= NOT DATA_h_ack;
	dat_valid_holt_lat1_en <= dat_input_holt_lat_en OR DATA_h_vo_1_int;
	dat_valid_holt_lat0: d_ff_1bit port map(a=>dat_valid_holt_lat0_val, en => dat_valid_holt_lat0_en, clk => fast_clk,d_ff_out => DATA_h_vo_0_int);
	dat_valid_holt_lat1: d_ff_1bit port map(a=>dat_valid_holt_lat1_val, en => dat_valid_holt_lat1_en, clk => fast_clk,d_ff_out => DATA_h_vo_1_int);
	DATA_h_vo_0 <= DATA_h_vo_0_int;
	DATA_h_vo_1 <= DATA_h_vo_1_int;
	
	
	--UGLY delay module for reading
	rd_reset <= NOT nRD_o;
	read_holt_p : PROCESS(fast_clk, rd_reset)
		variable RD_STATE : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1111";
	BEGIN
		--Reset State and data validity
		IF(rd_reset = '1') THEN 
			RD_STATE := "0000";
		END IF;
		
			--As soon as read is ready take it and wait for the next, setting valid bit as it is sent out
		CASE RD_STATE IS
			WHEN "0000" => --
				nCEr <= '1';
				nOE_int <= '1';
				RD_STATE := "0001";
			WHEN "0001" => --
				nCEr <= '0';
				nOE_int <= '0';
				RD_STATE := "0010";
			WHEN "0010" => --
				nCEr <= '0';
				nOE_int <= '0';
				RD_STATE := "0011";
			WHEN "0011" => --
				nCEr <= '0';
				nOE_int <= '0';
				RD_STATE := "0100";
			WHEN "0100" => --
				nCEr <= '0';
				nOE_int <= '0';
				RD_STATE := "0101";
			WHEN "0101" => --
				nCEr <= '0';
				nOE_int <= '0';
				RD_STATE := "0110";
			WHEN "0110" => --
				nCEr <= '0';
				nOE_int <= '0';
				IF (hWAIT = '1') then
					RD_STATE := "0110";
				else
					RD_STATE := "1101";
				end if;
			WHEN "1101" => --
				nCEr <= '1';
				nOE_int <= '1';
				RD_STATE := "1110";
			WHEN OTHERS => --Hold Here
				nCEr <= '1';
				nOE_int <= '1';
				RD_STATE := "1111";
		END CASE;
	
	END PROCESS read_holt_p;
	
	

	
	
	

end Behavioral;

