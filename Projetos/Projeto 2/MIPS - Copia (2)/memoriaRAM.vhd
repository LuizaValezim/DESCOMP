library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaRAM is
  generic (
    dataWidth : natural := 32;
    addrWidth : natural := 32;
    memoryAddrWidth : natural := 6); -- 64 posicoes de 32 bits cada
  port (
    clk : in STD_LOGIC;
    endereco : in std_logic_vector (addrWidth - 1 downto 0);
    Dado_in : in std_logic_vector(dataWidth - 1 downto 0);
    Dado_out : out std_logic_vector(dataWidth - 1 downto 0);
    we, re : in STD_LOGIC
  );
end entity;

architecture assincrona OF memoriaRAM is
  TYPE blocoMemoria is ARRAY(0 TO 2 ** memoryAddrWidth - 1) OF std_logic_vector(dataWidth - 1 downto 0);

  signal memRAM : blocoMemoria;
  signal enderecoLocal : std_logic_vector(memoryAddrWidth - 1 downto 0);

begin

  enderecoLocal <= endereco(memoryAddrWidth + 1 downto 2);

  process (clk)
  begin
    IF (rising_edge(clk)) THEN
      IF (we = '1') THEN
        memRAM(to_integer(unsigned(enderecoLocal))) <= Dado_in;
      end IF;
    end IF;
  end process;

  Dado_out <= memRAM(to_integer(unsigned(enderecoLocal))) when (re = '1') else
    (OTHERS => 'Z');

end architecture;