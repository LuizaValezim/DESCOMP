library ieee;
use ieee.std_logic_1164.all;

entity modelo_sw is
	port(
		 MEM_ADDRESS: out std_logic_vector(8 downto 0);
		 ADD_OUT: out std_logic_vector(larguraDados - 1 downto 0);
		 SW: in std_logic_vector(9 downto 0);
	);
	
	
end entity;

architecture arch_name of modelo_sw is

  signal MEM_Read: std_logic;
  signal MEM_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal MEM_ADD: std_logic_vector(8 downto 0);
  signal decoder_Habilita_OUT: std_logic_vector(7 downto 0);
  signal decoder_Posicao_OUT: std_logic_vector(7 downto 0);
  alias DATA_ADDRESS_A5 : std_logic is MEM_ADD(5);
  alias MEM_Habilita: std_logic is decoder_Habilita_OUT(0); 


begin

	SW_0_7: entity work.buffer_3_state_8portas generic map(dataWidth => 8)
				port map(
						entrada => SW(7 downto 0),
						habilita => (MEM_Read AND NOT(DATA_ADDRESS_A5) AND decoder_Posicao_OUT(0) AND  decoder_Habilita_OUT(5)),
						saida => MEM_OUT
				);
				
	SW_8: entity work.buffer_3_state_8portas generic map(dataWidth => 8)
				port map(
						entrada => "0000000" & SW(8),
						habilita => (MEM_Read AND NOT(DATA_ADDRESS_A5) AND decoder_Posicao_OUT(1) AND  decoder_Habilita_OUT(5)),
						saida => MEM_OUT
				);
				
	SW_9: entity work.buffer_3_state_8portas generic map(dataWidth => 8)
			port map(
					entrada => "0000000" & SW(9),
					habilita => (MEM_Read AND NOT(DATA_ADDRESS_A5) AND decoder_Posicao_OUT(2) AND  decoder_Habilita_OUT(5)),
					saida => MEM_OUT
					  
end architecture;