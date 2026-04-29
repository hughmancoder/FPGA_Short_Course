library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity state_machine is
    port
    (
        i_clk    : in  std_logic;
        i_rst    : in  std_logic;
        i_sw     : in  std_logic_vector(15 downto 0);
        o_led    : out std_logic_vector(15 downto 0)
    );
end state_machine;

architecture rtl of state_machine is
    type t_state is (s_idle, s_wait_sw1, s_wait_sw2, s_wait_sw3, s_toggle_leds);
    signal f_state : t_state;
    signal f_led   : std_logic_vector(15 downto 0);

begin

    o_led <= f_led;
    
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            f_state <= s_idle;
        elsif rising_edge(i_clk) then
            case f_state is
                when s_idle =>
                    if(i_sw(2 downto 0) = "000") then
                        f_state <= s_wait_sw1;
                    end if;
                when s_wait_sw1 =>
                    if(i_sw(0) = '1') then
                        f_state <= s_wait_sw2;
                    end if;
                when s_wait_sw2 =>
                    if(i_sw(1) = '1') then
                        f_state <= s_wait_sw3;
                    end if;
                when s_wait_sw3 =>
                    if(i_sw(2) = '1') then
                        f_state <= s_toggle_leds;
                    end if;
                when s_toggle_leds => 
                    f_state <= s_idle;
            end case;
        end if;
    end process;
    
    -- led output
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            f_led <= (others => '0');
        elsif rising_edge(i_clk) then
            if(f_state = s_toggle_leds) then
                f_led <= not f_led;
            end if;
        end if;
    end process;
end rtl;

