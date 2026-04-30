library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cfir is
    generic
    (
        g_nbits      : integer := 16
    );
    port
    (
        i_clk        : in  std_logic;
        i_data_i     : in  std_logic_vector(g_nbits-1 downto 0);
        i_data_q     : in  std_logic_vector(g_nbits-1 downto 0);
        o_data_i     : out std_logic_vector(g_nbits-1 downto 0);
        o_data_q     : out std_logic_vector(g_nbits-1 downto 0)
    );
end cfir;

architecture behavioral of cfir is

    signal w_fira_tdata : std_logic_vector(31 downto 0);
    signal w_firb_tdata : std_logic_vector(31 downto 0);
    signal w_firc_tdata : std_logic_vector(31 downto 0);
    signal w_fird_tdata : std_logic_vector(31 downto 0);
    signal f_sum_i      : signed(31 downto 0);
    signal f_sum_q      : signed(31 downto 0);

begin

    o_data_i <= std_logic_vector(f_sum_i(30 downto 15));
    o_data_q <= std_logic_vector(f_sum_q(30 downto 15));

    u_fir_real_1: entity work.fir_real
    port map (
        aclk               => i_clk,
        s_axis_data_tvalid => '1',
        s_axis_data_tready => open,
        s_axis_data_tdata  => i_data_i,
        m_axis_data_tvalid => open,
        m_axis_data_tdata  => w_fira_tdata
    );

    u_fir_imag_1: entity work.fir_imag
    port map (
        aclk               => i_clk,
        s_axis_data_tvalid => '1',
        s_axis_data_tready => open,
        s_axis_data_tdata  => i_data_q,
        m_axis_data_tvalid => open,
        m_axis_data_tdata  => w_firb_tdata
    );

    u_fir_real_2: entity work.fir_real
    port map (
        aclk               => i_clk,
        s_axis_data_tvalid => '1',
        s_axis_data_tready => open,
        s_axis_data_tdata  => i_data_q,
        m_axis_data_tvalid => open,
        m_axis_data_tdata  => w_firc_tdata
    );

    u_fir_imag_2: entity work.fir_imag
    port map (
        aclk               => i_clk,
        s_axis_data_tvalid => '1',
        s_axis_data_tready => open,
        s_axis_data_tdata  => i_data_i,
        m_axis_data_tvalid => open,
        m_axis_data_tdata  => w_fird_tdata
    );

    -- adders on the output
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            f_sum_i <= signed(w_fira_tdata) - signed(w_firb_tdata);
            f_sum_q <= signed(w_firc_tdata) + signed(w_fird_tdata);
        end if;
    end process;

end behavioral;