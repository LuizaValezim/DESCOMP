library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- Biblioteca IEEE para funções aritméticas

entity somadorgenerico1bit is
    port
    (
      entradaA, entradaB : in STD_LOGIC;
		cin                : in std_logic;
      saida              : out STD_LOGIC;
		cout               : out std_logic  
    );
end entity;

architecture comportamento of somadorgenerico1bit is
  begin
    saida <= cin xor (entradaA xor entradaB);
    cout <= (entradaA and entradaB) or (cin and (entradaA xor entradaB));
end architecture;