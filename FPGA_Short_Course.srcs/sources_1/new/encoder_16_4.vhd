

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- This is a priority encoder
entity encoder16_4 is
    Port ( i_clk : in STD_LOGIC;
           i_code : in STD_LOGIC_VECTOR (15 downto 0);
           o_encode : out STD_LOGIC_VECTOR (3 downto 0));
end encoder16_4;

architecture rtl of encoder16_4 is
    signal f_code   : std_logic_vector(15 downto 0);
    signal ff_code  : std_logic_vector(15 downto 0);
    signal f_encode: std_logic_vector(3 downto 0);
begin
    
    o_encode <= f_encode;
    
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            f_code <= i_code;
            ff_code <= f_code;
            -- priority encoder    
            if    ff_code(15) = '1' then f_encode <= "1111";
            elsif ff_code(14) = '1' then f_encode  <= "1110";
            elsif ff_code(13) = '1' then f_encode  <= "1101";
            elsif ff_code(12) = '1' then f_encode  <= "1100";
            elsif ff_code(11) = '1' then f_encode  <= "1011";
            elsif ff_code(10) = '1' then f_encode  <= "1010";
            elsif ff_code(9)  = '1' then f_encode  <= "1001";
            elsif ff_code(8)  = '1' then f_encode  <= "1000";
            elsif ff_code(7)  = '1' then f_encode  <= "0111";
            elsif ff_code(6)  = '1' then f_encode  <= "0110";
            elsif ff_code(5)  = '1' then f_encode  <= "0101";
            elsif ff_code(4)  = '1' then f_encode  <= "0100";
            elsif ff_code(3)  = '1' then f_encode  <= "0011";
            elsif ff_code(2)  = '1' then f_encode  <= "0010";
            elsif ff_code(1)  = '1' then f_encode  <= "0001";
            else  f_encode <= "0000";
            end if;
        end if;
    end process;

end architecture rtl;


architecture rtl_standard_encoder of encoder16_4 is
    signal f_code   : std_logic_vector(15 downto 0);
    signal ff_code  : std_logic_vector(15 downto 0);
    signal f_encode: std_logic_vector(3 downto 0);
begin
    
    o_encode <= f_encode;
    
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            f_code <= i_code;
            ff_code <= f_code;
                case ff_code is
                when "0000000000000001" => f_encode <= "0000";
                when "0000000000000010" => f_encode <= "0001";
                when "0000000000000100" => f_encode <= "0010";
                when "0000000000001000" => f_encode <= "0011";
                when "0000000000010000" => f_encode <= "0100";
                when "0000000000100000" => f_encode <= "0101";
                when "0000000001000000" => f_encode <= "0110";
                when "0000000010000000" => f_encode <= "0111";
                when "0000000100000000" => f_encode <= "1000";
                when "0000001000000000" => f_encode <= "1001";
                when "0000010000000000" => f_encode <= "1010";
                when "0000100000000000" => f_encode <= "1011";
                when "0001000000000000" => f_encode <= "1100";
                when "0010000000000000" => f_encode <= "1101";
                when "0100000000000000" => f_encode <= "1110";
                when "1000000000000000" => f_encode <= "1111";
                when others             => null;
            end case;
        end if;
    end process;

end architecture rtl_standard_encoder;

architecture rtl_loop of encoder16_4 is

    signal f_code   : std_logic_vector(15 downto 0) := (others => '0');
    signal ff_code  : std_logic_vector(15 downto 0) := (others => '0');
    signal f_encode : std_logic_vector(3 downto 0)  := (others => '0');
begin

    o_encode <= f_encode;

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            f_code  <= i_code;
            ff_code <= f_code;
            f_encode <= (others => '0'); 
            
            for i in 1 to 15 loop
                if ff_code(i) = '1' then
                    f_encode <= std_logic_vector(to_unsigned(i, 4));
                 end if;
             end loop;
            end if;
    end process;

end architecture rtl_loop;