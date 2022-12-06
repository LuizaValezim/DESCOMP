library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- biblioteca ieee para funções aritméticas

entity somadorGenerico is
    generic (
        larguradados : natural := 32
    );
    port (
        entradaa, entradab : in std_logic_vector((larguradados - 1) downto 0);
        saida : out std_logic_vector((larguradados - 1) downto 0)
    );
end entity;

architecture comportamento of somadorGenerico is
begin
    saida <= std_logic_vector(unsigned(entradaa) + unsigned(entradab));
end architecture;