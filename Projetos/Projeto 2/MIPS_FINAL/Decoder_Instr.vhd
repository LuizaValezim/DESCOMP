library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder_Instr is

  port ( 
		opcode 	: in std_logic_vector(5 DOWNTO 0);
		tipoR	 	: out std_logic;
		saida		: out std_logic_vector(11 DOWNTO 0)
  ); 
  
end entity;

architecture arquitetura of Decoder_Instr is

	constant INST_AND : std_logic_vector(5 downto 0) := "000000";
	constant INST_OR  : std_logic_vector(5 downto 0) := "000000";
	constant ADD 		: std_logic_vector(5 downto 0) := "000000";
	constant SUB 		: std_logic_vector(5 downto 0) := "000000";
	constant SLT 		: std_logic_vector(5 downto 0) := "000000";
	constant SIG_SLL 	: std_logic_vector(5 downto 0) := "000000";
	constant SIG_SRL 	: std_logic_vector(5 downto 0) := "000000";
	constant LW 		: std_logic_vector(5 downto 0) := "100011";
	constant SW 		: std_logic_vector(5 downto 0) := "101011";
	constant BEQ 		: std_logic_vector(5 downto 0) := "000100";
	constant JMP 		: std_logic_vector(5 downto 0) := "000010";
	constant JR 		: std_logic_vector(5 downto 0) := "000000";
	constant JAL 		: std_logic_vector(5 downto 0) := "000011";
	constant BNE 		: std_logic_vector(5 downto 0) := "000101";
	constant SLTI 		: std_logic_vector(5 downto 0) := "001010";
	constant ORI 		: std_logic_vector(5 downto 0) := "001101";
	constant ANDI 		: std_logic_vector(5 downto 0) := "001100";
	constant ADDI 		: std_logic_vector(5 downto 0) := "001000";
	constant LUI 		: std_logic_vector(5 downto 0) := "001111";
	
	alias MUX_PC_BEQ 	: std_logic is saida(11);
	alias MUX_RT_RD 	: std_logic_vector(1 DOWNTO 0) is saida(10 DOWNTO 9);
	alias ORIANDI 		: std_logic is saida(8);
	alias HAB_REG	  	: std_logic is saida(7);
	alias MUX_RT_IM  	: std_logic is saida(6);
	alias MUX_ULA_MEM	: std_logic_vector(1 DOWNTO 0) is saida(5 DOWNTO 4);
	alias BEQ_CTRL		: std_logic is saida(3);
	alias BNE_CTRL 	: std_logic is saida(2);
	alias RD_MEM		: std_logic is saida(1);
	alias WR_MEM		: std_logic is saida(0);

begin
	
	MUX_PC_BEQ 	<= '1' when (opcode = JMP OR opcode = JAL) else '0';
	
	MUX_RT_RD 	<= "01" when (opcode = INST_AND OR opcode = INST_OR OR opcode = ADD OR opcode = SUB OR opcode = SLT OR opcode = SIG_SLL OR opcode = SIG_SRL) else
						"10" when (opcode = JAL) else
						"00";
	
	ORIANDI		<= '1' when (opcode = ORI) else '0';
	HAB_REG 		<= '1' when (opcode = INST_AND OR opcode = INST_OR OR opcode = ADD OR opcode = SUB OR opcode = SLT 
										OR opcode = LW OR opcode = JAL OR opcode = SLTI OR opcode = ORI OR opcode = ANDI 
										OR opcode = ADDI OR opcode = LUI OR opcode = SIG_SLL OR opcode = SIG_SRL) else '0';
	MUX_RT_IM 	<= '1' when (opcode = LW OR opcode = SW OR opcode = SLTI OR opcode = ORI 
										OR opcode = ANDI OR opcode = ADDI) else '0';
	
	MUX_ULA_MEM <= "11" when (opcode = LUI) else
						"01" when (opcode = LW) else
						"10" when (opcode = JAL) else
						"00";
	
	BEQ_CTRL 	<= '1' when (opcode = BEQ) else '0';
	BNE_CTRL		<= '1' when (opcode = BNE) else '0';
	RD_MEM 		<= '1' when (opcode = LW) else '0';
	WR_MEM 		<= '1' when (opcode = SW) else '0';
	
	tipoR 		<= '1' when (opcode = INST_AND OR opcode = INST_OR OR opcode = ADD OR opcode = SUB 
										OR opcode = SLT OR opcode = JR OR opcode = SIG_SLL OR opcode = SIG_SRL) else '0';

end architecture;
