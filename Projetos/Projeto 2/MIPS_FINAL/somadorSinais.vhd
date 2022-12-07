library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  --Soma (esta biblioteca =ieee)

entity somadorSinais is
    generic(
        larguraDados : natural := 32
    );
    port(
        entradaCima: in  STD_LOGIC_VECTOR((larguraDados-1) downto 0);
		  entradaBaixo: in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
        saida:   out STD_LOGIC_VECTOR((larguraDados-1) downto 0)
    );
end entity;

architecture comportamento of somadorSinais is
    begin
        saida <= std_logic_vector(signed(entradaCima) + signed(entradaBaixo));
end architecture;