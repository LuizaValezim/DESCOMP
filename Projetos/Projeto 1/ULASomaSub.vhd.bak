library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULASomaSub is
    generic ( larguraDados : natural := 8 );
    port (
      entradaA, entradaB:  in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
      seletor:  in STD_LOGIC_VECTOR(2 downto 0);
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
		and_op <= STD_LOGIC_VECTOR(entradaA and "00000001");
      saida <= soma when (seletor = "001") else 
					subtracao when (seletor = "000") else
					passa when (seletor = "010") else
					and_op when (seletor = "100") else
					entradaB;
		flagEqual <= '1' when (subtracao = x"00") else '0';
end architecture;