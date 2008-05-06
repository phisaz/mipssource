-- instruction_register.vhdl created on 4:7  2008.3.30
library IEEE;
use IEEE.std_logic_1164.all;

entity instruction_register is
    port (
        clk, ld, reset: in STD_LOGIC;
        instruction : in  STD_LOGIC_VECTOR(31 downto 0);
        op_code: out STD_LOGIC_VECTOR(5 downto 0);
        reg_t : out std_logic_vector(4 downto 0);
        reg_s : out std_logic_vector(4 downto 0);
        reg_d : out std_logic_vector(4 downto 0);
        sh_amount : out std_logic_vector(4 downto 0);
        funct : out std_logic_vector(5 downto 0);
        imm : out std_logic_vector(31 downto 0) 
    );
end instruction_register;

architecture irArch of instruction_register is
--type op_typ is array(0 to 34) of STD_LOGIC_VECTOR(5 downto 0);
signal irReg: STD_LOGIC_VECTOR(31 downto 0);
signal regt,sh : std_logic_vector(4 downto 0);
signal regs,regd : std_logic_vector(4 downto 0);
signal immediate : std_logic_vector(31 downto 0);
signal offset_s,offset_u : std_logic_vector(15 downto 0);
signal fun : std_logic_vector(5 downto 0);
signal op : STD_LOGIC_VECTOR(5 downto 0);

begin
 offset_s <= (offset_s'range=>'1');
 offset_u <= (offset_u'range=>'0');
 --op_code <= (opcode'range=>'0');
 
  process(clk) 
  begin
  	if clk'event and clk = '1' then 
  		if reset = '1' then
  			irReg <= (irReg'range=>'0');
  		elsif ld = '1' then
  			irReg <= instruction;
  		end if;
  	end if;
   
  op <= (op'range => '1');
  case irReg(31 downto 26) is 
  		--OP_NOP: no operation
   		when "000000" =>
   					  op  <= "000000";
   					  regt<=(regt'range=>'0');
   					  regs<=(regs'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate<=(immediate'range=>'0');
   		when "000001" =>   --signed add reg immediate
   					  op  <= "000001";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
 					  regd<=(regd'range=>'0');
 					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_s & irReg(15 downto 0);
   		when "000010" =>   --unsigned add reg immediate
   					  op  <= "000010";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "000011" =>   --  immediate signed sub
   					  op  <= "000011";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_s & irReg(15 downto 0);
   		when "000100" =>   --  immediate unsigned sub
   					  op  <= "000100";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
		when "000101" =>   --  immediate signed mul
   					  op  <= "000101";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_s & irReg(15 downto 0);
   		when "000110" =>   --  immediate unsigned mul
   					  op  <= "000110";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "000111" =>   --  immediate signed div
   					  op  <= "000111";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_s & irReg(15 downto 0);
   		when "001000" =>   --  immediate unsigned div
   					  op  <= "001000";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   	        when "001001" =>   --  immediate bitwise and
   					  op  <= "001001";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "001010" =>   --  immediate bitwise or
   					  op  <= "001010";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "001011" =>   --  immediate bitwise xor
   					  op  <= "001011";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "001100" =>  --    aggregate ALU operations op with Rs,Rd,Rt and func operators 
   					  op <= "001100";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  sh<=(sh'range=>'0');
   					  regd<=irReg(15 downto 11);
   					  fun<=irReg(5 downto 0);
   					  immediate<=(immediate'range=>'0');
   		when "001101" =>  --   load 32-bits word
   					  op <= "001101";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "001110" =>  --   load 16-bits word
   					  op <= "001110";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "001111" =>  --   load 8-bits word
   					  op <= "001111";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "010000" =>  --   store 32-bits word
   					  op <= "010000";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "010001" =>  --   store 16-bits word
   					  op <= "010001";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "010010" =>  --   store 8-bits word
   					  op <= "010010";
   					  regt <= irReg(20 downto 16);
   					  regs <= irReg(25 downto 21);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   		when "010011" =>  -- jump to immediate
   					  op <= "010011";
   					  regt<=(regt'range=>'0');
   					  regs<=(regs'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   			   	      immediate <= offset_u & irReg(15 downto 0);
   		when "010100" => -- jump and link
					  op <= "010100";
					  regs<=(regs'range=>'0');
   					  immediate <= offset_u & irReg(15 downto 0);
   					  regt<=(regt'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   	    when "010101" =>  -- jump and link register
   	    			  op <= "010101";
					  regs <= irReg(25 downto 21);
   					  immediate <= offset_u & irReg(15 downto 0);
   					  regt<=(regt'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   		when "010110" =>  -- jump  register
   	    			  op <= "010110";
					  regs <= irReg(25 downto 21);
   					  immediate <= offset_u & irReg(15 downto 0);
   					  regt<=(regt'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   		when "010111" => -- branch equal zero
   					  op <= "010111";
					  regs <= irReg(25 downto 21);
   					  immediate <= offset_u & irReg(15 downto 0);
   					  regt<=(regt'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
		when "011000" => -- branch not equal zero
   					  op <= "011000";
					  regs <= irReg(25 downto 21);
   					  immediate <= offset_u & irReg(15 downto 0);
   					  regt<=(regt'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
		when "011001" => -- branch less than zero
   					  op <= "011001";
					  regs <= irReg(25 downto 21);
   					  immediate <= offset_u & irReg(15 downto 0);
   					  regt<=(regt'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   		when "011010" => -- branch greater than zero
   					  op <= "011010";
					  regs <= irReg(25 downto 21);
   					  immediate <= offset_u & irReg(15 downto 0);
   					  regt<=(regt'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   		when "011011" => -- branch less or equal than zero
   					  op <= "011011";
					  regs <= irReg(25 downto 21);
   					  immediate <= offset_u & irReg(15 downto 0);
   					  regt<=(regt'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   		when "011100" => -- branch greater or equal than zero
   					  op <= "011100";
					  regs <= irReg(25 downto 21);
   					  immediate <= offset_u & irReg(15 downto 0);
   					  regt<=(regt'range=>'0');
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   		when "011101" =>  --     branch equal register
					  op <= "011101";
					  regs <= irReg(25 downto 21);
   					  immediate<=(immediate'range=>'0');
   					  regt <= irReg(20 downto 16);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
		when "011110" =>  --     branch not equal register
					  op <= "011110";
					  regs <= irReg(25 downto 21);
   					  immediate<=(immediate'range=>'0');
   					  regt <= irReg(20 downto 16);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
		when "011111" =>  --      branch less than register implemented modules
					  op <= "011111";
					  regs <= irReg(25 downto 21);
   					  immediate<=(immediate'range=>'0');
   					  regt <= irReg(20 downto 16);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   		when "100000" =>  --      branch greater than register implemented modules
					  op <= "100000";
					  regs <= irReg(25 downto 21);
   					  immediate<=(immediate'range=>'0');
   					  regt <= irReg(20 downto 16);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   		when "100001" =>  --  branch less or equal register
					  op <= "100001";
					  regs <= irReg(25 downto 21);
   					  immediate<=(immediate'range=>'0');
   					  regt <= irReg(20 downto 16);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
   		when "100010" =>  -- branch greater or equal register
					  op <= "100010";
					  regs <= irReg(25 downto 21);
   					  immediate<=(immediate'range=>'0');
   					  regt <= irReg(20 downto 16);
   					  regd<=(regd'range=>'0');
   					  sh<=(sh'range=>'0');
   					  fun<=(fun'range=>'0');
		    WHEN OTHERS =>  
  	   end case;   		
	end process;
	
	
	op_code<=op;
	reg_t <= regt;
    reg_s <= regs;
    reg_d <= regd;
    sh_amount <= sh;
    funct <= fun; 
    imm <= immediate;
   		
end irArch;

