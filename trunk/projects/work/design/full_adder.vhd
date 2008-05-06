--------------------------------------------------------------fg--------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:28:02 02/29/2008 
-- Design Name: 
-- Module Name:    fulll_adder - Hierarchical 
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

entity full_adder is
port(A,B,Cin : in std_logic;
		S,P,G: out std_logic);
end full_adder;


architecture full_adder_behav of full_adder is
begin

	S <= (A xor B) xor Cin;
	G <= A and B;
	P <= A xor B;
	 
end full_adder_behav;


--ENTITY c_l_addr IS
--    PORT
--        (
--         x_in      :  IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
--         y_in      :  IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
--         carry_in  :  IN   STD_LOGIC;
--         sum       :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
--         carry_out :  OUT  STD_LOGIC
--        );
--END c_l_addr;
--
--ARCHITECTURE behavioral OF c_l_addr IS
--
--SIGNAL    h_sum              :    STD_LOGIC_VECTOR(3 DOWNTO 0);
--SIGNAL    carry_generate     :    STD_LOGIC_VECTOR(3 DOWNTO 0);
--SIGNAL    carry_propagate    :    STD_LOGIC_VECTOR(3 DOWNTO 0);
--SIGNAL    carry_in_internal  :    STD_LOGIC_VECTOR(3 DOWNTO 1);
--
--BEGIN
--    h_sum <= x_in XOR y_in;
--    carry_generate <= x_in AND y_in;
--    carry_propagate <= x_in OR y_in;
--    PROCESS (carry_generate,carry_propagate,carry_in_internal)
--    BEGIN
--    carry_in_internal(1) <= carry_generate(0) OR (carry_propagate(0) AND carry_in);
--        inst: FOR i IN 1 TO 2 LOOP
--              carry_in_internal(i+1) <= carry_generate(i) OR (carry_propagate(i) AND carry_in_internal(i));
--              END LOOP;
--    carry_out <= carry_generate(3) OR (carry_propagate(3) AND carry_in_internal(3));
--    END PROCESS;
--
--    sum(0) <= h_sum(0) XOR carry_in;
--    sum(3 DOWNTO 1) <= h_sum(3 DOWNTO 1) XOR carry_in_internal(3 DOWNTO 1);
--END behavioral;	
