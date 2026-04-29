library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cmult is
    generic
    (
        g_nbits    : integer := 16
    );
    port
    (
        i_clk      : in  std_logic;
        i_data_a_i : in  std_logic_vector(g_nbits - 1 downto 0);
        i_data_a_q : in  std_logic_vector(g_nbits - 1 downto 0);
        i_data_b_i : in  std_logic_vector(g_nbits - 1 downto 0);
        i_data_b_q : in  std_logic_vector(g_nbits - 1 downto 0);
        o_data_c_i : out std_logic_vector(2*g_nbits downto 0);
        o_data_c_q : out std_logic_vector(2*g_nbits downto 0)
    );
end cmult;

architecture behavioral of cmult is
    -- i = inphase (real)
    -- q = quadrature (imaginary)
    signal f_data_a_i : signed(g_nbits - 1 downto 0);
    signal f_data_a_q : signed(g_nbits - 1 downto 0);
    signal f_data_b_i : signed(g_nbits - 1 downto 0);
    signal f_data_b_q : signed(g_nbits - 1 downto 0);

    signal f_aibi     : signed(2*g_nbits - 1 downto 0);
    signal f_aibq     : signed(2*g_nbits - 1 downto 0);
    signal f_aqbi     : signed(2*g_nbits - 1 downto 0);
    signal f_aqbq     : signed(2*g_nbits - 1 downto 0);

    signal f_data_c_i : signed(2*g_nbits downto 0);
    signal f_data_c_q : signed(2*g_nbits downto 0);

begin
    o_data_c_i <= std_logic_vector(f_data_c_i);
    o_data_c_q <= std_logic_vector(f_data_c_q);
    
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            -- register inputs
            f_data_a_i  <= signed(i_data_a_i);
            f_data_a_q  <= signed(i_data_a_q);
            f_data_b_i  <= signed(i_data_b_i);
            f_data_b_q  <= signed(i_data_b_q);
            -- multipliers
            f_aibi      <= f_data_a_i * f_data_b_i;
            f_aibq      <= f_data_a_i * f_data_b_q;
            f_aqbi      <= f_data_a_q * f_data_b_i;
            f_aqbq      <= f_data_a_q * f_data_b_q;
            -- adders
            f_data_c_i  <= resize(f_aibi, 2*g_nbits+1) - resize(f_aqbq, 2*g_nbits+1);
            f_data_c_q  <= resize(f_aibq, 2*g_nbits+1) + resize(f_aqbi, 2*g_nbits+1);
        end if;
    end process;
    
end behavioral;
