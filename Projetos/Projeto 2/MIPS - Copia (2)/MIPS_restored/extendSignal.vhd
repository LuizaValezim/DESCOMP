LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY extendSignal IS
    GENERIC (
        larguraDadosEntrada : NATURAL := 16;
        larguraDadosSaida : NATURAL := 32
    );
    PORT (
        entrada : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(larguraDadosSaida - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF extendSignal IS
BEGIN
    saida <= (larguraDadosSaida - 1 DOWNTO larguraDadosEntrada => entrada(15)) & entrada;
END ARCHITECTURE;