library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_top is
end tb_top;

architecture Behavioral of tb_top is

    signal i_clk : std_logic := '1'; 
    signal i_sw  : std_logic_vector(15 downto 0) := (others => '0');
    signal o_led : std_logic_vector(15 downto 0);

begin

    i_clk <= not i_clk after 5ns;
        

    process
    begin        
        wait for 100 ns;
        i_sw <= x"0001";
        
        wait for 100 ns;
        i_sw <= x"1234";
        
        wait for 100 ns;        
        i_sw <= x"5678";
        
        wait for 100 ns;        
        i_sw <= x"0000";
        
        wait; --wait forever
    end process;
    

    u_top: entity work.top
    port map (
        i_clk => i_clk, 
        i_sw  => i_sw,
        o_led => o_led  
    );

end Behavioral;