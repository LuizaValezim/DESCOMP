library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; --soma (esta biblioteca =ieee)

entity somaConstante is
    generic (
        larguradados : natural := 32;
        constante : natural := 32
    );
    port (
        entrada : in std_logic_vector((larguradados - 1) downto 0);
        saida : out std_logic_vector((larguradados - 1) downto 0)
    );
end entity;

architecture comportamento of somaConstante is
begin
    saida <= std_logic_vector(unsigned(entrada) + constante);
end architecture;