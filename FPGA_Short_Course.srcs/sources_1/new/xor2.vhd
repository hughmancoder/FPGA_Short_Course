library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xor2 is
    port (
        i_xor_a : in  std_logic;
        i_xor_b : in  std_logic;
        o_xor_c : out std_logic 
    );
end xor2;

architecture rtl of xor2 is
begin
 
    o_xor_c <= i_xor_a xor i_xor_b;
end rtl;
