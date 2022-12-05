library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DecoderFunct is
	port (
		FUNCT : in std_logic_vector(5 downto 0);
		outPUT_FUN : out std_logic_vector(2 downto 0)
	);
end entity;


architecture arch_name OF DecoderFunct is
	constant ADDR : std_logic_vector(5 downto 0) := "100000";
	constant SUBR : std_logic_vector(5 downto 0) := "100010";
	constant SLT : std_logic_vector(5 downto 0) := "101010";
	constant ANDR : std_logic_vector(5 downto 0) := "100100";
	constant ORR : std_logic_vector(5 downto 0) := "100101";

begin

	outPUT_FUN <= "010" when (FUNCT = ADDR) else
		"110" when (FUNCT = SUBR) else
		"000" when (FUNCT = ANDR) else
		"001" when (FUNCT = ORR) else
		"111" when (FUNCT = SLT) else
		"010";

end architecture;