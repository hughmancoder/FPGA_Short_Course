library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;
library work;
    use work.dds_pkg.all;

entity dds is
    generic
    (
        g_freq_bits : integer := 10;
        g_nbits     : integer := 16
    );
    port
    (
        i_clk       : in  std_logic;
        i_rst       : in  std_logic;
        i_freq      : in  std_logic_vector(g_freq_bits-1 downto 0);
        o_dds_i     : out std_logic_vector(g_nbits-1 downto 0);
        o_dds_q     : out std_logic_vector(g_nbits-1 downto 0)
    );
end dds;

architecture behavioral of dds is

    signal f_phase_accum : signed(g_freq_bits-1 downto 0);
    signal f_dds_i       : signed(g_nbits-1 downto 0);
    signal f_dds_q       : signed(g_nbits-1 downto 0);

begin

-- assign outputs
o_dds_i <= std_logic_vector(f_dds_i);
o_dds_q <= std_logic_vector(f_dds_q);

-- phase accumulator
process(i_clk, i_rst)
begin
    if (i_rst = '1') then
        f_phase_accum <= (others => '0');
    elsif (rising_edge(i_clk)) then
        -- phase accumulator
        f_phase_accum <= f_phase_accum + signed(i_freq);
    end if;
end process;

-- sin/cos table lookup
process(i_clk)
begin
    if (rising_edge(i_clk)) then
        -- table lookup
        f_dds_i <= to_signed(k_cos_table(to_integer(unsigned(
                                        f_phase_accum))), g_nbits);
        f_dds_q <= to_signed(k_sin_table(to_integer(unsigned(
                                        f_phase_accum))), g_nbits);
    end if;
end process;

end behavioral;

