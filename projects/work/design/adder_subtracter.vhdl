-- adder_subtracter.vhdl created on 9:31  2008.4.1
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:06:40 03/10/2008 
-- Design Name: 
-- Module Name:    adder_subtracter - Behavioral 
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

entity adder_subtracter is
port(A : in std_logic_vector(31 downto 0);
	  B : in std_logic_vector(31 downto 0);
		SUB: in std_logic;
		SIGN: in std_logic;
		SUM: out std_logic_vector(31 downto 0);
		OVF : out std_logic
);
end adder_subtracter;

architecture Behavioral of adder_subtracter is
signal B_new , s: std_logic_vector(31 downto 0);
signal c_out_tmp: std_logic;
signal cout : std_logic;

begin


B_new <= (not B) when SUB='1' else B;


ra0 : entity work.RCA(Behavioral_RCA) port map(A,B_new,SUB,c_out_tmp,s);

SUM <= s;
OVF <= ( 
	     (A(31) AND (B_new(31)) AND (not(s(31))) ) 
		  OR 
		  ( not(A(31)) AND (not(B_new(31))) AND (s(31))) 
		 ) 
		 
		 when SIGN='1' 
		 else  ( s(31) XOR c_out_tmp );

end Behavioral;
