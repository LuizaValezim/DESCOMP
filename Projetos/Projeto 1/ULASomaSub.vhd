library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULASomaSub is
    generic ( larguraDados : natural := 8 );
    port (
      entradaA, entradaB:  in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
      seletor:  in STD_LOGIC_VECTOR(1 downto 0);
      saida:    out STD_LOGIC_VECTOR((larguraDados-1) downto 0);
		flagEqual: out STD_LOGIC
    );
end entity;

architecture comportamento of ULASomaSub is
   signal soma :      STD_LOGIC_VECTOR((larguraDados-1) downto 0);
   signal subtracao : STD_LOGIC_VECTOR((larguraDados-1) downto 0);
   signal passa : STD_LOGIC_VECTOR((larguraDados-1) downto 0);
	signal and_op : STD_LOGIC_VECTOR((larguraDados-1) downto 0);

    begin
      soma      <= STD_LOGIC_VECTOR(unsigned(entradaA) + unsigned(entradaB));
      subtracao <= STD_LOGIC_VECTOR(unsigned(entradaA) - unsigned(entradaB));
		passa <= STD_LOGIC_VECTOR(unsigned(entradaB));
		and_op <= STD_LOGIC_VECTOR(unsigned(entradaA) and unsigned(entradaB));
      saida <= soma when (seletor = "01") else 
					subtracao when (seletor = "00") else
					passa when (seletor = "10") else
					and_op when (seletor = "11") else
					entradaB;
		flagEqual <= '1' when (subtracao = x"00") else '0';
end architecture;