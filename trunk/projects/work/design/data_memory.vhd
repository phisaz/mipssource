
-- Module : data_memory
-- Author : folletto
-- Date   : mer, 30 apr 2008 17:32:08 +0200

library ieee;
use ieee.std_logic_1164.all;

-- 3 cases:
--   1. R[rd] <- ALUOutput
--	 2. MDR <- Mem[ALUOutput]   MDR = memory data register
--	 3. Mem[ALUOutput] <- B	
--LMD load data memory register

entity data_memory is 

port (
  	read_data : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	address : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 ); --it's the alu output
	write_data : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );--write_data is B output alu
	MemRead, Memwrite , clck: IN STD_LOGIC   
	 	
); 
     
end data_memory;     
        

architecture dm_architecture of data_memory is
signal data : STD_LOGIC_VECTOR(31 downto 0);

begin  

--LMD <- mem [ALUOUTPUT]  this is a load(read) operation
--If load, memory data is placed in LMD register 
--we replace mem[ALUOUTPUT] with a vector of 1

process(clck)
begin  
	if(clk = '1' and clk'event)	then
	 		if(MemRead = '1') then
	 		--da vedere se occorre implementare la ram
					data <= (data'range=>'1');	
								 		
	 		elsif MemWrite = '1' then
				--mem [ALUOUTPUT] <- B this is a store (write) operation
					data <= write_data; 	 	    		
									
	 	    end if;
	 	    read_data <= data;    
	end if;    	

end process;
end dm_architecture;








