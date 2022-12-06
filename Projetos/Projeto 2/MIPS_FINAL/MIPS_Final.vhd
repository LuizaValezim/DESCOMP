library ieee;
use ieee.std_logic_1164.all;

entity MIPS_Final is

	generic (
		larguradados : natural := 32;
		larguraenderecos : natural := 32;
		simulacao : boolean := false -- para gravar na placa, altere de true para false
	);
	port (

		clock_50 : in std_logic;
		fpga_reset_n  : in std_logic;
		key: in std_logic_vector(3 downto 0);	 
		sw: in std_logic_vector(9 downto 0);		

		ledr          : out std_logic_vector(9 downto 0);
		hex0          : out std_logic_vector(6 downto 0);
		hex1          : out std_logic_vector(6 downto 0);
		hex2          : out std_logic_vector(6 downto 0);
		hex3          : out std_logic_vector(6 downto 0);
		hex4          : out std_logic_vector(6 downto 0);
		hex5          : out std_logic_vector(6 downto 0)
	);

end entity;

architecture arquitetura of MIPS_Final is

	signal clk : std_logic;
	signal pc_constante : std_logic_vector(larguradados - 1 downto 0);
	signal prox_pc : std_logic_vector(larguradados - 1 downto 0);
	signal muxbeqout : std_logic_vector(larguradados - 1 downto 0);
	signal pc_out : std_logic_vector(larguradados - 1 downto 0);
	signal rom_out : std_logic_vector(larguradados - 1 downto 0);
	signal mux_out : std_logic_vector(4 downto 0);
	signal rs_ula_a : std_logic_vector(larguradados - 1 downto 0);
	signal rt_out : std_logic_vector(larguradados - 1 downto 0);
	signal mux_ula_b : std_logic_vector(larguradados - 1 downto 0);
	signal mux_dado_banco : std_logic_vector(larguradados - 1 downto 0);
	signal imediatoestendido : std_logic_vector(larguradados - 1 downto 0);
	signal imediatoestendidoshiftado : std_logic_vector(larguradados - 1 downto 0);
	signal ula_out : std_logic_vector(larguradados - 1 downto 0);
	signal mem_out : std_logic_vector(larguradados - 1 downto 0);
	signal ula_flag : std_logic;
	signal flag_eq_out : std_logic;
	signal somador_out : std_logic_vector(larguradados - 1 downto 0);
	signal decoder_out : std_logic_vector(13 downto 0);
	signal mux_rtrd_out : std_logic_vector(4 downto 0);
	signal mux_prox_pc : std_logic_vector(larguradados - 1 downto 0);
	signal mux_beq_jmp_out : std_logic_vector(larguradados - 1 downto 0);
	signal concat_jmp : std_logic_vector(larguradados - 1 downto 0);
	signal decoderfunct_out : std_logic_vector(2 downto 0);
	signal decoderopcode_out : std_logic_vector(2 downto 0);
	signal ula_ctrl : std_logic_vector(2 downto 0);
	signal saida_led_hex : std_logic_vector(larguradados-1 downto 0);
	signal imediato_tipoi : std_logic_vector(larguradados-1 downto 0);
	signal imediato_ori_andi : std_logic_vector(larguradados-1 downto 0); 
	signal muxula_beq_bne_out : std_logic;

	alias rt_ram : std_logic_vector(larguradados - 1 downto 0) is rt_out;
	alias rom_in : std_logic_vector(larguradados - 1 downto 0) is pc_out(larguradados - 1 downto 0);
	alias rsaddr : std_logic_vector(4 downto 0) is rom_out(25 downto 21);
	alias rtaddr : std_logic_vector(4 downto 0) is rom_out(20 downto 16);
	alias rdaddr : std_logic_vector(4 downto 0) is rom_out(15 downto 11);

	alias imediato : std_logic_vector(15 downto 0) is rom_out(15 downto 0);
	alias imediatojmp : std_logic_vector(25 downto 0) is rom_out(25 downto 0);
	alias mem_add : std_logic_vector(31 downto 0) is ula_out(31 downto 0);
	alias funct_signal: std_logic_vector(5 downto 0) is rom_out(5 downto 0);
	alias opcode_signal: std_logic_vector(5 downto 0) is rom_out(31 downto 26);
	alias selmuxflag : std_logic is flag_eq_out;

   alias jr : std_logic is decoder_out(13);
	alias selmuxjump : std_logic is decoder_out(12);
	alias selmuxrtrd : std_logic_vector(1 downto 0) is decoder_out(11 downto 10);
	alias ori_andi : std_logic is decoder_out(9);
	alias write_reg : std_logic is decoder_out(8);
	alias selimediatoreg : std_logic is decoder_out(7);
	alias tipor : std_logic is decoder_out(6);
	alias selmuxulamem : std_logic_vector(1 downto 0) is decoder_out(5 downto 4);
	alias beq : std_logic is decoder_out(3);
	alias bne: std_logic is decoder_out(2);
	alias read_ram : std_logic is decoder_out(1);
	alias write_ram : std_logic is decoder_out(0);

begin

	gravar:  if simulacao generate
				clk <= clock_50;
			else generate
				detectorsub0: work.edgedetector(bordasubida)
				port map(   clk      => clock_50,
							entrada  => (not key(0)),
							saida    => clk
							);
							
	end generate;
	
	concat_jmp <=  pc_constante(31 downto 28) & imediatojmp & "00";

	mux_next_pc_beq_jmp : entity work.muxGenerico2x1 generic map (larguradados => larguradados)
		port map(
			entradaa_mux => muxbeqout,
			entradab_mux => concat_jmp, 
			seletor_mux => selmuxjump, 
			saida_mux => mux_beq_jmp_out
		);

	mux_jr : entity work.muxGenerico2x1 generic map (larguradados => larguradados)
		port map(
			entradaa_mux => mux_beq_jmp_out,
			entradab_mux => rs_ula_a, 
			seletor_mux => jr, 
			saida_mux => mux_prox_pc
		);
	
	mux_funct_opcode : entity work.muxGenerico2x1 generic map (larguradados => 3)
		port map(
			entradaa_mux => decoderopcode_out,
			entradab_mux => decoderfunct_out,
			seletor_mux => tipor,
			saida_mux => ula_ctrl
		);
		
	mux_ori_andi_imediato : entity work.muxgenerico2x1 generic map (larguradados => larguradados)
		port map(
			entradaa_mux => imediato_tipoi,
			entradab_mux => imediato_ori_andi,
			seletor_mux => ori_andi,
			saida_mux => imediatoestendido
		);
	
	mux_rd_rt : entity work.muxgenerico4x1 generic map (larguradados => 5)
		port map(
			e0 => rtaddr,
			e1 => rdaddr,
			e2 =>  "11111",
			e3	=> "00000",
			sel_mux => selmuxrtrd,
			mux_out => mux_rtrd_out 			
	);
						
	mux_rt_imediato : entity work.muxgenerico2x1 generic map (larguradados => larguradados)
		port map(
			entradaa_mux => rt_out,
			entradab_mux => imediatoestendido,
			seletor_mux => selimediatoreg,
			saida_mux => mux_ula_b
		);
		
	muxula_beqbne : entity work.muxgenerico2x1 generic map (larguradados => 1)
		port map(
			entradaa_mux(0) => not(ula_flag),
			entradab_mux(0) => ula_flag,
			seletor_mux => beq,
			saida_mux(0) => muxula_beq_bne_out
		);
		
	muxbeq : entity work.muxgenerico2x1 generic map (larguradados => larguradados)
		port map(
			entradaa_mux => pc_constante,
			entradab_mux => somador_out,
			seletor_mux => muxula_beq_bne_out and (beq or bne),
			saida_mux => muxbeqout
		);

	mux_ula_mem : entity work.muxgenerico4x1 generic map (larguradados => larguradados)
		port map(
			e0 => ula_out,
			e1 => mem_out,
			e2 =>  pc_constante,
			e3	=> imediato & x"0000",
			sel_mux => selmuxulamem,
			mux_out => mux_dado_banco 			
		);
	
	mux_ula_pc: entity work.muxgenerico2x1 generic map (larguradados => larguradados)
		port map(
			entradaa_mux => pc_out,
			entradab_mux => ula_out,
			seletor_mux => sw(0),
			saida_mux => saida_led_hex 
		);

	pc_reg : entity work.registradorGenerico generic map (larguradados => larguraenderecos)
		port map(
			din => mux_prox_pc,
			dout => pc_out,
			enable => '1',
			clk => clk,
			rst => '0'
		);

	Somador_1 : entity work.somaConstante generic map (larguradados => larguraenderecos, constante => 4)
		port map(entrada => pc_out, saida => pc_constante);
		
	Somador_2 : entity work.somadorGenerico generic map (larguradados => larguraenderecos)
		port map(
			entradaa => pc_constante,
			entradab => imediatoestendidoshiftado,
			saida => somador_out
		);


	decoder : entity work.Decoder
		port map(
			opcode => opcode_signal,
			funct  => funct_signal,
			operacao => ula_ctrl(1 downto 0),
			output => decoder_out
	);

	decoder_Function : entity work.Decoder_Function
		port map(
			funct => funct_signal,
			output_fun => decoderfunct_out
	);
	
	decoder_Opcode : entity work.Decoder_Opcode
		port map(
			opcode => opcode_signal,
			output_op => decoderopcode_out
	);

	banco_Registradores : entity work.Banco_Registradores generic map (larguradados => larguradados)
		port map(
			clk => clk,
			enderecoa => rsaddr,
			enderecob => rtaddr,
			enderecoc => mux_rtrd_out,
			dadoescritac => mux_dado_banco,
			escrevec => write_reg,
			saidaa => rs_ula_a,
			saidab => rt_out
		);	
		
	imediato_tipoi <= (larguradados - 1 downto 16 => imediato(15)) & imediato;
	imediato_ori_andi <= "0000000000000000"  & imediato;

	shiftSignal : entity work.shiftSignal generic map (larguradados => larguradados, deslocar => 2)
		port map(
			entrada => imediatoestendido,
			saida => imediatoestendidoshiftado
		);


	ULA : entity work.ULASomaSub generic map(larguradados => larguradados)
		port map(
			entradaa => rs_ula_a,
			entradab => mux_ula_b,
			seletor => ula_ctrl(1 downto 0),
			inverteb => ula_ctrl(2),
			saida => ula_out,
			flagzero => ula_flag
		);

		
	RAM : entity work.memoriaRAM generic map (datawidth => larguradados, addrwidth => larguradados, memoryaddrwidth => 6)
		port map(
			clk => clk,
			endereco => mem_add,
			dado_in => rt_ram,
			dado_out => mem_out,
			we => write_ram,
			re => read_ram
		);
		
	ROM : entity work.memoriaROM generic map (datawidth => larguradados, addrwidth => larguraenderecos, memoryaddrwidth => 6)
		port map(
			clk => clk,
			endereco => rom_in,
			dado => rom_out
		);

	HEX_0 : entity work.logica_7seg generic map (in_width => 4, out_width => 7)
	port map(
		datain => saida_led_hex(3 downto 0),
		clk => clk,
		display_out => hex0
	);

	HEX_1 : entity work.logica_7seg generic map (in_width => 4, out_width => 7)
	port map(
		datain => saida_led_hex(7 downto 4),
		clk => clk,
		display_out => hex1
	);

	HEX_2 : entity work.logica_7seg generic map (in_width => 4, out_width => 7)
	port map(
		datain => saida_led_hex(11 downto 8),
		clk => clk,
		display_out => hex2
	);

	HEX_3 : entity work.logica_7seg generic map (in_width => 4, out_width => 7)
	port map(
		datain => saida_led_hex(15 downto 12),
		clk => clk,
		display_out => hex3
	);

	HEX_4 : entity work.logica_7seg generic map (in_width => 4, out_width => 7)
	port map(
		datain => saida_led_hex(19 downto 16),
		clk => clk,
		display_out => hex4
	);

	HEX_5 : entity work.logica_7seg generic map (in_width => 4, out_width => 7)
	port map(
		datain => saida_led_hex(23 downto 20),
		clk => clk,
		display_out => hex5
	);

	ledr(7 downto 0) <= saida_led_hex(31 downto 24);

end architecture;