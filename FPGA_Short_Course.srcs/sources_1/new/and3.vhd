

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity and3 is
port (
    i_and_a : in std_logic;
    i_and_b : in std_logic;
    i_and_c : in std_logic;
    o_and_d : out std_logic
    );
end and3;

architecture rtl of and3 is

begin

    o_and_d <= i_and_a and i_and_b and i_and_c;

end rtl;
