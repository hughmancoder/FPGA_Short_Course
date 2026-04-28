library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mult is
    generic
    (
        g_nbits    : integer := 16
    );
    port
    (
        i_clk      : in  std_logic;
        i_mult_a   : in  std_logic_vector(g_nbits-1 downto 0);
        i_mult_b   : in  std_logic_vector(g_nbits-1 downto 0);
        o_mult_c   : out std_logic_vector(2*g_nbits-1 downto 0)
    );
end mult;

architecture rtl of mult is

    signal f_mult_a    : signed(g_nbits-1 downto 0);
    signal f_mult_b    : signed(g_nbits-1 downto 0);
    signal f_mult_c : signed(2*g_nbits-1 downto 0);

begin
  
    o_mult_c <= std_logic_vector(f_mult_c);
      
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            f_mult_a <= signed(i_mult_a);
            f_mult_b <= signed(i_mult_b);
            f_mult_c <= f_mult_a * f_mult_b;
        end if;
    end process;

end rtl;