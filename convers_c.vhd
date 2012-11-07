--              
--    Package of utilities for the corrected behavioral model of GL85 
--                              (Clone of 8085 microprocessor)
--                                
--              Created by: Celine Poloce (08/1994)
--              MACAO Team of ERM/PHASE
--              Email: yann@erm2.u-strasbg.fr 


library ieee;
use ieee.std_logic_1164.all;


package conversion is

subtype  logic_state is integer range 0 to 1;

function plus16(A, B: std_logic_vector(15 downto 0)) return std_logic_vector;
function plus9(A, B: std_logic_vector(8 downto 0)) return std_logic_vector;
function plus8(A, B: std_logic_vector(7 downto 0)) return std_logic_vector;
function plus8b(A, B: std_logic_vector(7 downto 0)) return std_logic_vector;
function plus8_carry(A, B: std_logic_vector(7 downto 0); C: std_logic) return std_logic_vector;
function plus5b(A, B: std_logic_vector(4 downto 0)) return std_logic_vector;
--function plus4(A, B: std_logic_vector(3 downto 0)) return std_logic;
function invert(A: std_logic_vector(7 downto 0)) return std_logic_vector;
procedure plus4(A, B: in std_logic_vector(3 downto 0); 
                sum: out std_logic_vector(3 downto 0); 
                carryout: out std_logic);

end conversion;


package body conversion is

    -- add two signed numbers of the same length
    -- both arrays must have range (msb downto 0)
function plus16(A, B: std_logic_vector(15 downto 0)) return std_logic_vector is
        variable carry: STD_LOGIC;
        variable BV, sum: std_logic_vector(15 downto 0);

    begin
--        if (A(A'left) = 'X' or B(B'left) = 'X') then
--            sum := (others => 'X');
--            return(sum);
--        end if;
        carry := '0';
        BV := B;

        for i in 0 to 15 loop
            sum(i) := A(i) xor BV(i) xor carry;
            carry := (A(i) and BV(i)) or
                    (A(i) and carry) or
                    (carry and BV(i));
        end loop;
        return sum;
    end;

function plus9(A, B: std_logic_vector(8 downto 0)) return std_logic_vector is
        variable carry: STD_LOGIC;
        variable BV, sum: std_logic_vector(8 downto 0);

    begin
--        if (A(A'left) = 'X' or B(B'left) = 'X') then
--            sum := (others => 'X');
--            return(sum);
--        end if;
        carry := '0';
        BV := B;

        for i in 0 to 8 loop
            sum(i) := A(i) xor BV(i) xor carry;
            carry := (A(i) and BV(i)) or
                    (A(i) and carry) or
                    (carry and BV(i));
        end loop;
        return sum;
    end;

function plus8(A, B: std_logic_vector(7 downto 0)) return std_logic_vector is
        variable carry: STD_LOGIC;
        variable BV : std_logic_vector(7 downto 0);
        variable sum: std_logic_vector(8 downto 0);

    begin
--        if (A(A'left) = 'X' or B(B'left) = 'X') then
--            sum := (others => 'X');
--            return(sum);
--        end if;
        carry := '0';
        BV := B;

        for i in 0 to 7 loop
            sum(i) := A(i) xor BV(i) xor carry;
            carry := (A(i) and BV(i)) or
                    (A(i) and carry) or
                    (carry and BV(i));
        end loop;
        sum(8) := carry;
        return sum;
    end;

function plus8b(A, B: std_logic_vector(7 downto 0)) return std_logic_vector is
        variable carry: STD_LOGIC;
        variable BV : std_logic_vector(7 downto 0);
        variable sum: std_logic_vector(7 downto 0);

    begin
--        if (A(A'left) = 'X' or B(B'left) = 'X') then
--            sum := (others => 'X');
--            return(sum);
--        end if;
        carry := '0';
        BV := B;

        for i in 0 to 7 loop
            sum(i) := A(i) xor BV(i) xor carry;
            carry := (A(i) and BV(i)) or
                    (A(i) and carry) or
                    (carry and BV(i));
        end loop;
        return sum;
    end;

function plus8_carry(A, B: std_logic_vector(7 downto 0); C: std_logic) return std_logic_vector is
        variable carry: STD_LOGIC;
        variable BV : std_logic_vector(7 downto 0);
        variable sum: std_logic_vector(8 downto 0);

    begin
--        if (A(A'left) = 'X' or B(B'left) = 'X') then
--            sum := (others => 'X');
--            return(sum);
--        end if;
        carry := C;
        BV := B;

        for i in 0 to 7 loop
            sum(i) := A(i) xor BV(i) xor carry;
            carry := (A(i) and BV(i)) or
                    (A(i) and carry) or
                    (carry and BV(i));
        end loop;
        sum(8) := carry;
        return sum;
    end;

function plus5b(A, B: std_logic_vector(4 downto 0)) return std_logic_vector is
        variable carry: STD_LOGIC;
        variable BV : std_logic_vector(4 downto 0);
        variable sum: std_logic_vector(4 downto 0);

    begin
--        if (A(A'left) = 'X' or B(B'left) = 'X') then
--            sum := (others => 'X');
--            return(sum);
--        end if;
        carry := '0';
        BV := B;

        for i in 0 to 4 loop
            sum(i) := A(i) xor BV(i) xor carry;
            carry := (A(i) and BV(i)) or
                    (A(i) and carry) or
                    (carry and BV(i));
        end loop;
        return sum;
    end;

procedure plus4(A, B: in std_logic_vector(3 downto 0); 
                sum: out std_logic_vector(3 downto 0); 
                carryout: out std_logic) is
        variable carry: STD_LOGIC;
        variable BV : std_logic_vector(3 downto 0);
    begin
--        if (A(A'left) = 'X' or B(B'left) = 'X') then
--            sum := (others => 'X');
--            return(sum);
--        end if;
        carry := '0';
        BV := B;

        for i in 0 to 3 loop
            sum(i) := A(i) xor BV(i) xor carry;
            carry := (A(i) and BV(i)) or
                    (A(i) and carry) or
                    (carry and BV(i));
        end loop;
	carryout := carry;
    end;

function invert(A: std_logic_vector(7 downto 0)) return std_logic_vector is
  variable result: std_logic_vector(7 downto 0);

  begin
    for i in 0 to 7 loop
        result(i) := not A(i);
    end loop;
    return result;
 end;
        

end conversion;



