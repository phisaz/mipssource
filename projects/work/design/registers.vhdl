-- registers.vhdl created on 8:29  2008.3.30

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity registers is
    port (
        r_w, en, reset: in STD_LOGIC;
        aBus: in STD_LOGIC_VECTOR(4 downto 0);
        dBus: inout STD_LOGIC_VECTOR(31 downto 0)
    );
end registers;

architecture regArch of registers is
type reg_typ is array(0 to 31) of STD_LOGIC_VECTOR(31 downto 0);

signal reg: reg_typ;
begin
  process(en, reset, r_w, aBus, dBus) begin
  	if reset = '1' then
  		for i in 0 to 31 loop
  			reg(i) <= "00000000000000000000000000000000";
  		end loop;
  	elsif r_w = '0' then
  		reg(conv_integer(unsigned(aBus))) <= dBus;
  	end if;
  end process;
  dBus <= reg(conv_integer(unsigned(aBus))) 
  	when reset = '0' and en = '1' and r_w = '1' 
  	else (dBus'range=>'0');
	
end regArch;
