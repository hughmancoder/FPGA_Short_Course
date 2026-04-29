library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.ALL;
  
library work;
    use work.vadc_pkg.all;

entity vadc is
  generic
  (
    g_width      : integer := 16
  );
  port
  (
    i_clk        : in  std_logic;
    i_rst        : in  std_logic;
    o_adc        : out std_logic_vector(g_width-1 downto 0)
  );
end vadc;

architecture behavioral of vadc is

  constant k_en    : std_logic := '1';
  constant k_limit : std_logic_vector(9 downto 0) := "1111111111";

  signal f_rom     : t_vadc_array;
  signal f_data    : std_logic_vector(g_width-1 downto 0);
  signal w_count   : std_logic_vector(9 downto 0);
  

begin

  u_counter: entity work.counter
  generic map
  (
    g_nbits  => 10
  )
  port map
  (
    i_clk   => i_clk,
    i_rst   => i_rst,
    i_en    => k_en,
    i_limit => k_limit,
    o_done  => open, -- unconnected
    o_count => w_count -- adress of input from rom
  );
  
  o_adc <= f_data; -- assign outputs
  
  process(i_clk) 
  begin
    if(rising_edge(i_clk)) then
        -- array is from package
        f_data <= std_logic_vector(to_unsigned(k_vadc_array(to_integer(unsigned(w_count))), g_width));
    
         end if;
    end process;
    
end behavioral;