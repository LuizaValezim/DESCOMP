library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder_Opcode is
	port (
		opcode : in std_logic_vector(5 downto 0);
		output_op : out std_logic_vector(2 downto 0)
	);
end entity;

architecture arch_name of Decoder_Opcode is
	constant lw : std_logic_vector(5 downto 0) := "100011";
	constant sw : std_logic_vector(5 downto 0) := "101011";
	constant beq : std_logic_vector(5 downto 0) := "000100";
	constant j : std_logic_vector(5 downto 0) := "000010";
	constant jal : std_logic_vector(5 downto 0) := "000011";

	constant ori : std_logic_vector(5 downto 0) := "001101";
	constant addi : std_logic_vector(5 downto 0) := "001000";
	constant andi : std_logic_vector(5 downto 0) := "001100";
	constant slti : std_logic_vector(5 downto 0) := "001010";
	constant lui : std_logic_vector(5 downto 0) := "001111";
	constant bne : std_logic_vector(5 downto 0) := "000101";

begin

	output_op <= "010" when (opcode = sw or opcode = lw) else
		"110" when (opcode = beq) else
		"110" when (opcode = bne) else
		"000" when (opcode = j) else
		"000" when (opcode = jal) else
		"010" when (opcode = addi) else
		"000" when (opcode = andi) else
		"001" when (opcode = ori) else
		"111" when (opcode = slti) else
		"010";
		
end architecture;