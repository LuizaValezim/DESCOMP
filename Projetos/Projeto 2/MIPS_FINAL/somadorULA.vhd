library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somadorULA is

  port (  
		carryIN  : in 	std_logic;
		entradaA : in 	std_logic;
		entradaB : in 	std_logic;
		soma	 	: out std_logic;
		carryOUT : out std_logic
  );
  
end entity;

architecture arquitetura of somadorULA is

begin

	soma <= carryIN xor (entradaA xor entradaB);
	carryOUT <= (entradaA and entradaB) or (carryIN and (entradaA xor entradaB));

end architecture;