-- shift_compare.vhdl created on 10:6  2008.4.1
library ieee;
use ieee.std_logic_1164.all;

entity shiftcompare is
   port (Clk, Rst, Load: in std_ulogic;
         Init: in std_logic_vector(31 downto 0);
         Test: in std_logic_vector(31 downto 0);
         Limit: out std_logic
         );
end shiftcompare;

                                                                            
architecture structure of shiftcompare is
  component compare                                                             
   port(A, B: in std_ulogic_vector(0 to 7); 
   		EQ: out std_ulogic);                                                          
  end component;
                                                                               
  component shift                                                   
   port(Clk, Rst, Load: in std_logic;                                                              
        Data: in std_logic_vector(0 to 7);                                         
        Q: out std_logic_vector(0 to 7)
        );                                    
  end component;
                                                                               
  signal Q:  std_ulogic_vector(0 to 7);
                                                                               
begin                                                                            

  COMP1: compare port map (A=>Q, B=>Test, EQ=>Limit);                                                                               
  SHIFT1: shift port map (Clk=>Clk, Rst=>Rst, Load=>Load, Data=>Init, Q=>Q);

end structure;

