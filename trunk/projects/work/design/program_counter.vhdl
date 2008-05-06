-- program_counter.vhdl created on 4:4  2008.3.30
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity program_counter is
    port (
        clk, en_A, ld, inc, reset: in STD_LOGIC;
        aBus: out STD_LOGIC_VECTOR(31 downto 0);
        dBus: inout STD_LOGIC_VECTOR(31 downto 0)
    );
end program_counter;

architecture pcArch of program_counter is
signal pcReg: STD_LOGIC_VECTOR(31 downto 0);
begin
  process(clk) begin
  	if clk'event and clk = '1' then 
  		if reset = '1' then
  			pcReg <= (pcReg'range=>'0');
  		elsif ld = '1' then
  			pcReg <= dBus;
  		elsif inc = '1' then
  			pcReg <= pcReg + "00000000000000000000000000000100";
  		end if;
  	end if;
  end process;
  aBus <= pcReg when en_A = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
end pcArch;
