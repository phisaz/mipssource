
-- Module : wb
-- Author : folletto
-- Date   : Fri, 2 May 2008 02:33:19 +0200

library ieee;
use ieee.std_logic_1164.all;

entity  wb is 
port (
	
	ALU_output,from_LMD : in std_logic_vector(31 downto 0);
    memToReg,clock		: in	  std_logic;
    wboutput : out  std_logic_vector(31 downto 0)
 );    
end wb;     
        

architecture synth of wb is
component mux port(
	a,b : in std_logic_vector(31 downto 0);
	output : out std_logic_vector(31 downto 0);
	load_b : in std_logic;
	 clk			: in	  std_logic);
end component;
begin
    
    mux_wb : mux port map(ALU_output, from_LMD, wboutput,memToReg,clock);

end synth;








