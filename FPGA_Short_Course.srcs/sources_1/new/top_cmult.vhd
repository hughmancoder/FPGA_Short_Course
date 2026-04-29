library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_cmult is
    port
    (
        i_clk   : in  std_logic;
        i_rst   : in  std_logic;
        i_sw    : in  std_logic_vector(15 downto 0);
        o_led   : out std_logic_vector(15 downto 0)
    );
end top_cmult;

architecture behavioral of top_cmult is

    constant k_width    : integer := 16;
    signal w_count      : std_logic_vector(9 downto 0);
    signal w_rom_rand   : std_logic_vector(15 downto 0);
    signal w_cmult_i    : std_logic_vector(k_width*2 downto 0);
    signal w_cmult_q    : std_logic_vector(k_width*2 downto 0);

    attribute mark_debug : string;
    attribute mark_debug of w_cmult_i  : signal is "true";
    attribute mark_debug of w_cmult_q  : signal is "true";
    attribute mark_debug of w_rom_rand : signal is "true";

begin

    o_led <= i_sw;
    u_counter: entity work.counter 
    generic map
    (
        g_nbits => 10
    )
    port map 
    (
        i_clk => i_clk,
        i_rst => i_rst,
        i_en => '1',
        i_limit => "1111111111", -- 10 bit threshold (others => '1') works too
        o_done => open,
        o_count => w_count
    );
    
   u_rom_rand: entity work.rom_rand
    generic map
    (
        g_nbits => 10,
        g_width => k_width
    )
    port map
    (
        i_clk  => i_clk,
        i_addr => w_count,
        o_data => w_rom_rand
    );
    
    u_cmult: entity work.cmult
    generic map
    (
        g_nbits => k_width
    )
    port map
    (
        i_clk      => i_clk,
        i_data_a_i => w_rom_rand,
        i_data_a_q => w_rom_rand,
        i_data_b_i => w_rom_rand,
        i_data_b_q => w_rom_rand,
        o_data_c_i => w_cmult_i,
        o_data_c_q => w_cmult_q
    );



end behavioral;