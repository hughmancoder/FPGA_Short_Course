library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;

entity accum is
    generic
    (
        g_width_din : integer := 16;
        g_width_acc : integer := 48
    );
    port
    (
        i_clk   : in  std_logic;
        i_en    : in  std_logic;
        i_data  : in  std_logic_vector(g_width_din-1 downto 0);
        o_accum : out std_logic_vector(g_width_acc-1 downto 0)
    );
end accum;

architecture rtl of accum is

    signal f_en    : std_logic := '0';
    signal f_data  : signed(g_width_din-1 downto 0) := (others => '0');
    signal f_accum : signed(g_width_acc-1 downto 0) := (others => '0');

begin

    o_accum <= std_logic_vector(f_accum);
    
    process(i_clk) begin
        if (rising_edge(i_clk)) then
            f_en <= i_en;
            f_data <= signed(i_data);
            if (f_en = '0') then
                f_accum <= (others => '0');
            else
                f_accum <= f_accum + f_data;
            end if;
        end if;
    end process;
    
end rtl;
