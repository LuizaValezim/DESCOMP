library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
	port (
		opcode : in std_logic_vector(5 downto 0);
		funct : in std_logic_vector(5 downto 0);
		tipo_r : in std_logic;
		inverteb : out std_logic;
		output : out std_logic_vector(1 downto 0)
	);
end entity;

architecture arch_name of ULA is
	constant addr : std_logic_vector(5 downto 0) := "100000";
	constant subr : std_logic_vector(5 downto 0) := "100010";
	constant lw : std_logic_vector(5 downto 0) := "100011";
	constant sw : std_logic_vector(5 downto 0) := "101011";
	constant beq : std_logic_vector(5 downto 0) := "000100";
	constant j : std_logic_vector(5 downto 0) := "000010";
	constant slt : std_logic_vector(5 downto 0) := "101010";
	constant andr : std_logic_vector(5 downto 0) := "100100";
	constant orr : std_logic_vector(5 downto 0) := "100101";
	-- selmuxjump|selmuxrtrd|write_reg(1)|habmux(rt/imediato)|op(2)|selmuxmemula|habflagequal|
	--read_ram|write_ram
begin

	output <= "10" when (tipo_r = '1' and funct = addr ) else
		"10" when (tipo_r = '0' and (opcode = sw or opcode = lw)) else
		"10" when (tipo_r = '1' and (funct = subr)) else
		"10" when (tipo_r = '0' and (opcode = beq)) else
		"00" when (tipo_r = '1' and (funct = andr)) else
		"01" when (tipo_r = '1' and (funct = orr)) else
		"11" when (tipo_r = '1' and (funct = slt)) else
		"10";
		
	inverteb <= '1' when ((tipo_r = '1' and (funct = subr or funct = slt)) or (tipo_r = '0' and opcode = beq )) else
		'0';

end architecture;