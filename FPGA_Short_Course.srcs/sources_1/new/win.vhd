library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
    use work.win_pkg.all;

entity win is
    generic
    (
        g_nbits : integer := 16
    );
    port
    (
        i_clk      : in  std_logic;
        i_rst      : in  std_logic;
        i_adc      : in  std_logic_vector(g_nbits-1 downto 0);
        o_win_last : out std_logic;
        o_win_adc  : out std_logic_vector(g_nbits-1 downto 0)
    );
end win;

architecture rtl of win is

    signal f_adc_data : signed(g_nbits-1 downto 0);
    signal f_mult     : signed(2*g_nbits-1 downto 0);
    signal f_cnt      : unsigned(9 downto 0);
    signal f_win_data : signed(g_nbits-1 downto 0);
    signal f_win_last : std_logic;

begin

    o_win_adc  <= std_logic_vector(f_mult(30 downto 15));
    o_win_last <= f_win_last;

    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            f_mult     <= (others => '0');
            f_cnt      <= (others => '0');
            f_win_data <= (others => '0');
            f_adc_data <= (others => '0');
            f_win_last <= '0';
        elsif(rising_edge(i_clk)) then
            f_adc_data <= signed(i_adc);
            f_cnt      <= f_cnt + 1;
            f_win_data <= to_signed(k_win_array(to_integer(f_cnt)), 16);
            f_mult     <= f_adc_data * f_win_data;

            if(f_cnt = 1023) then
                f_win_last <= '1';
            else
                f_win_last <= '0';
            end if;
        end if;
    end process;

end rtl;