library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library STD;
use STD.TEXTIO.ALL;

entity tb_fft is
end tb_fft;

architecture behavioral of tb_fft is

    constant k_nbits            : integer := 16;

    signal i_clk                : std_logic := '1';
    signal i_rst                : std_logic := '1';
    signal w_adc                : std_logic_vector(15 downto 0);
    signal f_adc_cnt            : unsigned(9 downto 0);
    signal w_fft_tdata_in       : std_logic_vector(31 downto 0);
    signal f_fft_tlast_in       : std_logic;
    signal w_fft_tdata_out      : std_logic_vector(63 downto 0);
    signal w_fft_tuser_out      : std_logic_vector(15 downto 0);
    signal w_fft_tvalid_out     : std_logic;
    signal w_fft_tlast_out      : std_logic;
    signal w_fft_data_i         : std_logic_vector(26 downto 0);
    signal w_fft_data_q         : std_logic_vector(26 downto 0);
    -- added signal
    signal w_s_axis_data_tready : std_logic;
begin

    -- create 100MHz clock
    i_clk <= not i_clk after 5 ns;
    i_rst <= '0' after 3 ns;

    -- need to generate tlast
    process (i_clk, i_rst) begin
    if (i_rst = '1') then
        f_adc_cnt <= (others => '0');
        f_fft_tlast_in <= '0';
    elsif(rising_edge(i_clk)) then
        if w_s_axis_data_tready = '1' then
            f_adc_cnt <= f_adc_cnt + 1;
            if(f_adc_cnt = 1023) then
                f_fft_tlast_in <= '1';
            else
                f_fft_tlast_in <= '0';
            end if;
        end if;
    end if;
end process;                        


w_fft_tdata_in <= x"0000" & w_adc; -- concatenate bits Q data is zero

u_fft: entity work.fft_1024
Port map(
    aclk                        => i_clk,
    s_axis_config_tdata         => "00000000",
    s_axis_config_tvalid        => '0',
    s_axis_config_tready        => open, -- set here
    s_axis_data_tdata           => w_fft_tdata_in,
    s_axis_data_tvalid          => '1',
    s_axis_data_tready          => w_s_axis_data_tready, -- open,
    s_axis_data_tlast           => f_fft_tlast_in,
    m_axis_data_tdata           => w_fft_tdata_out,
    m_axis_data_tuser           => w_fft_tuser_out,
    m_axis_data_tvalid          => w_fft_tvalid_out,
    m_axis_data_tready          => '1',
    m_axis_data_tlast           => w_fft_tlast_out,
    event_frame_started         => open,
    event_tlast_unexpected      => open,
    event_tlast_missing         => open,
    event_status_channel_halt    => open,
    event_data_in_channel_halt   => open,
    event_data_out_channel_halt  => open
);

w_fft_data_i <= w_fft_tdata_out(26 downto 0);
w_fft_data_q <= w_fft_tdata_out(58 downto 32);

-- read input data from a text file
process
    file infile     : text open read_mode is "U:\FPGA_Short_Course\Matlab\fft_input.txt";
    variable v_line : line;
    variable v_a    : integer;
begin
    wait until rising_edge(i_clk);
    readline(infile, v_line);
    read(v_line, v_a);
    w_adc <= std_logic_vector(to_signed(v_a, k_nbits));
end process;

-- write output data to a text file
process
    file outfile    : text open write_mode is "U:\FPGA_Short_Course\Matlab\fft_output.txt";
    variable v_line : line;
    variable v_ci   : integer;
    variable v_cq   : integer;
    variable v_space : character := ' ';
begin
    while true loop
        wait until rising_edge(i_clk) and w_fft_tvalid_out = '1';
        v_ci := to_integer(signed(w_fft_data_i));
        v_cq := to_integer(signed(w_fft_data_q));
        write(v_line, v_ci);
        write(v_line, v_space);
        write(v_line, v_cq);
        writeline(outfile, v_line);
    end loop;
end process;

end behavioral;