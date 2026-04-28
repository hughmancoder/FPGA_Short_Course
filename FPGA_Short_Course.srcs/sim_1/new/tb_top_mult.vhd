library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_mult is
end tb_top_mult;

architecture schematic of tb_top_mult is

    signal i_clk   : std_logic := '1';
    signal i_rst   : std_logic := '1';
    signal i_sw    : std_logic_vector(15 downto 0);
    signal o_led   : std_logic_vector(15 downto 0);

begin

    -- generate clock and reset
    i_clk <= not i_clk after 5 ns;
    i_rst <= '0' after 3 ns;

    -- multiply by onne
    i_sw <= x"0001";

    u_top_mult: entity work.top_mult
    port map
    (
        i_clk    => i_clk,
        i_rst    => i_rst,
        i_sw     => i_sw,
        o_led    => o_led
    );

end schematic;