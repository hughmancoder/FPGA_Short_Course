library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_counter is
    port
    (
        i_clk      : in  std_logic;
        i_rst      : in  std_logic;
        i_sw       : in  std_logic_vector(15 downto 0);
        o_led      : out std_logic_vector(15 downto 0)
    );
end top_counter;

architecture Behavioral of top_counter is

    constant k_nbits : integer := 26;
    constant k_limit : integer := 49999999;
    signal f_led     : std_logic_vector(15 downto 0);
    signal w_done    : std_logic;
    signal w_count   : std_logic_vector(k_nbits-1 downto 0);

begin

    o_led <= f_led;

    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            f_led <= (others => '0');
        elsif(rising_edge(i_clk)) then
            if(w_done = '1') then
                f_led <= not f_led;
            end if;
        end if;
    end process;

    u_counter: entity work.counter
    generic map
    (
        g_nbits => k_nbits
    )
    port map
    (
        i_clk   => i_clk,
        i_rst   => i_rst,
        i_en    => '1',
        i_limit => std_logic_vector(to_unsigned(k_limit, k_nbits)),
        o_done  => w_done,
        o_count => w_count
    );

end Behavioral;