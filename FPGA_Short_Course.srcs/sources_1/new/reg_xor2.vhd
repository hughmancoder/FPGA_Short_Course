library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_xor2 is
    port (
        i_clk   : in  std_logic;
        i_xor_a : in  std_logic;
        i_xor_b : in  std_logic;
        o_xor_c : out std_logic
    );
end reg_xor2;

architecture rtl of reg_xor2 is
    signal f_xor_a : std_logic;
    signal f_xor_b : std_logic;
    signal f_xor_c : std_logic;
begin

    o_xor_c <= f_xor_c;

    process(i_clk)
    begin
        if (rising_edge(i_clk)) then           
            f_xor_a <= i_xor_a;
            f_xor_b <= i_xor_b;
            f_xor_c <= f_xor_a xor f_xor_b;
        end if;
    end process;

end rtl;