

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_and3 is
port (
    i_clk   : in std_logic;
    i_and_a : in std_logic;
    i_and_b : in std_logic;
    i_and_c : in std_logic;
    o_and_d : out std_logic
    );
end reg_and3;

architecture rtl of reg_and3 is
   signal f_and_a : std_logic;
   signal f_and_b : std_logic;
   signal f_and_c : std_logic;
   signal f_and_d : std_logic;
begin
    
    o_and_d <= f_and_d;
    
    -- register inputs/outputs
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            -- Stage 1: Registering inputs
            f_and_a <= i_and_a;
            f_and_b <= i_and_b;
            f_and_c <= i_and_c;
            
            -- Stage 2: Registering the logic result
            f_and_d <= f_and_a and f_and_b and f_and_c;
         end if;
    end process;

end rtl;
