library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder is
	port (
		opcode : in std_logic_vector(5 downto 0);
		funct : in std_logic_vector(5 downto 0);
		output : out std_logic_vector(13 downto 0)
	);
end entity;

architecture arch_name of Decoder is
	constant addr : std_logic_vector(5 downto 0) := "100000";
	constant subr : std_logic_vector(5 downto 0) := "100010";
	constant orr : std_logic_vector(5 downto 0) := "100101";
	
	constant lw : std_logic_vector(5 downto 0) := "100011";
	constant sw : std_logic_vector(5 downto 0) := "101011";
	constant beq : std_logic_vector(5 downto 0) := "000100";
	constant j : std_logic_vector(5 downto 0) := "000010";
	constant slt : std_logic_vector(5 downto 0) := "101010";
	
	constant addi : std_logic_vector(5 downto 0) := "001000";
	constant andi : std_logic_vector(5 downto 0) := "001100";
	constant slti : std_logic_vector(5 downto 0) := "001010";
	constant ori : std_logic_vector(5 downto 0) := "001101";
	
	constant jal : std_logic_vector(5 downto 0) := "000011";
	constant jr : std_logic_vector(5 downto 0) := "001000";
	constant lui : std_logic_vector(5 downto 0) := "001111";
	constant bne : std_logic_vector(5 downto 0) := "000101";

begin

	output <= "0" & "000011" & "0" & "01" & "0010" when (opcode = lw) else
			  "0" & "000001" & "0" & "00" & "0001" when (opcode = sw) else
			  "0" & "000000" & "0" & "00" & "1000" when (opcode = beq) else
			  "0" & "000000" & "0" & "00" & "0100" when (opcode = bne) else
			  "0" & "001010" & "1" & "00" & "0000" when (((funct = addr) or (funct = subr) or (funct = orr) or (funct = andr) or (funct = slt)) and opcode = "000000") else 
			  "0" & "000011" & "0" & "00" & "0000" when ((opcode = addi) or (opcode = slti)) else
			  "0" & "000111" & "0" & "00" & "0000" when ((opcode = ori) or (opcode = andi)) else
			  "0" & "100000" & "0" & "00" & "0000" when (opcode = j) else
			  "0" & "000010" & "0" & "11" & "0000" when (opcode = lui) else
			  "0" & "110010" & "0" & "10" & "0000" when (opcode = jal) else
			  "1" & "000000" & "1" & "00" & "0000" when (funct = jr) else
			  "00000000000000";
end architecture;