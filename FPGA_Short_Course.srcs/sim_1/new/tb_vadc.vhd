library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.ALL;
  
library work;
    use work.vadc_pkg.all;
    
entity tb_vadc is
end tb_vadc;

architecture Behavioral of tb_vadc is
    signal i_clk : std_logic := '1';
    signal i_rst : std_logic := '1';
    signal o_adc : std_logic_vector(15 downto 0);
begin
    
    i_clk <= not i_clk after 5 ns;
    i_rst <= '0' after 3 ns;
    
    u_vadc: entity work.vadc
    generic map
    (
        g_width => 16
    )
    port map
    (
        i_clk => i_clk,
        i_rst => i_rst,
        o_adc => o_adc
     );

end Behavioral;
