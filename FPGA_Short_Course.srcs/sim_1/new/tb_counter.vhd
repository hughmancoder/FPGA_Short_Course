
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_counter is
end tb_counter;

architecture Behavioral of tb_counter is
    constant k_nbits : integer := 10;
    signal i_clk      : std_logic := '1';
    signal i_rst      : std_logic := '1';
    signal i_en       : std_logic := '0';
    signal i_limit    : std_logic_vector(k_nbits-1 downto 0);
    signal o_done     : std_logic;
    signal o_count    : std_logic_vector(k_nbits-1 downto 0);
begin

i_clk <= not i_clk after 5 ns;
i_rst <= '0' after 23 ns;
i_en <= '1' after 100 ns;
i_limit <= "0000011111"; -- 31
    
u_counter : entity work.counter
generic map
(
g_nbits => k_nbits
)
port map
(
    i_clk      => i_clk,
    i_rst      => i_rst,
    i_en       => i_en,
    i_limit    => i_limit,
    o_done     => o_done,
    o_count    => o_count
);
end Behavioral;
