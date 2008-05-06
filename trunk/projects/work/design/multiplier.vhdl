-- multiplier.vhdl created on 10:13  2008.4.1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.std_logic_unsigned.all ;

ENTITY multiplier IS
	PORT (a : in std_logic_vector(15 downto 0);
		  b	: in std_logic_vector(15 downto 0); 
		  sign : in std_logic;
		  res : OUT std_logic_vector(31 downto 0));
END multiplier;

ARCHITECTURE behaviour OF multiplier IS
SIGNAL res_tmp : integer;--unsigned(31 downto 0);
signal res_tmp_signed :signed(31 downto 0);

signal a_int,b_int: integer; --unsigned(15 downto 0);
signal a_sign,b_sign: signed(15 downto 0);
signal flag_s : std_logic;

BEGIN
flag_s<='0';
	process(a,b,sign)
	begin
		
		a_int <= conv_integer(a);
		b_int <= CONV_INTEGER(b);
		if sign='1' then
			a_sign <= signed(a);
			b_sign <= signed(b);
			res_tmp_signed <= a_sign * b_sign;
			flag_s<='1';
	    else
	    	res_tmp <= a_int * b_int;
		end if;
			if flag_s='1' then
		  	   res <= STD_LOGIC_VECTOR(res_tmp_signed); 
			else res<=STD_LOGIC_VECTOR(to_unsigned(res_tmp,32));
			end if;
	end process;


END behaviour;