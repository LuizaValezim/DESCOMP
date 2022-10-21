library ieee;
use ieee.std_logic_1164.all;

entity processador is
  -- Total de bits das entradas e saidas
  generic ( larguraDados : natural := 8;
          larguraEnderecos : natural := 8;
        simulacao : boolean := TRUE -- para gravar na placa, altere de TRUE para FALSE
  );
  port   (
    CLK : in std_logic;
	 instruction: in std_logic_vector(12 downto 0);
	 DATA_IN: in std_logic_vector(larguraDados - 1 downto 0);
	 ----------------------------------------------------------
    ROM_Address: out std_logic_vector(larguraEnderecos downto 0);
	 DATA_OUT: out std_logic_vector(larguraDados-1 downto 0);
	 DATA_ADDRESS: out std_logic_vector(8 downto 0);
	 Palavra : out std_logic_vector(12 downto 0);
	 EQUAL_FLAG: out std_logic;
	 MEM_Read: out std_logic;
	 MEM_Write: out std_logic
  );
end entity;


architecture arquitetura of processador is

-- Sinais gerais e sinais do PC: 
  signal proxPC : std_logic_vector (larguraDados downto 0);
  signal saidaSomador : std_logic_vector (larguraDados downto 0);
  signal Endereco : std_logic_vector (larguraDados downto 0);

-- Sinais do decodificador de instruções para debug
  signal ULA_FLAG : std_logic;
  signal FLAG_EQ : std_logic;
  signal SelMux2: std_logic_vector (1 downto 0);

-- Sinais de saída do MUX, ALU, Memória, Registrador e Decoder 
  signal MUX_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal REGA_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal ULA_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal decoder_OUT : std_logic_vector(12 downto 0); -- sinais de controle e ler/escrever
  signal saidaRET : std_logic_vector(larguraDados downto 0);

-- Aliases para facilitar a leitura do código: MUX 
  alias MUX_A: std_logic_vector(larguraDados - 1 downto 0) is DATA_IN; -- MUX0
  alias MUX_B: std_logic_vector(larguraDados - 1 downto 0) is instruction(larguraDados - 1 downto 0); -- MUX1
  alias MUX_PC_0 : std_logic_vector(larguraDados downto 0) is saidaSomador;
  alias MUX_PC_1 : std_logic_vector(larguraDados downto 0) is instruction(8 downto 0);
  alias MUX_PC_2 : std_logic_vector(larguraDados downto 0) is saidaRET;
  alias MUX_PC_3 : std_logic_vector(larguraDados downto 0) is instruction(8 downto 0);

  
  -- Aliases para os sinais de controle: DECODER_OUT
  alias habFlag: std_logic is decoder_OUT(2);
  alias Operacao_ULA: std_logic_vector(2 downto 0) is decoder_OUT(5 downto 3);
  alias Habilita_A: std_logic is decoder_OUT(6);  
  alias SelMux: std_logic is decoder_OUT(7);
  alias jeq : std_logic is decoder_OUT(8);
  alias jsr : std_logic is decoder_OUT(9);
  alias ret : std_logic is decoder_OUT(10);
  alias jmp: std_logic is decoder_OUT(11);
  alias habEscritaRet: std_logic is decoder_OUT(12);

  
-- Aliases para facilitar a leitura do código: REGA
  alias REGA_IN: std_logic_vector(larguraDados - 1 downto 0) is ULA_OUT;
  
-- Aliases para facilitar a leitura do código: ULA
  alias ULA_A_IN: std_logic_vector(larguraDados - 1 downto 0) is REGA_OUT;
  alias ULA_B_IN: std_logic_vector(larguraDados - 1 downto 0) is MUX_OUT;

-- Aliases para facilitar a leitura do código: Memória

  alias OP_CODE: std_logic_vector(3 downto 0) is instruction(12 downto 9); 

begin


	
	-- O port map completo do Program Counter.
	PC : entity work.registradorGenerico generic map (larguraDados => larguraEnderecos+1)
				 port map (
							DIN => proxPC,
							DOUT => Endereco,
							ENABLE => '1',
							CLK => CLK,
							RST => '0');

	incrementaPC :  entity work.somaConstante generic map (larguraDados => larguraEnderecos+1, constante => 1)
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
						
	MUX2 :  entity work.muxGenerico4x1  generic map (larguraDados => larguraDados+1)
	  port map( 
				  E0 => MUX_PC_0,
				  E1 => MUX_PC_1,
				  E2 => MUX_PC_2,
				  E3 => b"0_0000_0000",
				  SEL_MUX => SelMux2,
				  MUX_OUT => proxPC);
				  

	-- O port map completo do MUX.
	MUX1 :  entity work.muxGenerico2x1  generic map (larguraDados => larguraDados)
			  port map( 
						  entradaA_MUX => MUX_A,
						  entradaB_MUX =>  MUX_B,
						  seletor_MUX => SelMux,
						  saida_MUX => MUX_OUT);
						  
	-- O port map completo da ULA:
	ULA1 : entity work.ULASomaSub generic map(larguraDados => larguraDados)
				 port map (
						 entradaA => ULA_A_IN,
						 entradaB => ULA_B_IN,
						 saida => ULA_OUT,
						 seletor => Operacao_ULA,
						 flagEqual => ULA_FLAG);	 
						 
	-- O port map completo do Acumulador.
	REGA : entity work.registradorGenerico generic map (larguraDados => larguraDados)
				 port map (
						 DIN => REGA_IN,
						 DOUT => REGA_OUT,
						 ENABLE => Habilita_A,
						 CLK => CLK,
						 RST => '0');
						 
						 
	-- port map do flip flop da flag de comparacao
	FLAG:
		entity work.flipflopGenerico
		port map (
			DIN		=> ULA_FLAG, 
			DOUT		=> FLAG_EQ,
			ENABLE 	=> habFlag,
			CLK 		=> CLK,
			RST 		=> '0'
		);


	LOG_DESVIO: entity work.logica_desvio
						port map(
							JMP => jmp,
							RET => ret,
							JSR => jsr,
							JEQ => jeq,							
							FLAG_EQ => FLAG_EQ,
							SelMuxPC => SelMux2
						);		


	decoderInstru1 : entity work.decoderInstru
			  port map( 
					  opcode => OP_CODE,
					  saida => decoder_OUT);		
					  


	ROM_Address <= Endereco;
	DATA_OUT <= REGA_OUT;
	EQUAL_FLAG <= FLAG_EQ;	
	Palavra <= decoder_OUT;
	MEM_Write <= decoder_OUT(0);
   MEM_Read <= decoder_OUT(1);
	DATA_ADDRESS <= instruction(8 downto 0);
	
end architecture;