

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top3 is  
end tb_top3;

architecture Behavioral of tb_top3 is

    signal i_clk : std_logic := '1';
    signal i_sw : std_logic_vector(15 downto 0);
    signal o_led : std_logic_vector(15 downto 0);
    
begin

  i_clk <= not i_clk after 5ns;
     
    process
    begin
        i_sw <= x"0000";        
        wait for 100 ns;
           
        i_sw <= x"0001";
        
        wait for 100 ns;   
        i_sw <= x"0005";
        
        wait for 100 ns; 
        i_sw <= x"0007";
        
        wait for 100 ns;  
        i_sw <= x"000F";
        
        wait for 100 ns;  
        i_sw <= x"0015";
        
        wait; --wait forever
    end process;
   
    u_top: entity work.top
    port map (
        i_clk => i_clk, 
        i_sw  => i_sw,
        o_led => o_led  
    );

end Behavioral;