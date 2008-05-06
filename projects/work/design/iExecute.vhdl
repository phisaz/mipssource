-- iExecute.vhdl created on 11:24  2008.4.1
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY iExecute is
	PORT(
         clock, reset : IN STD_LOGIC;
         op_code : in std_logic_vector(5 downto 0);
      	 reg_s : in STD_LOGIC_VECTOR( 31 DOWNTO 0 );
      	 reg_d : in STD_LOGIC_VECTOR( 31 DOWNTO 0 );
         reg_t : in STD_LOGIC_VECTOR( 31 DOWNTO 0 );
         Shift_amount : in std_logic_vector(4 downto 0);
         fun : in std_logic_vector(5 downto 0);
     -- operation_code: out std_logic_vector(5 downto 0); to see if the operation code is useful in the ALU
         Sign_extend : in STD_LOGIC_VECTOR( 31 DOWNTO 0 ); 
         result : out std_logic_vector(31 downto 0)
           );
end iExecute;


ARCHITECTURE behavior OF iExecute IS
component ALU 
 PORT(
      	 op_code : in std_logic_vector(5 downto 0);
      	 reg_s : in STD_LOGIC_VECTOR( 31 DOWNTO 0 );
      	 reg_d : in STD_LOGIC_VECTOR( 31 DOWNTO 0 );
         reg_t : in STD_LOGIC_VECTOR( 31 DOWNTO 0 );
         Shift_amount : in std_logic_vector(4 downto 0);
         fun : in std_logic_vector(5 downto 0);
     -- operation_code: out std_logic_vector(5 downto 0); to see if the operation code is useful in the ALU
         Sign_extend : in STD_LOGIC_VECTOR( 31 DOWNTO 0 ); 
         result : out std_logic_vector(31 downto 0)
        );
end component;

signal opcode: std_logic_vector(5 downto 0);
signal enable,load,increment,new_pc,old_pc : std_logic;
signal sham : std_logic_vector(4 downto 0);
signal regs,regd,regt : std_logic_vector(31 downto 0);
signal func : std_logic_vector(5 downto 0);
signal imm,res : std_logic_vector(31 downto 0);
signal zero : std_logic;   -- DA IMPLEMENTARE ANCORA

begin
	alu1 : ALU port map(opcode,regs,regd,regt,sham,func,imm,res);
		
 	process(clock,reset)
	begin
		if clock'event and clock = '1' then
		     if reset /= '1' then
						opcode <= op_code;
						regs <= reg_s;
						regd <= reg_d;
						regt <= reg_t;
						sham <= Shift_amount;
						func <= fun;
						imm  <= Sign_extend;
    	     end if;
		end if;
						
				
	end process;

end behavior;
