library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Biblioteca IEEE para funções aritméticas

entity somadorgenerico is
    generic (
        larguraDados : natural := 32
    );
    port (
        entradaA, entradaB : in std_logic_vector((larguraDados - 1) downto 0);
        saida : out std_logic_vector((larguraDados - 1) downto 0)
    );
end entity;

architecture comportamento OF somadorgenerico is
begin
    saida <= std_logic_vector(unsigned(entradaA) + unsigned(entradaB));
end architecture;