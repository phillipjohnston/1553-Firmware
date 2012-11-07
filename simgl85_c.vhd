--              
--          Test for the corrected behavioral model of GL85 
--                            (Clone of 8085 microprocessor)
--                                
--              Created by: Celine Poloce (08/1994)
--              MACAO Team of ERM/PHASE
--              Email: yann@erm2.u-strasbg.fr 



entity test_i8085_c is
end;

library ieee;
use ieee.std_logic_1164.all;
use work.gene_stimuli;
use work.i8085_c;
library std;

architecture sim of test_i8085_c is

component microproc
port(   x1:in std_logic;
	resetout,sod:out std_logic;
	sid,trap,rst75,rst65,rst55,intr:in std_logic;
	intabar:out std_logic;
	address_out:out  std_logic_vector(15 downto 0);
	s0,ale,wrbar,rdbar,s1,iombar : out  std_logic ;
	ready,resetinbar:in std_logic ;
	clkout:out std_logic  ;
	hlda:out std_logic  ;
	hold:in  std_logic ;
	id:in  std_logic_vector(7 downto 0));
end component;

component generateur
port(signal sortie_clk : out std_logic;
     signal sortie_init:out std_logic_vector(1 to 9);
     signal sortie_action :out std_logic_vector(7 downto 0));
end component;

for inst2 : microproc use entity i8085_c;
for inst1 : generateur use entity gene_stimuli;

signal init: std_logic_vector(1 to 9);
signal id :std_logic_vector(7 downto 0);
signal x1:std_ulogic;

-- alias for input signals --

alias sid :std_logic is init(1);
alias trap :std_logic is init (2);
alias rst75 :std_logic is init (3);
alias rst65 :std_logic is init (4);
alias rst55 :std_logic is init (5);
alias intr :std_logic is init (6);
alias ready :std_logic is init (7);
alias resetinbar :std_logic is init  (8);
alias hold :std_logic is init(9);


--      output signals    --

signal resetout,sod,intabar:std_logic ;
signal s0,ale,wrbar,rdbar :std_logic ;
signal s1,iombar,clkout:std_logic ;
signal hlda:std_logic;
signal address_out: std_logic_vector(15 downto 0);

begin
inst1 : generateur port map(x1,init,id);

inst2 : microproc port map(x1,resetout,sod,sid,trap,rst75,rst65,rst55,intr,
		  intabar,address_out,s0,ale,wrbar,rdbar,
		  s1,iombar,ready,resetinbar,clkout,hlda,hold,id);

chip_monitor : process
use std.textio.all;
	file log:text is out "i8085_2.log";
	variable trace_line : line;
	variable line_count : natural := 0;
begin  
    wait until x1='1';

    write(trace_line, string'("  "));
    write(trace_line, line_count);
    write(trace_line, ' ');
    write(trace_line, to_bitvector(address_out));
    write(trace_line, ' ');
    write(trace_line, to_bit(sod));
    write(trace_line, to_bit(intabar));
    write(trace_line, to_bit(s0));
    write(trace_line, to_bit(ale));
    write(trace_line, to_bit(wrbar));
    write(trace_line, to_bit(rdbar));
    write(trace_line, to_bit(s1));
    write(trace_line, to_bit(iombar));
    write(trace_line, to_bit(clkout));
    write(trace_line, to_bit(hlda));

    writeline(log, trace_line);
    line_count:=line_count+1;
end process;
end sim;

