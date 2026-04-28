library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder4 is
    port (
        i_clk    : in  std_logic;
        i_code   : in  std_logic_vector(3 downto 0);
        o_decode : out std_logic_vector(15 downto 0)
    );
end decoder4;

architecture rtl of decoder4 is

    signal f_code   : std_logic_vector(3 downto 0);
    signal ff_code  : std_logic_vector(3 downto 0);
    signal f_decode : std_logic_vector(15 downto 0);

begin
    o_decode <= f_decode;
    
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            f_code <= i_code;
            ff_code <= f_code;
            case ff_code is
                when "0000" => f_decode <= "0000000000000001";
                when "0001" => f_decode <= "0000000000000010";
                when "0010" => f_decode <= "0000000000000100";
                when "0011" => f_decode <= "0000000000001000";
                when "0100" => f_decode <= "0000000000010000";
                when "0101" => f_decode <= "0000000000100000";
                when "0110" => f_decode <= "0000000001000000";
                when "0111" => f_decode <= "0000000010000000";
                when "1000" => f_decode <= "0000000100000000";
                when "1001" => f_decode <= "0000001000000000";
                when "1010" => f_decode <= "0000010000000000";
                when "1011" => f_decode <= "0000100000000000";
                when "1100" => f_decode <= "0001000000000000";
                when "1101" => f_decode <= "0010000000000000";
                when "1110" => f_decode <= "0100000000000000";
                when "1111" => f_decode <= "1000000000000000";
                when others => null;
            end case;
        end if;
    end process;

end architecture rtl;
