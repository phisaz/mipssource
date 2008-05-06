library ieee;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity ldecode is 
      PORT( 
      clock,reset,load : IN STD_LOGIC;
      Instruction : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
      read_data_s : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
      read_data_d : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
      read_data_t : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
      Shift_amount : out std_logic_vector(4 downto 0);
      functio : out std_logic_vector(5 downto 0);
     -- operation_code: out std_logic_vector(5 downto 0); to see if the operation code is useful in the ALU
      Sign_extend : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 )
      );
end ldecode;

ARCHITECTURE behavior OF ldecode IS
component instruction_register
port (
        clk,ld, reset: in STD_LOGIC;
        instruction : in  STD_LOGIC_VECTOR(31 downto 0);
        op_code: out STD_LOGIC_VECTOR(5 downto 0);
        reg_t : out std_logic_vector(4 downto 0);
        reg_s : out std_logic_vector(4 downto 0);
        reg_d : out std_logic_vector(4 downto 0);
        sh_amount : out std_logic_vector(4 downto 0);
        funct : out std_logic_vector(5 downto 0);
        imm : out std_logic_vector(31 downto 0) 
    );

end component;

component registers
    port (
        r_w, en, reset: in STD_LOGIC;
        aBus: in STD_LOGIC_VECTOR(4 downto 0);
        dBus: out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

--we have 32 registers 8-bit width
     signal op_code: STD_LOGIC_VECTOR(5 downto 0);
     signal regt :  std_logic_vector(4 downto 0);
     signal regs :  std_logic_vector(4 downto 0);
     signal regd :  std_logic_vector(4 downto 0);
     signal shamount :  std_logic_vector(4 downto 0);
     signal fun : std_logic_vector(5 downto 0);
     signal imme,immed : std_logic_vector(31 downto 0);
     signal reg_d_tmp,reg_s_tmp,reg_t_tmp: std_logic_vector(31 downto 0); 
	  signal read_write,enable : std_logic;
     
     
begin
   
    ins_reg: instruction_register port map(clock,reset,load,Instruction,op_code,regt,regs,regd,shamount,fun,imme);
    reg1 : registers port map(read_write,enable,reset,regt,reg_t_tmp);
	reg2 : registers port map(read_write,enable,reset,regs,reg_s_tmp);
	reg3 : registers port map(read_write,enable,reset,regd,reg_d_tmp);
	--reg4 : registers port map(read_write,enable,reset,imme,immed);

		process (clock,reset)
		begin
			if clock='1' and clock'event then
				if reset /= '0' then
					read_write <= '1';
					enable<='1';
					
				end if;
			end if;
		end process;
		
	read_data_s <= reg_s_tmp;
	read_data_t <= reg_t_tmp;
	read_data_d <= reg_d_tmp;
	functio <= fun;
	Shift_amount <= shamount;
	Sign_extend <= imme;
	
end behavior;

