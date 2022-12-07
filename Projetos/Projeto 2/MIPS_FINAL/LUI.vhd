library ieee;
use ieee.std_logic_1164.all;

entity LUI is -- Instrução do subgrupo B: Carrega imediato para 16 bits MSB (load upper immediate: lui) 

    generic (
        larguraDadoEntrada : natural  :=  16;
        larguraDadoSaida   : natural  :=  32
    );
    port (
        in_signal : in  std_logic_vector(larguraDadoEntrada-1 downto 0);
        out_signal: out std_logic_vector(larguraDadoSaida-1 downto 0)
    );
	 
end entity;

architecture comportamento of LUI is
begin

    out_signal <= in_signal & x"0000";
	 
end architecture;