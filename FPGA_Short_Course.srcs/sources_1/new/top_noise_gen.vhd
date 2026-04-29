
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_noise_gen is
    port
    (
        i_clk   : in  std_logic;
        i_rst   : in  std_logic;
        i_sw    : in  std_logic_vector(15 downto 0);
        o_led   : out std_logic_vector(15 downto 0)
    );
end top_noise_gen;

architecture schematic of top_noise_gen is
    signal w_noise : std_logic_vector(7 downto 0);
    attribute mark_debug: string;
    attribute mark_debug of w_noise : signal is "true";
    
begin

    o_led <= i_sw;
    
    u_noise_gen: entity work.noise_gen
    port map
    (
        i_clk => i_clk,
        i_rst => i_rst,
        o_noise => w_noise
     );


end schematic;
