library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_0_31 is
  port (  
		SLT			: in 	std_logic;
		entradaA 	: in	std_logic;
		entradaB 	: in 	std_logic;
		inverteB		: in 	std_logic;
		carryIN		: in 	std_logic;
		seletor		: in 	std_logic_vector(1 DOWNTO 0);
		carryOUT		: out std_logic;
		resultado	: out std_logic
  );
  
end entity;

architecture arquitetura of ULA_0_31 is

	signal MUX_ENTB_OUT : std_logic;
	signal SOMADOR_OUT  : std_logic;

begin	

MUX_ENTB : entity work.muxGenerico2x1_1bit
	port map(
		entradaA_MUX => entradaB,
		entradaB_MUX => not(entradaB),
		seletor_MUX => inverteB,
		saida_MUX => MUX_ENTB_OUT
	);
	
SOMADOR : entity work.somadorULA
	port map(
		carryIN  => carryIN,
		entradaA => entradaA,
		entradaB => MUX_ENTB_OUT,
		soma	 	=> SOMADOR_OUT,
		carryOUT => carryOUT
	);

MUX_RESULTADO : entity work.muxGenerico4x1_1bit
	port map(
		entradaA_MUX => entradaA and MUX_ENTB_OUT,
		entradaB_MUX => entradaA or MUX_ENTB_OUT,
		entradaC_MUX => SOMADOR_OUT, 
		entradaD_MUX => SLT,
		seletor_MUX => seletor,
		saida_MUX => resultado
	);

end architecture;