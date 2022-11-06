library ieee;
use ieee.std_logic_1164.all;

entity modelo_desvio is
	port (
		JMP: in std_logic;
		RET: in std_logic;
		JSR: in std_logic;
		JEQ : in std_logic;
		FLAG_EQ : in std_logic;
		JLT : in std_logic;
		FLAG_LT : in std_logic;
		SelMuxPC: out std_logic_vector (1 downto 0)
	);
end entity;

architecture arch_name of modelo_desvio is
	signal inputs: std_logic_vector(6 downto 0);
	
begin
	inputs(6) <= JMP;
	inputs(5) <= RET;
	inputs(4) <= JSR;
	inputs(3) <= JEQ;
	inputs(2) <= FLAG_EQ;
	inputs(1) <= JLT;
	inputs(0) <= FLAG_LT;
	
	SelMuxPC <= "00" when (inputs = "0000000" or inputs = "0000100" or inputs = "0000001" or inputs = "0000101") else -- QUANDO TODOS JMP's estão ZERADOS
					"01" when (inputs = "1000000" or inputs = "1000100" or inputs = "1000001" or inputs = "1000101") else -- QUANDO O JMP ESTÁ ATIVADO
					"00" when (inputs = "0001000" or inputs = "0001001") else -- QUANDO JEQ ATIVADO MAS FLAG_EQ É 0
					"01" when (inputs = "0001100" or inputs = "0001101") else -- QUANDO JEQ ATIVADO E FLAG_EQ É 1
					"00" when (inputs = "0000010" or inputs = "0000110") else -- QUANDO JLT ATIVADO E FLAG_LT É 0
					"01" when (inputs = "0000011" or inputs = "0000111") else -- QUANDO JLT ATIVADO E FLAG_LT É 1
					"01" when (inputs = "0010000" or inputs = "0010100" or inputs = "0010001" or inputs = "0010101") else -- QUANDO JSR ATIVADO INDEPENDENTE DAS FLAGS
					"10" when (inputs = "0100000" or inputs = "0100100" or inputs = "0100001" or inputs = "0100101") else -- QUANDO RET ATIVADO INDEPENDENTE DAS FLAGS
					"00";
end architecture;
					