
-- Module : multiplier_s_u
-- Author : folletto
-- Date   : gio, 1 mag 2008 10:58:52 +0200

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity multiplier_s_u is 
port (
	A,B : in std_logic_vector(15 downto 0);
	SIGN : in std_logic;
	M : out std_logic_vector(31 downto 0)
 ); 
     
end multiplier_s_u;     
        

architecture synth of multiplier_s_u is
               
begin
      
M <= A * B;

end synth;








