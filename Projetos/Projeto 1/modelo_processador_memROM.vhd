library ieee;
use ieee.std_logic_1164.all;

entity modelo_processador_memROM is
	port(
		CLK: in std_logic;
		DATA_OUT: in std_logic_vector(3 downto 0);
		Data_Address_A5 : in std_logic;
		Decoder_Posicao: in std_logic;
		habilita : in std_logic;
		escrita : in std_logic
	);
	
	
end entity;

architecture arch_name of modelo_processador_memROM is

begin
	
	processador : entity work.processador 
				 port map (
					 CLK => CLK,   -- in
					 instruction => instruction_ROM,
					 DATA_IN => MEM_OUT,
					 ROM_Address => PC_OUT_processador,
					 DATA_OUT => Reg_A,
					 DATA_ADDRESS => MEM_ADD,
					 Palavra => Palavra_processador,
					 MEM_Read => MEM_Read,
					 MEM_Write => MEM_Write
				); 
				
	ROM : entity work.memoriaROM generic map (dataWidth => 13, addrWidth =>9) 
				 port map (
						 Endereco => Endereco,
						 Dado => instruction_ROM);
					  
					  
end architecture;