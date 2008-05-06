
-- Module : mem
-- Author : folletto
-- Date   : Fri, 2 May 2008 02:57:28 +0200

library ieee;
use ieee.std_logic_1164.all;

entity mem is 
generic(n: natural :=32);
port (

	npc, alu_output, b : in std_logic_vector(n-1 downto 0);
    cond, memWrite, memRead	,clock		: in	  std_logic;
    pc, towb : out std_logic_vector(n-1 downto 0)
); 
     
end mem;     
        

architecture mem_arch of mem is
 
 signal to_LMD : STD_LOGIC_VECTOR( n-1 DOWNTO 0 );
 signal load_s,clear_s : std_logic;
 
 
  
component data_memory port (
  	read_data : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	address : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 ); --it's the alu output
	write_data : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );--write_data is B output alu
	MemRead, Memwrite , clck: IN STD_LOGIC   
	 	
); end component; 

component reg port(	
    I:	in std_logic_vector(n-1 downto 0);
	clock:	in std_logic;
	load:	in std_logic;
	clear:	in std_logic;
	Q:	out std_logic_vector(n-1 downto 0)
);
end component;
begin
    
  load_s <= '1';
  clear_s <= '0';  
  dm : data_memory port map (to_LMD,alu_output,b,memRead,memWrite,clock);
  LMD : reg port map(to_LMD,clock,load_s ,clear_s ,towb);	
  mux_pc : mux port map(npc,alu_output,cond,clock);
  
  	
end mem_arch;








