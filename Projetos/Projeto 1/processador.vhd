library ieee;
use ieee.std_logic_1164.all;

entity processador is
  generic ( larguraDados : natural := 8;
          larguraEnderecos : natural := 9;
			 simulacao : boolean := FALSE 
  );
  port   (
    CLK : in std_logic;
	 instruction: in std_logic_vector(14 downto 0); 
	 DATA_IN: in std_logic_vector(larguraDados - 1 downto 0);
    ROM_Address: out std_logic_vector(larguraEnderecos-1 downto 0);
	 DATA_OUT: out std_logic_vector(larguraDados-1 downto 0);
	 DATA_ADDRESS: out std_logic_vector(8 downto 0);
	 Palavra : out std_logic_vector(13 downto 0);
	 enderecoRG : out std_logic_vector (1 downto 0);
	 MEM_Read: out std_logic;
	 MEM_Write: out std_logic
  );
end entity;


architecture arquitetura of processador is

-- PROGRAM COUNTER: 
  signal proxPC : std_logic_vector (larguraDados downto 0);
  signal saidaSomador : std_logic_vector (larguraDados downto 0);
  signal Endereco : std_logic_vector (larguraDados downto 0);

-- DECODER DE INSTRUÇÕES
  signal ULA_FLAG_EQUAL : std_logic;
  signal ULA_FLAG_LESS_THAN : std_logic;
  signal FLAG_EQ : std_logic;
  signal FLAG_LT : std_logic;
  signal SelMux2: std_logic_vector (1 downto 0);

-- MUX, REG, ULA, etc...
  signal MUX_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal REGA_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal ULA_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal decoder_OUT : std_logic_vector(13 downto 0); -- sinais de controle e ler/escrever
  signal saidaRET : std_logic_vector(larguraDados downto 0);

-- MUX 
  alias MUX_A: std_logic_vector(larguraDados - 1 downto 0) is DATA_IN; -- MUX0
  alias MUX_B: std_logic_vector(larguraDados - 1 downto 0) is instruction(larguraDados - 1 downto 0); -- MUX1
  alias MUX_PC_0 : std_logic_vector(larguraDados downto 0) is saidaSomador;
  alias MUX_PC_1 : std_logic_vector(larguraDados downto 0) is instruction(8 downto 0);
  alias MUX_PC_2 : std_logic_vector(larguraDados downto 0) is saidaRET;
  alias MUX_PC_3 : std_logic_vector(larguraDados downto 0) is instruction(8 downto 0);
  
-- DECODER_OUT
  alias habFlagLt: std_logic is decoder_OUT(2);
  alias habFlagEq: std_logic is decoder_OUT(3);
  alias Operacao_ULA: std_logic_vector(1 downto 0) is decoder_OUT(5 downto 4);
  alias Habilita_A: std_logic is decoder_OUT(6);  
  alias SelMux: std_logic is decoder_OUT(7);
  alias jlt : std_logic is decoder_OUT(8);
  alias jeq : std_logic is decoder_OUT(9);
  alias jsr : std_logic is decoder_OUT(10);
  alias ret : std_logic is decoder_OUT(11);
  alias jmp: std_logic is decoder_OUT(12);
  alias habEscritaRet: std_logic is decoder_OUT(13);
  
  alias enderecoReg : std_logic_vector(1 downto 0) is instruction(10 downto 9);
  alias OP_CODE: std_logic_vector(3 downto 0) is instruction(14 downto 11); 

  alias REGA_IN: std_logic_vector(larguraDados - 1 downto 0) is ULA_OUT;

  alias ULA_A_IN: std_logic_vector(larguraDados - 1 downto 0) is REGA_OUT;
  alias ULA_B_IN: std_logic_vector(larguraDados - 1 downto 0) is MUX_OUT;

begin

	PC : entity work.registradorGenerico generic map (larguraDados => larguraEnderecos)
				 port map (
							DIN => proxPC,
							DOUT => Endereco,
							ENABLE => '1',
							CLK => CLK,
							RST => '0');

	incrementaPC :  entity work.somaConstante generic map (larguraDados => larguraEnderecos, constante => 1)
			  port map( 
						entrada => Endereco,
						saida => saidaSomador);

	REG_RET : entity work.registradorGenerico generic map (larguraDados => larguraDados+1)
				 port map (
						 DIN => saidaSomador,
						 DOUT => saidaRET,
						 ENABLE => habEscritaRet,
						 CLK => CLK,
						 RST => '0');
				  
	MUX1 :  entity work.muxGenerico2x1  generic map (larguraDados => larguraDados)
			  port map( 
						  entradaA_MUX => MUX_A,
						  entradaB_MUX =>  MUX_B,
						  seletor_MUX => SelMux,
						  saida_MUX => MUX_OUT);
						  
	MUX2 :  entity work.muxGenerico4x1  generic map (larguraDados => larguraDados+1)
	  port map( 
				  E0 => MUX_PC_0,
				  E1 => MUX_PC_1,
				  E2 => MUX_PC_2,
				  E3 => b"0_0000_0000",
				  SEL_MUX => SelMux2,
				  MUX_OUT => proxPC);
						  
	ULA1 : entity work.ULASomaSub generic map(larguraDados => larguraDados)
				 port map (
						 entradaA => ULA_A_IN,
						 entradaB => ULA_B_IN,
						 saida => ULA_OUT,
						 seletor => Operacao_ULA,
						 flagEqual => ULA_FLAG_EQUAL,
						 flagLessThan => ULA_FLAG_LESS_THAN);	
						
					
	BANCO_REGISTRADORES: entity work.bancoRegistradores generic map (larguraDados => larguraDados, larguraEndBancoRegs => 2) 	
				port map ( 
							clk => CLK,
							endereco => enderecoReg,
							dadoEscrita => REGA_IN,
							habilitaEscrita => Habilita_A,
							saida  => REGA_OUT);
							
	flagEQ:
		entity work.flipflopGenerico
		port map (
			DIN		=> ULA_FLAG_EQUAL, 
			DOUT		=> FLAG_EQ,
			ENABLE 	=> habFlagEq,
			CLK 		=> CLK,
			RST 		=> '0'
		);
		
		
	flagLT:
		entity work.flipflopGenerico
		port map (
			DIN		=> ULA_FLAG_LESS_THAN, 
			DOUT		=> FLAG_LT,
			ENABLE 	=> habFlagLt,
			CLK 		=> CLK,
			RST 		=> '0'
		);
		

	modelo_desvio: entity work.modelo_desvio
						port map(
							JMP => jmp,
							RET => ret,
							JSR => jsr,
							JEQ => jeq,							
							FLAG_EQ => FLAG_EQ,
							JLT => jlt,
							FLAG_LT => FLAG_LT,
							SelMuxPC => SelMux2
						);		


	decoderInstr : entity work.decoderInstr
			  port map( 
					  opcode => OP_CODE,
					  saida => decoder_OUT);		
					  


	ROM_Address <= Endereco;
	DATA_OUT <= REGA_OUT;
	Palavra <= decoder_OUT;
	MEM_Write <= decoder_OUT(0);
   MEM_Read <= decoder_OUT(1);
	DATA_ADDRESS <= instruction(8 downto 0);
	enderecoRG <= enderecoReg;
	
end architecture;