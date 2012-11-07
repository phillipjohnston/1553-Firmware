--              
--    Reader of input vectors for the corrected behavioral model of GL85 
--     				(Clone of 8085 microprocessor)
--                                
--              Created by: Celine Poloce (08/1994)
--              MACAO Team of ERM/PHASE
--              Email: yann@erm2.u-strasbg.fr 



library ieee;
use ieee.std_logic_1164.all;

entity gene_stimuli is

port(signal sortie_clk : out std_ulogic;
     signal sortie_init:out std_logic_vector(1 to 9);
     signal sortie_action :out std_logic_vector(7 downto 0));
end gene_stimuli;


library std;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;

architecture archi of gene_stimuli is

signal sortie :bit_vector(1 to 18);

begin
	sortie_clk <= to_stdulogic (sortie(1));
	sortie_init(1 to 9) <= to_stdlogicvector (sortie(2 to 10));
	sortie_action(7 downto 0) <= to_stdlogicvector (sortie(11 to 18));
process
variable ligne_lue: line;
variable sortie_vec:bit_vector(1 to 18);
variable sortie_bit : bit;
variable longueur:integer:=0;
file descriptif:text is in "i8085_2.vec";

	begin
	while (not endfile(descriptif)) loop
		readline(descriptif,ligne_lue);
		longueur:=0;
		      for i in ligne_lue'range loop
			  if (ligne_lue(i)='0' or ligne_lue(i) ='1') 
				  then longueur:=longueur+1;
			  end if;
			  if (ligne_lue(i)='-') then exit;
			  end if;
		      end loop;
		if longueur/=0 then 
		      case longueur is
				when 1  => read(ligne_lue,sortie_bit);
					   sortie(1) <= transport sortie_bit;
				when 18 => for i in 1 to longueur loop
					   read(ligne_lue,sortie_vec(i));
					   end loop;
					   sortie <= transport sortie_vec;
				when others => null;
		      end case;
		      wait  for 250 ns;         -- the clock frequency is 1/500ns
		end if;
	end loop;

	wait for 100 ns;
end process;
end archi;



