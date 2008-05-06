----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:31:33 03/07/2008 
-- Design Name: 
-- Module Name:    cla_four - Behavioral 
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

--In other terms, if the last two carry bits (the ones on the far left of the 
--top row in these examples) are both 1's or both 0's, the result is valid; 
--if the last two carry bits are "1 0" or "0 1", a sign overflow has occurred. 
--Conveniently, an XOR operation on these two bits can quickly determine if 
--an overflow condition exists

entity cla_four is
port(A,B: in std_logic_vector(3 downto 0);
	  Cin : in std_logic;
	  Cout : out std_logic;
	  S : out std_logic_vector(3 downto 0));
end cla_four;
 

architecture CLA4_dataflow of cla_four is
signal c : std_logic_vector(4 downto 0);
signal P : std_logic_vector(4 downto 0);
signal G : std_logic_vector(4 downto 0);
signal new_B : std_logic_vector(3 downto 0);
signal A4, B4 : std_logic;

component full_adder
port(A,B,Cin : in std_logic;
		S,P,G: out std_logic);
end component;

begin


--new_B <= (not(B) when SUB='1' else B;



FA0:full_adder
port map(A(0), new_B(0), Cin, S(0),P(0),G(0));
FA1:full_adder
port map(A(1), new_B(1), c(1),S(1),P(1),G(1));
FA2:full_adder
port map(A(2), new_B(2), c(2),S(2),P(2),G(2));
FA3:full_adder
port map(A(3), new_B(3), c(3), S(3), P(3),G(3));

--for sign extension RIGHT ?
--FA4:full_adder
--port map(A4, B4, c(4), S(4), P(4),G(4));


c(0) <= Cin;
c(1) <= G(0) OR (C(0) AND P(0));
c(2) <= G(1) OR (G(0) AND P(1))  OR (C(0) AND P(1) AND P(0));
c(3) <= G(2) OR (G(1) AND P(2)) OR (G(0) AND P(2) AND P(1)) OR (C(0) AND P(2) AND P(1) AND P(0));
c(4) <= G(3) OR (G(2) AND P(3)) OR ( (G(1) AND P(3)) AND P(2)) OR ( ((G(0) AND P(3)) AND P(2)) AND P(1)) OR ( (((C(0) AND P(3)) AND P(2)) AND P(1)) AND P(0));
Cout <= c(4);
end CLA4_dataflow;

