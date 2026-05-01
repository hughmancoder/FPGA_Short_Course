library IEEE;
    use IEEE.std_logic_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;
    
library std;
use std.textio.all;
library work;
use work.win_pkg.all;

entity tb_win is
end tb_win;

architecture rtl of tb_win is

    constant k_nbits   : integer := 16;
    signal i_clk       : std_logic := '1';
    signal i_rst       : std_logic := '1';
    signal i_adc       : std_logic_vector(k_nbits-1 downto 0) := (others => '0');
    
    signal o_win_last  : std_logic;
    signal o_win_adc   : std_logic_vector(k_nbits-1 downto 0);

begin
    i_clk <= not i_clk after 5 ns;
    i_rst <= '0' after 3 ns;

    u_win: entity work.win
    generic map
    (
        g_nbits => 16
    )
    port map
    (
        i_clk      => i_clk,
        i_rst      => i_rst,
        i_adc      => i_adc,
        o_win_last => o_win_last,
        o_win_adc  => o_win_adc
    );

    -- read input data from a text file
    process
        file infile     : text open read_mode is "U:\FPGA_Short_Course\Matlab\win_input.txt";
        variable v_line : line;
        variable v_ai   : integer;
    begin
        wait until rising_edge(i_clk);
        readline(infile, v_line);
        read(v_line, v_ai);
        i_adc <= std_logic_vector(to_signed(v_ai, 16));
    end process;

    -- write output data to a text file
    process
        file infile     : text open write_mode is "U:\FPGA_Short_Course\Matlab\win_output.txt";
        variable v_line : line;
        variable v_ci   : integer;
    begin

        while true loop
            wait until rising_edge(i_clk);
            v_ci := to_integer(signed(o_win_adc));
            write(v_line, v_ci);
            writeline(infile, v_line);
        end loop;

    end process;

end rtl;