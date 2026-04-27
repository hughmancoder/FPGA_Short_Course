
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and3_behav is
port (
    i_and_a : in std_logic;
    i_and_b : in std_logic;
    i_and_c : in std_logic;
    o_and_d : out std_logic
    );
end and3_behav;

architecture behavioral of and3_behav is
begin
    process(i_and_a, i_and_b, i_and_c)
    begin
        if (i_and_a = '1' and i_and_b = '1' and i_and_c = '1') then
            o_and_d <= '1';
        else
            o_and_d <= '0';
        end if;
    end process;
end behavioral;

architecture dataflow of and3_behav is
begin
    
    o_and_d <= i_and_a and i_and_b and i_and_c;
end dataflow;