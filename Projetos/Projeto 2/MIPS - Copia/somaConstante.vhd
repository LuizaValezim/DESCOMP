library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; --Soma (esta biblioteca =ieee)

entity somaconstante is
    generic (
        larguraDados : natural := 32;
        constante : natural := 32
    );
    port (
        entrada : in std_logic_vector((larguraDados - 1) downto 0);
        saida : out std_logic_vector((larguraDados - 1) downto 0)
    );
end entity;

architecture comportamento OF somaconstante is
begin
    saida <= std_logic_vector(unsigned(entrada) + constante);
end architecture;