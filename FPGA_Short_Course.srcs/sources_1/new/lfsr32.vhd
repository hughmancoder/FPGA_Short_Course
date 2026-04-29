library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lfsr32 is
    port
    (
        i_clk   : in  std_logic;
        i_rst   : in  std_logic;
        i_seed  : in  std_logic_vector(31 downto 0);
        o_lfsr  : out std_logic_vector(31 downto 0)
    );
end lfsr32;

architecture rtl of lfsr32 is
signal f_lfsr : std_logic_vector(31 downto 0);

begin 

    o_lfsr <= f_lfsr;
    
    process(i_clk, i_rst)
    begin
     
    if (i_rst = '1') then
        f_lfsr <= i_seed;
    elsif(rising_edge(i_clk)) then
        -- linear feedback
        -- The result of this XOR operation becomes the new value for the least significant bit (f_lfsr(0)) on the next clock cycle.
        f_lfsr(0) <= f_lfsr(31) xor f_lfsr(21) xor f_lfsr(0);
        f_lfsr(31 downto 1) <= f_lfsr(30 downto 0);
    end if;    
    end process;
end rtl;