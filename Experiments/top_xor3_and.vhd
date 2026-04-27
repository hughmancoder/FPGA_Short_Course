library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_xor2_and3 is
    port (
        i_clk : in std_logic;
        i_sw  : in std_logic_vector(1 downto 0);
        o_led : out std_logic_vector(5 downto 0)
    );
end top_xor2_and3;

architecture schematic of top_xor2_and3 is
    signal w_xor_a : std_logic;
    signal w_xor_b : std_logic;
    signal w_xor_c : std_logic;
    signal w_and_d : std_logic;
    signal w_sw    : std_logic_vector(15 downto 0);
begin

    -- Tang Nano 20K buttons pull high when pressed
    w_sw(0) <= i_sw(0);
    w_sw(1) <= i_sw(1);
    
    -- w_sw(0) <= '1';
    -- w_sw(1) <= '0';
    -- Set the rest of the bits to match the original logic (binary 10101)
    w_sw(2) <= '1';
    w_sw(3) <= '0';
    w_sw(4) <= '1';
    w_sw(5) <= '0';
    w_sw(15 downto 6) <= (others => '0');
    
    u_xor_a: entity work.xor2_behav(behavioral)
    port map(
        i_xor_a => w_sw(0),
        i_xor_b => w_sw(1),
        o_xor_c => w_xor_a
    );
    
    u_xor_b: entity work.xor2_behav(behavioral)
    port map(
        i_xor_a => w_sw(2),
        i_xor_b => w_sw(3),
        o_xor_c => w_xor_b
    );

    u_xor_c: entity work.xor2_behav(behavioral)
    port map(
        i_xor_a => w_sw(4),
        i_xor_b => w_sw(5),
        o_xor_c => w_xor_c
    );

    u_and3: entity work.and3_behav(dataflow)
    port map(
        i_and_a => w_xor_a,
        i_and_b => w_xor_b,
        i_and_c => w_xor_c,
        o_and_d => w_and_d 
    ); 

    -- Invert the result for the active-low LED
    o_led(5) <= not w_and_d;

    -- Drive other LEDs so they aren't floating (and turn them off - active low)
    -- o_led(5 downto 1) <= (others => '1');

end schematic;
