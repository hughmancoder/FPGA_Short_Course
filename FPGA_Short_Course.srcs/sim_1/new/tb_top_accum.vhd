library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_accum is
end tb_top_accum;

architecture schematic of tb_top_accum is

    constant k_width : integer := 16;
    constant k_nbits : integer := 10;

    signal i_clk     : std_logic := '1';
    signal i_rst     : std_logic := '1';
    signal i_sw      : std_logic_vector(15 downto 0) := x"0000";
    signal o_led     : std_logic_vector(15 downto 0);

begin

i_clk <= not i_clk after 5 ns;
i_rst <= '0' after 3 ns;
i_sw(0) <= '1' after 100 ns;
  
u_top_accum: entity work.top_accum      
port map
(
        i_clk => i_clk,
        i_rst  => i_rst,
        i_sw   => i_sw,
        o_led  => o_led
);

end schematic;
