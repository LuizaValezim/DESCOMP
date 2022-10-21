library ieee;
use ieee.std_logic_1164.all;

entity modelo_desvio is
	port (
		JMP: in std_logic;
		RET: in std_logic;
		JSR: in std_logic;
		JEQ : in std_logic;
		FLAG_EQ : in std_logic;
		SelMuxPC: out std_logic_vector (1 downto 0)
	);
end entity;

architecture arch_name of modelo_desvio is
	signal inputs: std_logic_vector(4 downto 0);
	
begin
	inputs(4) <= JMP;
	inputs(3) <= RET;
	inputs(2) <= JSR;
	inputs(1) <= JEQ;
	inputs(0) <= FLAG_EQ;
	
	SelMuxPC <= "00" when (inputs = "00000" or inputs = "00001") else
					"01" when (inputs = "10000" or inputs = "10001") else
					"00" when (inputs = "00010") else
					"01" when (inputs = "00011") else
					"01" when (inputs = "00100" or inputs = "00101") else
					"10" when (inputs = "01000" or inputs = "01001") else
					"00";
end architecture;
					