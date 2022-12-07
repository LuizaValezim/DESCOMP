library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULASomaSub is
    generic ( larguraDados : natural := 4 );
    port (
      entradaA, entradaB:  in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
      seletor:  in STD_LOGIC_VECTOR(5 downto 0);
      saida:    out STD_LOGIC_VECTOR((larguraDados-1) downto 0);
		saida_flag_zero: out std_logic
    );
end entity;

architecture comportamento of ULASomaSub is
    signal soma :      STD_LOGIC_VECTOR((larguraDados-1) downto 0);
	 signal subtracao : STD_LOGIC_VECTOR((larguraDados-1) downto 0);
	 signal ceq : STD_LOGIC_VECTOR((larguraDados-1) downto 0);
	
    begin
      soma      <= STD_LOGIC_VECTOR(unsigned(entradaA) + unsigned(entradaB));
      subtracao <= STD_LOGIC_VECTOR(unsigned(entradaA) - unsigned(entradaB));
		ceq <= (x"00000001") when (subtracao = x"00000000") else x"00000000";
      
		saida <= soma when (seletor = 6X"20") else 
		subtracao when (seletor = 6X"22") else
		subtracao;
		
		saida_flag_zero <= ceq(0);
		
end architecture;
