library ieee;
use ieee.std_logic_1164.all;

entity modelo_key is
	port(
		CLK: in std_logic;
		Data_Address_A5 : in std_logic;
		Decoder_Posicao: in std_logic
	);
	
	
end entity;

architecture arch_name of modelo_key is

	signal MEM_Read : std_logic;
	signal DEBOUNCER_OUT : std_logic;


begin

	KEY_0: entity work.buffer_3_state_8portas generic map(dataWidth => 8)
			port map(
					entrada => "0000000" & DEBOUNCER_OUT,
					habilita => (MEM_Read AND Data_Address_A5 AND decoder_Posicao_OUT(0) AND  decoder_Habilita_OUT(5)),
					saida => MEM_OUT
			);
			

	KEY_1: entity work.buffer_3_state_8portas generic map(dataWidth => 8)
			port map(
					entrada => "0000000" & KEY(1),
					habilita => (MEM_Read AND Data_Address_A5 AND decoder_Posicao_OUT(1) AND  decoder_Habilita_OUT(5)),
					saida => MEM_OUT
			);


	KEY_2: entity work.buffer_3_state_8portas generic map(dataWidth => 8)
			port map(
					entrada => "0000000" & KEY(2),
					habilita => (MEM_Read AND Data_Address_A5 AND decoder_Posicao_OUT(2) AND  decoder_Habilita_OUT(5)),
					saida => MEM_OUT
			);


	KEY_3: entity work.buffer_3_state_8portas generic map(dataWidth => 8)
			port map(
					entrada => "0000000" & KEY(3),
					habilita => (MEM_Read AND Data_Address_A5 AND decoder_Posicao_OUT(3) AND  decoder_Habilita_OUT(5)),
					saida => MEM_OUT
			);	
					  
					  
end architecture;