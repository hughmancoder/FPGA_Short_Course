library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library STD;
use STD.TEXTIO.ALL;

entity tb_cfir is
end tb_cfir;

architecture behavioral of tb_cfir is

    constant k_nbits        : integer := 16;

    signal i_clk            : std_logic := '1';
    signal i_data_i         : std_logic_vector(k_nbits - 1 downto 0) := (others => '0');
    signal i_data_q         : std_logic_vector(k_nbits - 1 downto 0) := (others => '0');
    signal o_data_i         : std_logic_vector(k_nbits - 1 downto 0);
    signal o_data_q         : std_logic_vector(k_nbits - 1 downto 0);

begin

    -- create 100MHz clock
    i_clk <= not i_clk after 5 ns;

    -- instantiate the complex filter
    u_cfir: entity work.cfir
    generic map
    (
        g_nbits      => k_nbits
    )
    port map
    (
        i_clk        => i_clk,
        i_data_i     => i_data_i,
        i_data_q     => i_data_q,
        o_data_i     => o_data_i,
        o_data_q     => o_data_q
    );

    -- read input data from a text file
    process
        file infile      : text open read_mode 
                         is "C:\Users\a1829716\FPGA_Short_Course\Matlab\FIR\cfir_input.txt";
        variable v_line  : line;
        variable v_ai    : integer;
        variable v_aq    : integer;
        variable v_space : character;
    begin
        wait until rising_edge(i_clk);
        readline(infile, v_line);
        read(v_line, v_ai);
        read(v_line, v_space);
        read(v_line, v_aq);
        i_data_i <= std_logic_vector(to_signed(v_ai, k_nbits));
        i_data_q <= std_logic_vector(to_signed(v_aq, k_nbits));
    end process;

    -- write output data to a text file
    process
        file infile      : text open write_mode 
                         is "C:\Users\a1829716\FPGA_Short_Course\Matlab\FIR\cfir_output.txt";
        variable v_line  : line;
        variable v_ci    : integer;
        variable v_cq    : integer;
        variable v_space : character := ' ';
    begin

        while true loop
            wait until rising_edge(i_clk);
            v_ci := to_integer(signed(o_data_i));
            v_cq := to_integer(signed(o_data_q));
            write(v_line, v_ci);
            write(v_line, v_space);
            write(v_line, v_cq);
            writeline(infile, v_line);
        end loop;

    end process;

end behavioral;