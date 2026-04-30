library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity top_hilbert is
    port
    (
        i_clk   : in  std_logic;
        i_rst   : in  std_logic;
        i_sw    : in  std_logic_vector(15 downto 0);
        o_led   : out std_logic_vector(15 downto 0)
    );
end top_hilbert;

architecture schematic of top_hilbert is

    signal w_adc_data      : std_logic_vector(15 downto 0);
    signal w_hilbert_valid : std_logic;
    signal w_hilbert_i     : std_logic_vector(15 downto 0);
    signal w_hilbert_q     : std_logic_vector(15 downto 0);
    
    attribute mark_debug   : string;
    attribute mark_debug of w_adc_data: signal is "true";
    attribute mark_debug of w_hilbert_valid: signal is "true";
    attribute mark_debug of w_hilbert_i : signal is "true";
    attribute mark_debug of w_hilbert_q : signal is "true";
    

begin
    
    o_led <= i_sw;
    
    
    u_vadc: entity work.vadc
    generic map
    (
    g_width => 16
    )
    port map
    (
        i_clk  => i_clk,
        i_rst  => i_rst,
        o_adc  => w_adc_data
    );

    u_hilbert: entity work.hilbert
    generic map
    (
        g_nbits => 16
    )
    port map
    (
        i_clk        => i_clk,
        i_rst        => i_rst,
        i_adc_data   => w_adc_data,
        o_data_valid => w_hilbert_valid,
        o_data_i     => w_hilbert_i,
        o_data_q     => w_hilbert_q
    );

end schematic;
