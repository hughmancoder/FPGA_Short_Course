library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library STD;
use STD.TEXTIO.ALL;

entity tb_noise_gen is
end tb_noise_gen;

architecture rtl of tb_noise_gen is

    signal i_clk   : std_logic := '1';
    signal i_rst   : std_logic := '1';
    signal o_noise : std_logic_vector(7 downto 0);

begin
    
   i_clk <= not i_clk after 5 ns;
   i_rst <= '0' after 3 ns;
   
   u_noise_gen: entity work.noise_gen
   port map
   (
   i_clk => i_clk,
   i_rst => i_rst,
   o_noise => o_noise
   );
   
   process 
        file infile : text open write_mode
            is "C:\Users\a1829716\FPGA_Short_Course\Matlab\noise_gen_output.txt";
        variable v_line : line;
        variable v_noise : integer;
    begin
    
    while true loop
        wait until rising_edge(i_clk);
        v_noise := to_integer(signed(o_noise));
        write(v_line, v_noise);
        writeline(infile, v_line);
    end loop;
    end process;
end rtl;
