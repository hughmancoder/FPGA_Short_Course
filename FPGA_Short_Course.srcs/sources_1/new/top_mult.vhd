library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity top_mult is
    port
    (
        i_clk   : in  std_logic;
        i_rst   : in  std_logic;
        i_sw    : in  std_logic_vector(15 downto 0);
        o_led   : out std_logic_vector(15 downto 0)
    );
end top_mult;

architecture schematic of top_mult is
    constant k_width : integer := 16;
    constant k_nbits : integer := 10;
    constant k_limit : std_logic_vector(k_nbits-1 downto 0) := (others => '1');

    signal w_rom_data  : std_logic_vector(k_width-1 downto 0);
    signal w_done      : std_logic;
    signal w_count     : std_logic_vector(k_nbits-1 downto 0);
    signal w_mult_data : std_logic_vector(2*k_width-1 downto 0); -- 32 bits
begin

    o_led <= w_mult_data(2*k_width-1 downto k_width);
    
    -- instantiate module
    u_mult: entity work.mult
    generic map
    (
        g_nbits => k_width
    )
    port map 
    (
        i_clk => i_clk,
        i_mult_a => w_rom_data,
        i_mult_b => i_sw,
        o_mult_c => w_mult_data
    );
    
    u_counter: entity work.counter
    generic map
    (
        g_nbits => k_nbits
    )
    port map 
    (
        i_clk => i_clk,
        i_rst => i_rst,
        i_en => '1',
        i_limit => k_limit,
        o_done => w_done,
        o_count => w_count
    );
    
    u_rom_rand: entity work.rom_rand
    generic map
    (
        g_nbits => k_nbits,
        g_width => k_width
    )
    port map 
    (
      i_clk => i_clk,
      i_addr => w_count,
      o_data => w_rom_data        
    );
    
   
    
end schematic;
