library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.ALL;
library work;
  use work.rom_rand_pkg.all;

entity rom_rand is
  generic
  (
    g_nbits    : integer := 10; -- address width 2^10 = 1024
    g_width    : integer := 16 -- data width
  );
  port
  (
    i_clk      : in  std_logic;
    i_addr     : in  std_logic_vector(g_nbits-1 downto 0);
    o_data     : out std_logic_vector(g_width-1 downto 0)
  );
end rom_rand;

architecture behavioral of rom_rand is
    
  signal f_rom  : t_rom_array;
  signal f_data : std_logic_vector(g_width-1 downto 0);

begin

  -- assign outputs
  o_data <= f_data; -- concurrent assignment as its out of the process block

  -- read from the rom
  process(i_clk)
  begin
    if(rising_edge(i_clk)) then
      f_data <= std_logic_vector(to_unsigned(k_rom_rand(
                to_integer(unsigned(i_addr))), g_width));
    end if;
  end process;

end behavioral;
