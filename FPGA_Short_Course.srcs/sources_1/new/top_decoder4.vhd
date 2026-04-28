library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_decoder4 is
    port
    (
        i_clk : in  std_logic;
        i_rst : in  std_logic;
        i_sw  : in  std_logic_vector(15 downto 0);
        o_led : out std_logic_vector(15 downto 0)
    );
end top_decoder4;

architecture schematic of top_decoder4 is

begin
        u_decoder4: entity work.decoder4
        port map
        (
        i_clk => i_clk,
        i_code => i_sw(3 downto 0),
        o_decode => o_led
        );

end schematic;
