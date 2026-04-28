
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_decoder4 is
--  Port ( );
end tb_decoder4;

architecture rtl of tb_decoder4 is

        signal i_clk    : std_logic := '1';
        signal i_code   : std_logic_vector(3 downto 0) := "0000";
        signal o_decode : std_logic_vector(15 downto 0);
begin
    
    i_clk <= not i_clk after 5 ns;
    
    process 
    begin
        wait for 100ns;
          i_code <= std_logic_vector(unsigned(i_code) + 1);
        
    end process;
    
    u_decoder4: entity work.decoder4(rtl_loop)
    port map
    (
        i_clk => i_clk,
        i_code => i_code,
        o_decode => o_decode
    );

end rtl;
