library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_vadc is
port
(
    i_clk    : in  std_logic;
    i_rst    : in  std_logic;
    i_sw     : in  std_logic_vector(15 downto 0);
    o_led    : out std_logic_vector(15 downto 0)
);
end top_vadc;

architecture schematic of top_vadc is

    signal w_adc : std_logic_vector(15 downto 0);

    attribute mark_debug : string;
    attribute mark_debug of w_adc : signal is "true";

begin

    o_led <= i_sw;
    
    u_vadc: entity work.vadc
    generic map
    (
        g_width => 16
    )
    port map
    (
        i_clk    => i_clk,
        i_rst    => i_rst,
        o_adc    => w_adc
    );
    
end schematic;
