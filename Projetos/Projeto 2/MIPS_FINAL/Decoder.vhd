library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder is

  port ( 
		opcode 	: in std_logic_vector(5 DOWNTO 0);
		funct	 	: in std_logic_vector(5 DOWNTO 0);
		ula_ctrl : out std_logic_vector(3 DOWNTO 0);
		palavra	: out std_logic_vector(15 DOWNTO 0)
  );
  
end entity;

architecture arquitetura of Decoder is

	signal instruction_R		 	: std_logic;
	signal jr    					: std_logic;
	signal sll_signal          : std_logic;
	signal srl_signal          : std_logic;
	signal ULA_function  		: std_logic_vector(3 DOWNTO 0);
	signal ULA_opcode 		   : std_logic_vector(3 DOWNTO 0);
	signal MUX_ULA_out 	      : std_logic_vector(3 DOWNTO 0);
	signal decoder_out		   : std_logic_vector(11 DOWNTO 0);
	
begin

		ULA_function(3) <= '0';
		ULA_function(2) <= '1' when (funct = 6x"22" OR funct = 6x"2A") else '0';
		ULA_function(1) <= '1' when (funct = 6x"20" OR funct = 6x"22" OR funct = 6x"2A") else '0';
		ULA_function(0) <= '1' when (funct = 6x"25" OR funct = 6x"2A" OR funct = 6x"27") else '0';
		ULA_opcode(3) <= '0';
		
		ULA_opcode(2) <= '1' when (opcode = 6x"04" OR opcode = 6x"0A" OR opcode = 6x"05") else '0';
		ULA_opcode(1) <= '1' when (opcode = 6x"04" OR opcode = 6x"2B" OR opcode = 6x"23" OR opcode = 6x"0A" OR opcode = 6x"08" OR opcode = 6x"05") else '0';
		ULA_opcode(0) <= '1' when (opcode = 6x"0A" OR opcode = 6x"0D") else '0';

		
		MUX_ULA_CTRL : entity work.muxGenerico2x1 generic map(larguraDados => 4)
			port map(
				entradaA_MUX => ULA_opcode,
				entradaB_MUX => ULA_function,
				seletor_MUX =>  instruction_R,
				saida_MUX => MUX_ULA_out
			);
			
		CONTROL_UNIT : entity work.Decoder_Instr 
			port map(
				opcode 	=> opcode,
				tipoR	 	=> instruction_R,
				saida		=> decoder_out
			);
			
		jr <= '1' when (funct = 6x"08" AND instruction_R = '1') else '0';
		sll_signal <= '1' when (funct = 6x"00" AND instruction_R = '1') else '0';
		srl_signal <= '1' when (funct = 6x"02" AND instruction_R = '1') else '0';

		ula_ctrl <= MUX_ULA_out;
			
		palavra <= sll_signal & srl_signal & '0' & jr & decoder_out;
		
end architecture;
