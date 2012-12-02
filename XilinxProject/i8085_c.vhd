--
-- Rcsid[] = "$Id: i8085.vhd,v 2.1 1993/10/06 00:56:57 alex Exp $";
--
--
-- Behavioral model of GL85 (Clone of 8085 microprocessor)
--                                 Created by: Alex Miczo
--
-- Synthesizable version of GL85
-- Original design has three processes using multiple clk-edge statements
-- in a single process which is not allowable for synopsys synthesis. 
-- 
-- The correction we made in order to make it synthesizable is described in the following.
-- 1. We broke the processes into 6, so that each one has only one 'event 
--    statement.
-- 2. We use bit pattern variables in "when and case" statement, so we can remove
--    "bit2int, int2bit" subfunctions which are suitable for synthesis.
-- 3. We wrote the package, in which subfunctions for vector arithmetic operations 
--    such as "plus4, plus8, plus9,.. etc." are provided, in the file "convers_c.vhd",
--    so that they are all synthesizable.
-- 4. We modified Parity and Carry, Auxilary Carry assignments in accordance with 8085 
--    instructin manual like following: 
--       parity bit P ='1' for even number of '1'
--       Auxilary carry AC 
--       Carry bit CY: needs to be complemented for SUB, CMP instructions
-- 5. We commented out all "wait for" statement because they are not suppoerted by
--    synopsys synthesis.
-- 6. DAA (Decimal Ajust A) instruction was incomplete, we rewrote the code for the instruction.
-- 7. RLC, RRC, RAR instructions were incomplete, Carry was assigned wrong.
-- 8. CONDIDTIONAL RETURN, JUMP, CALL FIXED 
--
-- Some corrections are written by Kyung T. Lee and Jian Shen in April, 1997.
-- Comments made by us are designated with "L&S". 
--
-- ===================== More corrections ================================
-- More corrections are written by   Jian Shen     in Janurary, 1999.
-- Mostly related to interrupts.  Many corrections are not commented.
-- 9.  Added a process for the TRAPFF registers. Note that the 5 different
--     input characteristics for TRAP, RST7.5, RST6.5, RST5.5, INTR.   
-- 10. Added a process to trace internal signals, to the file "i8085_2.log2".
-- 11. Now, on TRAP, RST7.5, RST6.5, RST5.5, the PC will automatically branch to
--     the interrupts vectors, which is generated internally.
--     Inturrupts are sampled at the falling edge in the first cycle  after an instruction.
-- 12. Fixed SIM instruction to setup interrupt masks.
-- 13. Fixed Ready=0 when Mcycle=1. The problem was:
-- when (MCYCLE=1,TSTATE=2,READY=0), TSTATE->9, If the former instruction
-- happens to be a four cycle instruction which has a catch for (M=1, T not
-- 1,2,3), M->2.
--  ===================== Even More corrections ==============================
-- Even more corrections are written by R. Stephens Summerlin in October, 2012.
-- 	Corrections are commented with "--S-"  DATED:10-23-2012 2:16
-- 14. Switched wrinm3 to wrinm2 becuase they were applying to the wrong machine cycles
-- 15. Shen's M->2 code becuase it was going to M->1
-- 16. Fixed the jump commands by adding a PC change in the M3 T3 for JMP, 
-- 17. Fixed memory writing and memory writing status signals for many commands
-- 18. Added high impedance out for ADDRESS/DATA and RDBAR/WRBAR for the prerequisite states
-- 19. Removed some logic reset the disabling the priority interupt functions

library ieee;
use ieee.std_logic_1164.all;
library std;

-----                ENTITY DECLARATION

entity I8085_c is
    port(X1            : in std_ulogic;
         RESETOUT, SOD : out std_logic;
         SID, TRAP, RST75, RST65, RST55, INTR: in std_logic;
         INTABAR       : out std_logic;
         ADDRESS_OUT   : out std_logic_vector(15 downto 0);
         S0,ALE,WRBAR, RDBAR,S1,IOMBAR: out std_logic;
         READY, RESETINBAR : in std_logic;
         CLKOUT         : out std_logic; 
         HLDA         :    out std_logic; --:='Z';        
         HOLD           :    in std_logic;
         ID             :    in std_logic_vector (7 downto 0)
         );
end I8085_c;

-----               ARCHITECTURE DECLARATION

use work.conversion.all;

architecture BEHAVIOR of I8085_c is

    signal TSTATES : std_logic_vector (3 downto 0);
    signal MCYCLE  : std_logic_vector (2 downto 0);
    signal HOLDFF, INTEFF  : std_logic; 
    signal RESETOUTFF              : std_logic;    
    signal HLTAFF                  : std_logic;          
    signal Z, S, P, CY, AC         : std_logic;
    signal ACC,  -- ACC is the accumulator
           ACT,  -- ACT is the temp accumulator
           TEMP,
           DBUF,      -- buffer the input data (ID)
           B, C, D, E, H, L, Z_reg, W_reg : std_logic_vector (7 downto 0);
    signal SP, PC                         : std_logic_vector (15 downto 0);

    signal RD1, RD2, WR1: std_logic;
    signal FETCH_F_WZ: std_logic;
    signal DDD, SSS : std_logic_vector(2 downto 0);
    signal IGROUP : std_logic_vector(1 downto 0);
    signal CC_TEST : std_logic;
    signal M75FF, M65FF, M55FF : std_logic;
    signal TRAPFF: std_logic;        
    signal PRIO_ENCODE : std_logic_vector (2 downto 0);
    signal RST75FF: std_logic;           
    signal INTA : std_logic;
    signal EI_ENABLE, EI_FF : std_logic;
    signal BIMCB: std_logic;
	 
	 signal HLDA_STATE: std_logic; --S- for hold output
	 signal HLDA_STATE_d: std_logic; --S- for hold output

    signal END_INST_flag: std_logic;					-- for inturrupt sampling
    signal SOD_FF: std_logic;
    constant one16 : std_logic_vector(15 downto 0) := "0000000000000001";   
    constant one9  : std_logic_vector(8 downto 0) :=  "000000001";          
    constant allone16 : std_logic_vector(15 downto 0) := "1111111111111111";
    constant allone9  : std_logic_vector(8 downto 0)  := "111111111";       
    constant allone8  : std_logic_vector(7 downto 0)  := "11111111";        
    constant allzero8 : std_logic_vector(7 downto 0)  := "00000000";        

begin

    CLKOUT <= not(X1) ;

    P1: process(RESETINBAR,X1,DDD,SSS,IGROUP,INTA,TSTATES,MCYCLE)

     variable common,wrinm2,wrinm3    : std_logic;

     begin

-- Compute RDBAR/WRBAR signals
        if ( ((((IGROUP = "11") AND (DDD = "001")) AND (SSS = "101"))  		-- CALL
            or
        ((IGROUP = "11") AND (SSS = "111"))   					-- RST n
            or
        (INTA = '1')
            or
        ((IGROUP = "11") AND (SSS = "101")))   					-- PUSH rp
            and
        (((DDD = "000") or (DDD = "010")) or ((DDD = "100") or (DDD = "110"))) )
        then common := '0';
        else common := '1'; end if;

        if (((common = '0')
            or
        (((IGROUP = "01") and (DDD = "111")) and (SSS /= "110")))   		-- ORA
            or
        ((((IGROUP = "00") and (DDD = "000")) and (SSS = "010"))    		-- STAX B
            or
        (((IGROUP = "00") and (DDD = "010")) and (SSS = "010")))			-- STAX D
				or
		  (((IGROUP = "01") and (DDD = "110")) and (SSS /= "110")))    		--MOV M, R --S-Missing
        then wrinm2 := '1';
        else wrinm2 := '0'; end if;

        if ( ( ((common = '0')
            or
        ((IGROUP = "00") and  (DDD = "110") )) --S- Added or ((DDD = "110") to contain  MVI M/DCR M/INR M
            and
        (((SSS = "100") or (SSS = "101")) or (SSS = "110"))) 			-- MVI M/DCR M/INR M
            or
        (((IGROUP = "11") and (DDD = "010")) and (SSS = "011")))  		-- OUT
        then wrinm3 := '1';
        else wrinm3 := '0'; end if;

     if(RESETINBAR = '0') then
             RD1    <= '0';
             RD2    <= '0';
             WR1    <= '0';
     elsif (x1='0' and x1'event) then         
        if(TSTATES = "0010") then
                case MCYCLE is
                    when "001" => RD1 <= '1';
                              RD2 <= '0';
                              WR1 <= '0';
                    when "010" => RD1 <= '0';
                              if(wrinm2 = '0') then RD2 <= '1'; else RD2 <= '0'; end if; --S- Switched wrinm3 to wrinm2
                              if(wrinm2 = '1') then WR1 <= '1'; else WR1 <= '0'; end if;
										if((IGROUP = "11") and (SSS = "111")) then  WR1 <= '1'; RD2 <= '0'; end if; --S- added for RST
                    when "011" => RD1 <= '0';
                              if(wrinm3 = '0') then RD2 <= '1'; else RD2 <= '0'; end if; --S- Switched wrinm2 to wrinm3
                              if(wrinm3 = '1') then WR1 <= '1'; else WR1 <= '0'; end if;
										if((IGROUP = "11") and (SSS = "111")) then  WR1 <= '1'; RD2 <= '0'; end if; --S- added for RST
                    when "100" => RD1 <= '0';
                              if ((((IGROUP = "00") and (DDD = "111")) and (SSS = "010")) -- LDA
                                  or
                                 (((IGROUP = "00") and (DDD = "101")) and (SSS = "010"))) -- LHLD
											then RD2 <= '1'; 
                              else RD2 <= '0'; 
                              end if;
                              if ( (((IGROUP = "00") and (DDD = "110")) and (SSS = "010")) -- STA
										    or
											  ((IGROUP = "11") and (DDD = "001") and (SSS = "101"))  --S- CALL
											 or
											  ((IGROUP = "11") and (SSS = "100")) --S- Cond CALL
											 or
											  ((IGROUP = "11") and (DDD = "100") and (SSS = "011")) --S- XTHL
											 or
                                 (((IGROUP = "00") and (DDD = "100")) and (SSS = "010")) ) -- SHLD
											then WR1 <= '1'; 
                              else WR1 <= '0'; 
                              end if;
                    when "101" => RD1 <= '0';
                              if (((IGROUP = "00") and (DDD = "101")) and (SSS = "010")) -- LHLD
												then RD2 <= '1'; 
                                  else RD2 <= '0'; 
                                  end if;
                              if ( ((IGROUP = "11") and (DDD = "001") and (SSS = "101")) --S- CALL
											 or
											 ((IGROUP = "11") and (SSS = "100")) --S- Cond CALL
											 or
											  ((IGROUP = "11") and (DDD = "100") and (SSS = "011")) --S- XTHL
											 or
											  ((IGROUP = "00") and (DDD = "100") and (SSS = "010")) ) -- SHLD
												then WR1 <= '1'; 
                                  else WR1 <= '0'; 
                                  end if;
                    when others=>null;
                end case; -- MCYCLE
            --end if;
        elsif(TSTATES = "0011") then -- and X1 = '0') then
            RD1 <= '0';
            RD2 <= '0';
            WR1 <= '0';
        end if;
     end if;   -- X1 falling edge

 end process P1;


-------------------------------------------------------------------------------
-- Main process, instruction decode and Mcycle
-- Put out PC; Inc PC; Fetech instr; decode see what to do next
-------------------------------------------------------------------------------
    P2: process(RESETINBAR,X1,TSTATES,MCYCLE,IGROUP,SSS,DDD,RD1,RD2,SOD_FF,
                END_INST_flag,WR1,RESETOUTFF,PRIO_ENCODE,RST75)

     variable ALU_OUT                 : std_logic_vector (8 downto 0);
     variable B16BCTR                 : std_logic_vector (15 downto 0);
     variable LAST_OP                 : std_logic_vector (4 downto 0);
     variable temp_MOV                : std_logic_vector(7 downto 0);
     variable temp_D                  : std_logic_vector(7 downto 0);
     variable temp_E                  : std_logic_vector(7 downto 0);
     variable common,wrinm2,wrinm3    : std_logic; 
     variable temp4bit                : std_logic_vector(3 downto 0);
     variable inv_temp8               : std_logic_vector(7 downto 0);
     variable carryout                : std_logic;                	

     begin
        if(RESETINBAR = '0') then         -- clear the flip-flops
             MCYCLE <= ('0','0','1');
             PC <= (15 downto 0 => '0');  -- Program Counter

             RESETOUTFF <= '0';
             HLTAFF <= '0';
             INTEFF <= '0';
             M75FF <= '1';
             M65FF <= '1';
             M55FF <= '1';
             LAST_OP := "11111";
             FETCH_F_WZ <= '0';
             SOD_FF <= '0';
             END_INST_flag <= '0';
             DBUF <= "00000000";
             ACC  <= "00000000";
             ACT  <= "00000000";
             CY <= '0';    -- condition codes
             P  <= '0';
             AC <= '0';
             Z  <= '0';
             S  <= '0';
				 
				 --S- Reset Status Outputs
				 IOMBAR <= 'Z'; --S- For status accuracy

				 IGROUP  <= "00";      -- for synthesis, not necessary for RTL sim
             DDD     <= "000";     -- for synthesis
             SSS     <= "000";     -- for synthesis
             SP	     <= "0000000000000000";     -- for synthesis

        elsif (X1 = '1') and (x1'event) then  -- Begin processing on positive edge of clock
            RESETOUTFF <= '1';
				HLTAFF <= '0';			-- set one long enough to make HLT work
				if HLTAFF = '1' then MCYCLE <= "001"; end if;  -- prepares for the
							   -- next instruction
				if TSTATES = "0001" then
					ALE <= '1';			-- It is address, not data 
				if END_INST_flag = '1' then 
					END_INST_flag <= '0';
				end if;
	    else ALE <= '0';
	    end if;

---------------------------------------------------------------------------
            if MCYCLE = "001" AND (TSTATES = "0000"             --L&S 
                 or TSTATES = "0001" or TSTATES = "0010" or TSTATES = "0011") then

--========================================================================
--                                                                      ==
        ------------------------------------------------------------    ==
        --           Common processing for all OP-CODES           --    ==
        --           MCYCLE = 1                                   --    ==
        --             AND                                        --    ==
        --           TSTATES = 1, 2, or 3                         --    ==
        --           Instruction Fetch                            --    ==
        ------------------------------------------------------------    ==
--                                                                      ==
--========================================================================

                 case TSTATES is -- case bit2int(TSTATES) is
-- MCYCLE = 1, TSTATES = 1
                    when "0001" =>
                        ADDRESS_OUT <= PC ; --after 1 ns;
                        IOMBAR  <= '0'; --INTRFF ; --after 1 ns;
-- Cf., interrupt acknowledge timing, p 2-13, MCS 80/85 user's manual
                        S1 <= '1' ; --after 1 ns;
                        S0 <= '1' ; --after 1 ns;
-- MCYCLE = 1, TSTATES = 2
                    when "0010" =>
                        if not (LAST_OP = "11111") then --99) then
--------------------------- Procedure OP_RUNIN_NEXT_INST; --------------------------------------
                            case LAST_OP is
                                when "00000" =>  -- ADD r
                                           ALU_OUT := plus8(ACT,TEMP); -- L&S
                                when "00001" =>  -- ADC r
                                           ALU_OUT := plus8_carry(ACT,TEMP,CY); -- L&S
                                when "00010" => -- SUB r
                                           ALU_OUT := plus8_carry(ACT,invert(TEMP),'1');   -- L&S  
                                           ALU_OUT(8) := not ALU_OUT(8); -- L&S complement carrry for sub/comp/dcr
                                when "00011" =>  -- SBB r
                                           ALU_OUT := plus8_carry(ACT,invert(TEMP),'1'); -- L&S
                                           if(CY = '1') then ALU_OUT := plus9(ALU_OUT,allone9); end if; -- L&S
                                           ALU_OUT(8) := not ALU_OUT(8); -- L&S
                                when "00100" => -- ACT and TEMP;
                                        for i in 7 downto 0 loop                             
                                           alu_out(i) := act(i) and temp(i);
                                        end loop;

                                when "00101" => --ACT xor TEMP;
                                         for i in 7 downto 0 loop                                       
                                                alu_out(i) := act(i) xor temp(i);
                                         end loop;
                                
                                when "00110" => -- ACT  or TEMP;
                                        for i in 7 downto 0 loop
                                               alu_out(i):= act(i) or temp(i);
                                        end loop;
                                when "00111" => -- CMP
                                        ALU_OUT := plus8_carry(ACT,invert(TEMP),'1'); -- L&S
													 ALU_OUT(8) := not ALU_OUT(8); -- L&S
                                when "01010"|"01011"|"01100"|"01101" => --when 10|11|12|13 => 
                                        CY <= ALU_OUT(8); -- L&S
                                when "10100" => --when 20 => 
													 ACC(7) <= SID;  -- RIM
                                when "11110" => --when 30 => 
                                     if ACC(6) = '1' then SOD_FF <= ACC(7); end if; -- SIM
                                when others => null;
                            end case; -- end of case LAST_OP
                            if((LAST_OP(4)='0') and (not (LAST_OP = "00111"))) then
                                  ACC <= ALU_OUT(7 downto 0); end if;
                            if((LAST_OP(4)='0') and ( (LAST_OP(3)='0') or ((LAST_OP(2)='0')and(LAST_OP(1)='0')) )) then -- L&S
                                if ALU_OUT = "000000000" then Z <= '1'; else Z <= '0'; end if;
                                S <= ALU_OUT(7);
                                CY <= ALU_OUT(8);
                                P <= not( ALU_OUT(0) XOR ALU_OUT(1) XOR ALU_OUT(2) XOR ALU_OUT(3) XOR
                                          ALU_OUT(4) XOR ALU_OUT(5) XOR ALU_OUT(6) XOR ALU_OUT(7)); -- L&S
                            end if;
                            case LAST_OP is
                                when "00000"|"00001" => -- when 0|1
												 AC <= ALU_OUT(4) XOR TEMP(4) XOR ACT(4);
										  when "00010"|"00011"|"00111" => --when 2|3|7 => --case "00111" added L&S
                                     inv_temp8 := plus8b(invert(TEMP),"00000001");  -- L&S
                                     AC <= ALU_OUT(4) XOR inv_temp8(4) XOR ACT(4);
                                when "00100" => --when 4 =>   
                                     CY <= '0';
                                     AC <= '1';
                                when "00101"|"00110" => --when 5|6 => 
                                     CY <= '0';
                                     AC <= '0';
                                when others => null;
                            end case;    -- LAST_OP
--------------------------- end Procedure OP_RUNIN_NEXT_INST; ----------------------------------
                        end if;
                        if (FETCH_F_WZ = '1') then 
                            B16BCTR(15 downto 8) := W_REG(7 downto 0);
                            B16BCTR(7 downto 0)  := Z_REG(7 downto 0);
                            B16BCTR := plus16(B16BCTR,one16);
                            PC <= B16BCTR;
                            FETCH_F_WZ <= '0';
                        else 
                            PC <= plus16(PC,one16); -- L&S
                        end if;
-- MCYCLE = 1, TSTATES = 3
                    when "0011" =>
                        LAST_OP := "11111"; --99; -- L&S
                        DBUF <= ID;         -- DBUS_IN(DBUF);         
                        TEMP <= ID;
			-- Decode the instruction register
                        IGROUP  <= ID(7 downto 6);     -- high order two bits select instruction group
                        DDD     <= ID(5 downto 3);     -- bits 5 downto 3 select destination register
                        SSS     <= ID(2 downto 0);     -- bits 2 downto 0 select source register
                    when others => null;
                end case;  -- end of case TSTATES					 
					 
--=========================================================================  -- save {M1,T7},{M1,T8},{M1,T9}
	    elsif MCYCLE = "001" and (TSTATES = "0111" or TSTATES = "1000" or TSTATES = "1001") then
		MCYCLE <= "010"; --S- Changed 001 to 010 to correct to the intention of the code
            else
--          either (MCYCLE > 1) OR (MCYCLE = 1 AND TSTATES > 3)
--=========================================================================
--
-- Instruction decode begins here.  The high order two bits of the op-code, referred
-- to as IGROUP, select the major function.  Then, the third, fourth and fifth bits
-- of the op-code, referred to as DDD, select the destination, and the rightmost
-- three bits of the op-code, referred to as SSS, select the source.  The DDD and SSS
-- fields either further refine the functionality or select source and destination
-- registers for the op-code.
--
                case IGROUP is 

                    when "00" => 
                        case SSS is 
                            when "000" =>
                                case DDD is     -- OP-CODE = 00 DDD 000 (SSS = 000)
                                    when "000" => END_INST_flag <= '1';     			-- NOP
                                    when "100" => 						-- RIM
                                        ACC(0) <= M55FF;
                                        ACC(1) <= M65FF;
                                        ACC(2) <= M75FF;
                                        if(EI_ENABLE = '1') then ACC(3) <= EI_FF; else ACC(3) <= INTEFF; end if;
                                        ACC(4) <= RST55;
                                        ACC(5) <= RST65;
                                        ACC(6) <= RST75FF;
                                        LAST_OP:="10100";
                                        END_INST_flag <= '1';
                                    when "110" => 						-- SIM
                                        if ACC(3) = '1' then
                                            M55FF <= ACC(0);
                                            M65FF <= ACC(1);
                                            M75FF <= ACC(2); 
                                        end if;
                                        if ACC(4) = '1' then        -- Inturrupt enable
--                                          RST75FF <= '0';         -- 755 enable 
                                            LAST_OP:="11110"; 
                                        end if;
                                        END_INST_flag <= '1';    
                                    when "001"|"010"|"011"|"101"|"111" => END_INST_flag <= '1';     -- ILLEGAL INSTR
                                    when others => null;
                                end case;  -- end of case DDD
                            when "001" =>            -- OP-CODE = 00 DDD 001 (SSS = 001)  -- LXI | DAA
                                case DDD(0) is  --L&S
                                    when '0' =>    -- LXI  (Load immediate register pair)
                                        case MCYCLE is 
                                            when "001" =>
                                                MCYCLE <= "010";
                                            when "010" =>
                                                case TSTATES is 
                                                    when "0001" =>   -- MEM_PC_READ_T1;
                                                        ADDRESS_OUT   <= PC ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '1' ; --after 1 ns;
                                                        S0  <= '0' ; --after 1 ns;
                                                    when "0010" =>  -- PC_READ_T2;
                                                        PC <= plus16(PC,one16); --inc_sig(PC); -- L&S
                                                        DBUF <= ID;
                                                    when "0011" =>
                                                        case DDD(2 downto 1) is --L&S
                                                            when "00" => C <= DBUF;
                                                            when "01" => E <= DBUF;
                                                            when "10" => L <= DBUF;
                                                            when "11" => SP(7 downto 0) <= DBUF;
                                                            when others => null;
                                                        end case;
                                                        MCYCLE <= "011";
                                                    when others => null;
                                                end case;
                                            when "011" =>
                                                case TSTATES is 
                                                    when "0001" =>   -- MEM_PC_READ_T1;
                                                        ADDRESS_OUT   <= PC ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '1' ; --after 1 ns;
                                                        S0  <= '0' ; --after 1 ns;
                                                    when "0010" =>  -- PC_READ_T2;
                                                        PC <= plus16(PC,one16); --inc_sig(PC); -- L&S
                                                        DBUF <= ID;
                                                    when "0011" =>
                                                        case DDD(2 downto 1) is --L&S
                                                            when "00" => B <= DBUF;
                                                            when "01" => D <= DBUF;
                                                            when "10" => H <= DBUF;
                                                            when "11" => SP(15 downto 8) <= DBUF;
                                                            when others => null;
                                                        end case;
                                                        END_INST_flag <= '1';
                                                        MCYCLE <= "001";
                                                        ADDRESS_OUT <= PC ; --after 1 ns;
                                                    when others => null;
                                                end case;  -- TSTATES
                                             when others => null;
                                        end case;    -- MCYCLE
                                    when '1' =>    -- DAD  (Double add)
                                        case MCYCLE is 
                                           when "001" =>
                                               MCYCLE <= "010";
                                           when "010" =>
                                               case TSTATES is 
                                                   when "0001" =>
                                                       case DDD(2 downto 1) is --L&S
                                                           when "00" => ACT <= C;
                                                           when "01" => ACT <= E;
                                                           when "10" => ACT <= L;
                                                           when "11" => ACT <= SP(7 downto 0);
                                                           when others => null;
                                                        end case; -- DPAIR
                                                   when "0010" => 
                                                        ALU_OUT := plus8(ACT,L); -- L&S
                                                   when "0011" =>
                                                       L <= ALU_OUT(7 downto 0);
                                                       CY <= ALU_OUT(8);
                                                       MCYCLE <= "011";
                                                   when others => null;
                                               end case; -- TSTATES
                                           when "011" =>
                                               case TSTATES is --case bit2int(TSTATES) is
                                                   when "0001" => 
                                                       case DDD(2 downto 1) is --L&S
                                                           when "00" => ACT <= B;
                                                           when "01" => ACT <= D;
                                                           when "10" => ACT <= H;
                                                           when "11" => ACT <= SP(15 downto 8);
                                                           when others => null;
                                                       end case; -- DPAIR
                                                   when "0010" =>
                                                       ALU_OUT := plus8_carry(ACT,H,CY); -- L&S
                                                   when "0011" =>
                                                       H <= ALU_OUT(7 downto 0);
                                                       CY <= ALU_OUT(8);
                                                       MCYCLE <= "001";
                                                       END_INST_flag <= '1';
                                                   when others => null;
                                                 end case; -- TSTATES
                                           when others => null;
                                        end case; -- MCYCLE
                                    when others => null;
                                end case;    -- IRBIT3
                            when "010" =>  -- op code = 00 DDD 010 (SSS = 010)
                                case DDD is
                                    when "000" | "010" => -- 0|2			-- STAX
                                        case MCYCLE is 
                                            when "001" =>
                                                MCYCLE <= "010";
                                            when "010" =>
                                                case TSTATES is 
                                                    when "0001" => --when 1 =>
                                                        if(DDD(2 downto 1) = "00") then --L&S
                                                            ADDRESS_OUT(15 downto 8) <= B ; --after 1 ns;
                                                            ADDRESS_OUT(7 downto 0)  <= C ; --after 1 ns;
                                                        else
                                                            ADDRESS_OUT(15 downto 8) <= D ; --after 1 ns;
                                                            ADDRESS_OUT(7 downto 0)  <= E ; --after 1 ns;
                                                        end if;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '0' ; --after 1 ns; --S- Swithced S1 and S0 fir writing state
                                                        S0  <= '1' ; --after 1 ns;
                                                    when "0010" => --when 2 => -- HL_READ_T2
                                                        ADDRESS_OUT(7 downto 0) <= ACC;
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "001";
                                                        END_INST_flag <= '1';
                                                    when others => null;
                                                end case; -- end of case TSTATES
                                            when others => null;
                                        end case;  -- MCYCLE
                                    when "001" | "011" => -- 1|3 => 			-- LDAX
                                        case MCYCLE is --case bit2int(MCYCLE) is
                                            when "001" => --when 1 =>
                                                MCYCLE <= "010";
                                            when "010" => --when 2 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 =>
                                                        if(DDD(2 downto 1) = "00") then --L&S
                                                            ADDRESS_OUT(15 downto 8) <= B ; --after 1 ns;
                                                            ADDRESS_OUT(7 downto 0)  <= C ; --after 1 ns;
                                                        else
                                                            ADDRESS_OUT(15 downto 8) <= D ; --after 1 ns;
                                                            ADDRESS_OUT(7 downto 0)  <= E ; --after 1 ns;
                                                        end if;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '1' ; --after 1 ns;
                                                        S0  <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 => -- HL_READ_T2
                                                        ACC <= ID;
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "001";
                                                        END_INST_flag <= '1';
                                                    when others => null;
                                                end case; -- end of case TSTATES
                                            when others => null; 
                                        end case;  -- MCYCLE
                                    when "100" | "101" => --when 4|5 =>   		-- SHLD/LHLD
                                        case MCYCLE is --case bit2int(MCYCLE) is
                                            when "001" => --when 1 =>
                                                MCYCLE <= "010";
                                            when "010" => --when 2 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => -- MEM_PC_READ_T1
                                                        ADDRESS_OUT   <= PC ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '1' ; --after 1 ns;
                                                        S0  <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 => -- PC_READ_T2
                                                        PC <= plus16(PC,one16); --inc_sig(PC); -- L&S
                                                        Z_reg <= ID;
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "011";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when "011" => --when 3 => 
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => -- MEM_PC_READ_T1
                                                        ADDRESS_OUT   <= PC ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '1' ; --after 1 ns;
                                                        S0  <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 => -- PC_READ_T2
                                                        PC <= plus16(PC,one16); --inc_sig(PC); -- L&S
                                                        W_reg <= ID;
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "100";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when "100" => --when 4 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => -- MEM_WZ_WRITE_T1
                                                        ADDRESS_OUT(15 downto 8) <= W_reg ; --after 1 ns;
                                                        ADDRESS_OUT(7 downto 0) <= Z_reg ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
																		  if(DDD(0) = '0') then --S- added to fix Status for LHLD
																			S1  <= '0' ; --after 1 ns;
																			S0  <= '1' ; --after 1 ns;
																		  else
																			S1  <= '1' ; --after 1 ns;
																			S0  <= '0' ; --after 1 ns;
																		  end if;
                                                    when "0010" => --when 2 =>
                                                        if(DDD(0) = '0') then --L&S
                                                            ADDRESS_OUT(7 downto 0) <= L ; --after 1 ns;
                                                        else
                                                            L <= ID;
                                                        end if;
                                                        B16BCTR(15 downto 8) := W_REG;
                                                        B16BCTR(7 downto 0)  := Z_REG;
                                                        B16BCTR := plus16(B16BCTR,one16); --inc16(B16BCTR); -- L&S
                                                    when "0011" => --when 3 =>
                                                        W_REG <= B16BCTR(15 downto 8);
                                                        Z_REG <= B16BCTR(7 downto 0);
                                                        MCYCLE <= "101";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when "101" => --when 5 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => -- MEM_WZ_WRITE_T1
                                                        ADDRESS_OUT(15 downto 8) <= W_reg ; --after 1 ns;
                                                        ADDRESS_OUT(7 downto 0) <= Z_reg ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
																		  if(DDD(0) = '0') then --S- added to fix Status for LHLD
																			S1  <= '0' ; --after 1 ns;
																			S0  <= '1' ; --after 1 ns;
																		  else
																			S1  <= '1' ; --after 1 ns;
																			S0  <= '0' ; --after 1 ns;
																		  end if;
                                                    when "0010" => --when 2 =>
                                                        if(DDD(0) = '0') then --L&S
                                                            ADDRESS_OUT(7 downto 0) <= H ; --after 1 ns;
                                                        else
                                                            H <= ID;
                                                        end if;
                                                    when "0011" => --when 3 =>
                                                        END_INST_flag <= '1';
                                                        MCYCLE <= "001";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when others => null;
                                        end case;  -- MCYCLE
                                    when "110" | "111" => --when 6|7 =>   		-- 6 = STA
                                                 					-- 7 = LDA  (load accumulator)
                                        case MCYCLE is --case bit2int(MCYCLE) is
                                            when "001" => --when 1 =>
                                                MCYCLE <= "010";
                                            when "010" => --when 2 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => -- MEM_PC_READ_T1
                                                        ADDRESS_OUT   <= PC ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '1' ; --after 1 ns;
                                                        S0  <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 => -- PC_READ_T2
																		  PC <= plus16(PC,one16); --inc_sig(PC);
                                                        Z_reg <= ID;
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "011";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when "011" => --when 3 => 
                                                case TSTATES is --
                                                    when "0001" => --when 1 => -- MEM_PC_READ_T1
                                                        ADDRESS_OUT   <= PC ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '1' ; --after 1 ns;
                                                        S0  <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 => -- PC_READ_T2
																		  PC <= plus16(PC,one16); --inc_sig(PC);
                                                        W_reg <= ID;
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "100";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when "100" => --when 4 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => -- MEM_WZ_WRITE_T1
                                                        ADDRESS_OUT(15 downto 8) <= W_reg ; --after 1 ns;
                                                        ADDRESS_OUT(7 downto 0) <= Z_reg ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
																		  if(DDD(0) = '0') then
																			S1  <= '0' ; --after 1 ns;
																			S0  <= '1' ; --after 1 ns;
																		  else --S- To make the status output agree with command
																			S1  <= '1' ; 
																			S0  <= '0' ;
																		  end if;
                                                    when "0010" => --when 2 =>
                                                        if(DDD(0) = '0') then --L&S
                                                            ADDRESS_OUT(7 downto 0) <= ACC ; --after 1 ns; -- STA
                                                        else
                                                            ACC <= ID; -- LDA
                                                        end if;
                                                    when "0011" => --when 3 =>
                                                        END_INST_flag <= '1';
                                                        MCYCLE <= "001";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when others => null;
                                        end case;  -- MCYCLE
                                    when others => null;
                                end case;          -- end of case DDD
                            when "011" =>  -- op code = 00 DDD 011 (SSS = 011)      -- INX | DCX
                                case TSTATES is --case bit2int(TSTATES) is
                                    when "0100" => --when 4 =>
                                        case DDD(2 downto 1) is --L&S
                                            when "00" => B16BCTR(15 downto 8) := B;
                                                      B16BCTR(7 downto 0)  := C;
                                            when "01" => B16BCTR(15 downto 8) := D;
                                                      B16BCTR(7 downto 0)  := E;
                                            when "10" => B16BCTR(15 downto 8) := H;
                                                      B16BCTR(7 downto 0)  := L;
                                            when "11" => B16BCTR := SP;
                                            when others => null;
                                        end case;                  -- end of case DPAIR
                                                                              -- when irbit3 = 0, INX, when 1, DCX
                                        if(DDD(0) = '0') then --L&S
                                            B16BCTR := plus16(B16BCTR, one16); --inc16(B16BCTR); -- L&S     INX
                                        else B16BCTR := plus16(B16BCTR, allone16); --dec16(B16BCTR);  -- L&S  DCX
                                        end if;
                                    when "0101" => --when 5 =>
                                        case DDD(2 downto 1) is --L&S
                                            when "00" => B  <= B16BCTR(15 downto 8);
                                                      C  <= B16BCTR(7 downto 0);
                                            when "01" => D  <= B16BCTR(15 downto 8);
                                                      E  <= B16BCTR(7 downto 0);
                                            when "10" => H  <= B16BCTR(15 downto 8);
                                                      L  <= B16BCTR(7 downto 0);
                                            when "11" => SP <= B16BCTR;
                                            when others => null;
                                        end case;                  -- end of case DPAIR
                                    when "0110" => END_INST_flag <= '1';
                                    when others => null;
                                end case;                  -- end of case TSTATES
                            when "100" | "101" =>  -- op code = 00 DDD 10X (SSS = 10X)         -- INC | DCR
                                if DDD="110" then   -- memory access
                                    case MCYCLE is --case bit2int(MCYCLE) is
                                        when "001" => --when 1 =>
                                            MCYCLE <= "010";
                                        when "010" => --when 2 =>
                                            case TSTATES is --case bit2int(TSTATES) is
                                                when "0001" => --when 1 =>
                                                    ADDRESS_OUT(15 downto 8) <= H ; --after 1 ns;
                                                    ADDRESS_OUT(7 downto 0)  <= L ; --after 1 ns;
                                                    IOMBAR <= '0' ; --after 1 ns;
                                                    S1  <= '1' ; --after 1 ns;
                                                    S0  <= '0' ; --after 1 ns;
                                                when "0010" => 
                                                    if (SSS(0) = '0') then --L&S
                                                        ALU_OUT := plus8(ID,"00000001"); -- L&S      INC M
                                                    else
                                                        ALU_OUT := plus8(ID,allone8); -- L&S         DCR M
                                                    end if;
                                                when "0011" => --when 3 => 
                                                    TEMP <= ALU_OUT(7 downto 0);
                                                    if ALU_OUT = "000000000" then Z <= '1'; else Z <= '0'; end if;
                                                    S <= ALU_OUT(7);
                                                    P <= not(ALU_OUT(0) XOR ALU_OUT(1) XOR ALU_OUT(2) XOR ALU_OUT(3) XOR
                                                              ALU_OUT(4) XOR ALU_OUT(5) XOR ALU_OUT(6) XOR ALU_OUT(7)); -- L&S
                                                    AC <= ALU_OUT(4) XOR TEMP(4) XOR ACT(4);
                                                    MCYCLE <= "011";
                                                when others => null;
                                            end case; -- TSTATES
                                        when "011" => --when 3 =>
                                            case TSTATES is --case bit2int(TSTATES) is
                                                when "0001" => --when 1 => 
                                                    ADDRESS_OUT(15 downto 8) <= H ; --after 1 ns;
                                                    ADDRESS_OUT(7 downto 0)  <= L ; --after 1 ns;
                                                    IOMBAR <= '0' ; --after 1 ns;
                                                    S1  <= '0' ; --after 1 ns;
                                                    S0  <= '1' ; --after 1 ns;
                                                when "0010" => --when 2 =>
                                                    ADDRESS_OUT(7 downto 0) <= TEMP ; --after 1 ns;
                                                when "0011" => --when 3 =>
                                                    END_INST_flag <= '1';
                                                    MCYCLE <= "001";
                                                when others => null;
                                            end case;  -- TSTATES
                                        when others => null;
                                    end case; -- MCYCLE
                                else 
                                    case DDD is --case bit2int(DDD) is
                                        when "000" => ALU_OUT(7 downto 0) := B;
                                        when "001" => ALU_OUT(7 downto 0) := C;
                                        when "010" => ALU_OUT(7 downto 0) := D;
                                        when "011" => ALU_OUT(7 downto 0) := E;
                                        when "100" => ALU_OUT(7 downto 0) := H;
                                        when "101" => ALU_OUT(7 downto 0) := L;
                                        when "111" => ALU_OUT(7 downto 0) := ACC;
                                        when others => null;
                                    end case;
                                    if (SSS(0) = '0') then --L&S
                                          ALU_OUT := plus9(ALU_OUT, one9); --inc9(ALU_OUT);    --INC r L&S
                                    else 
                                          ALU_OUT := plus9(ALU_OUT, allone9); --dec9(ALU_OUT);  --DCR r L&S
                                    end if;
                                    case DDD is --case bit2int(DDD) is
                                        when "000" => B   <= ALU_OUT(7 downto 0);
                                        when "001" => C   <= ALU_OUT(7 downto 0);
                                        when "010" => D   <= ALU_OUT(7 downto 0);
                                        when "011" => E   <= ALU_OUT(7 downto 0);
                                        when "100" => H   <= ALU_OUT(7 downto 0);
                                        when "101" => L   <= ALU_OUT(7 downto 0);
                                        when "111" => ACC <= ALU_OUT(7 downto 0);
                                        when others => null;
                                    end case;
                                    if ALU_OUT = "000000000" then Z <= '1'; else Z <= '0'; end if; -- L&S
                                    S <= ALU_OUT(7);
                                    P <= not(ALU_OUT(0) XOR ALU_OUT(1) XOR ALU_OUT(2) XOR ALU_OUT(3) XOR
                                              ALU_OUT(4) XOR ALU_OUT(5) XOR ALU_OUT(6) XOR ALU_OUT(7)); -- L&S
                                    AC <= ALU_OUT(4) XOR TEMP(4) XOR ACT(4);
                                    END_INST_flag <= '1';
                                end if; -- INR/DCR
                            when "110" => -- MVI      (SSS = 6)
                                if (DDD = "110") then -- move 2nd byte of inst. to Memory
                                    case MCYCLE is --case bit2int(MCYCLE) is
                                        when "001" => --when 1 =>
                                                  MCYCLE <= "010";
                                        when "010" => --when 2 => 
                                                  case TSTATES is --case bit2int(TSTATES) is
                                                  when "0001" => --when 1 => 
                                                          ADDRESS_OUT <= PC ; --after 1 ns;
                                                          IOMBAR <= '0' ; --after 1 ns;
                                                          S1  <= '1' ; --after 1 ns;
                                                          S0  <= '0' ; --after 1 ns;
                                                  when "0010" => --when 2 =>
                                                          PC <= plus16(PC,one16); --inc_sig(PC); -- L&S
                                                          TEMP <= ID;
                                                  when "0011" => --when 3 =>
                                                          MCYCLE <= "011";
                                                  when others => null;
                                                  end case;
                                        when "011" => --when 3 => 
                                                  case TSTATES is --case bit2int(TSTATES) is
                                                  when "0001" => --when 1 =>
                                                          ADDRESS_OUT(15 downto 8) <= H ; --after 1 ns;
                                                          ADDRESS_OUT(7 downto 0)  <= L ; --after 1 ns;
                                                          IOMBAR <= '0' ; --after 1 ns;
                                                          S1 <= '0' ; --after 1 ns;
                                                          S0 <= '1' ; --after 1 ns;
                                                  when "0010" => --when 2 =>
                                                          ADDRESS_OUT(7 downto 0) <= TEMP ; --after 1 ns;
                                                  when "0011" => --when 3 =>
                                                          END_INST_flag <= '1';
                                                          MCYCLE <= "001";
                                                  when others => null;
                                                  end case;
                                        when others => null;
                                        end case;
                                else                  -- move 2nd byte of inst. to designated register
                                    case MCYCLE is --case bit2int(MCYCLE) is
                                        when "001" => MCYCLE <= "010";--when 1 => MCYCLE <= "010";
                                        when "010" => --when 2 =>
                                            case TSTATES is --case bit2int(TSTATES) is
                                                when "0001" => --when 1 =>
                                                          ADDRESS_OUT <= PC ; --after 1 ns;
                                                          IOMBAR <= '0' ; --after 1 ns;
                                                          S1 <= '1' ; --after 1 ns;
                                                          S0 <= '0' ; --after 1 ns;
                                                when "0010" => --when 2 =>
                                                          PC <= plus16(PC,one16); --inc_sig(PC); -- L&S
                                                          DBUF <= ID;
                                                when "0011" => --when 3 =>
                                                          MCYCLE <= "001";
                                                          case DDD is --case bit2int(DDD) is
                                                              when "000" => B <= DBUF;
                                                              when "001" => C <= DBUF;
                                                              when "010" => D <= DBUF;
                                                              when "011" => E <= DBUF;
                                                              when "100" => H <= DBUF;
                                                              when "101" => L <= DBUF;
                                                              when "111" => ACC <= DBUF;
                                                              when others => null;
                                                          end case; -- end of case DDD
                                                          END_INST_flag <= '1';
                                                when others => null;
                                            end case;
                                        when others => null;
                                    end case;
                                end if;
                            when "111" => -- (SSS = 7) ROTATE_ETC
                                LAST_OP := plus5b("00"&DDD,"01010"); -- L&S
                                case DDD is --case bit2int(DDD) is
                                    when "000" => 						--  RLC
					      ALU_OUT(8) := ACC(7); -- L&S                          
                                              ALU_OUT(7 downto 1) := ACC(6 downto 0);
                                              ALU_OUT(0) := ACC(7);
                                    when "001" => 						--  RRC
					      ALU_OUT(8) := ACC(0); -- L&S 
                                              ALU_OUT(6 downto 0) := ACC(7 downto 1);
                                              ALU_OUT(7) := ACC(0);
                                    when "010" => 						--  RAL
                                              ALU_OUT(8 downto 1) := ACC(7 downto 0);
                                              ALU_OUT(0) := CY;
                                    when "011" => 						--  RAR
					      ALU_OUT(8) := ACC(0); -- L&S 
                                              ALU_OUT(6 downto 0) := ACC(7 downto 1);
                                              ALU_OUT(7) := CY;
                                    when "100" =>  	--completely rewritten by L&S		--  DAA
                                              plus4(ACC(3 downto 0),"0110",temp4bit(3 downto 0),carryout);
					      if(AC = '1') then	--there is a aux-carry from prev addition   L&S 
                                                ALU_OUT(3 downto 0) := temp4bit;
                                              elsif(carryout = '1') then  --ACC(3 downto 0) > 9
                                                ALU_OUT(3 downto 0) := temp4bit;
					      else 
						ALU_OUT(3 downto 0) := ACC(3 downto 0);
					      end if;
                                              
                                              if(carryout ='1') then 
                                                plus4(ACC(7 downto 4),"0111",temp4bit(3 downto 0),carryout);
					      else 
						plus4(ACC(7 downto 4),"0110",temp4bit(3 downto 0),carryout);	
                                              end if;
                                              if(CY = '1') then     --ACC(7 downto 4) had carray from previous add
                                                ALU_OUT(7 downto 4) := temp4bit;
						ALU_OUT(8) := '1';
                                              elsif(carryout = '1') then  --ACC(7 downto 4) > 9 
					        ALU_OUT(7 downto 4) := temp4bit; 
						ALU_OUT(8) := '1';
					      else
						ALU_OUT(7 downto 4) := ACC(7 downto 4);
						ALU_OUT(8) := '0';
					      end if;
                                    when "101" => --int2bit9(ALU_OUT,-bit2int8(ACC) + 255); 	-- CMA
                                            ALU_OUT := plus8_carry(allone8,invert(ACC),'1');
                                    when "110" => CY <= '1';   					-- STC 
                                    when "111" => if (CY = '0') then CY <= '1'; else CY <= '0'; end if;   -- CMC
                                    when others => null;
                                end case;
                                END_INST_flag <= '1';
                             when others => null;
                        end case;                  -- end of case SSS

                    when "01" => -- IGROUP = (0,1) MOV, HLT  op code = 01 DDD SSS (IR = 01)
                        if (SSS = "110") then  --if (bit2int(SSS) = 6) then
                            if (DDD = "110") then  					 -- HLT instruction
                                case TSTATES is --case bit2int(TSTATES) is
                                    when "0100" => --when 4 =>
                                        MCYCLE <= "010"; 
                                        HLTAFF <= '1';
                                    when "0010" => --when 2 => -- L&S(5cycle,but have to leave it 7 here)
                                        END_INST_flag <= '1';
                                    when others => null;
                                end case; -- end of case TSTATES
                            else                         -- (Move from Memory to Reg.)   -- MOVM
                                case TSTATES is --case bit2int(TSTATES) is
                                    when "0001" => --when 1 => -- MEM_HL_READ_T1
                                        ADDRESS_OUT(15 downto 8) <= H ; --after 1 ns;
                                        ADDRESS_OUT(7 downto 0)  <= L ; --after 1 ns;
                                        IOMBAR <= '0' ; --after 1 ns;
                                        S1  <= '1' ; --after 1 ns;
                                        S0  <= '0' ; --after 1 ns;
                                    when "0010" => --when 2 => -- HL_READ_T2
                                        DBUF <= ID;
                                    when "0011" => --when 3 =>
                                        MCYCLE <= "001";
                                        END_INST_flag <= '1';
                                        case DDD is --case bit2int(DDD) is
                                            when "000" => B <= DBUF;
                                            when "001" => C <= DBUF;
                                            when "010" => D <= DBUF;
                                            when "011" => E <= DBUF;
                                            when "100" => H <= DBUF;
                                            when "101" => L <= DBUF;
                                            when "111" => ACC <= DBUF;
                                            when others => null;
                                        end case; -- end of case DDD
                                    when "0100" => -- when 4 =>
                                        MCYCLE <= "010";
                                    when others => null;
                                end case; -- end of case TSTATES
                            end if;
                        elsif (DDD = "110") then  --(move from Reg. to Memory) 		--MOVM
                            case TSTATES is --case bit2int(TSTATES) is
                                when "0001" => --when 1 =>
                                    IOMBAR <= '0' ; --after 1 ns;
                                    S1 <= '0' ; --after 1 ns;
                                    S0 <= '1' ; --after 1 ns;
                                when "0010" => --when 2 => -- WRITE_T2
                                    ADDRESS_OUT(7 downto 0)  <= TEMP;
                                when "0011" => --when 3 =>
                                    MCYCLE <= "001";
                                    END_INST_flag <= '1';
                                when "0100" => --when 4 => -- SOURCE_REG
                                    ADDRESS_OUT(15 downto 8) <= H ; --after 1 ns; -- MEM_HL_WRITE_T1
                                    ADDRESS_OUT(7 downto 0)  <= L ; --after 1 ns;
                                    MCYCLE <= "010";
                                    case SSS is --case bit2int(SSS) is
                                        when "000" => TEMP <= B;
                                        when "001" => TEMP <= C;
                                        when "010" => TEMP <= D;
                                        when "011" => TEMP <= E;
                                        when "100" => TEMP <= H;
                                        when "101" => TEMP <= L;
                                        when "111" => TEMP <= ACC;
                                        when others => null;
                                    end case; -- case SSS
                                when others => null;
                            end case; -- end of case TSTATES
                        else -- ((bit2int(DDD)/=6) and (bit2int(SSS)/=6)) then 		--MOV r1,r2  
                            case SSS is --case bit2int(SSS) is
                                when "000" => temp_MOV := B;
                                when "001" => temp_MOV := C;
                                when "010" => temp_MOV := D;
                                when "011" => temp_MOV := E;
                                when "100" => temp_MOV := H;
                                when "101" => temp_MOV := L;
                                when "111" => temp_MOV := ACC;
                                when others => null;
                            end case; -- case SSS
                            case DDD is --case bit2int(DDD) is
                                when "000" => B <= temp_MOV;
                                when "001" => C <= temp_MOV;
                                when "010" => D <= temp_MOV;
                                when "011" => E <= temp_MOV;
                                when "100" => H <= temp_MOV;
                                when "101" => L <= temp_MOV;
                                when "111" => ACC <= temp_MOV;
                                when others => null;
                            end case; -- end of case DDD
                            END_INST_flag <= '1';
                        end if; -- MOV_HLT (IRGROUP = 01)

                    when "10" =>  -- IGROUP = (1,0)  op code = 10 DDD SSS (IR = 10) (ALU operations)
                              LAST_OP := "00"&DDD;
--
-- The Group 2 instructions complete execution during state T2 of the next instruction.
-- The DDD field is used to decode the operation.
                              if NOT(SSS = "110") then  -- One MCycle 1, Tstate 4
                                  case SSS is --case bit2int(SSS) is
                                      when "000" => TEMP <= B;
                                      when "001" => TEMP <= C;
                                      when "010" => TEMP <= D;
                                      when "011" => TEMP <= E;
                                      when "100" => TEMP <= H;
                                      when "101" => TEMP <= L;
                                      when "111" => TEMP <= ACC;
                                      when others => null;
                                  end case;  -- source_reg
                                  ACT <= ACC;
                                  END_INST_flag <= '1';
                              else    			-- SSS = 6 => memory fetch
                                  case TSTATES is --case bit2int(TSTATES) is
                                      when "0001" => --when 1 =>
                                          ADDRESS_OUT(15 downto 8) <= H ; --after 1 ns;
                                          ADDRESS_OUT(7 downto 0)  <= L ; --after 1 ns;
                                          IOMBAR <= '0' ; --after 1 ns;
                                          S1  <= '1' ; --after 1 ns;
                                          S0  <= '0' ; --after 1 ns;
                                      when "0010" => --when 2 =>
                                          DBUF <= ID;
                                      when "0011" => --when 3 =>
                                          TEMP <= DBUF;
                                          END_INST_flag <= '1';
                                          MCYCLE <= "001";
                                      when "0100" => ACT <= ACC;--when 4 => ACT <= ACC; 
						 -- if TSTATES=4, then MCYCLE must be 1
                                          MCYCLE <= "010";
                                      when others => null;
                                  end case; -- TSTATES
                              end if;
                    when "11" =>  -- IGROUP = (1,1) op code = 11 DDD SSS (IR = 11)
                        case SSS is --case bit2int(SSS) is
                            when "000" => 					-- RC (Return Conditional)
                                case MCYCLE is --case bit2int(MCYCLE) is
                                    when "001" => --when 1 =>
                                        case TSTATES is --case bit2int(TSTATES) is
                                        when "0100" => --when 4 =>
                                            case DDD is --case bit2int(DDD) is
                                               when "000" => CC_TEST <= not Z;
                                               when "001" => CC_TEST <= Z;
                                               when "010" => CC_TEST <= not CY;
                                               when "011" => CC_TEST <= CY;
                                               when "100" => CC_TEST <= not P;
                                               when "101" => CC_TEST <= P;
                                               when "110" => CC_TEST <= not S;
                                               when "111" => CC_TEST <= S;
                                               when others => null;
                                            end case;  -- DPAIR
                                        when "0110" => --when 6 =>
                                            if (CC_TEST = '0') then 
                                                END_INST_flag <= '1';
                                            else
                                                MCYCLE <= "010";
                                            end if;
                                        when others => null;
                                        end case; -- TSTATES
                                    when "010" => --when 2 =>
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 => -- MEM_SP_READ_T1
                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                S1 <= '1' ; --after 1 ns;
                                                S0 <= '0' ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 => -- SP_READ_T2
																SP <= plus16(SP,one16);    -- L&S  4.26
                                                PC(7 downto 0) <= ID;
                                                Z_reg <= ID;
                                            when "0011" => --when 3 =>
                                                MCYCLE <= "011";
                                            when others => null;
                                        end case; -- TSTATES
                                    when "011" => --when 3 =>
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 => 
                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                S1 <= '1' ; --after 1 ns;
                                                S0 <= '0' ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 => -- SP_READ_T2
																SP <= plus16(SP,one16);
                                                PC(15 downto 8) <= ID;
                                                W_reg <= ID;
                                            when "0011" => --when 3 =>
                                                END_INST_flag <= '1';
                                                FETCH_F_WZ <= '1';
                                                MCYCLE <= "001";
                                            when others => null;
                                        end case; -- TSTATES
                                    when others => null;
                                    end case; -- MCYCLE
                            when "001" =>  --when 1 =>-- SSS = 1
                                case DDD(0) is --L&S
                                    when '0' =>        				--  POP rp
-- rp - register pair
-- rp = 00: BC , rp = 01: DE , rp = 10: HL , rp = 11: PSW
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 => -- MEM_SP_READ_T1
                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                S1 <= '1' ; --after 1 ns;
                                                S0 <= '0' ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 => -- SP_READ_T2
                                                DBUF <= ID;  -- buffer the input data
                                                SP <= plus16(SP,one16); --inc_sig(SP);
                                            when "0011" => --when 3 =>
                                                case MCYCLE is --case bit2int(MCYCLE) is
                                                when "010" => --when 2 =>
                                                    MCYCLE <= "011";
                                                      --case DPAIR is --case bit2int(DPAIR) is --L&S
                                                      case DDD(2 downto 1) is --L&S
                                                        when "00" => C  <= DBUF;
                                                        when "01" => E  <= DBUF;
                                                        when "10" => L  <= DBUF;
                                                        when "11" => CY <= DBUF(0);
                                                                     P  <= DBUF(2);
                                                                     AC <= DBUF(4);
                                                                     Z  <= DBUF(6);
                                                                     S  <= DBUF(7);
                                                        when others => null;
                                                      end case;
                                                when "011" => --when 3 =>
                                                    MCYCLE <= "001";
                                                    --case DPAIR is --case bit2int(DPAIR) is --L&S
                                                      case DDD(2 downto 1) is --L&S
                                                        when "00" => B   <= DBUF;
                                                        when "01" => D   <= DBUF;
                                                        when "10" => H   <= DBUF;
                                                        when "11" => ACC <= DBUF;
                                                        when others => null;
                                                    end case;
                                                    END_INST_flag <= '1';
                                                when others => null;
                                                end case;
                                            when "0100" =>MCYCLE <= "010";-- when 4 => MCYCLE <= "010"; -- if TSTATES = 4, MCYCLE must be 1
                                            when others => null;
                                            end case;
                                    when '1' =>
                                        --case DPAIR is --case bit2int(DPAIR) is --L&S
                                        case DDD(2 downto 1) is --L&S
                                            when "00" => 				-- RET
                                                case MCYCLE is --case bit2int(MCYCLE) is
                                                    when "001" => --when 1 =>
                                                        MCYCLE <= "010";
                                                    when "010" => --when 2 =>
                                                        case TSTATES is --case bit2int(TSTATES) is
                                                            when "0001" => --when 1 => -- MEM_SP_READ_T1
                                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                                S1 <= '1' ; --after 1 ns;
                                                                S0 <= '0' ; --after 1 ns;
                                                                IOMBAR <= '0' ; --after 1 ns;
                                                            when "0010" => --when 2 => -- SP_READ_T2
                                                                SP <= plus16(SP,one16); --inc_sig(SP);
                                                                PC(7 downto 0) <= ID;
                                                            when "0011" => --when 3 =>
                                                                MCYCLE <= "011";
                                                            when others => null;
                                                        end case; -- TSTATES
                                                    when "011" => --when 3 =>
                                                        case TSTATES is --case bit2int(TSTATES) is
                                                            when "0001" => --when 1 => 
                                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                                S1 <= '1' ; --after 1 ns;
                                                                S0 <= '0' ; --after 1 ns;
                                                                IOMBAR <= '0' ; --after 1 ns;
                                                            when "0010" => --when 2 => -- SP_READ_T2
                                                                SP <= plus16(SP,one16); --inc_sig(SP);
                                                                PC(15 downto 8) <= ID;
                                                            when "0011" => --when 3 =>
                                                                END_INST_flag <= '1';
                                                                MCYCLE <= "001";
                                                            when others => null;
                                                        end case; -- TSTATES
                                                    when others => null;
                                                    end case; -- MCYCLE
																when "10" => -- PCHL
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0100" => --when 4 =>
                                                        PC(15 downto 8) <= H;
                                                    when "0101" => --when 5 =>
                                                        PC(7 downto 0) <= L;
																	 when "0110" => END_INST_flag <= '1';
                                                    when others => null;
                                                end case;
                                            when "11" => -- SPHL
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0100" => --when 4 =>
                                                        SP(15 downto 8) <= H;
                                                    when "0101" => --when 5 =>
                                                        SP(7 downto 0) <= L;
																	 when "0110" => END_INST_flag <= '1';
                                                    when others => null;
                                                end case;
                                            when others => null;
                                        end case; -- end of case DPAIR
                                     when others => null;
                                    end case;   -- end of case IRBIT3
                            when "010" => --when 2 => 				-- Conditional Jump
                                case MCYCLE is --case bit2int(MCYCLE) is
                                    when "001" => --when 1 =>  -- TSTATES = 4
                                        case DDD is --case bit2int(DDD) is
                                           when "000" => CC_TEST <= not Z;
                                           when "001" => CC_TEST <= Z;
                                           when "010" => CC_TEST <= not CY;
                                           when "011" => CC_TEST <= CY;
                                           when "100" => CC_TEST <= not P;
                                           when "101" => CC_TEST <= P;
                                           when "110" => CC_TEST <= not S;
                                           when "111" => CC_TEST <= S;
                                           when others => null;
                                        end case;
                                        MCYCLE <= "010";
                                    when "010" => --when 2 =>
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 => -- MEM_SP_READ_T1
                                                ADDRESS_OUT <= PC ; --after 1 ns;
                                                S1 <= '1' ; --after 1 ns;
                                                S0 <= '0' ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 =>
                                                PC <= plus16(PC,one16); --inc_sig(PC);
                                                Z_reg <= ID;  -- Byte2 -> Z
                                            when "0011" => --when 3 =>
																if(CC_TEST = '1') then MCYCLE <= "011";
																else
																	MCYCLE <= "001";
																	END_INST_flag <= '1';
																	PC <= plus16(PC,one16); --S- Skip the not needed add byte to make 2Machine Cycles long
																	ADDRESS_OUT <= PC; --S- Skip the not needed add byte to make 2Machine Cycles long													
																end if;										-- L&S  4.26
                                            when others => null;
                                        end case; -- TSTATES
                                    when "011" => --when 3 =>
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 => 
                                                ADDRESS_OUT <= PC ; --after 1 ns;
                                                S1 <= '1' ; --after 1 ns;
                                                S0 <= '0' ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 =>
                                                PC <= plus16(PC,one16); --inc_sig(PC);
                                                W_reg <= ID;  -- Byte3 -> W
                                            when "0011" => --when 3 =>
                                                ADDRESS_OUT(15 downto 8) <= W_REG ; --after 1 ns;
                                                ADDRESS_OUT(7 downto 0)  <= Z_REG ; --after 1 ns;
																PC(15 downto 8) <= W_REG ; --S- Added to expedite jumps
                                                PC(7 downto 0)  <= Z_REG ; --S- Added to expedite jumps
                                                END_INST_flag <= '1';
                                                if(CC_TEST = '1') then FETCH_F_WZ <= '1'; else FETCH_F_WZ <= '0'; end if;
                                                MCYCLE <= "001";
                                            when others => null;
                                        end case; -- TSTATES
                                     when others => null;
                                    end case; -- MCYCLE
                            when "011" => --when 3 =>
                                case DDD is  --case bit2int(DDD) is
                                    when "000" => --when 0 => 				-- JMP
                                        case MCYCLE is --case bit2int(MCYCLE) is
                                            when "001" => --when 1 =>  -- TSTATES = 4
                                                MCYCLE <= "010";
                                            when "010" => --when 2 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => -- MEM_SP_READ_T1
                                                        ADDRESS_OUT <= PC ; --after 1 ns;
                                                        S1 <= '1' ; --after 1 ns;
                                                        S0 <= '0' ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 =>
                                                        PC <= plus16(PC,one16); --inc_sig(PC);
                                                        Z_reg <= ID;  -- Byte2 -> Z
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "011";
                                                    when others => null;
                                                end case; -- TSTATES
                                            when "011" => --when 3 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => 
                                                        ADDRESS_OUT <= PC ; --after 1 ns;
                                                        S1 <= '1' ; --after 1 ns;
                                                        S0 <= '0' ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 =>
                                                        PC <= plus16(PC,one16); --inc_sig(PC);
                                                        W_reg <= ID;  -- Byte3 -> W
                                                    when "0011" => --when 3 =>
                                                        ADDRESS_OUT(15 downto 8) <= W_REG ; --after 1 ns;
                                                        ADDRESS_OUT(7 downto 0)  <= Z_REG ; --after 1 ns;
																		  PC(15 downto 8) <= W_REG ; --S- Added to expedite jumps
                                                        PC(7 downto 0)  <= Z_REG ; --S- Added to expedite jumps
                                                        END_INST_flag <= '1';
                                                        FETCH_F_WZ <= '1';
                                                        MCYCLE <= "001";
                                                    when others => null;
                                                end case; -- TSTATES
                                             when others => null;
                                            end case; -- MCYCLE
				    when "010" | "011" => --when 2|3 => 			-- IO_OUT/IO_IN
                                        case MCYCLE is --case bit2int(MCYCLE) is
                                            when "001" => --when 1 =>  -- TSTATES = 4
                                                MCYCLE <= "010";
                                            when "010" => --when 2 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => -- MEM_SP_READ_T1
                                                        ADDRESS_OUT <= PC ; --after 1 ns;
                                                        S1 <= '1' ; --after 1 ns;
                                                        S0 <= '0' ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 =>
                                                        PC <= plus16(PC,one16); --inc_sig(PC);
                                                        Z_reg <= ID;  -- Byte2 -> Z
                                                        W_reg <= ID;  -- Byte2 -> W
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "011";
                                                    when others => null;
                                                end case; -- TSTATES
                                            when "011" => --when 3 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => 
                                                        ADDRESS_OUT(7 downto 0) <= Z_reg ; --after 1 ns; --S- Changed to use loaded byte
																		  ADDRESS_OUT(15 downto 8) <= W_reg ; --after 1 ns; --S- Changed to use loaded byte
																		  if(DDD(0) = '0') then --S- added to fix Status for IO_IN
																			S1  <= '0' ; --after 1 ns;
																			S0  <= '1' ; --after 1 ns;
																		  else
																			S1  <= '1' ; --after 1 ns;
																			S0  <= '0' ; --after 1 ns;
																		  end if;
                                                        IOMBAR <= '1' ; --after 1 ns; --S- IO MC
                                                    when "0010" => --when 2 =>
                                                        --if(irbit3 = '0') then -- OUT instruction --L&S
                                                        if(DDD(0) = '0') then --L&S
                                                            ADDRESS_OUT(7 downto 0)  <= ACC ; --after 1 ns;
                                                        else                -- IN instruction
                                                            ACC <= ID ; --after 1 ns;
                                                        end if;
                                                    when "0011" => --when 3 =>
                                                        END_INST_flag <= '1';
                                                        MCYCLE <= "001";
                                                    when others => null;
                                                end case; -- TSTATES
                                             when others => null;
                                            end case; -- MCYCLE
                                    when "100" => --when 4 => 					-- XTHL
                                        case MCYCLE is --case bit2int(MCYCLE) is
                                            when "001" => --when 1 =>
                                                MCYCLE <= "010";
                                            when "010" => --when 2 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 =>
                                                        ADDRESS_OUT <= SP ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '1' ; --after 1 ns;
                                                        S0  <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 => -- PC_READ_T2
                                                        SP <= plus16(SP,one16); --inc_sig(SP);
                                                        Z_reg <= ID;
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "011";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when "011" => --when 3 => 
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 =>
                                                        ADDRESS_OUT <= SP ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '1' ; --after 1 ns;
                                                        S0  <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 => -- PC_READ_T2
                                                        W_reg <= ID;
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "100";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when "100" => --when 4 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 =>
                                                        ADDRESS_OUT <= SP ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '0' ; --after 1 ns;
                                                        S0  <= '1' ; --after 1 ns;
                                                    when "0010" => --when 2 =>
                                                        ADDRESS_OUT(7 downto 0) <= H ; --after 1 ns;
                                                        SP <= plus16(SP,allone16); --dec_sig(SP);
                                                    when "0011" => --when 3 =>
                                                        MCYCLE <= "101";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when "101" => --when 5 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 =>
                                                        ADDRESS_OUT <= SP ; --after 1 ns;
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                        S1  <= '0' ; --after 1 ns;
                                                        S0  <= '1' ; --after 1 ns;
                                                    when "0010" => --when 2 =>
                                                        ADDRESS_OUT(7 downto 0) <= L ; --after 1 ns;
                                                    when "0011" => --when 3 =>
                                                        L <= Z_reg;
                                                        H <= W_reg;
                                                        END_INST_flag <= '1';
                                                        MCYCLE <= "001";
                                                    when others => null;
                                                end case;  -- TSTATES
                                            when others => null;
                                        end case;  -- MCYCLE
                                    when "101" => --when 5 => 					-- XCHG
                                        temp_D := D;
                                        temp_E := E;
                                        D <= H;
                                        E <= L;
                                        H <= temp_D;
                                        L <= temp_E;
				        END_INST_flag <= '1';
                                    when "110" => --when 6 => 
                                          INTEFF <= '0';  			-- (DI) disable interrupts
				          END_INST_flag <= '1';
                                    when "111" => --when 7 => 
                                          INTEFF <= '1';  			-- (EI) enable interrupts
		                          END_INST_flag <= '1';
                                    when others => null; -- when "001" => NOOP; ILLEGAL INSTR
                               end case; -- end of case DDD
                            when "100" => --when 4 => 				-- CONDITIONAL CALL
                                case MCYCLE is --case bit2int(MCYCLE) is
                                    when "001" => --when 1 => 
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0100" =>        --when 4 => dec_sig(SP);
                                                SP <= plus16(SP,allone16); --dec_sig(SP);
                                                case DDD is --case bit2int(DDD) is
                                                   when "000" => CC_TEST <= not Z;
                                                   when "001" => CC_TEST <= Z;
                                                   when "010" => CC_TEST <= not CY;
                                                   when "011" => CC_TEST <= CY;
                                                   when "100" => CC_TEST <= not P;
                                                   when "101" => CC_TEST <= P;
                                                   when "110" => CC_TEST <= not S;
                                                   when "111" => CC_TEST <= S;
                                                   when others => null;
                                                end case;
                                            when "0110" => MCYCLE <= "010";
                                            when others => null;
                                        end case;
                                    when "010" => --when 2 => 
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 =>   -- MEM_PC_READ_T1;
                                                ADDRESS_OUT   <= PC ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                                S1  <= '1' ; --after 1 ns;
                                                S0  <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 =>  -- PC_READ_T2;
                                                PC <= plus16(PC,one16); --inc_sig(PC);
                                                DBUF <= ID;
                                            when "0011" => --when 3 =>
                                                Z_REG <= DBUF;
																if (CC_TEST = '1') then MCYCLE <= "011";
																else
																	 MCYCLE <= "001";
																	 END_INST_flag <= '1';
																	 PC <= plus16(PC,one16); --S- To keep thr right number of Machine cycles
																	 ADDRESS_OUT <= PC ; --S- To keep thr right number of Machine cycles
																end if;
																-- L&S  4.26
                                            when others => null;
                                        end case;
                                    when "011" => --when 3 =>
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 =>   -- MEM_PC_READ_T1;
                                                ADDRESS_OUT   <= PC ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                                S1  <= '1' ; --after 1 ns;
                                                S0  <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 =>  -- PC_READ_T2;
                                                PC <= plus16(PC,one16); --inc_sig(PC);
                                                DBUF <= ID;
                                            when "0011" => --when 3 =>
                                                W_REG <= DBUF;
                                                MCYCLE <= "100";
                                            when others => null;
                                        end case;
                                    when "100" => --when 4 => 
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 =>  -- MEM_SP_WRITE_T1
                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                S1 <= '0' ; --after 1 ns;
                                                S0 <= '0' ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 =>
                                                SP <= plus16(SP,allone16); --dec_sig(SP); 
                                                DBUF <= PC(15 downto 8);
																ADDRESS_OUT(7 downto 0) <= PC(15 downto 8); --after 1 ns; --S- Moved up a MC
                                            when "0011" => --when 3 => -- WRITE_T3; 
                                                --S- ADDRESS_OUT(7 downto 0) <= DBUF ; --after 1 ns;
                                                MCYCLE <= "101";
                                            when others => null;
                                        end case;
                                    when "101" => --when 5 => 
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 =>  -- MEM_SP_WRITE_T1
                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                S1 <= '0' ; --after 1 ns;
                                                S0 <= '0' ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 =>
                                                DBUF <= PC(7 downto 0);
																ADDRESS_OUT(7 downto 0) <= PC(7 downto 0); --after 1 ns; --S- Moved up a MC
                                            when "0011" => --when 3 => -- WRITE_T3; 
																END_INST_flag <= '1';
                                                --S- ADDRESS_OUT(7 downto 0) <= DBUF ; --after 1 ns;
															   PC(15 downto 8) <= W_REG ; --S- Added to expedite jumps
															   PC(7 downto 0)  <= Z_REG ; --S- Added to expedite jumps
                                                MCYCLE <= "001";
                                                if(CC_TEST = '1') then FETCH_F_WZ <= '1'; else FETCH_F_WZ <= '0'; end if;
                                            when others => null;
                                        end case;
                                    when others => null;
                                end case;
                            when "101" => --when 5 =>             -- IGROUP = 3, SSS = 5
                                --case IRBIT3 is --L&S
                                case DDD(0) is --L&S
                                    when '0' => 				-- PUSH rp (register pair)
                                        case MCYCLE is --case bit2int(MCYCLE) is
                                            when "001" => --when 1 => 
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0101" =>    --when 5 =>  -- Compared to 8080
                                                        SP <= plus16(SP,allone16); --dec_sig(SP);
                                                    when "0110" => --when 6 =>  -- 8085 uses an additional state, T6
                                                        MCYCLE <= "010";
                                                        ADDRESS_OUT <= SP ; --after 1 ns;
                                                    when others => null;
                                                end case;
                                            when "010" => --when 2 =>
                                                case TSTATES is --case bit2int(TSTATES) is
                                                    when "0001" => --when 1 => -- MEM_SP_WRITE_T1
                                                        ADDRESS_OUT <= SP ; --after 1 ns;
                                                        S1 <= '0' ; --after 1 ns;
                                                        S0 <= '1' ; --after 1 ns;  --S- Changed to 1 for write status
                                                        IOMBAR <= '0' ; --after 1 ns;
                                                    when "0010" => --when 2 => -- RP_PSW_SOURCE
                                                        --case DPAIR is --case bit2int(DPAIR) is --L&S
                                                        case DDD(2 downto 1) is --L&S
                                                            when "00" => ADDRESS_OUT(7 downto 0) <= B(7 downto 0) ; --after 1 ns;
                                                            when "01" => ADDRESS_OUT(7 downto 0) <= D ; --after 1 ns;
                                                            when "10" => ADDRESS_OUT(7 downto 0) <= H ; --after 1 ns;
                                                            when "11" => ADDRESS_OUT(7 downto 0) <= ACC ; --after 1 ns;
                                                            when others => null;
                                                        end case;
                                                        SP <= plus16(SP,allone16); --dec_sig(SP);
                                                    when "0011" => --when 3 => 
                                                        MCYCLE <= "011";
                                                        ADDRESS_OUT <= SP ; --after 1 ns;
                                                    when others => null;
                                                end case;
                                            when "011" => --when 3 => 
                                                case TSTATES is --case bit2int(TSTATES) is
                                                when "0001" => --when 1 => -- MEM_SP_WRITE_T1
                                                    ADDRESS_OUT <= SP ; --after 1 ns;
                                                    S1 <= '0' ; --after 1 ns;
                                                    S0 <= '1' ; --after 1 ns; --S- Changed to 1 for write status
                                                    IOMBAR <= '0' ; --after 1 ns;
                                                when "0010" => --when 2 =>  -- RP_PSW_SOURCE(2)
                                                    --case DPAIR is --case bit2int(DPAIR) is --L&S
                                                    case DDD(2 downto 1) is --L&S
                                                        when "00" => ADDRESS_OUT(7 downto 0) <= C ; --after 1 ns;
                                                        when "01" => ADDRESS_OUT(7 downto 0) <= E ; --after 1 ns;
                                                        when "10" => ADDRESS_OUT(7 downto 0) <= L ; --after 1 ns;
                                                        when "11" =>
                                                            ADDRESS_OUT(0) <= CY ; --after 1 ns;  -- condition codes
                                                            ADDRESS_OUT(1) <= '0' ; --after 1 ns;
                                                            ADDRESS_OUT(2) <= P ; --after 1 ns;
                                                            ADDRESS_OUT(3) <= '0' ; --after 1 ns;
                                                            ADDRESS_OUT(4) <= AC ; --after 1 ns;
                                                            ADDRESS_OUT(5) <= '0' ; --after 1 ns;
                                                            ADDRESS_OUT(6) <= Z ; --after 1 ns;
                                                            ADDRESS_OUT(7) <= S ; --after 1 ns;
                                                        when others => null;
                                                    end case;
                                                when "0011" => --when 3 => 
                                                    END_INST_flag <= '1';
                                                    MCYCLE <= "001";
                                                    ADDRESS_OUT <= PC ; --after 1 ns;
                                                when others => null;
                                               end case;
                                             when others => null;
                                            end case;
                                    when '1' =>
                                        --case DPAIR is --case bit2int(DPAIR) is --L&S
                                        case DDD(2 downto 1) is --L&S
                                            when "00" => 					-- CALL
                                                case MCYCLE is --case bit2int(MCYCLE) is
                                                    when "001" => --when 1 => 
                                                        case TSTATES is --case bit2int(TSTATES) is
                                                            when "0100" => SP <= plus16(SP,allone16); --dec_sig(SP); --when 4 => dec_sig(SP);
                                                            when "0110" => MCYCLE <= "010"; --when 5 => MCYCLE <= "010";
                                                            when others => null;
                                                        end case;
                                                    when "010" => --when 2 => 
                                                        case TSTATES is --case bit2int(TSTATES) is
                                                            when "0001" => --when 1 =>   -- MEM_PC_READ_T1;
                                                                ADDRESS_OUT   <= PC ; --after 1 ns;
                                                                IOMBAR <= '0' ; --after 1 ns;
                                                                S1  <= '1' ; --after 1 ns;
                                                                S0  <= '0' ; --after 1 ns;
                                                            when "0010" => --when 2 =>  -- PC_READ_T2;
                                                                PC <= plus16(PC,one16); --inc_sig(PC);
                                                                DBUF <= ID;
                                                            when "0011" => --when 3 =>
                                                                Z_REG <= DBUF;
                                                                MCYCLE <= "011";
                                                            when others => null;
                                                        end case;
                                                    when "011" => --when 3 => 
                                                        case TSTATES is --case bit2int(TSTATES) is
                                                            when "0001" => --when 1 =>   -- MEM_PC_READ_T1;
                                                                ADDRESS_OUT   <= PC ; --after 1 ns;
                                                                IOMBAR <= '0' ; --after 1 ns;
                                                                S1  <= '1' ; --after 1 ns;
                                                                S0  <= '0' ; --after 1 ns;
                                                            when "0010" => --when 2 =>  -- PC_READ_T2;
                                                                PC <= plus16(PC,one16); --inc_sig(PC);
                                                                DBUF <= ID;
                                                            when "0011" => --when 3 =>
                                                                W_REG <= DBUF;
                                                                MCYCLE <= "100";
                                                            when others => null;
                                                        end case;
                                                    when "100" => --when 4 => 
                                                        case TSTATES is --case bit2int(TSTATES) is
                                                            when "0001" => --when 1 =>  -- MEM_SP_WRITE_T1
                                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                                S1 <= '0' ; --after 1 ns;
                                                                S0 <= '0' ; --after 1 ns;
                                                                IOMBAR <= '0' ; --after 1 ns;
                                                            when "0010" => --when 2 =>
                                                                SP <= plus16(SP,allone16); --dec_sig(SP);
                                                                DBUF <= PC(15 downto 8);
																					 ADDRESS_OUT(7 downto 0) <= PC(15 downto 8); --S- Moved up a cycle
                                                            when "0011" => --when 3 => -- WRITE_T3; 
                                                                --S- ADDRESS_OUT(7 downto 0) <= DBUF ; --after 1 ns;
                                                                MCYCLE <= "101";
                                                            when others => null;
                                                        end case;
                                                    when "101" => --when 5 => 
                                                        case TSTATES is --case bit2int(TSTATES) is
                                                            when "0001" => --when 1 =>  -- MEM_SP_WRITE_T1
                                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                                S1 <= '0' ; --after 1 ns;
                                                                S0 <= '0' ; --after 1 ns;
                                                                IOMBAR <= '0' ; --after 1 ns;
                                                            when "0010" => --when 2 =>
                                                                DBUF <= PC(7 downto 0);
																					 ADDRESS_OUT(7 downto 0) <= PC(7 downto 0); --S- Moved up a cycle
                                                            when "0011" => --when 3 => -- WRITE_T3; 
																				    PC(15 downto 8) <= W_REG ; --S- Added to expedite jumps
																				    PC(7 downto 0)  <= Z_REG ; --S- Added to expedite jumps
                                                                MCYCLE <= "001";
                                                                FETCH_F_WZ <= '1';
																					 END_INST_flag <= '1';
                                                            when others => null;
                                                        end case;
                                                     when others => null;
                                                end case;
                                          when others =>
															END_INST_flag <= '1';
														null; 			--NOOP; --when 1|2|3 => ILLEGAL  INSTR
                                        end case; -- end of case DPAIR
                                    when others => null;
                                end case; -- end of case IRBIT3
                            when "110" => --when 6 =>    -- SSS = 6 => memory fetch		-- ADI,ACI,SUB,SBI
                                LAST_OP := "00"&DDD; --LAST_OP := bit2int3(DDD);		-- ANI,XRI,ORI,CPI
                                case TSTATES is --case bit2int(TSTATES) is
                                    when "0001" => --when 1 =>
                                        ADDRESS_OUT <= PC ; --after 1 ns;
                                        IOMBAR <= '0' ; --after 1 ns;
                                        S1  <= '1' ; --after 1 ns;
                                        S0  <= '0' ; --after 1 ns;
                                    when "0010" => --when 2 =>
                                        PC <= plus16(PC,one16); --inc_sig(PC);
                                        DBUF <= ID;
                                    when "0011" => --when 3 =>
                                        TEMP <= DBUF;
                                        END_INST_flag <= '1';
                                        MCYCLE <= "001";
                                    when "0100" => --when 4 => ACT <= ACC;  -- if TSTATES=4, then MCYCLE must be 1
													 ACT <= ACC;
                                        MCYCLE <= "010";
                                    when others => null;
                                end case; -- TSTATES
                            when "111" => --when 7 => 						-- RST
                                case MCYCLE is --case bit2int(MCYCLE) is
                                    when "001" => --when 1 =>
                                        case TSTATES is --case bit2int(TSTATES) is
                                        when "0100" => --when 4 =>
                                            --int2bit_sig8(W_reg,0); 
                                            W_reg <= "00000000";
                                            SP <= plus16(SP,allone16); --dec_sig(SP);
                                        when "0110" => --when 6 =>
                                            MCYCLE <= "010";
                                        when others => null;
                                        end case; -- TSTATES
                                    when "010" => --when 2 =>
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 => -- MEM_SP_READ_T1
                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                S1 <= '1' ; --after 1 ns;
                                                S0 <= '0' ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 => -- SP_READ_T2
                                                SP <= plus16(SP,allone16); --dec_sig(SP);
                                                ADDRESS_OUT(7 downto 0) <= PC(15 downto 8) ; --after 1 ns;
                                            when "0011" => --when 3 =>
                                                MCYCLE <= "011";
                                            when others => null;
                                        end case; -- TSTATES
                                    when "011" => --when 3 =>
                                        case TSTATES is --case bit2int(TSTATES) is
                                            when "0001" => --when 1 => 
                                                ADDRESS_OUT <= SP ; --after 1 ns;
                                                S1 <= '1' ; --after 1 ns;
                                                S0 <= '0' ; --after 1 ns;
                                                IOMBAR <= '0' ; --after 1 ns;
                                            when "0010" => --when 2 => -- SP_READ_T2
                                                ADDRESS_OUT(7 downto 0) <= PC(7 downto 0) ; --after 1 ns;
                                                Z_reg(7 downto 6) <= "00";
                                                Z_reg(5 downto 3) <= TEMP(5 downto 3);
                                                Z_reg(2 downto 0) <= "000";
                                            when "0011" => --when 3 =>
																PC(15 downto 8) <= W_REG ; --S- Added to expedite jumps
                                                PC(7 downto 0)  <= Z_REG ; --S- Added to expedite jumps
                                                END_INST_flag <= '1';
                                                FETCH_F_WZ <= '1';
                                                MCYCLE <= "001";
                                            when others => null;
                                        end case; -- TSTATES
                                     when others => null;
                                end case; -- MCYCLE
                            when others => null;
                        end case; -- end of case SSS
                    when others => null;
                 end case; -- end of case IGROUP
					  
					if HLDA_STATE = '1' then --S- 0110
						ADDRESS_OUT(15 downto 0) <= "ZZZZZZZZZZZZZZZZ"; --S- Added High Impedance out
						IOMBAR <= 'Z' ; --S- Added High Impedance out
						HLDA <= '1';
						HLDA_STATE_d <= '1';
					else HLDA <= '0'; HLDA_STATE_d <= '0';
					end if;
					 
					  
            end if; -- (MCYCLE = 1) ELSE (MCYCLE > 1)

---------------------------------------------------------------------------

-- Internally generated interrupt vectors
	    if(PRIO_ENCODE = "000") then
		PC		<= "0000000000100100";
		ADDRESS_out	<= "0000000000100100";
	    elsif PRIO_ENCODE = "001" then
		PC		<= "0000000000111100";
		ADDRESS_out	<= "0000000000111100";
	    elsif PRIO_ENCODE = "010" then
		PC		<= "0000000000110100";
		ADDRESS_out	<= "0000000000110100";
	    elsif PRIO_ENCODE = "011" then
		PC		<= "0000000000101100";
		ADDRESS_out	<= "0000000000101100";
	    end if;
     end if;  -- if RESETINBAR = '0' else if up_edge(X1)
     end process P2;




-------------------------------------------------------------------------
-- This next process computes some outputs, not a registered process
--
-------------------------------------------------------------------------
     P3: process(TSTATES,MCYCLE,IGROUP,SSS,DDD,RD1,INTA,RD2,BIMCB,SOD_FF,
                WR1,RESETOUTFF)

     variable DAD_inst                : std_logic; --bit;

     begin

        if ((IGROUP = "00") and (SSS = "001") and (DDD(0) ='1')) then --L&S
            DAD_inst := '0'; else DAD_inst := '1'; end if;

        if(MCYCLE = "001") then 
            if(INTA = '1') then BIMCB <= '1'; else BIMCB <= '0'; end if;
        else  -- MCYCLE /= 1
            if(DAD_inst = '0') then BIMCB <= '1'; else BIMCB <= '0'; end if;
        end if;

		  if(RESETINBAR = '0' OR HLDA_STATE_d = '1') then --S- Added for status accuracy
			RDBAR <= 'Z'; --S- Added for status accuracy
			WRBAR <= 'Z'; --S- Added for status accuracy
			INTABAR <= '1'; --S- Added for status accuracy
		  else
			RDBAR <= ((BIMCB or INTA) or (not(RD1) and not(RD2)));
			WRBAR <= not(WR1) or not(DAD_inst);
			
         INTABAR <= not INTA;
		  end if;
            
        SOD <= SOD_FF ; --after 5 ns;
        RESETOUT <= not RESETOUTFF;

  end process P3;

     
-------------------------------------------------------------------------
-- This next process computes the T-states (minor state) transitions.
--
-- The order of the T-states (and their mapping into
-- the gate-level state machine) are as follows
-- TX, T1, T2, T3, T4, T5, T6, TW, THALT, TH
--
-- M1, M2, M3, M4, M5
-------------------------------------------------------------------------
P4: process(RESETINBAR,X1,TSTATES,MCYCLE,IGROUP,DDD,SSS,HOLDFF,HLTAFF,HOLD,READY,RST75FF)
  variable BIMC	                   : logic_state;

  begin

    if(RESETINBAR = '0') then
        TSTATES <= "0000";
        HOLDFF <= '0';
		  HLDA_STATE <= '0'; --S- Hold variable
	
    elsif((X1 = '1') and (X1'event)) then   -- X1 is the clock signal
        case TSTATES is 
          when "0000" =>
                    TSTATES <= "0001";

          when "0001" =>
                   if (HLTAFF = '1') then TSTATES <= "1000"; --TT := 8; 
                   else TSTATES <= "0010"; --TT := 2; 
                   end if;

          when "0010" =>
                    if ((SSS = "001") and (DDD(0) = '1') and (IGROUP = "00") -- DAD inst. --L&S
                          and ((MCYCLE = "010") or (MCYCLE = "011"))) then
                    BIMC := 1; else BIMC := 0; end if;
                    if (READY = '1') or (BIMC = 1) then 
                        TSTATES <= "0011"; --TT := 3;
                        if (HOLD = '1') then HOLDFF <= '1'; 
                        else HOLDFF <= '0'; end if;
                    else TSTATES <= "0111"; -- else TT := 7;
                    end if;

	  when "0111" =>
                    if (READY = '1') then 
                        TSTATES <= "0011"; 
                        if (HOLD = '1') then HOLDFF <= '1'; 
                        else HOLDFF <= '0'; end if;
                    else TSTATES <= "0111";
                    end if;
		    
          when "0011" =>
                    if (HOLDFF = '1') then
								HLDA_STATE <= '1'; --S- Hold variable
                    end if;
                    if MCYCLE = "001" then TSTATES <= "0100"; 
                    elsif HOLDFF = '1' then TSTATES <= "1001"; --TT := 9;
                    else
                        TSTATES <= "0001"; --TT := 1;
                    end if;
          when "0100" =>
                    if( ((IGROUP="00") and (SSS="011"))  -- INX/DCX instructions
                           or 
                       ((IGROUP="11") and ((SSS="000") or (SSS="100") or (SSS="101") or (SSS="111") ) ) --Rcond,Call,Ccond,push,RST
                           or
                       ((IGROUP="11") and (DDD="101") and (SSS="001"))    -- PCHL  --L&S
                           or 
                       ((IGROUP="11") and (DDD="111") and (SSS="001"))  ) -- SPHL --L&S
                    then
                        TSTATES <= "0101"; --TT := 5;       
                        if HOLD = '1' then 
                            HOLDFF <= '1';
                         end if;
                    elsif HOLDFF = '1' then
                        TSTATES <= "1001"; --TT  := 9;
								HLDA_STATE <= '1'; --S- Hold variable
                    else
                        TSTATES <= "0001"; --TT  := 1;
                    end if;

          when "0101" => TSTATES <= "0110"; --when 5 => TT := 6;

          when "0110" =>
                    if HOLDFF = '1' then
								TSTATES <= "1001"; --TT := 9;
								HLDA_STATE <= '1'; --S- Hold variable
                    else TSTATES <= "0001"; --else TT := 1; 
                    end if;

          when "1000" =>
                    if HOLD = '1' then
                        TSTATES <= "1001"; --TT := 9;
                        HOLDFF <= '1';
		    elsif RST75FF = '1' then 
                        TSTATES <= "0001"; --TT := 1;  
                    else TSTATES <= "1000"; --TT := 8; 
                    end if;
		    
          when "1001" =>
                    if not (HOLD = '1') then
								TSTATES <= "0001";
								HOLDFF <= '0';
								HLDA_STATE <= '0'; --S- Hold variable
                    end if;

	  when others => null;
          end case;            -- end of case TT
    end if;
  end process P4;


-----------------------------------------------------------------------------
-- latch TRAP
-------------------------------------------------------------------------------

P5: process(RESETINBAR,X1,TRAP)
  begin
       if(RESETINBAR = '0' or PRIO_ENCODE = "000") then         -- clear the flip-flops
             TRAPFF <= '0';
       elsif (TRAP = '1' and TRAP'event) then 
            TRAPFF <= '1';
--       else TRAPFF <= '0';
       end if;
 end process P5;
       
-----------------------------------------------------------------------------
-- latch TRAP RST75
-------------------------------------------------------------------------------

P6: process(RESETINBAR,PRIO_ENCODE,RST75)
  begin
       if(RESETINBAR = '0' or PRIO_ENCODE = "001") then 
            RST75FF <= '0';
       elsif(RST75='1' and RST75'event) then 
	    RST75FF <= '1';
       end if;
 end process P6;


-------------------------------------------------------------------------------
-- Interrupt checking
-- PIE sense five inturrupts using the priority and interrupt enable INTEFF
-- then at the right cycle on the falling edge, PIO_ENCODE <= PIE
-- This gets attention in the main process, and which then branches to the right address
-------------------------------------------------------------------------------

P7: process(RESETINBAR,X1,INTEFF,TSTATES,MCYCLE,END_INST_flag)

  variable PIE: std_logic_vector(2 downto 0); --bit_vector(2 downto 0);
  begin
       if(TRAP = '1' and TRAPFF = '1') then
           PIE := "000";
       elsif INTEFF = '1' then
           if (M75FF = '0' and RST75FF = '1') then PIE := "001";
           elsif(M65FF = '0' and RST65 = '1') then PIE := "010";
           elsif(M55FF = '0' and RST55 = '1') then PIE := "011";
           elsif(INTR = '1')                  then PIE := "100";
	   else	                                   PIE := "111";
           end if;
       else PIE := "111";
       end if;

       if(RESETINBAR = '0') then
           PRIO_ENCODE <= "111";
           INTA <= '0';
           EI_FF <= '0';
       elsif (X1 = '0') and (X1'event) then
           if ((((INTEFF = '1') and (TSTATES = "1000")) or (TSTATES = "1001")) -- THALT or THOLD
	       or (END_INST_flag = '1')) then
               PRIO_ENCODE <= PIE;
           end if;
           if(PRIO_ENCODE = "100") then
               INTA <= '1';
           else
               INTA <= '0';
           end if;
           if(EI_ENABLE = '1') then EI_FF <= INTEFF; end if;
       end if;

 end process P7;

-------------------------------------------------------------------------------
-- Trailing edge and TRAP, then set EI_ENABLE
-------------------------------------------------------------------------------

       
P8: process(X1,RESETINBAR)
  begin
       if(RESETINBAR = '0') then
           EI_ENABLE <= '0';
       elsif(X1='0' and X1'event) then
           if(PRIO_ENCODE = "000") then 
                EI_ENABLE <= '1'; 
           else EI_ENABLE <= '0'; 
           end if;
       end if;
 end process P8;

       
end BEHAVIOR;




