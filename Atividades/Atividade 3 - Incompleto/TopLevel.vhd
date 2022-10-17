library ieee;
use ieee.std_logic_1164.all;

entity TopLevel is
  -- Total de bits das entradas e saidas
  generic ( larguraDados : natural := 8;
        larguraEnderecos : natural := 8;
        simulacao : boolean := TRUE -- para gravar na placa, altere de TRUE para FALSE
  );
  port   (
    CLOCK_50 : in std_logic;
    KEY: in std_logic_vector(3 downto 0);
    SW: in std_logic_vector(9 downto 0);
   PC_OUT: out std_logic_vector(larguraEnderecos-1 downto 0);
    LEDR  : out std_logic_vector(9 downto 0)
  );
end entity;


architecture arquitetura of TopLevel is

-- Faltam alguns sinais:
  signal chavesX_ULA_B : std_logic_vector (larguraDados-1 downto 0);
  signal chavesY_MUX_A : std_logic_vector (larguraDados-1 downto 0);
  signal MUX_REG1 : std_logic_vector (larguraDados-1 downto 0);
  signal REG1_ULA_A : std_logic_vector (larguraDados-1 downto 0);
  signal Saida_ULA : std_logic_vector (larguraDados-1 downto 0);
  signal Sinais_Controle : std_logic_vector (12 downto 0);
  signal Endereco : std_logic_vector (larguraDados downto 0);
  signal proxPC : std_logic_vector (larguraDados downto 0);
  signal Chave_Operacao_ULA : std_logic;
  signal CLK : std_logic;
  signal SelMUX : std_logic;
  signal Habilita_A : std_logic;
  signal Reset_A : std_logic;
  signal Operacao_ULA : std_logic_vector(1 downto 0);
  signal Saida_Decoder : std_logic_vector(5 downto 0);
  signal Saida_RAM : std_logic_vector(larguraDados-1 downto 0);
  

begin

-- Instanciando os componentes:

-- Para simular, fica mais simples tirar o edgeDetector
gravar:  if simulacao generate
CLK <= KEY(0);
else generate
detectorSub0: work.edgeDetector(bordaSubida)
        port map (clk => CLOCK_50, entrada => (not KEY(0)), saida => CLK);
end generate;

-- O port map completo do MUX.
MUX1 :  entity work.muxGenerico2x1  generic map (larguraDados => larguraDados)
        port map( entradaA_MUX => Saida_RAM,
                 entradaB_MUX =>  Saida_ULA,
                 seletor_MUX => SelMUX,
                 saida_MUX => MUX_REG1);
DEC : entity work.decoderInstru port map 
		(opcode => Sinais_Controle(12 downto 9), saida => Saida_Decoder);

-- O port map completo do Acumulador.
REGA : entity work.registradorGenerico   generic map (larguraDados => larguraDados)
          port map (DIN => MUX_REG1, 
			 DOUT => REG1_ULA_A, 
			 ENABLE => Habilita_A, 
			 CLK => CLK, 
			 RST => Reset_A);

-- O port map completo do Program Counter.
PC : entity work.registradorGenerico   generic map (larguraDados => larguraEnderecos-1)
          port map (DIN => proxPC, 
			 DOUT => Endereco, 
			 ENABLE => '1', 
			 CLK => CLK, 
			 RST => '0');

incrementaPC :  entity work.somaConstante  generic map (larguraDados => larguraEnderecos-1, constante => 1)
        port map( entrada => Endereco, 
		  saida => proxPC);

-- O port map completo da ULA:
ULA1 : entity work.ULASomaSub  generic map(larguraDados => larguraDados)
          port map (entradaA => REG1_ULA_A, 
			 entradaB => chavesX_ULA_B, 
			 saida => Saida_ULA, 
			 seletor => Operacao_ULA);

RAM1 : entity work.memoriaRAM   generic map (dataWidth => larguraDados, addrWidth => larguraEnderecos)
          port map (addr => Sinais_Controle(7 downto 0), 
			 we => Saida_Decoder(0), 
			 re => Saida_Decoder(1),
			 habilita => Sinais_Controle(8), 
			 dado_in => REG1_ULA_A, 
			 dado_out => Saida_RAM, 
			 clk => CLK);

			 -- Falta acertar o conteudo da ROM (no arquivo memoriaROM.vhd)
ROM1 : entity work.memoriaROM   generic map (dataWidth => larguraDados, addrWidth => larguraEnderecos)
          port map (Endereco => Endereco, Dado => Sinais_Controle);

selMUX <= Saida_Decoder(5);
Habilita_A <= Saida_Decoder(4);
Operacao_ULA <= Saida_Decoder(3 downto 2);

-- I/O
chavesY_MUX_A <= SW(3 downto 0);
chavesX_ULA_B <= SW(9 downto 6);

-- A ligacao dos LEDs:
LEDR (9) <= SelMUX;
LEDR (8) <= Habilita_A;
LEDR (7 downto 0) <= REG1_ULA_A;

PC_OUT <= Endereco(7 downto 0);

end architecture;