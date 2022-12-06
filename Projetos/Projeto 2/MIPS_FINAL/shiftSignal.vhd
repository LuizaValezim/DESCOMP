library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftSignal is
    generic (
        larguradados : natural := 32;
        deslocar : natural := 2
    );
    port (
        entrada : in std_logic_vector(larguradados - 1 downto 0);
        saida : out std_logic_vector(larguradados - 1 downto 0)
    );
end entity;

architecture comportamento of shiftSignal is
begin
    saida <= entrada(larguradados - 1 - deslocar downto 0) & "00";
end architecture;