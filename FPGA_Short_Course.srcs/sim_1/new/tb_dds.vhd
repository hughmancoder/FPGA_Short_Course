library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library STD;
use STD.TEXTIO.ALL;
library work;
use work.dds_pkg.all;

entity tb_dds is
end tb_dds;

architecture behavioral of tb_dds is

    constant k_freq_bits : integer := 10;
    constant k_nbits     : integer := 16;

    signal i_clk   : std_logic := '1';
    signal i_rst   : std_logic := '1';
    -- signal i_freq  : std_logic_vector(k_freq_bits-1 downto 0) := "0000000001";
    -- Example: Increasing the frequency step to 50
    -- signal i_freq : std_logic_vector(k_freq_bits-1 downto 0) := std_logic_vector(to_signed(50, k_freq_bits));
    signal i_freq : std_logic_vector(k_freq_bits-1 downto 0) := std_logic_vector(to_signed(-10, k_freq_bits));
    signal o_dds_i : std_logic_vector(k_nbits-1 downto 0);
    signal o_dds_q : std_logic_vector(k_nbits-1 downto 0);

begin

    -- create clock and reset signals
    i_clk <= not i_clk after 5 ns;
    i_rst <= '0' after 3 ns;
    
    u_dds: entity work.dds
    generic map
    (
        g_freq_bits => k_freq_bits,
        g_nbits => k_nbits
    )
    port map
    (
        i_clk => i_clk,  
        i_rst => i_rst,
        i_freq => i_freq,
        o_dds_i => o_dds_i,
        o_dds_q => o_dds_q
    );

    -- write dds output data to a text file
    process
        file outfile      : text open write_mode is
        "C:\Users\a1829716\FPGA_Short_Course\Matlab\text_files\dds_output.txt";
        variable v_line   : line;
        variable v_dds_i  : integer;
        variable v_dds_q  : integer;
        variable v_space  : character := ' ';
    begin
        -- three clock delay from input to output of cmult
        wait until rising_edge(i_clk);
        wait until rising_edge(i_clk);
        wait until rising_edge(i_clk);

        -- loop through file checking all outputs
        while true loop
            wait until rising_edge(i_clk);
            v_dds_i := to_integer(signed(o_dds_i));
            v_dds_q := to_integer(signed(o_dds_q));
            write(v_line, v_dds_i);
            write(v_line, v_space);
            write(v_line, v_dds_q);
            writeline(outfile, v_line);
        end loop;
    end process;

end behavioral;
