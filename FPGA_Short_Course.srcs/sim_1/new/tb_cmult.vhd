library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;
library STD;
    use STD.TEXTIO.ALL;

entity tb_cmult is
end tb_cmult;

architecture behavioral of tb_cmult is

    constant k_nbits : integer := 16; -- value is fixed for constant
    
    signal i_clk       : std_logic := '1';
    signal i_data_a_i  : std_logic_vector(k_nbits - 1 downto 0) := (others => '0');
    signal i_data_a_q  : std_logic_vector(k_nbits - 1 downto 0) := (others => '0');
    signal i_data_b_i  : std_logic_vector(k_nbits - 1 downto 0) := (others => '0');
    signal i_data_b_q  : std_logic_vector(k_nbits - 1 downto 0) := (others => '0');
    signal o_data_c_i  : std_logic_vector(2*k_nbits downto 0);
    signal o_data_c_q  : std_logic_vector(2*k_nbits downto 0);

begin
   
    -- create 100MHz clock
    i_clk <= not i_clk after 5 ns;
    
    u_cmult: entity work.cmult
    generic map
    (
        g_nbits => k_nbits
    )
    port map
    (
        i_clk      => i_clk,
        i_data_a_i => i_data_a_i,
        i_data_a_q => i_data_a_q,
        i_data_b_i => i_data_b_i,
        i_data_b_q => i_data_b_q,
        o_data_c_i => o_data_c_i,
        o_data_c_q => o_data_c_q
    );
    
        -- read input data from a text file
    process
        file infile     : text open read_mode 
            is "C:\Users\a1829716\FPGA_Short_Course\Matlab\cmult_in_data.txt";
        variable v_line  : line;
        variable v_ai    : integer;
        variable v_aq    : integer;
        variable v_bi    : integer;
        variable v_bq    : integer;
        variable v_space : character;
    begin
        wait until rising_edge(i_clk);
        readline(infile, v_line);
        read(v_line, v_ai);
        read(v_line, v_space);
        read(v_line, v_aq);
        read(v_line, v_space);
        read(v_line, v_bi);
        read(v_line, v_space);
        read(v_line, v_bq);
        i_data_a_i <= std_logic_vector(to_signed(v_ai, k_nbits));
        i_data_a_q <= std_logic_vector(to_signed(v_aq, k_nbits));
        i_data_b_i <= std_logic_vector(to_signed(v_bi, k_nbits));
        i_data_b_q <= std_logic_vector(to_signed(v_bq, k_nbits));
    end process;
    
    -- read expected output data from a text file and check it
    process
        file infile     : text open read_mode
            is "C:\Users\a1829716\FPGA_Short_Course\Matlab\cmult_out_data.txt";
        variable v_line  : line;
        variable v_ci    : integer;
        variable v_cq    : integer;
        variable v_space : character;
        variable v_cycle : integer := 0; -- for debugging
    begin
        --  clock delay from input to output of cmult

        wait until rising_edge(i_clk); v_cycle := v_cycle + 1;
        wait until rising_edge(i_clk); v_cycle := v_cycle + 1;
        wait until rising_edge(i_clk); v_cycle := v_cycle + 1;
        wait until rising_edge(i_clk); v_cycle := v_cycle + 1;

        -- loop through file checking all outputs
        while true loop
            wait until rising_edge(i_clk);
            v_cycle := v_cycle + 1;
            readline(infile, v_line);
            read(v_line, v_ci);
            read(v_line, v_space);
            read(v_line, v_cq);
            assert v_ci = to_integer(signed(o_data_c_i))
                -- report "Did not match expected output" severity error;
                report LF & "--- MISMATCH DETECTED ---" &
                   LF & "Cycle:    " & integer'image(v_cycle) &
                   LF & "Expected: " & integer'image(v_ci) &
                   LF & "Actual:   " & integer'image(to_integer(signed(o_data_c_i))) &
                   LF & "-------------------------"
                   severity error;
            assert v_cq = to_integer(signed(o_data_c_q))
                -- report "v_cq did not match expected output" severity error;
                report LF & "--- MISMATCH DETECTED (IMAG) ---" &
                       LF & "Cycle:    " & integer'image(v_cycle) &
                       LF & "Expected: " & integer'image(v_cq) &
                       LF & "Actual:   " & integer'image(to_integer(signed(o_data_c_q))) &
                       LF & "-------------------------"
                       severity error;
        end loop;

    end process;

end behavioral;
