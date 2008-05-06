
-- Module : control_unit
-- Author : folletto
-- Date   : Tue, 6 May 2008 13:55:29 +0100

library ieee;
use ieee.std_logic_1164.all;

entity control_unit is 
port (
    --clk			: in	  std_logic
    opcode : in std_logic_vector(5 downto 0); 
    RegDst : out std_logic;			--used to choose whether to use Rd or not
    Branch : out std_logic;			--branch! 
    MemRead : out std_logic;    	--used to read from memory -> load 
    MemWrite : out std_logic;       --used to write to memory -> store
    MemToReg : out std_logic;		--used to write in the register the result of the load (that is in LMD)
    AluOp : out std_logic_vector(5 down to 0); --opcode
    ALUImm : out std_logic;        --ALUSrc in fulltext -> used to choose between Immediate or Rt 
    RegWrite : out std_logic	   --used when we have to write back to registers 
    
    ); 
     
end control_unit;     
        

architecture synth of control_unit is
               
begin  

process(opcode)
begin

--TODO: initialize all in ports to zero

AluOp <= opcode;

case  opcode is
    
       	when "000001" =>   --signed add reg immediate
   							ALUImm <= '1';
   							RegWrite <= '1';  										 
   		when "000010" =>   --unsigned add reg immediate
   							ALUImm <= '1';
   							RegWrite <= '1';
   		when "000011" =>   --  immediate signed sub
   							ALUImm <= '1';
   							RegWrite <= '1';
   		when "000100" =>   --  immediate unsigned sub
   							ALUImm <= '1';
   							RegWrite <= '1';
		when "000101" =>   --  immediate signed mul
							ALUImm <= '1';
   							RegWrite <= '1';
   		when "000110" =>   --  immediate unsigned mul
   							ALUImm <= '1';
   							RegWrite <= '1';
   		when "000111" =>   --  immediate signed div
   							ALUImm <= '1';
   							RegWrite <= '1';
   		when "001000" =>   --  immediate unsigned div
   							ALUImm <= '1';
   							RegWrite <= '1';
        when "001001" =>   --  immediate bitwise and
        					ALUImm <= '1';
   							RegWrite <= '1';
   		when "001010" =>   --  immediate bitwise or
   							ALUImm <= '1';
   							RegWrite <= '1';
   		when "001011" =>   --  immediate bitwise xor
   							ALUImm <= '1';
   							RegWrite <= '1';
   		when "001100" =>  --    aggregate ALU operations op with Rs,Rd,Rt and func operators
   							RegDst <= '1'; 
   							RegWrite <= '1'; 
   		when "001101" =>  --   load 32-bits word
   							ALUImm <= '1';
   							MemRead <= '1';
   							RegWrite <= '1';
   							MemToReg <= '1';
   		when "001110" =>  --   load 16-bits word
   							ALUImm <= '1';
   							MemRead <= '1';
   							RegWrite <= '1';
   							MemToReg <= '1';
   		when "001111" =>  --   load 8-bits word
   							ALUImm <= '1';
   							MemRead <= '1';
   							RegWrite <= '1';
   							MemToReg <= '1';
   		when "010000" =>  --   store 32-bits word
   							ALUImm <= '1';
   							MemWrite <= '1';
   		when "010001" =>  --   store 16-bits word
   							ALUImm <= '1';
   							MemWrite <= '1';
   		when "010010" =>  --   store 8-bits word
   							ALUImm <= '1';
   							MemWrite <= '1';
		--TO ASK all branches and jumps   							
   		when "010011" =>  -- jump to immediate
   							Branch <= '1';
   							
   		when "010100" => -- jump and link
   							Branch <= '1';
   	    when "010101" =>  -- jump and link register
   	    					Branch <= '1';
   	    					RegWrite <= '1';
   	    					
   		when "010110" =>  -- jump  register
   							Branch <= '1';
   		when "010111" => -- branch equal zero
   							Branch <= '1';
		when "011000" => -- branch not equal zero
		   					Branch <= '1';
		when "011001" => -- branch less than zero
		   					Branch <= '1';
   		when "011010" => -- branch greater than zero
   		   					Branch <= '1';
   		when "011011" => -- branch less or equal than zero
   		   					Branch <= '1';
   		when "011100" => -- branch greater or equal than zero
   		   					Branch <= '1';
   		when "011101" =>  --     branch equal register
   		   					Branch <= '1';
		when "011110" =>  --     branch not equal register
		   					Branch <= '1';
		when "011111" =>  --      branch less than register implemented modules
		   					Branch <= '1';
   		when "100000" =>  -- branch greater than register implemented modules
   		   					Branch <= '1';
   		when "100001" =>  -- branch less or equal register
   		   					Branch <= '1';
   		when "100010" =>  -- branch greater or equal register
   							Branch <= '1';
	    WHEN OTHERS =>  
end case;


end process;

end synth;








