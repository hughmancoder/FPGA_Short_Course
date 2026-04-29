library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_lfsr32 is
end tb_lfsr32;

architecture rtl of tb_lfsr32 is

    signal i_clk : std_logic := '1';
    signal i_rst : std_logic := '1';
    signal o_lfsr : std_logic_vector(31 downto 0);
begin
    i_clk <= not i_clk after 5 ns;
    i_rst <= '0' after 3 ns;
    
    u_lfsr3: entity work.lfsr32
    port map 
    (
        i_clk => i_clk,
        i_rst => i_rst,
        i_seed => x"00000001",
        o_lfsr => o_lfsr
    );

end rtl;
