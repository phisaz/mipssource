
-- Module : Ifetch
-- Author : folletto
-- Date   : gio, 24 apr 2008 14:32:44 +0200

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--LIBRARY Ipm;
--USE Ipm.lpm_components.ALL;


ENTITY lfetch IS
PORT( SIGNAL Instruction : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
      SIGNAL PC_in : IN STD_LOGIC_VECTOR( 31 DOWNTO 0 );
      SIGNAL PC_out : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
      SIGNAL clock, reset,load,reset_ram : IN STD_LOGIC
      
);
END lfetch;


ARCHITECTURE fetch_arch OF lfetch IS
component program_counter
port (
        clk, en_A, ld, inc, reset: in STD_LOGIC;
        aBus: out STD_LOGIC_VECTOR(31 downto 0);
        dBus: in STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

component ram
 port (
        r_w, en, reset: in STD_LOGIC;
        aBus: in STD_LOGIC_VECTOR(31 downto 0);
        dBus: inout STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

signal enable,lod,increment,read_write,enabler: std_logic;
signal pcReg,pc_in2,instr:std_logic_vector(31 downto 0);

begin
    new_pc:  program_counter port map(clock,enable,lod,increment,reset,pcReg,pc_in2);
    new_ram : ram port map(read_write,enabler,reset,pcReg,instr);
    
	manage_pc:process (clock,reset,load)
	begin
		if clock'event and clock = '1' then
		     if reset='1' then
		     		enable<='1';
		     		lod<='0';
		     		increment<='0';
		     		pc_in2<=(pc_in'range=>'0');
		        	
		     elsif load='1' then
		     		enable<='1';
		     		lod<='1';
		     		increment<='0';
		     		pc_in2<=PC_in;
		     	else
		     		enable<='1';
		     		lod<='0';
		     		increment<='1';
		     		pc_in2<=PC_in;
		     end if;		 
		  end if;		
		
	end process;
	
	manage_ram:process(clock,reset)
	begin
		if clock'event and clock = '1' then
			if reset='1' then
				enabler<='0';
			else
				enabler<='1';
				read_write<='1';  --permits the read from the ram
				
			end if;
		end if;
	end process;
    Pc_out<=  pcReg;
	instruction <= instr;
end fetch_arch;







