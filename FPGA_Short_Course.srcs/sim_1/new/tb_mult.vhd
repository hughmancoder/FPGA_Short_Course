library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library STD;
use STD.TEXTIO.ALL;

entity tb_mult is
end tb_mult;

architecture behavioural of tb_mult is

    -- Constants for bit widths
    constant k_nbits : integer := 16;

    -- Signals
    signal i_clk    : std_logic := '1';
    signal i_mult_a : std_logic_vector(k_nbits-1 downto 0) := (others => '0');
    signal i_mult_b : std_logic_vector(k_nbits-1 downto 0) := (others => '0');
    signal o_mult_c : std_logic_vector(2*k_nbits-1 downto 0);

begin

    -- Clock Generation: 100MHz
    i_clk <= not i_clk after 5 ns;
    
     u_mult: entity work.mult
    generic map
    (
        g_nbits  => k_nbits
    )
    port map
    (
        i_clk    => i_clk,
        i_mult_a => i_mult_a,
        i_mult_b => i_mult_b,
        o_mult_c => o_mult_c
    );

    
    -- Process to read input data (A and B) from a text file
    process
        file infile      : text open read_mode is "C:\Users\a1829716\FPGA_Short_Course\Matlab\mult_input.txt";
        variable v_line  : line;
        variable v_a, v_b : integer;
        variable v_space  : character; -- Used to skip the space between integers
    begin
        while not endfile(infile) loop
            readline(infile, v_line);
            read(v_line, v_a);
            read(v_line, v_space); -- Consume the delimiter
            read(v_line, v_b);
            
            i_mult_a <= std_logic_vector(to_signed(v_a, k_nbits));
            i_mult_b <= std_logic_vector(to_signed(v_b, k_nbits));
            wait until rising_edge(i_clk);
        end loop;

        wait; 
    end process;

    -- Process to read expected output data and verify
    process
        file outfile        : text open read_mode is "C:\Users\a1829716\FPGA_Short_Course\Matlab\mult_output.txt";
        variable v_line     : line;
        variable v_expected : integer;
    begin
        -- Adjust this delay based on your multiplier's pipeline depth
        wait until rising_edge(i_clk);
        wait until rising_edge(i_clk);

        while not endfile(outfile) loop
            readline(outfile, v_line);
            read(v_line, v_expected);
            
            assert (to_integer(signed(o_mult_c)) = v_expected)
                report "Output mismatch! Expected: " & integer'image(v_expected) & 
                       " Got: " & integer'image(to_integer(signed(o_mult_c)))
                severity failure;
                
            wait until rising_edge(i_clk);
        end loop;

        report "Simulation successful - all outputs matched.";
        wait;
    end process;

end behavioural;
