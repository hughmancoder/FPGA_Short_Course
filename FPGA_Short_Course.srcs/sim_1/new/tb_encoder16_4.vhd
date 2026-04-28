library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_encoder16_4 is
end tb_encoder16_4;

architecture rtl of tb_encoder16_4 is
    -- Internal signals for the testbench
    signal i_clk    : std_logic := '0';
    -- Initialise with only bit 0 high to see the encoder work through the range
    signal i_code   : std_logic_vector(15 downto 0) := x"0001";
    signal o_encode : std_logic_vector(3 downto 0);
begin
    

    i_clk <= not i_clk after 5 ns;
    

    process 
    begin
        -- Initial wait to allow the module to stabilise
        wait for 100 ns;
        
    

        -- i_code <= std_logic_vector(shift_left(unsigned(i_code), 1));

    
        -- Walk the '1' through every bit from 0 to 15
        for i in 0 to 14 loop
            wait until rising_edge(i_clk);
            i_code <= std_logic_vector(shift_left(unsigned(i_code), 1));
        end loop;

        wait for 100 ns;
        

        report "Simulation completed successfully.";
        wait; 
    end process;
    

    u_encoder16_4: entity work.encoder16_4(rtl_loop)
    port map (
        i_clk    => i_clk,
        i_code   => i_code,
        o_encode => o_encode
    );

end architecture rtl;