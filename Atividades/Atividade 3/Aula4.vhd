library ieee;
use ieee.std_logic_1164.all;

entity Aula4 is
  -- Total de bits das entradas e saidas
  generic ( larguraDados : natural := 8;
          larguraEnderecos : natural := 8;
        simulacao : boolean := FALSE -- para gravar na placa, altere de TRUE para FALSE
  );
  port   (
    CLOCK_50 : in std_logic;
    KEY: in std_logic_vector(3 downto 0);
    PC_OUT: out std_logic_vector(larguraEnderecos - 1 downto 0);
    LEDR  : out std_logic_vector(9 downto 0);
	 REG_OUT: out std_logic_vector(larguraDados-1 downto 0)
	 
  );
end entity;


architecture arquitetura of Aula4 is

-- Sinais gerais e sinais do PC: 
  signal CLK : std_logic;
  signal proxPC : std_logic_vector (larguraDados downto 0);
  signal Endereco : std_logic_vector (larguraDados downto 0);
  
  signal instruction: std_logic_vector(12 downto 0);
-- opcode(12 downto 9) endereco(8 downto 0) valor(7 downto 0)

-- Sinais de saída do MUX, ALU, Memória, Registrador e Decoder 
  signal MUX_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal REGA_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal ULA_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal MEM_OUT: std_logic_vector(larguraDados - 1 downto 0);
  signal decoder_OUT : std_logic_vector(5 downto 0); -- sinais de controle e ler/escrever
  
-- Aliases para facilitar a leitura do código: MUX
  alias MUX_A: std_logic_vector(larguraDados - 1 downto 0) is MEM_OUT; -- MUX0
  alias MUX_B: std_logic_vector(larguraDados - 1 downto 0) is instruction(larguraDados - 1 downto 0); -- MUX1
  alias SelMux: std_logic is decoder_OUT(5);
  
  
-- Aliases para facilitar a leitura do código: REGA
  alias REGA_IN: std_logic_vector(larguraDados - 1 downto 0) is ULA_OUT;
  alias Habilita_A: std_logic is decoder_OUT(4);
  
-- Aliases para facilitar a leitura do código: ULA

  alias ULA_A_IN: std_logic_vector(larguraDados - 1 downto 0) is REGA_OUT;
  alias ULA_B_IN: std_logic_vector(larguraDados - 1 downto 0) is MUX_OUT;
  alias Operacao_ULA: std_logic_vector(1 downto 0) is decoder_OUT(3 downto 2);

-- Aliases para facilitar a leitura do código: Memória

  alias MEM_ADD: std_logic_vector(larguraDados - 1 downto 0) is instruction(larguraDados - 1 downto 0);
  alias MEM_Habilita: std_logic is instruction(8); 
  alias MEM_IN: std_logic_vector(larguraDados - 1 downto 0) is REGA_OUT;
  alias MEM_Read: std_logic is decoder_OUT(1);
  alias MEM_Write: std_logic is decoder_OUT(0);
  
  alias OP_CODE: std_logic_vector(3 downto 0) is instruction(12 downto 9); 

  
begin


	-- Instanciando os componentes:

	-- Para simular, fica mais simples tirar o edgeDetector
	gravar:  if simulacao generate
	CLK <= KEY(0);
	else generate
	detectorSub0: work.edgeDetector(bordaSubida)
			  port map (
						clk => CLOCK_50,
						entrada => (not KEY(0)),
						saida => CLK);
	end generate;
	
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
						saida => proxPC);

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
						 seletor => Operacao_ULA);	 

	-- O port map completo do Acumulador.
	REGA : entity work.registradorGenerico generic map (larguraDados => larguraDados)
				 port map (
						 DIN => REGA_IN,
						 DOUT => REGA_OUT,
						 ENABLE => Habilita_A,
						 CLK => CLK,
						 RST => '0');

				 
	-- Falta acertar o conteudo da ROM (no arquivo memoriaROM.vhd)
	ROM1 : entity work.memoriaROM generic map (dataWidth => 13, addrWidth =>4) -- POR QUE 4?
				 port map (
						 Endereco => Endereco,
						 Dado => instruction);

	decoderInstru1 : entity work.decoderInstru
			  port map( 
					  opcode => OP_CODE,
					  saida => decoder_OUT);		
						  
	RAM1 : entity work.memoriaRAM generic map (dataWidth => larguraDados, addrWidth => larguraEnderecos)
				 port map (
						 addr => MEM_ADD,
						 we => MEM_Write,
						 re => MEM_Read,
						 habilita => MEM_Habilita,
						 dado_in => MEM_IN,
						 dado_out => MEM_OUT,
						 clk => CLK);				

	PC_OUT <= Endereco (7 downto 0);
	REG_OUT <= REGA_OUT;
	LEDR(larguraDados - 1 downto 0) <= REGA_OUT;
	LEDR(9 downto 8) <= "00";
	
end architecture;