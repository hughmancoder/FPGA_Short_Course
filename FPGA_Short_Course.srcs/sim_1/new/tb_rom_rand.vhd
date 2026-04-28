library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.ALL;
library work;
  use work.rom_rand_pkg.all;

entity tb_rom_rand is
end tb_rom_rand;

architecture behavioral of tb_rom_rand is

    constant k_nbits : integer := 10;
    constant k_width : integer := 16;
    
    signal i_clk     : std_logic := '1';
    signal i_addr    : std_logic_vector(k_nbits-1 downto 0) := (others => '0');
    signal o_data    : std_logic_vector(k_width-1 downto 0);

begin
    

    i_clk <= not i_clk after 5 ns;

    process
    begin
        wait until rising_edge(i_clk);
        i_addr <= std_logic_vector(to_unsigned(
                    to_integer(unsigned(i_addr)) + 1, k_nbits));
    end process;
    

    u_rom_rand : entity work.rom_rand
    generic map
    (
        g_nbits => k_nbits,
        g_width => k_width  
    )
    port map
    (
        i_clk  => i_clk,
        i_addr => i_addr,
        o_data => o_data
    );

end behavioral;