library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_accum is
port(
i_clk    : in  std_logic;
i_rst    : in  std_logic;
i_sw     : in  std_logic_vector(15 downto 0);
o_led    : out std_logic_vector(15 downto 0)
);
end top_accum;

architecture schematic of top_accum is
    constant k_width : integer := 16;
    constant k_nbits : integer := 10;
    constant k_limit : std_logic_vector(k_nbits-1 downto 0) := (others => '1');
    
    signal w_rom_data   : std_logic_vector(k_width-1 downto 0);
    signal w_done       : std_logic;
    signal w_count      : std_logic_vector(k_nbits-1 downto 0);
    signal w_accum_data : std_logic_vector(47 downto 0);
    
    attribute mark_debug : string;
    attribute mark_debug of w_rom_data   : signal is "true";
    attribute mark_debug of w_count      : signal is "true";
    attribute mark_debug of w_accum_data : signal is "true";

begin

o_led <= i_sw;

u_accum: entity work.accum
generic map(
    g_width_din => k_width,
    g_width_acc => 48
)
port map
(
    i_clk => i_clk,
    i_en => i_sw(0),
    i_data => w_rom_data,
    o_accum => w_accum_data
);
    
u_counter: entity work.counter
generic map
(
    g_nbits    => k_nbits
)
port map
(
    i_clk      => i_clk,
    i_rst      => i_rst,
    i_en       => '1',
    i_limit    => k_limit,
    o_done     => w_done,
    o_count    => w_count
);

u_rom_rand: entity work.rom_rand
generic map
(
    g_nbits    => k_nbits,
    g_width    => k_width
)
port map
(
    i_clk      => i_clk,
    i_addr     => w_count,
    o_data     => w_rom_data
);

end schematic;
