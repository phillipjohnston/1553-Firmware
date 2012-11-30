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
			  
           DATA_h_out : out  STD_LOGIC_VECTOR (15 downto 0);
           DATA_h_valid_out: out  STD_LOGIC;
           --DATA_h_vo_1 : out  STD_LOGIC; --S- Only need one valid out
			  
			  --holt com busses
           ADDRESS_HOLT : out  STD_LOGIC_VECTOR (15 downto 0);
           DATA_HOLT : inout  STD_LOGIC_VECTOR (15 downto 0);
			  READY_HOLT : in STD_LOGIC; --Added to avoid bad writes
			  
			  --config signals
           BWID : out  STD_LOGIC;
           BTYPE : out  STD_LOGIC;
           WPOL : out  STD_LOGIC;
			  
			  --control signals
           nCE : out  STD_LOGIC;
           nWE : out  STD_LOGIC;
           nOE : out  STD_LOGIC;
           nMR : out  STD_LOGIC;
			  --hWAIT : IN STD_LOGIC;
			  
           DATA_i_ack : out  STD_LOGIC;
			  
			  --unuzed
           ACK_IRQ : out  STD_LOGIC;
           nIRQ : in  STD_LOGIC);
end Holt_Connect;




architecture Behavioral of Holt_Connect is

		--Addressing
		--SIGNAL pre_ADDRESS_HOLT : STD_LOGIC_VECTOR(15 DOWNTO 0);

		--Writing
		SIGNAL DATA_i8085_L_LAT : STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL DATA_i8085_H_LAT : STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL DAT_L_VAL_LAT : STD_LOGIC;
		SIGNAL DAT_H_VAL_LAT : STD_LOGIC;
		SIGNAL DATA_i_ACK_int,DATA_i_ACK_int_post_lat : STD_LOGIC;
		SIGNAL DATA_i_ACK_en : STD_LOGIC;
		SIGNAL nDAT_L_VAL,nDAT_H_VAL : STD_LOGIC;
		SIGNAL data_tri_out : STD_LOGIC;
		SIGNAL nCEw : STD_LOGIC;
		
		--statemachine regs
		SIGNAL wr_reset : STD_LOGIC;
		
		--Reading
		SIGNAL dat_input_holt_lat_en : STD_LOGIC;
		SIGNAL nCEr : STD_LOGIC;
		SIGNAL nOE_int : STD_LOGIC;
		
		--S- FMS stuff
		type state_type_w is (s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16);
		signal wr_state : state_type_w := s16;
--		type state_type_r is (rdst_idle,rdst_go,rdst_wait_for_hwait_high,rdst_wait_for_hwait_low,rdst_latch,rdst_latch_2,rdst_done);
		type state_type_r is (rdst_nReady,rdst_idle,rdst_req_read,rdst_wait0,rdst_readOut,rdst_wait_ack,rdst_wait1, rdst_wait2, rdst_wait3);--,r9,r10,r11,r12,r13,);
		signal rd_state : state_type_r;
		
		
		
		--COMPONENTS
		COMPONENT d_ff_8bit is
		Port (  a : in  STD_LOGIC_VECTOR (7 downto 0);
				  en : in  STD_LOGIC;
				  clk : in  STD_LOGIC;
				  rst : in STD_LOGIC;
				  d_ff_out : out  STD_LOGIC_VECTOR (7 downto 0));
		end COMPONENT;
		
		COMPONENT d_ff_16bit is
		Port (  a : in  STD_LOGIC_VECTOR (15 downto 0);
				  en : in  STD_LOGIC;
				  clk : in  STD_LOGIC;
				  rst : in STD_LOGIC;
				  d_ff_out : out  STD_LOGIC_VECTOR (15 downto 0));
		end COMPONENT;
		
		COMPONENT d_ff_1bit is
		Port ( a : in  STD_LOGIC;
           en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
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
	
	--Read or Write Status  --S- Waste of space
----------	wrnotrd_status <= NOT nWR_o and nRD_o;--wr=1 rd=0
----------	wrnotrd_en <= NOT (nWR_o and nRD_o);
----------	wrnotrd_dff : d_ff_1bit port map(a =>wrnotrd_status, en=>wrnotrd_en, clk=>fast_clk, rst => reset, d_ff_out=>wrnotrd_status_lat);
	
	
	
	
	
	--CLOCKING IN THE ADDRESS

	--Get first address and latch it onto the ADDRESS_HOLT bus
	--S- Already latched form i8085_Connect
	--adr_input_i8085_lat: d_ff_16bit port map (a=>ADDRESS_LATCHED, en => ALE_o, clk => fast_clk, rst => reset, d_ff_out => pre_ADDRESS_HOLT);
	ADDRESS_HOLT(14 DOWNTO 1) <= ADDRESS_LATCHED(14 DOWNTO 1); --S- Bit shifted it in the FUTURE?
	ADDRESS_HOLT(15) <= '0';
	ADDRESS_HOLT(0) <= '0';
	
	
	
	
	--WRITING LOGIC--
	
	--use  valid signal to en latch data
----	dat_in_L_en <= DATA_i_vo_0;-- and ADDRESS_LATCHED(15) and NOT ADDRESS_LATCHED(0); --S- Not needed
----	dat_in_H_en <= DATA_i_vo_1; --and ADDRESS_LATCHED(15) and ADDRESS_LATCHED(1);
	
	dat_input_i8085_L_lat: d_ff_8bit port map (a=>DATA_i_o_0, en => DATA_i_vo_0, clk => fast_clk, rst => reset, d_ff_out => DATA_i8085_L_LAT);
	dat_input_i8085_H_lat: d_ff_8bit port map (a=>DATA_i_o_1, en => DATA_i_vo_1, clk => fast_clk, rst => reset, d_ff_out => DATA_i8085_H_LAT);
	
	DATA_HOLT(15 DOWNTO 8) <= DATA_i8085_H_LAT WHEN data_tri_out='1' ELSE "ZZZZZZZZ";
	DATA_HOLT(7 DOWNTO 0) <= DATA_i8085_L_LAT WHEN data_tri_out='1' ELSE "ZZZZZZZZ";
		
	
	--ack once both valids are high
	data_ack_lat : d_ff_1bit port map(a =>DATA_i_ack_int, en=>DATA_i_ack_en, clk=>fast_clk, rst => reset, d_ff_out=>DATA_i_ACK_int_post_lat);
	DATA_i_ack_en <= '1';
	DATA_i_ack_int <= DATA_i_vo_0 AND DATA_i_vo_1; 
	DATA_i_ACK <= DATA_i_ACK_int_post_lat;

	

	--UGLY delay module for writing
	wr_reset <= DATA_i_ack_int;
	write_holt_p : PROCESS(fast_clk, wr_reset) --S- Made async reset FSM
	BEGIN
		--Reset State and data validity
		IF(wr_reset = '1') THEN  --S- I assume these are reset values
			WR_STATE <= s1;
			nCEw <= '1';
			nWE <= '1';
			data_tri_out <= '1';
		ELSIF(fast_clk = '1' AND fast_clk'event) THEN
		
			--As soon as read is ready take it and wait for the next, setting valid bit as it is sent out
			CASE WR_STATE IS --S- These states could sure use some comments
				WHEN  s1 => --
						nCEw <= '1';
						nWE <= '1';
						data_tri_out <= '1';
						WR_STATE <=  s2;
				WHEN  s2 => --
						nCEw <= '1';
						nWE <= '1';
						data_tri_out <= '1';
						WR_STATE <=  s3;
				WHEN  s3 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s4;
				WHEN  s4 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s5;
				WHEN  s5 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s6;
				WHEN  s6 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s7;
				WHEN  s7 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s8;
				WHEN  s8 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s9;
				WHEN  s9 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s10;
				WHEN  s10 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s11;
				WHEN  s11 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s12;
				WHEN  s12 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s13;
				WHEN  s13 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s14;
				WHEN  s14 => --
						nCEw <= '0';
						nWE <= '0';
						data_tri_out <= '1';
						WR_STATE <=  s15;
				WHEN  s15 => --
						nCEw <= '1';
						nWE <= '1';
						data_tri_out <= '1';
						WR_STATE <=  s16;
				WHEN  s16 => --Hold Here      --S- Was other, made state 16
						nCEw <= '1';
						nWE <= '1';
						data_tri_out <= '0';
						WR_STATE <=  s16;
			END CASE;
		
		END IF;
			
	END PROCESS write_holt_p;
	
	
	
	
	
	--READING LOGIC
	
	--Reads
--	dat_input_holt_lat_en <= NOT nOE_int and NOT hWAIT;
	dat_input_holt_lat: d_ff_16bit port map(a=>DATA_HOLT, en => dat_input_holt_lat_en, clk => fast_clk, rst => reset, d_ff_out => DATA_h_out);
	
	DATA_h_valid_out <= dat_input_holt_lat_en; --If data latched it is valid
	
	
	
	--S- Redid entire FSM
	read_holt_p : PROCESS(fast_clk, reset) --S- Changed rd_reset to reset
	BEGIN
		--Reset State and data validity
		IF(reset = '1') THEN
			RD_STATE <= rdst_nReady;
			
			nCEr <= '1';
			nOE_int <= '1';
			dat_input_holt_lat_en <= '0';

		ELSIF(fast_clk = '1' AND fast_clk'event) THEN
		
				--waits for holt to be ready, then waits for read requests from the 8085, then waits for data from the holt, then sends data to i8085Connect and waits for ack
			CASE RD_STATE IS --Ref for States:rdst_nReady,rdst_idle,rdst_req_read,rdst_wait0,rdst_readOut,rdst_wait1, rdst_wait2, rdst_wait3
			
				WHEN rdst_nReady => --Wait for the Holt ot be ready
				
					nCEr <= '1';
					nOE_int <= '1';
					dat_input_holt_lat_en <= '0';
					
					if (READY_HOLT = '1') then
						RD_STATE <= rdst_idle;
					else
						RD_STATE <= rdst_nReady;
					end if;
					
				WHEN rdst_idle => --Wait for he 8085 to want to read
				
					nCEr <= '1';
					nOE_int <= '1';
					dat_input_holt_lat_en <= '0';
					
					if (ADDRESS_LATCHED(15) = '1' AND nRD_o = '0') then
						RD_STATE <= rdst_req_read;
					else
						RD_STATE <= rdst_idle;
					end if;
					
				WHEN rdst_req_read => --Tell the Holt the 8085 wants to read
				
					nCEr <= '0';
					nOE_int <= '0';
					dat_input_holt_lat_en <= '0';
					
					RD_STATE <= rdst_wait0;
					
				WHEN rdst_wait0 | rdst_wait1 | rdst_wait2 | rdst_wait3 => --Wait 130ns for the data to appear
				
					nCEr <= '0';
					nOE_int <= '0';
					dat_input_holt_lat_en <= '0';
					
					if (RD_STATE = rdst_wait0) then
						RD_STATE <= rdst_wait1;
					elsif (RD_STATE = rdst_wait1) then
						RD_STATE <= rdst_wait2;
					elsif (RD_STATE = rdst_wait2) then
						RD_STATE <= rdst_wait3;
					else
						RD_STATE <= rdst_readOut;
					end if;

					
				WHEN rdst_readOut => --Send the data to i8085_Connect to dish out and wait for an ALE fall
				
					nCEr <= '0';
					nOE_int <= '0';
					dat_input_holt_lat_en <= '1';
					
					iF (ALE_o = '0') then
						RD_STATE <= rdst_wait_ack;
					else
						RD_STATE <= rdst_readOut;
					end if;
					
				WHEN rdst_wait_ack => --Wait for an ack to restart
				
					nCEr <= '1';
					nOE_int <= '1';
					dat_input_holt_lat_en <= '0';
					
					iF (DATA_h_ack = '1') then
						RD_STATE <= rdst_idle;
					else
						RD_STATE <= rdst_wait_ack;
					end if;

				

			END CASE;
		
		END IF;
		
	
	END PROCESS read_holt_p;
	
	

	
	
	

end Behavioral;

