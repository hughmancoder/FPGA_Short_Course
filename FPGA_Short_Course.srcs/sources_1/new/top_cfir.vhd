library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;

entity top_cfir is
    port
    (
        i_clk   : in  std_logic;
        i_rst   : in  std_logic;
        i_sw    : in  std_logic_vector(15 downto 0);
        o_led   : out std_logic_vector(15 downto 0)
    );
end top_cfir;

architecture behavioral of top_cfir is

    constant k_width   : integer := 16;
    signal w_count     : std_logic_vector(9 downto 0);
    signal w_rom_rand  : std_logic_vector(15 downto 0);
    signal f_rom_rand  : std_logic_vector(15 downto 0);
    signal w_cfir_i    : std_logic_vector(15 downto 0);
    signal w_cfir_q    : std_logic_vector(15 downto 0);

    attribute mark_debug : string;
    attribute mark_debug of w_cfir_i : signal is "true";
    attribute mark_debug of w_cfir_q : signal is "true";

begin

    -- assign outputs
    o_led <= i_sw;
    
    u_counter: entity work.counter
    generic map
    (
    g_nbits => 10
    )
    port map
    (
        i_clk   => i_clk,
        i_rst   => i_rst,
        i_en    => '1',
        i_limit => "1111111111",
        o_done  => open,
        o_count => w_count
    );

   
   u_rom_rand: entity work.rom_rand
generic map
(
    g_nbits  => 10,
    g_width  => k_width
)
port map
(
    i_clk    => i_clk,
    i_addr   => w_count,
    o_data   => w_rom_rand
);

-- delayed version of random data
process(i_clk)
begin
    if(rising_edge(i_clk)) then
        f_rom_rand <= w_rom_rand;
    end if;
end process;

u_cfir: entity work.cfir
generic map
(
    g_nbits => k_width
)
port map
(
    i_clk    => i_clk,
    i_data_i => w_rom_rand,
    i_data_q => f_rom_rand,
    o_data_i => w_cfir_i,
    o_data_q => w_cfir_q
);

end behavioral;