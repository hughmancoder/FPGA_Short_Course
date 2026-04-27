
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( i_clk : in STD_LOGIC;
--           i_rst_n : in STD_LOGIC;
           i_sw : in STD_LOGIC_VECTOR (15 downto 0);
           o_led : out STD_LOGIC_VECTOR (15 downto 0));
end top;

architecture Behavioral of top is

begin

    o_led <= i_sw;
    
end Behavioral;
