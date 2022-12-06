library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity extendSignal is

    generic (
        larguradadosentrada : natural := 16;
        larguradadossaida : natural := 32
    );
    port (
        entrada : in std_logic_vector(15 downto 0);
        saida : out std_logic_vector(larguradadossaida - 1 downto 0)
    );
	 
end entity;

architecture comportamento of extendSignal is
begin
    saida <= (larguradadossaida - 1 downto larguradadosentrada => entrada(15)) & entrada;
end architecture;