library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopLevel is
  generic (
		simulacao : boolean := TRUE -- para gravar na placa, altere de TRUE para FALSE 
  );
  port (  
		CLOCK_50			 	: in std_logic;
		KEY					: in std_logic_vector(3 DOWNTO 0);
		SW						: in std_logic_vector(9 DOWNTO 0);
		HEX0					: out std_logic_vector(6 DOWNTO 0);
		HEX1					: out std_logic_vector(6 DOWNTO 0);
		HEX2					: out std_logic_vector(6 DOWNTO 0);
		HEX3					: out std_logic_vector(6 DOWNTO 0);
		HEX4					: out std_logic_vector(6 DOWNTO 0);
		HEX5					: out std_logic_vector(6 DOWNTO 0);
		PALAVRA				: out std_logic_vector(15 DOWNTO 0);
		PC_OUT				: out std_logic_vector(31 DOWNTO 0);
		ULA_OUT 				: out std_logic_vector(31 DOWNTO 0);
		BANCO_IN 			: out std_logic_vector(31 DOWNTO 0)
  );
	
end entity;


architecture arquitetura of TopLevel is

	signal SIG_CLK			  			: std_logic;
	signal SIG_SAIDA_FLAGZ_ULA		: std_logic;
	signal SIG_DEC_TO_INVB			: std_logic;	
	signal SIG_AND_BEQ_BNE			: std_logic;
	signal SIG_OR_BEQ_BNE			: std_logic;
	signal SIG_MUX_FLAGZ_OUT		: std_logic;
	signal DECODER_TO_ULA			: std_logic_vector(3 DOWNTO 0);
	signal SIG_RD	 					: std_logic_vector(4 DOWNTO 0);
	signal SIG_RS			 			: std_logic_vector(4 DOWNTO 0);
	signal SIG_RT			 			: std_logic_vector(4 DOWNTO 0);
	signal SIG_MUXBANREG_OUT		: std_logic_vector(4 DOWNTO 0);
	signal SIG_FUNCT					: std_logic_vector(5 DOWNTO 0);
	signal SIG_SHAMT					: std_logic_vector(4 DOWNTO 0);
	signal PALAVRA_CONTROLE			: std_logic_vector(15 DOWNTO 0);
	signal SIG_IMEDIATO				: std_logic_vector(15 DOWNTO 0);
	signal SIG_IMEDIATO_EXTENDIDO	: std_logic_vector(31 DOWNTO 0);
	signal SIG_INCPC_OUT 			: std_logic_vector(31 DOWNTO 0);
	signal SIG_INCPC_BEQ_OUT 		: std_logic_vector(31 DOWNTO 0);
	signal SIG_MUX_BEQ_OUT 			: std_logic_vector(31 DOWNTO 0);
	signal SIG_MUX_PROXPC_OUT 		: std_logic_vector(31 DOWNTO 0);
	signal SIG_MUX_ULAB_OUT			: std_logic_vector(31 DOWNTO 0);
	signal SIG_MUX_ULA_OUT			: std_logic_vector(31 DOWNTO 0);
	signal SIG_MUXPC_OUT				: std_logic_vector(31 DOWNTO 0);
	signal SIG_PC_OUT      			: std_logic_vector(31 DOWNTO 0);
	signal SIG_ROM_OUT     			: std_logic_vector(31 DOWNTO 0);
	signal SIG_RAM_OUT				: std_logic_vector(31 DOWNTO 0);
	signal SIG_ULA_OUT	  			: std_logic_vector(31 DOWNTO 0);
	signal SIG_BAN_OUT_REGA			: std_logic_vector(31 DOWNTO 0);
	signal SIG_BAN_OUT_REGB			: std_logic_vector(31 DOWNTO 0);
	signal SIG_MUX_ULA_MEM_OUT		: std_logic_vector(31 DOWNTO 0);
	signal SIG_MUX_HEX_OUT		: std_logic_vector(31 DOWNTO 0);
	signal SIG_LUI_OUT				: std_logic_vector(31 DOWNTO 0);
	signal SIG_SHIFTER_OUT			: std_logic_vector(31 DOWNTO 0);
	signal SIG_MUX_SHIFTER_OUT		: std_logic_vector(31 DOWNTO 0);

begin


gravar: if simulacao generate
	
	SIG_CLK <= KEY(0);
	
			else generate

	SIG_CLK <= KEY(0);

end generate;

------------------------------------------- Program Counter --------------------------------------------

PC: entity work.registradorGenerico generic map(larguraDados => 32)
		port map(
			DIN => SIG_MUX_PROXPC_OUT,
			DOUT =>	SIG_PC_OUT,
			ENABLE =>'1',
			CLK => SIG_CLK,
			RST => '0'
		);
		
---------------------------------------------- Somadores -----------------------------------------------


incPC : entity work.somaConstante generic map(larguraDados => 32, constante => 4)
		port map(
			entrada => SIG_PC_OUT,
			saida => SIG_INCPC_OUT
		);
		
incImediato : entity work.somadorSinais generic map(larguraDados => 32)
		port map(
			entradaCima => SIG_INCPC_OUT,
			entradaBaixo => SIG_IMEDIATO_EXTENDIDO(29 DOWNTO 0) & "00",
			saida => SIG_INCPC_BEQ_OUT
		);
		
------------------------------------------------ MUXs -------------------------------------------------

MUX_BEQ : entity work.muxGenerico2x1 generic map(larguraDados => 32)
		port map(
			entradaA_MUX => SIG_INCPC_OUT,
			entradaB_MUX => SIG_INCPC_BEQ_OUT,
			seletor_MUX => SIG_AND_BEQ_BNE,
			saida_MUX => SIG_MUX_BEQ_OUT
		);
		
MUX_PROXPC : entity work.muxGenerico2x1 generic map(larguraDados => 32)
		port map(
			entradaA_MUX => SIG_MUXPC_OUT,
			entradaB_MUX => SIG_BAN_OUT_REGA,
			seletor_MUX => PALAVRA_CONTROLE(12),
			saida_MUX => SIG_MUX_PROXPC_OUT
		);
		
MUX_BANREG : entity work.muxGenerico4x1 generic map(larguraDados => 5)
		port map(
			entradaA_MUX => SIG_RT,
			entradaB_MUX => SIG_RD,
			entradaC_MUX => "11111",
			entradaD_MUX => "00000",
			seletor_MUX => PALAVRA_CONTROLE(10 DOWNTO 9),
			saida_MUX => SIG_MUXBANREG_OUT
		);
		
MUX_ULAB : entity work.muxGenerico2x1 generic map(larguraDados => 32)
		port map(
			entradaA_MUX => SIG_BAN_OUT_REGB,
			entradaB_MUX => SIG_IMEDIATO_EXTENDIDO,
			seletor_MUX => PALAVRA_CONTROLE(6),
			saida_MUX => SIG_MUX_ULAB_OUT
		);
		
MUX_JMP : entity work.muxGenerico2x1 generic map(larguraDados => 32)
		port map(
			entradaA_MUX => SIG_MUX_BEQ_OUT,
			entradaB_MUX => SIG_INCPC_OUT(31 DOWNTO 28) & SIG_IMEDIATO_EXTENDIDO(25 DOWNTO 0) & "00",
			seletor_MUX => PALAVRA_CONTROLE(11),
			saida_MUX => SIG_MUXPC_OUT
		);

MUX_ULA_MEM : entity work.muxGenerico4x1 generic map(larguraDados => 32)
		port map(
			entradaA_MUX => SIG_MUX_ULA_OUT,
			entradaB_MUX => SIG_RAM_OUT,
			entradaC_MUX => SIG_INCPC_OUT,
			entradaD_MUX => SIG_LUI_OUT,
			seletor_MUX => PALAVRA_CONTROLE(5 DOWNTO 4),
			saida_MUX => SIG_MUX_ULA_MEM_OUT
		);
		
MUX_ULA_OUT : entity work.muxGenerico2x1 generic map(larguraDados => 32)
		port map(
			entradaA_MUX => SIG_ULA_OUT,
			entradaB_MUX => not SIG_ULA_OUT,
			seletor_MUX => PALAVRA_CONTROLE(13),
			saida_MUX => SIG_MUX_ULA_OUT
		);
		
MUX_SHIFT : entity work.muxGenerico2x1 generic map(larguraDados => 32)
		port map(
			entradaA_MUX => SIG_MUX_ULA_MEM_OUT,
			entradaB_MUX => SIG_SHIFTER_OUT,
			seletor_MUX => PALAVRA_CONTROLE(14) OR PALAVRA_CONTROLE(15),
			saida_MUX => SIG_MUX_SHIFTER_OUT
		);
		
MUX_HEX : entity work.muxGenerico2x1 generic map(larguraDados => 32)
		port map(
			entradaA_MUX => SIG_PC_OUT,
			entradaB_MUX => SIG_MUX_ULA_OUT,
			seletor_MUX => SW(0),
			saida_MUX => SIG_MUX_HEX_OUT
		);
		
MUX_FLAGZ : entity work.muxGenerico2x1_1bit
		port map(
			entradaA_MUX => not SIG_SAIDA_FLAGZ_ULA,
			entradaB_MUX => SIG_SAIDA_FLAGZ_ULA,
			seletor_MUX => PALAVRA_CONTROLE(3),
			saida_MUX => SIG_MUX_FLAGZ_OUT
		);
		
		
----------------------------------------------- Memórias -----------------------------------------------
		
ROM : entity work.ROM generic map(dataWidth => 32, addrWidth => 32, memoryAddrWidth => 6)
		port map (
			Endereco => SIG_PC_OUT,
			Dado => SIG_ROM_OUT
		);
		
RAM : entity work.RAM generic map(dataWidth => 32, addrWidth => 32, memoryAddrWidth => 6)
		port map(
			clk => SIG_CLK,
			Endereco => SIG_MUX_ULA_OUT,
			Dado_in => SIG_BAN_OUT_REGB,
			Dado_out => SIG_RAM_OUT,
			we => PALAVRA_CONTROLE(0),
			re => PALAVRA_CONTROLE(1),
			habilita => '1'
		);
		
bancoRegistradores : entity work.bancoReg generic map(larguraDados => 32, larguraEndBancoRegs => 5)
		port map (
			clk => SIG_CLK,
			enderecoA => SIG_RS,  
			enderecoB => SIG_RT, 
			enderecoC => SIG_MUXBANREG_OUT, 
			dadoEscritaC => SIG_MUX_SHIFTER_OUT,
			escreveC => PALAVRA_CONTROLE(7),
			saidaA => SIG_BAN_OUT_REGA,
			saidaB => SIG_BAN_OUT_REGB
		);
		
ULA : entity work.ULA
		port map (
			entradaA 	=> SIG_BAN_OUT_REGA,
			entradaB		=> SIG_MUX_ULAB_OUT,
			sel_mux		=> DECODER_TO_ULA(1 DOWNTO 0),
			inverteB		=> DECODER_TO_ULA(2),
			resultado	=> SIG_ULA_OUT,
			flagZero		=> SIG_SAIDA_FLAGZ_ULA
		);
	
		
shift : entity work.Shift generic map(larguraDados => 32)
		port map(
			input => SIG_BAN_OUT_REGB,
			shamt	=> SIG_SHAMT,
			sll_signal => PALAVRA_CONTROLE(15), 
			srl_signal => PALAVRA_CONTROLE(14),
			output => SIG_SHIFTER_OUT
		);
		
extendSignal : entity work.extendSignal generic map(larguraDadoEntrada => 16, larguraDadoSaida => 32)
		port map(
			ori_andi_signal => PALAVRA_CONTROLE(8),
			in_signal => SIG_IMEDIATO,
			out_signal => SIG_IMEDIATO_EXTENDIDO
		);
		
LUI : entity work.LUI generic map(larguraDadoEntrada => 16, larguraDadoSaida => 32)
		port map(
			in_signal => SIG_IMEDIATO,
			out_signal => SIG_LUI_OUT
		);
		
decoder : entity work.Decoder
	port map(
		opcode => SIG_ROM_OUT(31 DOWNTO 26),
		funct	 => SIG_ROM_OUT(5 DOWNTO 0),
		ula_ctrl => DECODER_TO_ULA, 
		palavra => PALAVRA_CONTROLE
	);
	

------------------------------------------------- HEX -------------------------------------------------

HEX_0 :  entity work.conversorHex7Seg
        port map(
				dadoHex => SIG_MUX_HEX_OUT(3 DOWNTO 0),
            apaga =>  '0',
            negativo => '0',
            overFlow =>  '0',
            saida7seg => HEX0
			);

HEX_1 :  entity work.conversorHex7Seg
        port map(
				dadoHex => SIG_MUX_HEX_OUT(7 DOWNTO 4),
            apaga =>  '0',
            negativo => '0',
            overFlow =>  '0',
            saida7seg => HEX1
			);

HEX_2 :  entity work.conversorHex7Seg
        port map(
				dadoHex => SIG_MUX_HEX_OUT(11 DOWNTO 8),
            apaga =>  '0',
            negativo => '0',
            overFlow =>  '0',
            saida7seg => HEX2
			);

HEX_3 :  entity work.conversorHex7Seg
        port map(
				dadoHex => SIG_MUX_HEX_OUT(15 DOWNTO 12),
            apaga =>  '0',
            negativo => '0',
            overFlow =>  '0',
            saida7seg => HEX3
			);

HEX_4 :  entity work.conversorHex7Seg
        port map(
				dadoHex => SIG_MUX_HEX_OUT(19 DOWNTO 16),
            apaga =>  '0',
            negativo => '0',
            overFlow =>  '0',
            saida7seg => HEX4
			);

	
HEX_5 :  entity work.conversorHex7Seg
        port map(
				dadoHex => SIG_MUX_HEX_OUT(23 DOWNTO 20),
            apaga =>  '0',
            negativo => '0',
            overFlow =>  '0',
            saida7seg => HEX5
			);
			
SIG_AND_BEQ_BNE <= SIG_OR_BEQ_BNE and SIG_MUX_FLAGZ_OUT; 
SIG_OR_BEQ_BNE <= PALAVRA_CONTROLE(3) or PALAVRA_CONTROLE(2);

SIG_RD <= SIG_ROM_OUT(15 DOWNTO 11);
SIG_RS <= SIG_ROM_OUT(25 DOWNTO 21);
SIG_RT <= SIG_ROM_OUT(20 DOWNTO 16);
SIG_FUNCT <= SIG_ROM_OUT(5 DOWNTO 0);
SIG_IMEDIATO <= SIG_ROM_OUT(15 DOWNTO 0);
SIG_SHAMT <= SIG_ROM_OUT(10 DOWNTO 6);

PC_OUT <= SIG_PC_OUT;
ULA_OUT <= SIG_MUX_ULA_OUT;
PALAVRA <= PALAVRA_CONTROLE;
BANCO_IN <= SIG_MUX_SHIFTER_OUT;

end architecture;
