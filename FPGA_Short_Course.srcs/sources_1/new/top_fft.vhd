library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_fft is
    port (
        i_clk   : in  std_logic;
        i_rst   : in  std_logic;
        i_sw    : in  std_logic_vector(15 downto 0);
        o_led   : out std_logic_vector(15 downto 0)
    );
end top_fft;

architecture schematic of top_fft is

    signal w_adc            : std_logic_vector(15 downto 0);
    signal f_adc_cnt        : unsigned(9 downto 0);
    signal w_fft_tdata_in   : std_logic_vector(31 downto 0);
    signal f_fft_tlast_in   : std_logic;
    signal w_fft_tdata_out  : std_logic_vector(63 downto 0);
    signal w_fft_tuser_out  : std_logic_vector(15 downto 0);
    signal w_fft_tvalid_out : std_logic;
    signal w_fft_tlast_out  : std_logic;
    signal w_fft_data_i     : std_logic_vector(26 downto 0);
    signal w_fft_data_q     : std_logic_vector(26 downto 0);

    attribute mark_debug : string;
    attribute mark_debug of w_adc : signal is "true";
    attribute mark_debug of w_fft_data_i: signal is "true";
    attribute mark_debug of w_fft_data_q: signal is "true";
    attribute mark_debug of w_fft_tlast_out: signal is "true"; -- Required for triggering
    

begin

    o_led <= i_sw;

    process(i_clk, i_rst)
    begin
        if (i_rst = '1') then
            f_adc_cnt      <= (others => '0');
            f_fft_tlast_in <= '0';
        elsif (rising_edge(i_clk)) then
            f_adc_cnt <= f_adc_cnt + 1;

            if (f_adc_cnt = 1023) then
                f_fft_tlast_in <= '1';
            else
                f_fft_tlast_in <= '0';
            end if;
        end if;
    end process;

u_vadc: entity work.vadc
generic map
(
    g_width => 16
)
port map
(
    i_clk => i_clk,
    i_rst => i_rst,
    o_adc => w_adc
);

w_fft_tdata_in  <= x"0000" & w_adc;

u_fft: entity work.fft_1024
Port map(
    aclk => i_clk,
    s_axis_config_tdata     => "00000000",
    s_axis_config_tvalid    => '0',
    s_axis_config_tready    => open,
    s_axis_data_tdata       => w_fft_tdata_in,
    s_axis_data_tvalid      => '1',
    s_axis_data_tready      => open,
    s_axis_data_tlast       => f_fft_tlast_in,
    m_axis_data_tdata       => w_fft_tdata_out,
    m_axis_data_tuser       => w_fft_tuser_out,
    m_axis_data_tvalid      => w_fft_tvalid_out,
    m_axis_data_tready      => '1',
    m_axis_data_tlast       => w_fft_tlast_out,
    event_frame_started     => open,
    event_tlast_unexpected  => open,
    event_tlast_missing     => open,
    event_status_channel_halt => open,
    event_data_in_channel_halt => open,
    event_data_out_channel_halt => open
);

w_fft_data_i <= w_fft_tdata_out(26 downto 0);
w_fft_data_q <= w_fft_tdata_out(58 downto 32);

end schematic;
