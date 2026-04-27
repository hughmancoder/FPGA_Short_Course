

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top2 is
    port (
    i_clk: in std_logic;
    i_sw  : in std_logic_vector(15 downto 0);
    o_led : out std_logic_vector(15 downto 0)
    );
end top2;

architecture schematic of top2 is

signal w_xor_a : std_logic;
signal w_xor_b : std_logic;
signal w_xor_c : std_logic;

    
begin
    -- instantiate modules
    u_xor_a: entity work.xor2
    port map (
        i_xor_a => i_sw(0),
        i_xor_b => i_sw(1),
        o_xor_c => w_xor_a
    );
 
 u_xor_b: entity work.xor2
    port map (
        i_xor_a => i_sw(2),
        i_xor_b => i_sw(3),
        o_xor_c => w_xor_b
    );


    u_xor_c: entity work.xor2
    port map (
        i_xor_a => i_sw(4),
        i_xor_b => i_sw(5),
        o_xor_c => w_xor_c
    );

   
    u_and3: entity work.and3
    port map (
        i_and_a => w_xor_a,
        i_and_b => w_xor_b,
        i_and_c => w_xor_c,
        o_and_d => o_led(0) 
    );
end schematic;
