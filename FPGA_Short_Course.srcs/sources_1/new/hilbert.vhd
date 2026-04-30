library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hilbert is
    generic
    (
        g_nbits      : integer := 16
    );
    port
    (
        i_clk        : in  std_logic;
        i_rst        : in  std_logic;
        i_adc_data   : in  std_logic_vector(g_nbits-1 downto 0);
        o_data_valid : out std_logic;
        o_data_i     : out std_logic_vector(g_nbits-1 downto 0);
        o_data_q     : out std_logic_vector(g_nbits-1 downto 0)
    );
end hilbert;

architecture behavioral of hilbert is

    constant k_zeros       : std_logic_vector(15 downto 0) := x"0000";
    constant k_25mhz       : std_logic_vector(9 downto 0)  := "0100000000"; --256
    signal w_dds_i         : std_logic_vector(g_nbits-1 downto 0);
    signal w_dds_q         : std_logic_vector(g_nbits-1 downto 0);
    signal w_mix_i         : std_logic_vector(2*g_nbits downto 0); -- 33 bits
    signal w_mix_q         : std_logic_vector(2*g_nbits downto 0);
    signal w_trunc_i       : std_logic_vector(g_nbits-1 downto 0);
    signal w_trunc_q       : std_logic_vector(g_nbits-1 downto 0);
    signal w_filter_i      : std_logic_vector(g_nbits-1 downto 0);
    signal w_filter_q      : std_logic_vector(g_nbits-1 downto 0);
    signal f_data_valid    : std_logic;

begin

    o_data_valid  <= f_data_valid;
    o_data_i <= w_filter_i;
    o_data_q <= w_filter_q;
    
    u_dds: entity work.dds
    generic map
    (
        g_freq_bits => 10, --frequency_resolution
        g_nbits     => 16
    )
    port map
    (
        i_clk   => i_clk,
        i_rst   => i_rst,
        i_freq  => k_25mhz, -- 25 Mhz (1024/256 = factor of 4 => 100 / 4 => 25 Mhz
        o_dds_i => w_dds_i,
        o_dds_q => w_dds_q
    );

    u_cmult: entity work.cmult
    generic map
    (
        g_nbits => 16
    )
    port map
    (
        i_clk      => i_clk,
        i_data_a_i => i_adc_data,
        i_data_a_q => k_zeros,
        i_data_b_i => w_dds_i,
        i_data_b_q => w_dds_q,
        o_data_c_i => w_mix_i,
        o_data_c_q => w_mix_q -- 33 bit output
    );
    
   
    w_trunc_i <= w_mix_i(2*g_nbits-2 downto g_nbits-1);
    w_trunc_q <= w_mix_q(2*g_nbits-2 downto g_nbits-1);
    
    u_maf4_i: entity work.maf4
    generic map
    (
    g_nbits => 16
    )
    port map
    (
        i_clk      => i_clk,
        i_data     => w_trunc_i,
        o_data     => w_filter_i
    );
    
    u_maf4_q: entity work.maf4
    generic map
    (
        g_nbits    => 16
    )
    port map
    (
        i_clk      => i_clk,
        i_data     => w_trunc_q,
        o_data     => w_filter_q
    );
    
    process(i_clk,i_rst)
    begin
        if(i_rst = '1') then
            f_data_valid <= '0';
        elsif(rising_edge(i_clk)) then
            f_data_valid <= not f_data_valid;
        end if;
    end process;
    
    end behavioral;

