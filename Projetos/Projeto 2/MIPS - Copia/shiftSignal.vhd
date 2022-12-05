library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftSignal is

    generic (
        larguraDados : natural := 32;
        deslocar : natural := 2
    );
    port (
        entrada : in std_logic_vector(larguraDados - 1 downto 0);
        saida : out std_logic_vector(larguraDados - 1 downto 0)
    );
end entity;

architecture comportamento OF shiftSignal is
begin
    saida <= entrada(larguraDados - 1 - deslocar downto 0) & "00";
end architecture;