-- ALU.vhdl created on 9:14  2008.4.1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.std_logic_unsigned.all ;

entity ALU is 
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
end ALU;

architecture behavior of ALU is

--it's like having a direct link between alu and pc manager

component program_counter
 port (
        clk, en_A, ld, inc, reset: in STD_LOGIC;
        aBus: out STD_LOGIC_VECTOR(31 downto 0);
        dBus: in STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

component adder_subtracter
port(A : in std_logic_vector(31 downto 0);
	  B : in std_logic_vector(31 downto 0);
		SUB: in std_logic;
		SIGN: in std_logic;
		SUM: out std_logic_vector(31 downto 0);
		OVF : out std_logic
);
end component;

component multiplier
PORT (a : in std_logic_vector(15 downto 0);
		  b	: in std_logic_vector(15 downto 0); 
		  sign : in std_logic;
		  res : OUT std_logic_vector(31 downto 0));
end component;

component divider
PORT (a : in std_logic_vector(31 downto 0);
		  b	: in std_logic_vector(31 downto 0); 
		  sign : in std_logic;
		  res : OUT std_logic_vector(31 downto 0));
end component;


signal opcode,enable,en,load,increment: std_logic;
signal new_pc,old_pc,new_pcl,old_pcl : std_logic_vector(31 downto 0);
signal enablel,loadl,incrementl : std_logic;

signal read_write,reset,resetl: std_logic;

signal indix: std_logic_vector(4 downto 0); -- for store/load operation
-- for add oper
signal result_tmp,res,res_add_sub,res_m,res_d : std_logic_vector(31 downto 0);
signal op1,op2 : std_logic_vector(31 downto 0);
signal sgn :std_logic;

--for mul oper
signal result_tmpm : std_logic_vector(31 downto 0);
signal op1m,op2m : std_logic_vector(15 downto 0);
signal sgnm :std_logic;

--for div oper
signal result_tmpd : std_logic_vector(31 downto 0);
signal op1d,op2d : std_logic_vector(31 downto 0);
signal sgnd :std_logic;
signal clock : std_logic;
signal sb,ow : std_logic;


begin
   res_add_sub<=(res_add_sub'range=>'1');
	res_m<=(res_m'range=>'1');
	res_d<=(res_d'range=>'1');
	add_sub : adder_subtracter port map (op1,op2,sb,sgn,res_add_sub,ow);
	mul : multiplier port map(op1m,op2m,sgnm,res_m);
	div : divider  port map(op1d,op2d,sgnd,res_d);
	pc: program_counter port map(clock,enable,load,increment,reset,new_pc,old_pc);
	pc_load: program_counter port map(clock,enablel,loadl,incrementl,resetl,new_pcl,old_pcl);
	process(op_code)
	begin
	    case op_code is
	    --OP_NOP: no operation
   		when "000000" =>
   					 result_tmp <= (result_tmp'range => '0');
   		when "000001" =>   --signed add reg immediate
   					  op1 <= reg_s;
   					  op2 <= Sign_extend ; -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  sgn <= '1';
   					  sb <= '0';
   		when "000010" =>   --unsigned add reg immediate
   					  op1 <= reg_s;
   					  op2 <= Sign_extend ; -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  sgn <= '0';
   					  sb <= '0';
   		when "000011" =>   --  immediate signed sub
   					  op1 <= reg_s;
   					  op2 <= Sign_extend ; -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  sgn <= '1';
   					  sb <= '1';
   		when "000100" =>   --  immediate unsigned sub
   					  op1 <= reg_s;
   					  op2 <= Sign_extend ; -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  sgn <= '0';
   					  sb <= '1';
		when "000101" =>   --  immediate signed mul
   					  op1m <= reg_s(15 downto 0);
   					  op2m <= Sign_extend(15 downto 0); -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  sgnm <= '1';
   					
   		when "000110" =>   --  immediate unsigned mul
   					  op1m <= reg_s(15 downto 0);
   					  op2m <= Sign_extend(15 downto 0); -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  sgnm <= '0';
   					
   		when "000111" =>   --  immediate signed div
   					   op1d <= reg_s;
   					  op2d <= Sign_extend; -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  sgnm <= '1';
   					
   		when "001000" =>   --  immediate unsigned div
   					  op1d <= reg_s;
   					  op2d <= Sign_extend; -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  sgnm <= '0';
   					
   	    when "001001" =>   --  immediate bitwise and
   					  op1d <= reg_s;
   					  op2d <= Sign_extend ; -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  res <= op1d AND op2d;
   		when "001010" =>   --  immediate bitwise or
   					  op1d <= reg_s;
   					  op2d <= Sign_extend ; -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  res <= op1d OR op2d;
   		when "001011" =>   --  immediate bitwise xor
   					  op1d <= reg_s;
   					  op2d <= Sign_extend ; -- i consider always 32 bit extend to all 0 if unsegned else all 1
   					  res <= op1d XOR op2d;
   		when "001100" =>  --    aggregate ALU operations op with Rs,Rd,Rt and func operators 
   					  case fun is
   					  		when "000000" =>  --signed add
   					  			op1 <= reg_s;
   					  			op2 <= reg_t;
   					  			sgn <= '1';
		     					sb <= '0';
		     				when "000001" => --unsigned add
		     					op1 <= reg_s;
   					  			op2 <= reg_t;
   					  			sgn <= '0';
		     					sb <= '0';
		     				when "000010" => --signed sub
		     					op1 <= reg_s;
   					  			op2 <= reg_t;
   					  			sgn <= '1';
		     					sb <= '1';
		     				when "000011" =>  --unsigned sub
		     					op1 <= reg_s;
   					  			op2 <= reg_t;
   					  			sgn <= '0';
		     					sb <= '1';
		     				when "000100" =>  --signed mul
		     					op1m <= reg_s(15 downto 0);
   					  			op2m <= reg_t(15 downto 0);
   					  			sgnm <= '1';
		     					
		     				when "000101" => --unsigned mul
		     					op1m <= reg_s(15 downto 0);
   					  			op2m <= reg_t(15 downto 0);
   					  			sgnm <= '0';
   					  		when "000110" => --signed div
   					  			op1d <= reg_s;
   					  			op2d <= reg_t;
   					  			sgnd <= '1';
   					  		when "000111" => --unsigned div
   					  			op1d <= reg_s;
   					  			op2d <= reg_t;
   					  			sgnd <= '0';
   					  		when "001000" => --logical left shift N.B. to see better and validate !!!!!
   					  			op1d <= reg_s;
   					  			res <= std_logic_vector(unsigned(op1d) sll to_integer(unsigned(Shift_amount)));
   					  		when "001001" => -- logical right shift
   					  			op1d <= reg_s;
   					  			
   					  			res <= std_logic_vector(unsigned(op1d) srl to_integer(unsigned(Shift_amount)));
   					  	--TODO check because errors
   					  			
   					  	--	when "001010" =>  --aritmetic left shift
   					  		--	op1d <= reg_s;
   					  	--	res <= op1d sla 1 ; --(unsigned(Shift_amount)));
   					  	--	when "001011" => --aritmetic right shift
   					  		--	op1d <= reg_s;
   					  	--		res <= std_logic_vector(unsigned(op1d) sra to_integer(unsigned(Shift_amount)));
   					  			 
   					  		when "001100" => --left rotate
   					  			op1d <= reg_s;
   					  			res <= std_logic_vector(unsigned(op1d) rol to_integer(unsigned(Shift_amount)));
							when "001101" => --right rotate
   					  			op1d <= reg_s;
   					  		res <= std_logic_vector(unsigned(op1d) ror to_integer(unsigned(Shift_amount)));
   					  		when "001111" => --bitwise and
   					  			op1d <= reg_s;
   					  			op2d <= reg_t;
   					  			res <= op1d and op2d;
   					  		when "010000" => --bitwise or
   					  			op1d <= reg_s;
   					  			op2d <= reg_t;
   					  			res <= op1d or op2d;
   					  		when "010001" => --bitwise xor
   					  			op1d <= reg_s;
   					  			op2d <= reg_t;
   					  			res <= op1d xor op2d;
								WHEN OTHERS => 
   					  end case;

   		when "001101" =>  --   load 32-bits word
   					   op1<=reg_s;
					   op2<=Sign_extend;
					   sgn <= '0';
   					   sb <= '0';
							
   		when "001110" => --   load 16-bits word
   					     op1<="0000000000000000" & reg_s(15 downto 0);
							op2<="0000000000000000" & Sign_extend(15 downto 0);
							sgn <= '0';
   					   sb <= '0';
   		when "001111" =>  --   load 8-bits word
   					   op1<="000000000000000000000000" & reg_s(7 downto 0);
							op2<="000000000000000000000000" & Sign_extend(7 downto 0);
							sgn <= '0';
   					   sb <= '0';
   		when "010000" =>  --   store 32-bits word
   					    op1<=reg_s;
							op2<=Sign_extend;
							sgn <= '0';
   					   sb <= '0';
   		when "010001" =>  --   store 16-bits word
   					    op1<="0000000000000000" & reg_s(15 downto 0);
							op2<="0000000000000000" & Sign_extend(15 downto 0);
							sgn <= '0';
   					   sb <= '0';
   		when "010010" =>  --   store 8-bits word
   					  op1<="000000000000000000000000" & reg_s(7 downto 0);
							op2<="000000000000000000000000" & Sign_extend(7 downto 0);
							sgn <= '0';
   					   sb <= '0';
   		
   		when "010011" =>  -- jump to immediate
						res <= Sign_extend(15 downto 0) sll 2; 
		--TO DO														
   		when "010100" => -- jump and link
   						-- retrieve the old pc setting the parameter for the component pcl
						res <= Sign_extend(15 downto 0) sll 2;
		--TODO						
   	    when "010101" =>  -- jump and link register
   	    			      --here i return only the destination address to jump...then i put in NPC the res
   		
   		--TODO branches
   		when "010110" =>  -- jump  register
   	                   res <= reg_s;			      --here i return only the destination address to jump...then i put in NPC the res
   	    when "010111" => --branch equal zero
   	    			  
   	    when "011000" =>  --branch not equal zero
		when "011001" =>  --branch less than zero
		when "011010" => --branch greater than zero
		when "011011" =>  --branch less or eq to zero
		when "011100" => ----branch greater or eq to zero
		when "011101" => ----branch equal register
		when "011110" => ----branch not equal register
		when "011111"=> ----branch less than register
		when "100000" => ----branch greater than register
		when "100001" => ----branch less or equal to register
		when "100010"=> ----branch greater or eq to register		      
   	   when OTHERS =>  			    
   		---- COMPLETARE GLI ALTRI JUMP
  	   end case;   		
	       					
	if(res_add_sub /= "11111111111111111111111111111111") then
			res<=res_add_sub;
	elsif res_m /= "11111111111111111111111111111111" then
			  res <= res_m;
		elsif res_d /= "11111111111111111111111111111111" then
				res <=res_d;
	end if;			
	end process;
	
end behavior;



