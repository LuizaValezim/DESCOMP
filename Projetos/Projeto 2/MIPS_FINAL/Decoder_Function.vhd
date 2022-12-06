library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder_Function is
	port (
		funct : in std_logic_vector(5 downto 0);
		output_fun : out std_logic_vector(2 downto 0)
	);
end entity;


architecture arch_name of Decoder_Function is
	constant addr : std_logic_vector(5 downto 0) := "100000";
	constant subr : std_logic_vector(5 downto 0) := "100010";
	constant slt : std_logic_vector(5 downto 0) := "101010";
	constant andr : std_logic_vector(5 downto 0) := "100100";
	constant orr : std_logic_vector(5 downto 0) := "100101";
	constant jr : std_logic_vector(5 downto 0) := "001000";

begin

	output_fun <= "010" when (funct = addr) else
		"110" when (funct = subr) else
		"000" when (funct = andr) else
		"001" when (funct = orr) else
		"111" when (funct = slt) else
		"000" when (funct = jr) else
		"010";

end architecture;