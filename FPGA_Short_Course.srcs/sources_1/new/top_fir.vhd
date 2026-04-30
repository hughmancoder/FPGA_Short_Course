library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_fir is
    port
    (
        i_clk   : in  std_logic;
        i_rst   : in  std_logic;
        i_sw    : in  std_logic_vector(15 downto 0);
        o_led   : out std_logic_vector(15 downto 0)
    );
end top_fir;

architecture schematic of top_fir is

    signal w_adc_data      : std_logic_vector(15 downto 0);
    signal w_hilbert_valid : std_logic;
    signal w_hilbert_i     : std_logic_vector(15 downto 0);
    signal w_hilbert_q     : std_logic_vector(15 downto 0);
    signal w_tdata_in      : std_logic_vector(31 downto 0);
    signal w_tdata_out     : std_logic_vector(79 downto 0);
    signal w_fir_i         : std_logic_vector(15 downto 0);
    signal w_fir_q         : std_logic_vector(15 downto 0);

    attribute mark_debug   : string;
    attribute mark_debug of w_adc_data  : signal is "true";
    attribute mark_debug of w_hilbert_i : signal is "true";
    attribute mark_debug of w_hilbert_q : signal is "true";
    attribute mark_debug of w_fir_i     : signal is "true";
    attribute mark_debug of w_fir_q     : signal is "true";

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
        g_nbits      => 16
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
    
    w_tdata_in <= w_hilbert_q & w_hilbert_i;
    
    u_fir_lpf: entity work.fir_lpf
    Port map(
        aclk                  => i_clk,
        s_axis_data_tvalid    => '1',
        s_axis_data_tready    => open,
        s_axis_data_tdata     => w_tdata_in,
        m_axis_data_tvalid    => open,
        m_axis_data_tdata     => w_tdata_out
    );
    
    w_fir_i <= w_tdata_out(33 downto 18);
    w_fir_q <= w_tdata_out(73 downto 58);
    
end schematic;

