----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:31:17 11/26/2012 
-- Design Name: 
-- Module Name:    i8085_Connect - Behavioral 
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

entity i8085_Connect is
    Port ( reset : in  STD_LOGIC;
           fast_clk : in  STD_LOGIC;
			  
			  --Directly from the i8085
           add_i8085 : in  STD_LOGIC_VECTOR (15 downto 0);
           ALE : in  STD_LOGIC;
           nWR : in  STD_LOGIC;
           nRD : in  STD_LOGIC;
			  
			  --Holt data, from Holt_Connect, is given out one at a time to the i8085
           DATA_holt_in : in  STD_LOGIC_VECTOR (15 downto 0);
           DATA_holt_valid_in : in  STD_LOGIC;

			  
			  --This is enabled by add_i8085(15) for the Holt_Connect
           address_latched : out  STD_LOGIC_VECTOR (15 downto 0);	  
           nWR_out : out  STD_LOGIC;
           nRD_out : out  STD_LOGIC;
           ALE_out : out  STD_LOGIC;
			  
			  --Data, held out for te Holt_Connect
           DATA_i_out_L : out  STD_LOGIC_VECTOR (7 downto 0);
           DATA_i_out_U : out  STD_LOGIC_VECTOR (7 downto 0);
           DATA_i_vout_L : out  STD_LOGIC;
           DATA_i_vout_U : out  STD_LOGIC;
			  
			  --From Holt_Connect, confirms write data transfer
			  DATA_i_ack  : in  STD_LOGIC;
			  
			  --To Holt_Connect, confirms read data transfer
			  DATA_h_ack  : out  STD_LOGIC;
			  
			  --Out to i8085
           IDATA_out : out  STD_LOGIC_VECTOR (7 downto 0)
			  --i8085_hold : out STD_LOGIC
			  
			  );
end i8085_Connect;

architecture Behavioral of i8085_Connect is

	signal addr_temp 			: STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal idata_temp 			: STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal DATA_i_vout_L_temp 	: STD_LOGIC;
	signal DATA_i_vout_U_temp 	: STD_LOGIC;
	signal DATA_h_ack_temp 		: STD_LOGIC;
	
	signal holt_data_in 			: STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal holt_data_lat 		: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	--DFF Enables
	signal DATA_i_L_en 	: STD_LOGIC;
	signal DATA_i_U_en 	: STD_LOGIC; 
	signal IDATA_tri 	: STD_LOGIC;
	signal data_temp_en  : STD_LoGIC;
	signal holt_data_en   : STD_LoGIC;
	
	
	--FMS stuff
	type state_type_w is (s1,s2,s3,s4,s5);
	signal state_w : state_type_w;
	type state_type_r is (s1,s2,s3,s4,s5,s6,sWait_1,sWait_2);
	signal state_r : state_type_r;
	
	
	
	COMPONENT d_ff_8bit IS
	
	PORT(
		a    		: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		en 		: IN STD_LOGIC;
		clk		: IN STD_LOGIC;
		rst		: IN STD_LOGIC;
		d_ff_out	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT d_ff_16bit IS
	PORT(
		a    		: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		en 		: IN STD_LOGIC;
		clk		: IN STD_LOGIC;
		rst		: IN STD_LOGIC;
		d_ff_out	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;


begin

	--Latching the 8085 address for Holt_Connect, High Z otherwise
	DFF_add : d_ff_16bit port map (a=>add_i8085, en => ALE, clk => fast_clk, rst => reset, d_ff_out => addr_temp);
		
	--High Z when no need
	address_latched <= addr_temp WHEN add_i8085(15) = '1' ELSE "ZZZZZZZZZZZZZZZZ";
	IDATA_out <= idata_temp WHEN IDATA_tri = '1' ELSE "ZZZZZZZZ";
	
	--Driving with temps
	DATA_i_vout_L <= DATA_i_vout_L_temp;
	DATA_i_vout_U <= DATA_i_vout_U_temp;
	DATA_h_ack <= DATA_h_ack_temp;
	
	--Enable Holt_Connect outputs by add_i8085(15)
	nWR_out <= nWR WHEN add_i8085(15) = '1' ELSE '1';
	nRD_out <= nRD WHEN add_i8085(15) = '1' ELSE '1';
	ALE_out <= ALE WHEN add_i8085(15) = '1' ELSE '0';
	
	
	--Obtain and validate data from the i8085 for Holt_Connect
	
	--D_ff outputs, control verses state machine outputs
	DFF_data_i_L : d_ff_8bit port map (a=>add_i8085(7 downto 0), en => DATA_i_L_en, clk => fast_clk, rst => reset, d_ff_out => DATA_i_out_L);
	DFF_data_i_U : d_ff_8bit port map (a=>add_i8085(7 downto 0), en => DATA_i_U_en, clk => fast_clk, rst => reset, d_ff_out => DATA_i_out_U);
	
	--Process that contains control signals
	write_p : PROCESS(fast_clk, reset)
	BEGIN
		
		if(reset = '1') then --ASYNC Reset
			state_w <= s1;
			
			DATA_i_vout_L_temp <= '0';
			DATA_i_vout_U_temp <= '0';
						
			DATA_i_L_en <= '0';
			DATA_i_U_en <= '0';
			
		elsif(fast_clk = '1' AND fast_clk'event) then
			--As soon as read is ready take it and wait for the next, setting valid bit as it is sent out
			CASE state_w IS
				WHEN s1 => --Turn off data validity and Wait for write data 0 then
				
					DATA_i_vout_L_temp <= '0';
					DATA_i_vout_U_temp <= '0';
								
					DATA_i_L_en <= '0';
					DATA_i_U_en <= '0';
					
					IF( nWR = '0' AND add_i8085(15) = '1' ) THEN		
						STATE_W <= s2;
					ELSE
						STATE_W <= s1;
					END IF;
				WHEN s2 => --Enable dff for data 0 and Wait for stop write
					
					DATA_i_vout_L_temp <= '0';
					DATA_i_vout_U_temp <= '0';
								
					DATA_i_L_en <= '1';
					DATA_i_U_en <= '0';
					
					IF( nWR = '1' AND add_i8085(15) = '1' ) THEN
						STATE_W <= s3;
					ELSE
						STATE_W <= s2;
					END IF;
				WHEN s3 => --Disable DFF0 and Set Valid bit for data 0 and Wait for write data 1
					
					DATA_i_vout_L_temp <= '1';
					DATA_i_vout_U_temp <= '0';
								
					DATA_i_L_en <= '0';
					DATA_i_U_en <= '0';
										
					IF( nWR = '0' AND add_i8085(15) = '1' ) THEN
						STATE_W <= s4;
					ELSE
						STATE_W <= s3;					
					END IF;
				WHEN s4 => --Enable DFF for data 1 and Wait for stop write
					DATA_i_vout_L_temp <= '1';
					DATA_i_vout_U_temp <= '0';
								
					DATA_i_L_en <= '0';
					DATA_i_U_en <= '1';
					
					IF( nWR = '1' AND add_i8085(15) = '1' ) THEN
						STATE_W <= s5;
					ELSE
						STATE_W <= s4;					
					END IF;
				WHEN s5 => --Disable DFF1 and Set Valid bit for data 1 and Wait for acknowledge
					
					DATA_i_vout_L_temp <= '1';
					DATA_i_vout_U_temp <= '1';
								
					DATA_i_L_en <= '0';
					DATA_i_U_en <= '0';
					
					IF( DATA_i_ack = '1' ) THEN
						STATE_W <= s1;
					ELSE
						STATE_W <= s5;					
					END IF;
						
			END CASE;
		end if;
	
	END PROCESS write_p;
	
	
	--Take Data from the Holt_Connect and set it up for the i8085
	--Work under process, fixing messsed up CASE, not rigerously tested
	
	DFF_data_out : d_ff_16bit port map (a=>DATA_holt_in, en => holt_data_en, clk => fast_clk, rst => reset, d_ff_out => holt_data_lat);
	
	read_p : PROCESS(reset,fast_clk)
	BEGIN
		if(reset = '1') then
			
			state_r <= s1;
			
			IDATA_tri <= '0';
			idata_temp <= x"00";
			holt_data_en <= '0';
			DATA_h_ack_temp <='0';
			
		ELSIF(fast_clk = '1' AND fast_clk'event) then
				--Waits for a valid signal, puts the data out then waits for the processer to stop reading, 
					--then it puts out the second data, and waits for the processor to stop reading
			CASE STATE_R IS
				WHEN s1 => --Wait for lower holt_data valid flag

					IDATA_tri <= '0';
					idata_temp <= x"00";
					holt_data_en <= '0';
					DATA_h_ack_temp <='0';
					
					IF( DATA_holt_valid_in = '1') THEN
						STATE_R <= s2;
					ELSE
						STATE_R <= s1;
					END IF;
				WHEN s2 => --Latch in Holt data
				
					IDATA_tri <= '0';
					idata_temp <= holt_data_lat(7 downto 0);
					holt_data_en <= '1';
					DATA_h_ack_temp <='0';
					
					STATE_R <= s3;


				WHEN s3 => --Hold out data for i8085 Wait for end of read
				
					IDATA_tri <= '1';
					idata_temp <= holt_data_lat(7 downto 0);
					holt_data_en <= '0';
					DATA_h_ack_temp <='0';
					
					IF( ALE = '0' ) THEN
						STATE_R <= sWait_1;
					ELSE
						STATE_R <= s3;
					END IF;
				WHEN sWait_1 => --Wait for nRD to go high                 
				
					IDATA_tri <= '0';
					idata_temp <= holt_data_lat(15 downto 8);
					holt_data_en <= '0';
					DATA_h_ack_temp <='0';
					
					IF( nRD = '1' ) THEN
						STATE_R <= s4;
					ELSE
						STATE_R <= sWait_1;
					END IF;
				WHEN s4 => --Wait for the next half of the Holt data read Wait for start of read                 
				
					IDATA_tri <= '0';
					idata_temp <= holt_data_lat(15 downto 8);
					holt_data_en <= '0';
					DATA_h_ack_temp <='0';
					
					IF( nRD = '0' AND addr_temp(15) = '1' ) THEN
						STATE_R <= s5;
					ELSE
						STATE_R <= s4;
					END IF;
				WHEN s5 => --Hold out second half of holt data Wait for end of read               
				
					IDATA_tri <= '1';
					idata_temp <= holt_data_lat(15 downto 8);
					holt_data_en <= '0';
					DATA_h_ack_temp <='0';
					
					IF( ALE = '0' ) THEN
						STATE_R <= sWait_2;
					ELSE
						STATE_R <= s5;
					END IF;
				WHEN sWait_2 => --Wait for nRD to go high                 
				
					IDATA_tri <= '0';
					idata_temp <= x"00";
					holt_data_en <= '0';
					DATA_h_ack_temp <='0';
					
					IF( nRD = '1' ) THEN
						STATE_R <= s6;
					ELSE
						STATE_R <= sWait_2;
					END IF;
				WHEN s6 => --Send out awknowledge                 
				
					IDATA_tri <= '0';
					idata_temp <= x"00";
					holt_data_en <= '0';
					DATA_h_ack_temp <='1';
					
					STATE_R <= s1;

						
			END CASE;
		END IF;
	
	END PROCESS read_p;
	


	
	

end Behavioral;

