
-- Module : mux
-- Author : folletto
-- Date   : mer, 30 apr 2008 20:38:42 +0200

library ieee;
use ieee.std_logic_1164.all;

entity mux is 
port (
	
	a,b : in std_logic_vector(31 downto 0);
	output : out std_logic_vector(31 downto 0);
	load_b : in std_logic;
	 clk			: in	  std_logic); 
     
end mux;     
        

architecture mux_behaviour of mux is
    signal  tmp_out : std_logic_vector(31 downto 0);
begin
    
process(clk)
              
begin  
	if(clk = '1' and clk'event)	then
	 		if(load_b = '1') then
					tmp_out <= b;		 		
	 		else 
	 	    		tmp_out <= a;
	 	    end if;    
	end if;    	
	
	output <= tmp_out;
end process;

end mux_behaviour;








