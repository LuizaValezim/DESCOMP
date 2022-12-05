library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControleULA is
	port (
		OPCODE : in std_logic_vector(5 downto 0);
		FUNCT : in std_logic_vector(5 downto 0);
		TIPO_R : in STD_LOGIC;
		inverteB : out STD_LOGIC;
		outPUT : out std_logic_vector(1 downto 0)
	);
end entity;

architecture arch_name OF ControleULA is
	constant ADDR : std_logic_vector(5 downto 0) := "100000";
	constant SUBR : std_logic_vector(5 downto 0) := "100010";
	constant LW : std_logic_vector(5 downto 0) := "100011";
	constant SW : std_logic_vector(5 downto 0) := "101011";
	constant BEQ : std_logic_vector(5 downto 0) := "000100";
	constant J : std_logic_vector(5 downto 0) := "000010";
	constant SLT : std_logic_vector(5 downto 0) := "101010";
	constant ANDR : std_logic_vector(5 downto 0) := "100100";
	constant ORR : std_logic_vector(5 downto 0) := "100101";

begin

	outPUT <= "10" when (TIPO_R = '1' AND FUNCT = ADDR ) else
		"10" when (TIPO_R = '0' AND (OPCODE = SW OR OPCODE = LW)) else
		"10" when (TIPO_R = '1' AND (FUNCT = SUBR)) else
		"10" when (TIPO_R = '0' AND (OPCODE = BEQ)) else
		"00" when (TIPO_R = '1' AND (FUNCT = ANDR)) else
		"01" when (TIPO_R = '1' AND (FUNCT = ORR)) else
		"11" when (TIPO_R = '1' AND (FUNCT = SLT)) else
		"10";
		
	inverteB <= '1' when ((TIPO_R = '1' AND (FUNCT = SUBR OR FUNCT = SLT)) OR (TIPO_R = '0' AND OPCODE = BEQ )) else
		'0';

end architecture;