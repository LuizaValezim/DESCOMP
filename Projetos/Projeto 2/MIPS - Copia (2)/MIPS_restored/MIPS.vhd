library ieee;
use ieee.std_logic_1164.all;

entity MIPS is

	generic (
		larguraDados : natural := 32;
		larguraenderecos : natural := 32;
		simulacao : BOOLEAN := FALSE -- para gravar na placa, altere de TRUE para FALSE
	);
	port (
		CLOCK_50 : in STD_LOGIC;
		FPGA_RESET_N  : in std_logic;
		KEY: in std_logic_vector(3 downto 0);	 
		SW: in std_logic_vector(9 downto 0);		
		LEDR          : out std_logic_vector(9 downto 0);
		HEX0          : out std_logic_vector(6 downto 0);
		HEX1          : out std_logic_vector(6 downto 0);
		HEX2          : out std_logic_vector(6 downto 0);
		HEX3          : out std_logic_vector(6 downto 0);
		HEX4          : out std_logic_vector(6 downto 0);
		HEX5          : out std_logic_vector(6 downto 0)
	);

end entity;

architecture arquitetura OF MIPS is

	signal CLK : STD_LOGIC;
	signal PC_constante : std_logic_vector(larguraDados - 1 downto 0);
	signal Prox_PC : std_logic_vector(larguraDados - 1 downto 0);
	signal MuxBeqout : std_logic_vector(larguraDados - 1 downto 0);
	signal PC_out : std_logic_vector(larguraDados - 1 downto 0);
	signal ROM_out : std_logic_vector(larguraDados - 1 downto 0);
	signal MUX_out : std_logic_vector(4 downto 0);
	signal Rs_ULA_A : std_logic_vector(larguraDados - 1 downto 0);
	signal Rt_out : std_logic_vector(larguraDados - 1 downto 0);
	signal MUX_ULA_B : std_logic_vector(larguraDados - 1 downto 0);
	signal MUX_DADO_BANCO : std_logic_vector(larguraDados - 1 downto 0);
	signal imediatoEstendido : std_logic_vector(larguraDados - 1 downto 0);
	signal imediatoEstendidoShiftado : std_logic_vector(larguraDados - 1 downto 0);
	signal ULA_out : std_logic_vector(larguraDados - 1 downto 0);
	signal MEM_out : std_logic_vector(larguraDados - 1 downto 0);
	signal ULA_FLAG : STD_LOGIC;
	signal FLAG_EQ_out : STD_LOGIC;
	signal somador_out : std_logic_vector(larguraDados - 1 downto 0);
	signal decoder_out : std_logic_vector(8 downto 0);
	signal MUX_RTRD_out : std_logic_vector(4 downto 0);
	signal MUX_PROX_PC : std_logic_vector(larguraDados - 1 downto 0);
	signal CONCAT_JMP : std_logic_vector(larguraDados - 1 downto 0);
	signal decoderFunct_out : std_logic_vector(2 downto 0);
	signal decoderOpcode_out : std_logic_vector(2 downto 0);
	signal Ula_ctrl : std_logic_vector(2 downto 0);
	signal saida_LED_HEX : std_logic_vector(larguraDados-1 downto 0);

	alias Rt_RAM : std_logic_vector(larguraDados - 1 downto 0) is Rt_out;
	alias ROM_in : std_logic_vector(larguraDados - 1 downto 0) is PC_out(larguraDados - 1 downto 0);
	alias RsAddr : std_logic_vector(4 downto 0) is ROM_out(25 downto 21);
	alias RtAddr : std_logic_vector(4 downto 0) is ROM_out(20 downto 16);
	alias RdAddr : std_logic_vector(4 downto 0) is ROM_out(15 downto 11);

	alias imediato : std_logic_vector(15 downto 0) is ROM_out(15 downto 0);
	alias imediatoJmp : std_logic_vector(25 downto 0) is ROM_out(25 downto 0);
	alias MEM_ADD : std_logic_vector(31 downto 0) is ULA_out(31 downto 0);
	alias FUNCT_signal: std_logic_vector(5 downto 0) is ROM_out(5 downto 0);
	alias OPCODE_signal: std_logic_vector(5 downto 0) is ROM_out(31 downto 26);
	alias SelMuxFlag : STD_LOGIC is FLAG_EQ_out;
	alias TIPOR : STD_LOGIC is decoder_out(8);
	alias SelMuxJump : STD_LOGIC is decoder_out(7);
	alias SelMuxRtRd : STD_LOGIC is decoder_out(6);
	alias write_REG : STD_LOGIC is decoder_out(5);
	alias SelImediatoReg : STD_LOGIC is decoder_out(4);
	alias SelMuxUlaMem : STD_LOGIC is decoder_out(3);
	alias habFlagEqual : STD_LOGIC is decoder_out(2);
	alias read_RAM : STD_LOGIC is decoder_out(1);
	alias write_RAM : STD_LOGIC is decoder_out(0);

begin

	gravar:  if simulacao generate
				CLK <= CLOCK_50;
			else generate
				detectorSub0: work.edgeDetector(bordaSubida)
				port map(   clk      => CLOCK_50,
							entrada  => (not KEY(0)),
							saida    => CLK
							);
	end generate;
	
	Somador : entity work.somaconstante generic map (larguraDados => larguraenderecos, constante => 4)
		port map(
			entrada => PC_out, saida => PC_constante
		);
		
	Somador_Shift : entity work.somadorgenerico generic map (larguraDados => larguraenderecos)
		port map(
			entradaA => PC_constante,
			entradaB => imediatoEstendidoShiftado,
			saida => somador_out
		);

	Program_Counter : entity work.registradorgenerico generic map (larguraDados => larguraenderecos)
		port map(
			Din => MUX_PROX_PC,
			Dout => PC_out,
			ENABLE => '1',
			CLK => CLK,
			RST => '0'
		);
		

	CONCAT_JMP <=  PC_constante(31 downto 28) & imediatoJmp & "00";
	

	decoder : entity work.Decoder
		port map(
			OPCODE => OPCODE_signal,
			FUNCT  => FUNCT_signal,
			OPERACAO => ULA_ctrl(1 downto 0),
			outPUT => decoder_out
	);
	
	opcode_decoder : entity work.DecoderOpcode
		port map(
			OPCODE => OPCODE_signal,
			outPUT_OP => decoderOpcode_out
	);

	
	function_decoder : entity work.DecoderFunct
		port map(
			FUNCT => FUNCT_signal,
			outPUT_FUN => decoderFunct_out
	);


	banco_registradores : entity work.bancoReg generic map (larguraDados => larguraDados)
		port map(
			clk => CLK,
			enderecoA => RsAddr,
			enderecoB => RtAddr,
			enderecoC => MUX_RTRD_out,
			dadoEscritaC => MUX_DADO_BANCO,
			escreveC => write_REG,
			saidaA => Rs_ULA_A,
			saidaB => Rt_out
		);
		

	extendSignal: entity work.extendSignal generic map (larguraDadosEntrada => 16, larguraDadosSaida => larguraDados)
		port map(
			entrada => imediato,
			saida => imediatoEstendido
		);

	shiftSignal : entity work.shiftSignal generic map (larguraDados => larguraDados, deslocar => 2)
		port map(
			entrada => imediatoEstendido,
			saida => imediatoEstendidoShiftado
		);
		
		
	MUX_fop : entity work.muxgenerico2x1 generic map (larguraDados => 3)
	port map(
		entradaA_MUX => decoderOpcode_out,
		entradaB_MUX => decoderFunct_out,
		seletor_MUX => TIPOR,
		saida_MUX => ULA_ctrl
	);
	
	MUX_pc : entity work.muxgenerico2x1 generic map (larguraDados => larguraDados)
		port map(
			entradaA_MUX => MuxBeqout,
			entradaB_MUX => CONCAT_JMP, 
			seletor_MUX => SelMuxJump, 
			saida_MUX => MUX_PROX_PC
		);

	MUX_rdrt : entity work.muxgenerico2x1 generic map (larguraDados => 5)
		port map(
			entradaA_MUX => RtAddr,
			entradaB_MUX => RdAddr,
			seletor_MUX => SelMuxRtRd,
			saida_MUX => MUX_RTRD_out
		);

	MUX_beq : entity work.muxgenerico2x1 generic map (larguraDados => larguraDados)
		port map(
			entradaA_MUX => PC_constante,
			entradaB_MUX => somador_out,
			seletor_MUX => (habFlagEqual AND ULA_FLAG),
			saida_MUX => MuxBeqout
		);
					
	MUX_ula : entity work.muxgenerico2x1 generic map (larguraDados => larguraDados)
		port map(
			entradaA_MUX => Rt_out,
			entradaB_MUX => imediatoEstendido,
			seletor_MUX => SelImediatoReg,
			saida_MUX => MUX_ULA_B
		);

	MUX_ulaMEM : entity work.muxgenerico2x1 generic map (larguraDados => larguraDados)
		port map(
			entradaA_MUX => ULA_out,
			entradaB_MUX => MEM_out,
			seletor_MUX => SelMuxUlaMem,
			saida_MUX => MUX_DADO_BANCO
		);
		
	MUX_ulaPC: entity work.muxgenerico2x1 generic map (larguraDados => larguraDados)
	port map(
		entradaA_MUX => PC_out,
		entradaB_MUX => ULA_out,
		seletor_MUX => SW(0),
		saida_MUX => saida_LED_HEX 
	);

	ULA : entity work.ULA generic map(larguraDados => larguraDados)
		port map(
			entradaA => Rs_ULA_A,
			entradaB => MUX_ULA_B,
			seletor => ULA_ctrl(1 downto 0),
			inverteB => ULA_ctrl(2),
			saida => ULA_out,
			flagZero => ULA_FLAG
		);
		
		
	RAM : entity work.memoriaRAM generic map (dataWidth => larguraDados, addrWidth => larguraDados, memoryAddrWidth => 6)
	port map(
		clk => CLK,
		endereco => MEM_ADD,
		Dado_in => Rt_RAM,
		Dado_out => MEM_out,
		we => write_RAM,
		re => read_RAM
	);
	
	ROM : entity work.memoriaROM generic map (dataWidth => larguraDados, addrWidth => larguraenderecos, memoryAddrWidth => 6)
		port map(
			clk => CLK,
			endereco => ROM_in,
			Dado => ROM_out
		);


	HEX_0 : entity work.modelo_7seg generic map (in_WIDTH => 4, out_WIDTH => 7)
	port map(
		datain => saida_LED_HEX(3 downto 0),
		CLK => CLK,
		display_out => HEX0
	);

	HEX_1 : entity work.modelo_7seg generic map (in_WIDTH => 4, out_WIDTH => 7)
	port map(
		datain => saida_LED_HEX(7 downto 4),
		CLK => CLK,
		display_out => HEX1
	);

	HEX_2 : entity work.modelo_7seg generic map (in_WIDTH => 4, out_WIDTH => 7)
	port map(
		datain => saida_LED_HEX(11 downto 8),
		CLK => CLK,
		display_out => HEX2
	);

	HEX_3 : entity work.modelo_7seg generic map (in_WIDTH => 4, out_WIDTH => 7)
	port map(
		datain => saida_LED_HEX(15 downto 12),
		CLK => CLK,
		display_out => HEX3
	);

	HEX_4 : entity work.modelo_7seg generic map (in_WIDTH => 4, out_WIDTH => 7)
	port map(
		datain => saida_LED_HEX(19 downto 16),
		CLK => CLK,
		display_out => HEX4
	);

	HEX_5 : entity work.modelo_7seg generic map (in_WIDTH => 4, out_WIDTH => 7)
	port map(
		datain => saida_LED_HEX(23 downto 20),
		CLK => CLK,
		display_out => HEX5
	);

	LEDR(7 downto 0) <= saida_LED_HEX(31 downto 24);
                

end architecture;