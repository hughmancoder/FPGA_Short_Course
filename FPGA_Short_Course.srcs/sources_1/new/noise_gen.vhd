library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity noise_gen is
port
(
    i_clk    : in  std_logic;
    i_rst    : in  std_logic;
    o_noise  : out std_logic_vector(7 downto 0)
);
end noise_gen;

architecture rtl of noise_gen is

    signal w_lfsr0 : std_logic_vector(31 downto 0);
    signal w_lfsr1 : std_logic_vector(31 downto 0);
    signal w_lfsr2 : std_logic_vector(31 downto 0);
    signal w_lfsr3 : std_logic_vector(31 downto 0);
    signal f_sum1  : signed(7 downto 0);
    signal f_sum2  : signed(7 downto 0);
    signal f_sum3  : signed(7 downto 0);

begin

    o_noise <= std_logic_vector(f_sum3);
    
    u_lfsr32_0: entity work.lfsr32
    port map
    (
        i_clk => i_clk,
        i_rst => i_rst,
        i_seed => x"00000001",
        o_lfsr => w_lfsr0
    );
    
    u_lfsr32_1: entity work.lfsr32
    port map
    (
        i_clk => i_clk,
        i_rst => i_rst,
        i_seed => x"87654321",
        o_lfsr => w_lfsr1
    );
    
    
    u_lfsr32_2: entity work.lfsr32
    port map
    (
        i_clk => i_clk,
        i_rst => i_rst,
        i_seed => x"12345678",
        o_lfsr => w_lfsr2
    );
    
    u_lfsr32_3: entity work.lfsr32
    port map
    (
        i_clk   => i_clk,
        i_rst   => i_rst,
        i_seed  => x"AA55AA55",
        o_lfsr  => w_lfsr3
    );
    
     process(i_clk)
     begin
        if(rising_edge(i_clk)) then
          f_sum1 <= resize(signed(w_lfsr0(5 downto 0)), 8) +
                      resize(signed(w_lfsr1(5 downto 0)), 8);
          f_sum2 <= resize(signed(w_lfsr2(5 downto 0)), 8) +
                      resize(signed(w_lfsr3(5 downto 0)), 8);
          f_sum3 <= f_sum1 + f_sum2;
        end if;
     end process;
end rtl;