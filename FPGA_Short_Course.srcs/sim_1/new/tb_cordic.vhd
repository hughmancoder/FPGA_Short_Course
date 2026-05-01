library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;
library STD;
    use STD.TEXTIO.ALL;

entity tb_cordic is
end tb_cordic;

architecture behavioral of tb_cordic is

    constant k_nbits        : integer := 16;
    signal i_clk            : std_logic := '1';
    signal i_data_i         : std_logic_vector(26 downto 0);
    signal i_data_q         : std_logic_vector(26 downto 0);
    signal o_mag            : std_logic_vector(15 downto 0);
    signal o_phase          : std_logic_vector(15 downto 0);
    signal w_cordic_din     : std_logic_vector(63 downto 0);
    signal w_cordic_dv      : std_logic;
    signal w_cordic_dout    : std_logic_vector(63 downto 0);
    signal w_mag            : std_logic_vector(26 downto 0);
    signal w_phz            : std_logic_vector(26 downto 0);

begin

    -- create 100MHz clock
    i_clk <= not i_clk after 5 ns;

    w_cordic_din <= "00000" & i_data_q & "00000" & i_data_i;

    -- instantiate the complex filter
    u_cordic: entity work.cordic_16
    Port map(
        aclk                    => i_clk,
        s_axis_cartesian_tvalid => '1',
        s_axis_cartesian_tdata  => w_cordic_din,
        m_axis_dout_tvalid      => w_cordic_dv,
        m_axis_dout_tdata       => w_cordic_dout
    );

    w_mag <= w_cordic_dout(26 downto 0);
    w_phz <= w_cordic_dout(58 downto 32);

    -- read input data from a text file
    process
        file infile      : text open read_mode is "U:\FPGA_Short_Course\Matlab\cordic_input.txt";
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
        i_data_i <= std_logic_vector(to_signed(v_ai, 27));
        i_data_q <= std_logic_vector(to_signed(v_aq, 27));
    end process;

    -- write output data to a text file
    process
        file infile      : text open write_mode is "U:\FPGA_Short_Course\Matlab\cordic_output.txt";
        variable v_line  : line;
        variable v_ci    : integer;
        variable v_cq    : integer;
        variable v_space : character := ' ';
    begin
        
        while true loop
            wait until rising_edge(i_clk);
            v_ci := to_integer(unsigned(w_mag));
            v_cq := to_integer(signed(w_phz));
            write(v_line, v_ci);
            write(v_line, v_space);
            write(v_line, v_cq);
            writeline(infile, v_line);
        end loop;

    end process;

end behavioral;