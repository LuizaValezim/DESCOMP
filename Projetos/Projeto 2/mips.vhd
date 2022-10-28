library ieee;
use ieee.std_logic_1164.all;

entity mips is

	generic ( larguraDados : natural := 8;
          larguraEnderecos : natural := 9;
			 simulacao : boolean := FALSE -- para gravar na placa, altere de TRUE para FALSE
  );
  port   (
    CLK : in std_logic;
	 instruction: in std_logic_vector(14 downto 0)
	 ROM_Address: out std_logic_vector(larguraEnderecos-1 downto 0);
	 DATA_OUT: out std_logic_vector(larguraDados-1 downto 0);
	 DATA_ADDRESS: out std_logic_vector(8 downto 0);
	 Palavra : out std_logic_vector(11 downto 0);
	 enderecoRG : out std_logic_vector (1 downto 0);
	 MEM_Read: out std_logic;
	 MEM_Write: out std_logic
  );
  
end entity;

architecture arquitetura of mips is

	-- Sinais gerais e sinais do PC: 
  signal proxPC : std_logic_vector (larguraDados downto 0);
  signal saidaSomador : std_logic_vector (larguraDados downto 0);
  signal Endereco : std_logic_vector (larguraDados downto 0);
  signal instruction_ROM: std_logic_vector(14 downto 0);  
  
  signal instrucao: std_logic_vector(31 downto 0);
  
  -- MUX 
  alias MUX_A: std_logic_vector(larguraDados - 1 downto 0) is DATA_IN; -- MUX0
  alias MUX_B: std_logic_vector(larguraDados - 1 downto 0) is instruction(larguraDados - 1 downto 0); -- MUX1
  alias MUX_PC_0 : std_logic_vector(larguraDados downto 0) is saidaSomador;
  alias MUX_PC_1 : std_logic_vector(larguraDados downto 0) is instruction(8 downto 0);
  alias MUX_PC_2 : std_logic_vector(larguraDados downto 0) is saidaRET;
  alias MUX_PC_3 : std_logic_vector(larguraDados downto 0) is instruction(8 downto 0);
  
  alias enderecoReg : std_logic_vector(1 downto 0) is instruction(10 downto 9);
  alias OP_CODE: std_logic_vector(3 downto 0) is instruction(14 downto 11); 
  
  -- ULA
  alias ULA_A: std_logic_vector(larguraDados - 1 downto 0) is MUX_OUT;
  alias Habilita_A: std_logic is decoder_OUT(5); 
 
  
 begin 
	
	-- Program Counter
	PC : entity work.registradorGenerico generic map (larguraDados => larguraEnderecos)
				 port map (
							DIN => proxPC,
							DOUT => Endereco,
							ENABLE => '1',
							CLK => CLK,
							RST => '0');

	incrementaPC :  entity work.somaConstante generic map (larguraDados => larguraEnderecos, constante => 4)
			  port map( 
						entrada => Endereco,
						saida => saidaSomador);
						
	-- MUX
	MUX1 :  entity work.muxGenerico2x1  generic map (larguraDados => larguraDados)
			  port map( 
						  entradaA_MUX => MUX_A,
						  entradaB_MUX =>  MUX_B,
						  seletor_MUX => SelMux,
						  saida_MUX => MUX_OUT);
	
	-- O port map completo da ULA
	ULA1 : entity work.ULASomaSub generic map(larguraDados => larguraDados)
				 port map (
						 entradaA => ULA_A_IN,
						 entradaB => ULA_B_IN,
						 saida => ULA_OUT,
						 seletor => Operacao_ULA,
						 flagEqual => ULA_FLAG);
						
	-- Banco de Registradores				
	BANCO_REGISTRADORES: entity work.bancoReg generic map (larguraDados => larguraDados, larguraEndBancoRegs => 2) 	
				port map ( 
							clk => CLK,
							enderecoA => instrucao(25 downto 21),
							enderecoB => instrucao(20 downto 16),
							enderecoC => saida_mux_rt_rd,
							dadoEscritaC => saida_mux_ula_mem,
							escreveC => hab_escrita_reg,
							saidaA => REG1_ULA_B,
							saidaB => REG_ULA_C
						
	-- ROM	
	ROM1 : entity work.memoriaROM generic map (dataWidth => 15, addrWidth => 9) 
				 port map (
						 Endereco => Endereco,
						 Dado => instruction_ROM);
  
	ROM_Address <= Endereco;	
	DATA_ADDRESS <= instruction(8 downto 0);
	enderecoRG <= enderecoReg;
	
end architecture;