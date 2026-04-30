library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library STD;
use STD.TEXTIO.ALL;

entity tb_hilbert is
end tb_hilbert;

architecture behavioral of tb_hilbert is

    constant k_nbits        : integer := 16;

    signal i_clk            : std_logic := '1';
    signal i_rst            : std_logic := '1';
    signal i_adc_data       : std_logic_vector(k_nbits-1 downto 0);
    signal o_data_valid     : std_logic;
    signal o_data_i         : std_logic_vector(k_nbits-1 downto 0);
    signal o_data_q         : std_logic_vector(k_nbits-1 downto 0);

begin

    -- Clock and Reset Generation
    i_clk <= not i_clk after 5ns;
    i_rst <= '0' after 3 ns;
    
    u_hilberst: entity work.hilbert
    generic map
    (
        g_nbits => k_nbits
    )
    port map
    (
        i_clk        => i_clk,
        i_rst        => i_rst,
        i_adc_data   => i_adc_data,
        o_data_valid => o_data_valid,
        o_data_i     => o_data_i,
        o_data_q     => o_data_q
    );

    -- read input data from a text file
    process
        file infile     : text open read_mode is "C:\Users\a1829716\FPGA_Short_Course\Matlab\hilbert\hilbert_input.txt";
        variable v_line : line;
        variable v_a    : integer;
    begin
        wait until rising_edge(i_clk);
        readline(infile, v_line);
        read(v_line, v_a);
        i_adc_data <= std_logic_vector(to_signed(v_a, k_nbits));
    end process;

    -- write hilbert output data to a text file
    process
        file outfile       : text open write_mode is "C:\Users\a1829716\FPGA_Short_Course\Matlab\hilbert\hilbert_output.txt";
        variable v_line    : line;
        variable v_data_i  : integer;
        variable v_data_q  : integer;
        variable v_space   : character := ' ';
    begin
        -- write when data is valid
        while true loop
            wait until rising_edge(i_clk) and o_data_valid = '1';
            v_data_i := to_integer(signed(o_data_i));
            v_data_q := to_integer(signed(o_data_q));
            write(v_line, v_data_i);
            write(v_line, v_space);
            write(v_line, v_data_q);
            writeline(outfile, v_line);
        end loop;
    end process;

end behavioral;

