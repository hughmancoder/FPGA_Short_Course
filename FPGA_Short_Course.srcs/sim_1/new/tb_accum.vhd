library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;
library STD;
    use STD.TEXTIO.ALL;

entity tb_accum is
end tb_accum;

architecture behavioural of tb_accum is

    -- Constants for bit widths
    constant k_width_din : integer := 16;
    constant k_width_acc : integer := 48;

    -- Signals
    signal i_clk   : std_logic := '1';
    signal i_en    : std_logic := '0';
    signal i_data  : std_logic_vector(k_width_din-1 downto 0) := (others => '0');
    signal o_accum : std_logic_vector(k_width_acc-1 downto 0);

begin

    -- Clock Generation: 100MHz (10ns period)
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
    
    -- Process to read input data from a text file
    process
        file infile      : text open read_mode is "C:\Users\a1829716\FPGA_Short_Course\Matlab\accum_input.txt";
        variable v_line  : line;
        variable v_data  : integer;
    begin
        -- Initial Reset/Enable state
        i_en <= '0';
        wait until rising_edge(i_clk);
        i_en <= '1'; 

        while not endfile(infile) loop
            readline(infile, v_line);
            read(v_line, v_data);
            
            i_data <= std_logic_vector(to_signed(v_data, k_width_din));
            wait until rising_edge(i_clk);
        end loop;

        -- Optional: Disable after file is finished
        i_en <= '0';
        wait; 
    end process;

    -- Process to read expected output data and verify
    process
        file outfile     : text open read_mode is "C:\Users\a1829716\FPGA_Short_Course\Matlab\accum_output.txt";
        variable v_line  : line;
        variable v_expected : integer;
    begin

        wait until rising_edge(i_clk);
        wait until rising_edge(i_clk);
        wait until rising_edge(i_clk);

        while not endfile(outfile) loop
            readline(outfile, v_line);
            read(v_line, v_expected);
            
            assert (to_integer(signed(o_accum)) = v_expected)
                report "Output mismatch! Expected: " & integer'image(v_expected) & 
                       " Got: " & integer'image(to_integer(signed(o_accum)))
                severity failure;
                
            wait until rising_edge(i_clk);
        end loop;

        report "Simulation successful - all outputs matched.";
        wait;
    end process;

end behavioural;