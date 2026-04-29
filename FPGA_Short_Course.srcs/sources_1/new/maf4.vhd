library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity maf4 is
    generic
    (
        g_nbits    : integer := 16
    );
    port
    (
        i_clk      : in  std_logic;
        i_data     : in  std_logic_vector(g_nbits-1 downto 0);
        o_data     : out std_logic_vector(g_nbits-1 downto 0)
    );
end maf4;

architecture behavioral of maf4 is

    signal f_data     : signed(g_nbits-1 downto 0) := (others => '0');
    signal ff_data    : signed(g_nbits-1 downto 0) := (others => '0');
    signal fff_data   : signed(g_nbits-1 downto 0) := (others => '0');
    signal ffff_data  : signed(g_nbits-1 downto 0) := (others => '0');
    signal f_sum1a    : signed(g_nbits downto 0)   := (others => '0');
    signal f_sum1b    : signed(g_nbits downto 0)   := (others => '0');
    signal f_sum2     : signed(g_nbits+1 downto 0) := (others => '0');

begin

    -- assign outputs (divide by 4)
    o_data <= std_logic_vector(f_sum2(g_nbits+1 downto 2));

    -- synchronous filter operations
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            -- tapped delay line
            f_data    <= signed(i_data);
            ff_data   <= signed(f_data);
            fff_data  <= signed(ff_data);
            ffff_data <= signed(fff_data);
            -- first stage adders
            f_sum1a   <= resize(f_data, g_nbits+1) + resize(ff_data, g_nbits+1);
            f_sum1b   <= resize(fff_data, g_nbits+1) + resize(ffff_data, g_nbits+1);
            -- second stage adder
            f_sum2    <= resize(f_sum1a, g_nbits+2) + resize(f_sum1b, g_nbits+2);
        end if;
    end process;

end behavioral;
