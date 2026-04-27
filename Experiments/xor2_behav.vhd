library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xor2_behav is
    port (
        i_xor_a : in  std_logic;
        i_xor_b : in  std_logic;
        o_xor_c : out std_logic 
    );
end xor2_behav;

architecture behavioral of xor2_behav is
begin
    process(i_xor_a, i_xor_b)
    begin
        if (i_xor_a = '1' and i_xor_b = '0') or (i_xor_a = '0' and i_xor_b = '1') then
            o_xor_c <= '1';
        else
            o_xor_c <= '0';
        end if;
    end process;
end behavioral;