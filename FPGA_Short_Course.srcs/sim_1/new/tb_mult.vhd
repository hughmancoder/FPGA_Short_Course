library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;
library STD;
    use STD.TEXTIO.ALL;

entity tb_accum is
end tb_accum;

architecture behavioural of tb_accum is

    constant k_width_din : integer := 16;
    constant k_width_acc : integer := 48;
    
    signal i_clk   : std_logic := '1';
    signal i_en    : std_logic := '0';
    signal i_data  : std_logic_vector(k_width_din-1 downto 0) := (others => '0');
    signal o_accum : std_logic_vector(k_width_acc-1 downto 0);

begin
    i_clk <= not i_clk after 5 ns;
    
    u_accum: entity work.accum
    generic map
    (
       g_width_din => k_width_din,
       g_width_acc => k_width_acc
    )
    port map
    (
        i_clk   => i_clk,
        i_en    => i_en,
        i_data  => i_data,
        o_accum => o_accum
    );
    

process
    file infile      : text open read_mode
                       is "C:\Users\a1829716\FPGA_Short_Course\Matlab\accum_input.txt";
    variable v_line  : line;
    variable v_data  : integer;
begin
    i_en <= '0';
    wait until rising_edge(i_clk);
    i_en <= '1';
    
    while not endfile(infile) loop
        readline(infile, v_line);
        read(v_line, v_data);
        i_data <= std_logic_vector(to_signed(v_data, k_width_din));
        wait until rising_edge(i_clk);
    end loop;
    
    i_en <= '0';
    wait;
end process;

-- read expected output data from a text file and check it
process
    file infile      : text open read_mode
                       is "C:\Users\a1829716\FPGA_Short_Course\Matlab\accum_output.txt";
    variable v_line  : line;
    variable v_expected  : integer;
begin
    -- two clock delay from input to output of accum
    wait until rising_edge(i_clk);
    wait until rising_edge(i_clk);
    wait until rising_edge(i_clk);

    -- loop through file checking all outputs
    while not endfile(infile) loop
        wait until rising_edge(i_clk);
        readline(infile, v_line);
        read(v_line, v_expected);
        assert v_expected = to_integer(signed(o_accum))
            report "Did not match expected output" severity failure;
    end loop;
    
    report "File simulation successful!" severity note;
    wait;
end process;

end behavioural;

  