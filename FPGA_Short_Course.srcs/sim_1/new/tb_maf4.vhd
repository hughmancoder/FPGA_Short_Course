library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library STD;
use STD.TEXTIO.ALL;

entity tb_maf4 is
end tb_maf4;

architecture behavioral of tb_maf4 is

    constant k_nbits : integer := 16;
    signal i_clk     : std_logic := '1';
    signal i_data    : std_logic_vector(k_nbits-1 downto 0) 
                     := (others => '0');
    signal o_data    : std_logic_vector(k_nbits-1 downto 0);

begin
    i_clk <= not i_clk after 5 ns;
    
    
    u_maf4: entity work.maf4
    generic map
    (
        g_nbits => 16
    )
    port map
    (
        i_clk  => i_clk,
        i_data => i_data,
        o_data => o_data
    );

        -- read input data from a text file
    process
        file infile     : text open read_mode 
            is "C:\Users\a1829716\FPGA_Short_Course\Matlab\text_files\maf4_input.txt";
        variable v_line : line;
        variable v_idata : integer;
    begin
        wait until rising_edge(i_clk);
        readline(infile, v_line);
        read(v_line, v_idata);
        i_data <= std_logic_vector(to_signed(v_idata, k_nbits));
    end process;

    -- read expected output data from a text file and check it
    process
        file infile     : text open read_mode 
            is "C:\Users\a1829716\FPGA_Short_Course\Matlab\text_files\maf4_output.txt";
        variable v_line : line;
        variable v_odata : integer;
    begin
        -- four clock delay from input to output of cmult
        wait until rising_edge(i_clk);
        wait until rising_edge(i_clk);
        wait until rising_edge(i_clk);
        wait until rising_edge(i_clk);

        -- loop through file checking all outputs
        while true loop
            wait until rising_edge(i_clk);
            readline(infile, v_line);
            read(v_line, v_odata);
            assert v_odata = to_integer(signed(o_data))
                report "Did not match expected output" severity failure;
        end loop;

    end process;
end behavioral;
