----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:13:33 03/10/2008 
-- Design Name: 
-- Module Name:    RCA - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RCA is
generic(N : integer := 32;
		  N_CLA : integer := 4);
port(A : in std_logic_vector(N-1 downto 0);
	  B : in std_logic_vector(N-1 downto 0);
     Cin : in std_logic;
	  Cout: out std_logic;	
	  S: out std_logic_vector(N-1 downto 0)
	  );

end RCA;

architecture Behavioral_RCA of RCA is

signal carry : std_logic_vector(N/N_CLA downto 0);

component cla_four
port(A,B: in std_logic_vector(N_CLA-1 downto 0);
	  Cin : in std_logic;
	  Cout : out std_logic;
	  S : out std_logic_vector(N_CLA-1 downto 0));
end component;

begin

carry(0) <= Cin;

cla : for i in 0 to N/N_CLA-1 generate
cla_cell : cla_four port map(
									 A((((i+1)*  N_CLA)-1) downto (i*N_CLA)),
									 B((((i+1)*  N_CLA)-1) downto (i*N_CLA)),
									 carry(i),
									 carry(i+1),
									 S((((i+1)*  N_CLA)-1) downto (i*N_CLA))
									);
end generate cla;									 
Cout <= carry(N/N_CLA);
end Behavioral_RCA;

