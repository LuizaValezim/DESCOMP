library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DecoderOpcode is
	port (
		OPCODE : in std_logic_vector(5 downto 0);
		outPUT_OP : out std_logic_vector(2 downto 0)
	);
end entity;

architecture arch_name OF DecoderOpcode is

	constant LW : std_logic_vector(5 downto 0) := "100011";
	constant SW : std_logic_vector(5 downto 0) := "101011";
	constant BEQ : std_logic_vector(5 downto 0) := "000100";
	constant J : std_logic_vector(5 downto 0) := "000010";
	
begin

	outPUT_OP <= "010" when (OPCODE = SW OR OPCODE = LW) else
		"110" when (OPCODE = BEQ) else
		"000" when (OPCODE = J) else
		"010";
		
end architecture;