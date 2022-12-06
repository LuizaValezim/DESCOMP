library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaRAM is

  generic (
    datawidth : natural := 32;
    addrwidth : natural := 32;
    memoryaddrwidth : natural := 6); 
  port (
    clk : in std_logic;
    endereco : in std_logic_vector (addrwidth - 1 downto 0);
    dado_in : in std_logic_vector(datawidth - 1 downto 0);
    dado_out : out std_logic_vector(datawidth - 1 downto 0);
    we, re : in std_logic
  );
end entity;

architecture assincrona of memoriaRAM is
  type blocomemoria is array(0 to 2 ** memoryaddrwidth - 1) of std_logic_vector(datawidth - 1 downto 0);
  signal memram : blocomemoria;
  signal enderecolocal : std_logic_vector(memoryaddrwidth - 1 downto 0);

begin

  enderecolocal <= endereco(memoryaddrwidth + 1 downto 2);

  process (clk)
  begin
    if (rising_edge(clk)) then
      if (we = '1') then
        memram(to_integer(unsigned(enderecolocal))) <= dado_in;
      end if;
    end if;
  end process;

  dado_out <= memram(to_integer(unsigned(enderecolocal))) when (re = '1') else
    (others => 'z');

end architecture;