library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    generic
    (
        g_nbits    : integer := 10
    );
    port
    (
        i_clk      : in  std_logic;
        i_rst      : in  std_logic;
        i_en       : in  std_logic;
        i_limit    : in  std_logic_vector(g_nbits-1 downto 0);
        o_done     : out std_logic;
        o_count    : out std_logic_vector(g_nbits-1 downto 0)
    );
end counter;


architecture Behavioral of counter is

    signal f_count : unsigned(g_nbits-1 downto 0);
    signal f_done  : std_logic;

begin

-- assign outputs
o_count <= std_logic_vector(f_count);
o_done  <= f_done;

-- counter
process(i_clk, i_rst)
begin
    if(i_rst = '1') then
        f_count <= (others => '0');
        f_done  <= '0';
    elsif(rising_edge(i_clk)) then
        if(i_en = '1') then
            f_count <= f_count + 1;
            if(f_count = unsigned(i_limit)) then
                f_count <= (others => '0');
                f_done  <= '1';
            else
                f_done  <= '0';
            end if;
        end if;
    end if;
end process;

end Behavioral;
