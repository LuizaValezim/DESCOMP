library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
   generic (
          dataWidth: natural := 15;
          addrWidth: natural := 9
    );
   port (
          Endereco : in std_logic_vector (8 DOWNTO 0);
          Dado : out std_logic_vector (dataWidth-1 DOWNTO 0)
    );
end entity;

architecture assincrona of memoriaROM is

  constant NOP  : std_logic_vector(3 downto 0) := "0000";
  constant LDA  : std_logic_vector(3 downto 0) := "0001";
  constant SOMA : std_logic_vector(3 downto 0) := "0010";
  constant SUB  : std_logic_vector(3 downto 0) := "0011";
  constant LDI : std_logic_vector(3 downto 0) := "0100";
  constant STA : std_logic_vector(3 downto 0) := "0101";
  constant JMP : std_logic_vector(3 downto 0) := "0110";
  constant JEQ : std_logic_vector(3 downto 0) := "0111";
  constant CEQ : std_logic_vector(3 downto 0) := "1000";
  constant JSR : std_logic_vector(3 downto 0) := "1001";
  constant RET : std_logic_vector(3 downto 0) := "1010";
  constant ANDI : std_logic_vector(3 downto 0) := "1011";
  
  constant R0:    std_logic_vector (1 DOWNTO 0)	:= "00";
  constant R1:    std_logic_vector (1 DOWNTO 0)	:= "01";
  constant R2:    std_logic_vector (1 DOWNTO 0)	:= "10";
  constant R3:    std_logic_vector (1 DOWNTO 0)	:= "11";

  type blocoMemoria is array(0 TO 2**addrWidth - 1) of std_logic_vector(dataWidth-1 DOWNTO 0);

  function initMemory
        return blocoMemoria is variable tmp : blocoMemoria := (others => (others => '0'));
		
  begin
      -- Palavra de Controle = SelMUX, Habilita_A, Reset_A, Operacao_ULA
					-- Inicializa os endereços:
					

			tmp(0) := LDI  &  R0  &  '0'  &  x"00";	-- LDI $0, R0 	# Inicializando algumas vari�veis importantes : R0 = 0
			tmp(1) := LDI  &  R1  &  '0'  &  x"01";	-- LDI $1, R1 	# R1 = 1
			tmp(2) := LDI  &  R2  &  '0'  &  x"09";	-- LDI $9, R2 	# R2 = 9
			tmp(3) := LDI  &  R3  &  '0'  &  x"0a";	-- LDI $10, R3 	# R3 = 10
			tmp(4) := STA  &  R0  &  '1'  &  x"00";	-- STA @256, R0 	# Armazena o valor do acumulador em no LEDR0 ~ LEDR7
			tmp(5) := STA  &  R0  &  '1'  &  x"01";	-- STA @257, R0 	# Armazena o valor do acumulador no LEDR8
			tmp(6) := STA  &  R0  &  '1'  &  x"02";	-- STA @258, R0 	# Armazena o valor do acumulador em LEDR9
			tmp(7) := STA  &  R0  &  '1'  &  x"20";	-- STA @288, R0 	# Armazena o valor do acumulador em HEX0
			tmp(8) := STA  &  R0  &  '1'  &  x"21";	-- STA @289, R0 	# Armazena o valor do acumulador em HEX1
			tmp(9) := STA  &  R0  &  '1'  &  x"22";	-- STA @290, R0 	# Armazena o valor do acumulador em HEX2
			tmp(10) := STA  &  R0  &  '1'  &  x"23";	-- STA @291, R0 	# Armazena o valor do acumulador em HEX3
			tmp(11) := STA  &  R0  &  '1'  &  x"24";	-- STA @292, R0 	# Armazena o valor do acumulador em HEX4
			tmp(12) := STA  &  R0  &  '1'  &  x"25";	-- STA @293, R0 	# Armazena o valor do acumulador em HEX5
			tmp(13) := STA  &  R0  &  '0'  &  x"00";	-- STA @0, R0 	# Armazena o valor do acumulador em MEM[0] (unidades)
			tmp(14) := STA  &  R0  &  '0'  &  x"01";	-- STA @1, R0 	# Armazena o valor do acumulador em MEM[1] (dezenas)
			tmp(15) := STA  &  R0  &  '0'  &  x"02";	-- STA @2, R0 	# Armazena o valor do acumulador em MEM[2] (centenas)
			tmp(16) := STA  &  R0  &  '0'  &  x"03";	-- STA @3, R0 	# Armazena o valor do acumulador em MEM[3] (milhar)
			tmp(17) := STA  &  R0  &  '0'  &  x"04";	-- STA @4, R0 	# Armazena o valor do acumulador em MEM[4] (dezenas de milhar)
			tmp(18) := STA  &  R0  &  '0'  &  x"05";	-- STA @5, R0 	# Armazena o valor do acumulador em MEM[5] (centenas de milhar)
			tmp(19) := STA  &  R0  &  '0'  &  x"06";	-- STA @6, R0 	# Armazena o valor do acumulador em MEM[6] (flag de inibir contagem)
			tmp(20) := STA  &  R0  &  '0'  &  x"07";	-- STA @7, R0 
			tmp(21) := STA  &  R1  &  '0'  &  x"08";	-- STA @8, R1 	# Armazena o valor do acumulador em MEM[8] (vari�vel 1 para incremento)
			tmp(22) := STA  &  R3  &  '0'  &  x"09";	-- STA @9, R3 	# Armazena o valor do acumulador em MEM[9] (vari�vel 10 para compara��es)
			tmp(23) := STA  &  R2  &  '0'  &  x"0a";	-- STA @10, R2 	# Armazena o valor do acumulador em MEM[10] (valor limite para UNIDADE)
			tmp(24) := STA  &  R2  &  '0'  &  x"0b";	-- STA @11, R2 	# Armazena o valor do acumulador em MEM[11] (valor limite para DEZENA)
			tmp(25) := STA  &  R2  &  '0'  &  x"0c";	-- STA @12, R2 	# Armazena o valor do acumulador em MEM[12] (valor limite para CENTENA)
			tmp(26) := STA  &  R2  &  '0'  &  x"0d";	-- STA @13, R2 	# Armazena o valor do acumulador em MEM[13] (valor limite para MILHAR)
			tmp(27) := STA  &  R2  &  '0'  &  x"0e";	-- STA @14, R2 	# Armazena o valor do acumulador em MEM[14] (valor limite para DEZENA DE MILHAR)
			tmp(28) := STA  &  R2  &  '0'  &  x"0f";	-- STA @15, R2 	# Armazena o valor do acumulador em MEM[15] (valor limite para CENTENA DE MILHAR )
			tmp(29) := NOP  &  R0  &  '0'  &  x"00";	-- NOP 	# LOOP PRINCIPAL
			tmp(30) := LDA  &  R0  &  '0'  &  x"06";	-- LDA @6, R0 	# Carregando o acumulador com o valor da flag de inibir
			tmp(31) := CEQ  &  R0  &  '0'  &  x"08";	-- CEQ @8, R0 	# Compara com 1 para ver se a flag est� ativada
			tmp(32) := JEQ  &  R0  &  '0'  &  x"27";	-- JEQ @39, R0 	# Se for igual, pula pra leitura de config limite
			tmp(33) := LDA  &  R0  &  '1'  &  x"60";	-- LDA @352, R0 	# Carrega o acumulador com a leitura do bot�o KEY0
			tmp(34) := ANDI  &  R0  &  '0'  &  x"01";	-- ANDI @1, R0 	#M�scara na leitura do bot�o
			tmp(35) := CEQ  &  R0  &  '0'  &  x"07";	-- CEQ @7, R0 	# Compara com 0, se igual 0 -> bot�o n�o apertado. igual a 1 -> vai pra contagem
			tmp(36) := JEQ  &  R0  &  '0'  &  x"27";	-- JEQ @39  	# Se for 0, vai ler a proxima chave
			tmp(37) := JSR  &  R0  &  '0'  &  x"3c";	-- JSR @INCREMENTO    	# Se for 1, vai pra sub-rotina de incremento
			tmp(38) := NOP  &  R0  &  '0'  &  x"00";	-- NOP      	# Aqui � onde o RET volta
			tmp(39) := LDA  &  R1  &  '1'  &  x"61";	-- LDA @353, R1  	# Carrega o acumulador com a leitura do bot�o KEY1
			tmp(40) := ANDI  &  R1  &  '0'  &  x"01";	-- ANDI @1, R1 	#M�scara na leitura do bot�o
			tmp(41) := CEQ  &  R1  &  '0'  &  x"07";	-- CEQ @7, R1 	# Compara com 0, se igual 0 -> bot�o n�o apertado. igual a 1 -> vai pra configuracao do limite de contagem
			tmp(42) := JEQ  &  R0  &  '0'  &  x"2d";	-- JEQ @45 	# Se for 0, vai pro LIMITE - JSR DE BAIXO
			tmp(43) := JSR  &  R0  &  '0'  &  x"79";	-- JSR @CONFIG_LIMITE     	# Se for 1, vai pra sub-rotina de configuracao
			tmp(44) := NOP  &  R0  &  '0'  &  x"00";	-- NOP      	# Onde o RET volta
			tmp(45) := JSR  &  R0  &  '0'  &  x"b3";	-- JSR @CONFERE_LIMITE    	# Chama a sub rotina para verificar o limite
			tmp(46) := NOP  &  R0  &  '0'  &  x"00";	-- NOP 	# Aqui � onde o RET volta
			tmp(47) := LDA  &  R1  &  '1'  &  x"62";	-- LDA @354, R1 	# Carrega o acumulador com a leitura do bot�o KEY2
			tmp(48) := ANDI  &  R1  &  '0'  &  x"01";	-- ANDI @1, R1 	# Depois de fazer a leitura do bot�o aplica a m�scara
			tmp(49) := CEQ  &  R1  &  '0'  &  x"07";	-- CEQ @7, R1 	# Compara com 0, se igual 0 -> bot�o n�o apertado. igual a 1 -> vai pra contagem
			tmp(50) := JEQ  &  R0  &  '0'  &  x"35";	-- JEQ @53  	# Se for 0, vai ler a proxima chave
			tmp(51) := JSR  &  R0  &  '0'  &  x"e8";	-- JSR @DECREMENTO  	# Se for 1, vai pra sub-rotina de incremento
			tmp(52) := NOP  &  R0  &  '0'  &  x"00";	-- NOP      	# Aqui � onde o RET volta
			tmp(53) := LDA  &  R3  &  '1'  &  x"64";	-- LDA @356, R3 	# Carrega o acumulador com a leitura do bot�o FPGA_RESET 
			tmp(54) := ANDI  &  R3  &  '0'  &  x"01";	-- ANDI @1, R3 	#M�scara na leitura do bot�o
			tmp(55) := CEQ  &  R3  &  '0'  &  x"08";	-- CEQ @8, R3    	# Compara com 1
			tmp(56) := JEQ  &  R0  &  '0'  &  x"3a";	-- JEQ @58  	# Se for 1, da� vai pra subrotina pra reiniciar a contagem
			tmp(57) := JSR  &  R0  &  '0'  &  x"d0";	-- JSR @REINICIAR_CONTAGEM
			tmp(58) := JSR  &  R0  &  '0'  &  x"db";	-- JSR @ATUALIZA_SEVEN_SEG
			tmp(59) := JMP  &  R0  &  '0'  &  x"1d";	-- JMP @LOOP_PRINCIPAL
			tmp(60) := STA  &  R0  &  '1'  &  x"ff";	-- STA @511, R0 	# Limpa a leitura do bot�o
			tmp(61) := LDA  &  R1  &  '0'  &  x"06";	-- LDA @6, R1 	# Carrega o valor da flag de inibir contagem
			tmp(62) := CEQ  &  R1  &  '0'  &  x"08";	-- CEQ @8, R1 	# Compara com 1 para ver se a flag est� ativada
			tmp(63) := JEQ  &  R0  &  '0'  &  x"78";	-- JEQ @120 	#Se for 1, n�o incrementa e vai pro RET
			tmp(64) := LDA  &  R0  &  '0'  &  x"00";	-- LDA @0, R0 	# Carrega o valor das unidades
			tmp(65) := SOMA  &  R0  &  '0'  &  x"08";	-- SOMA @8, R0 	# Soma com 1
			tmp(66) := CEQ  &  R0  &  '0'  &  x"09";	-- CEQ @9, R0 	# Compara com 10
			tmp(67) := JEQ  &  R0  &  '0'  &  x"46";	-- JEQ @INC_DEZENA 	# Se for 10, vai para a dezena
			tmp(68) := STA  &  R0  &  '0'  &  x"00";	-- STA @0, R0 	# Armazena o valor das unidades
			tmp(69) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# E retorna
			tmp(70) := LDA  &  R0  &  '0'  &  x"07";	-- LDA @7, R0 	#Carrega 0 no REG
			tmp(71) := STA  &  R0  &  '0'  &  x"00";	-- STA @0, R0 	# Carrega 0 nas unidades
			tmp(72) := LDA  &  R0  &  '0'  &  x"01";	-- LDA @1, R0 	#Carrega o valor das dezenas
			tmp(73) := SOMA  &  R0  &  '0'  &  x"08";	-- SOMA @8, R0 	# Soma com 1
			tmp(74) := CEQ  &  R0  &  '0'  &  x"09";	-- CEQ @9, R0 	# Compara com 10
			tmp(75) := JEQ  &  R0  &  '0'  &  x"4e";	-- JEQ @INC_CENTENA 	# Se for 10, vai para a centena
			tmp(76) := STA  &  R0  &  '0'  &  x"01";	-- STA @1, R0 	#Armazena o valor das dezenas
			tmp(77) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# E retorna
			tmp(78) := LDA  &  R0  &  '0'  &  x"07";	-- LDA @7, R0 	#Carrega 0 no REG
			tmp(79) := STA  &  R0  &  '0'  &  x"01";	-- STA @1, R0 	# Carrega 0 nas dezenas
			tmp(80) := LDA  &  R0  &  '0'  &  x"02";	-- LDA @2, R0 	# Carrega o valor das centenas
			tmp(81) := SOMA  &  R0  &  '0'  &  x"08";	-- SOMA @8, R0 	# Soma com 1
			tmp(82) := CEQ  &  R0  &  '0'  &  x"09";	-- CEQ @9, R0 	# Compara com 10
			tmp(83) := JEQ  &  R0  &  '0'  &  x"56";	-- JEQ @INC_MILHAR 	# Se for 10, vai para a milhar
			tmp(84) := STA  &  R0  &  '0'  &  x"02";	-- STA @2, R0 	# Armazena o valor das centenas
			tmp(85) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# E retorna
			tmp(86) := LDA  &  R0  &  '0'  &  x"07";	-- LDA @7, R0 	#Carrega 0 no REG
			tmp(87) := STA  &  R0  &  '0'  &  x"02";	-- STA @2, R0 	# Carrega 0 nas centenas
			tmp(88) := LDA  &  R0  &  '0'  &  x"03";	-- LDA @3, R0 	#  Carrega o valor dos milhares
			tmp(89) := SOMA  &  R0  &  '0'  &  x"08";	-- SOMA @8, R0 	# Soma com 1
			tmp(90) := CEQ  &  R0  &  '0'  &  x"09";	-- CEQ @9, R0 	# Compara com 10
			tmp(91) := JEQ  &  R0  &  '0'  &  x"5e";	-- JEQ @INC_DEZMILHAR 	#  Se for 10, vai para a dezena de milhar
			tmp(92) := STA  &  R0  &  '0'  &  x"03";	-- STA @3, R0 	# Armazena o valor dos milhares
			tmp(93) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# E retorna
			tmp(94) := LDA  &  R0  &  '0'  &  x"07";	-- LDA @7, R0 	#Carrega 0 no REG
			tmp(95) := STA  &  R0  &  '0'  &  x"03";	-- STA @3, R0 	# Carrega 0 no milhar
			tmp(96) := LDA  &  R0  &  '0'  &  x"04";	-- LDA @4, R0 	# Carrega o valor das dezenas de milhar
			tmp(97) := SOMA  &  R0  &  '0'  &  x"08";	-- SOMA @8, R0 	# Soma com 1
			tmp(98) := CEQ  &  R0  &  '0'  &  x"09";	-- CEQ @9, R0 	# Compara com 10
			tmp(99) := JEQ  &  R0  &  '0'  &  x"66";	-- JEQ @INC_CENTMILHAR 	# Se for 10, vai para a centena de milhar
			tmp(100) := STA  &  R0  &  '0'  &  x"04";	-- STA @4, R0 	# Armazena o valor das dezena de milhar
			tmp(101) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# E retorna
			tmp(102) := LDA  &  R0  &  '0'  &  x"07";	-- LDA @7, R0 	#Carrega 0 no REG
			tmp(103) := STA  &  R0  &  '0'  &  x"04";	-- STA @4, R0 	# Carrega 0 nas dezenas de milhar
			tmp(104) := LDA  &  R0  &  '0'  &  x"05";	-- LDA @5, R0 	#Carrega o valor das centenas de milhar
			tmp(105) := SOMA  &  R0  &  '0'  &  x"08";	-- SOMA @8, R0 	# Soma com 1
			tmp(106) := CEQ  &  R0  &  '0'  &  x"09";	-- CEQ @9, R0 	# Compara com 10
			tmp(107) := JEQ  &  R0  &  '0'  &  x"6e";	-- JEQ @OVERFLOW 	# Se for 10, vai para o overflow
			tmp(108) := STA  &  R0  &  '0'  &  x"05";	-- STA @5, R0 	# Armazena o valor das centena de milhar
			tmp(109) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# E retorna
			tmp(110) := LDA  &  R2  &  '0'  &  x"08";	-- LDA @8, R2 	# Carrega o valor 1
			tmp(111) := STA  &  R2  &  '0'  &  x"06";	-- STA @6, R2 	# Armazena o valor 1 na flag de inibir contagem
			tmp(112) := STA  &  R2  &  '1'  &  x"02";	-- STA @258, R2 	# Armazena o valor 1 no LEDR9 indicando OVERFLOW
			tmp(113) := LDI  &  R3  &  '0'  &  x"09";	-- LDI $9, R3 	# N�o deixar somar, voltar pro m�ximo m�ximo permitido
			tmp(114) := STA  &  R3  &  '0'  &  x"00";	-- STA @0, R3 	#Guarda 9 nas unidades
			tmp(115) := STA  &  R3  &  '0'  &  x"01";	-- STA @1, R3 	#Guarda 9 nas dezenas
			tmp(116) := STA  &  R3  &  '0'  &  x"02";	-- STA @2, R3 	#Guarda 9 nas centenas
			tmp(117) := STA  &  R3  &  '0'  &  x"03";	-- STA @3, R3 	#Guarda 9 nos milhares
			tmp(118) := STA  &  R3  &  '0'  &  x"04";	-- STA @4, R3 	#Guarda 9 nas dezenas de milhar
			tmp(119) := STA  &  R3  &  '0'  &  x"05";	-- STA @5, R3 	#Guarda 9 nas centenas de milhar
			tmp(120) := RET  &  R0  &  '0'  &  x"00";	-- RET
			tmp(121) := STA  &  R0  &  '1'  &  x"fe";	-- STA @510, R0 	# Para limpar a leitura do bot�o 1
			tmp(122) := LDA  &  R1  &  '0'  &  x"08";	-- LDA @8, R1  	# Carrega 1
			tmp(123) := STA  &  R1  &  '1'  &  x"00";	-- STA @256, R1 	# Liga o LED 0 ~ 7 dizendo que est� pronto pra ler a chave das unidades
			tmp(124) := LDA  &  R0  &  '1'  &  x"61";	-- LDA @353, R0 	# Guarda a leitura de KEY1
			tmp(125) := ANDI  &  R0  &  '0'  &  x"01";	-- ANDI @1, R0 	# Depois de fazer a leitura do bot�o aplica a m�scara
			tmp(126) := CEQ  &  R0  &  '0'  &  x"07";	-- CEQ @7, R0 	#Compara com o valor 0
			tmp(127) := LDA  &  R2  &  '1'  &  x"40";	-- LDA @320, R2 	# L� as chaves e salva o valor no REG
			tmp(128) := JEQ  &  R0  &  '0'  &  x"7a";	-- JEQ @LIM_UNIDADE
			tmp(129) := STA  &  R2  &  '0'  &  x"0a";	-- STA @10, R2 	# Guarda o valor limite nas unidades
			tmp(130) := STA  &  R0  &  '1'  &  x"fe";	-- STA @510, R0 	# Para limpar a leitura do bot�o 1
			tmp(131) := LDI  &  R1  &  '0'  &  x"02";	-- LDI $2, R1 	# Carrega 2
			tmp(132) := STA  &  R1  &  '1'  &  x"00";	-- STA @256, R1 	# Liga o LED 0 ~ 7 dizendo que est� pronto pra ler a chave das unidades
			tmp(133) := LDA  &  R0  &  '1'  &  x"61";	-- LDA @353, R0 	# Guarda a leitura de KEY1
			tmp(134) := ANDI  &  R0  &  '0'  &  x"01";	-- ANDI @1, R0 	# Depois de fazer a leitura do bot�o aplica a m�scara
			tmp(135) := CEQ  &  R0  &  '0'  &  x"07";	-- CEQ @7, R0 	#Compara com o valor 0
			tmp(136) := LDA  &  R2  &  '1'  &  x"40";	-- LDA @320, R2 	# L� de novo o valor das chaves e salva no REG
			tmp(137) := JEQ  &  R0  &  '0'  &  x"83";	-- JEQ @LIM_DEZENA 	# Volta pro inicio desse bloco
			tmp(138) := STA  &  R2  &  '0'  &  x"0b";	-- STA @11, R2 	# Guarda o valor limite nas dezenas
			tmp(139) := STA  &  R0  &  '1'  &  x"fe";	-- STA @510, R0 	# Para limpar a leitura do bot�o 1
			tmp(140) := LDI  &  R1  &  '0'  &  x"04";	-- LDI $4, R1 	# Carrega 4
			tmp(141) := STA  &  R1  &  '1'  &  x"00";	-- STA @256, R1 	# Liga o LED 0 ~ 7 dizendo que est� pronto pra ler a chave das unidades
			tmp(142) := LDA  &  R0  &  '1'  &  x"61";	-- LDA @353, R0 	# Guarda a leitura de KEY1
			tmp(143) := ANDI  &  R0  &  '0'  &  x"01";	-- ANDI @1, R0 	# Depois de fazer a leitura do bot�o aplica a m�scara
			tmp(144) := CEQ  &  R0  &  '0'  &  x"07";	-- CEQ @7, R0 	#Compara com o valor 0
			tmp(145) := LDA  &  R2  &  '1'  &  x"40";	-- LDA @320, R2 	# L� de novo o valor das chaves e salva no REG
			tmp(146) := JEQ  &  R0  &  '0'  &  x"8c";	-- JEQ @LIM_CENTENA  	# Volta pro inicio desse bloco
			tmp(147) := STA  &  R2  &  '0'  &  x"0c";	-- STA @12, R2 	# Guarda o valor limite nas centenas
			tmp(148) := STA  &  R0  &  '1'  &  x"fe";	-- STA @510, R0 	# Para limpar a leitura do bot�o 1
			tmp(149) := LDI  &  R1  &  '0'  &  x"08";	-- LDI $8, R1 	# Carrega 8
			tmp(150) := STA  &  R1  &  '1'  &  x"00";	-- STA @256, R1 	# Liga o LED 0 ~ 7 dizendo que est� pronto pra ler a chave das unidades
			tmp(151) := LDA  &  R0  &  '1'  &  x"61";	-- LDA @353, R0 	# Guarda a leitura de KEY1
			tmp(152) := ANDI  &  R0  &  '0'  &  x"01";	-- ANDI @1, R0 	# Depois de fazer a leitura do bot�o aplica a m�scara
			tmp(153) := CEQ  &  R0  &  '0'  &  x"07";	-- CEQ @7, R0 	#Compara com o valor 0
			tmp(154) := LDA  &  R2  &  '1'  &  x"40";	-- LDA @320, R2 	# L� de novo o valor das chaves e salva no REG
			tmp(155) := JEQ  &  R0  &  '0'  &  x"95";	-- JEQ @LIM_MILHAR
			tmp(156) := STA  &  R2  &  '0'  &  x"0d";	-- STA @13, R2 	# Guarda o valor limite nos milhares
			tmp(157) := STA  &  R0  &  '1'  &  x"fe";	-- STA @510, R0 	# Para limpar a leitura do bot�o 1 
			tmp(158) := LDI  &  R1  &  '0'  &  x"10";	-- LDI $16, R1 	# Carrega 16
			tmp(159) := STA  &  R1  &  '1'  &  x"00";	-- STA @256, R1 	# Liga o LED 0 ~ 7 dizendo que est� pronto pra ler a chave das unidades
			tmp(160) := LDA  &  R0  &  '1'  &  x"61";	-- LDA @353, R0 	# Guarda a leitura de KEY1
			tmp(161) := ANDI  &  R0  &  '0'  &  x"01";	-- ANDI @1, R0 	# Depois de fazer a leitura do bot�o aplica a m�scara
			tmp(162) := CEQ  &  R0  &  '0'  &  x"07";	-- CEQ @7, R0 	#Compara com o valor 0
			tmp(163) := LDA  &  R2  &  '1'  &  x"40";	-- LDA @320, R2 	# L� de novo o valor das chaves e salva no REG
			tmp(164) := JEQ  &  R0  &  '0'  &  x"9e";	-- JEQ @LIM_DEZMILHAR
			tmp(165) := STA  &  R2  &  '0'  &  x"0e";	-- STA @14, R2 	# Guarda o valor limite nas dezena de milhar
			tmp(166) := STA  &  R0  &  '1'  &  x"fe";	-- STA @510, R0 	# Para limpar a leitura do bot�o 1
			tmp(167) := LDI  &  R1  &  '0'  &  x"20";	-- LDI $32, R1 	# Carrega 32
			tmp(168) := STA  &  R1  &  '1'  &  x"00";	-- STA @256, R1 	# Liga o LED 0 ~ 7 dizendo que est� pronto pra ler a chave das unidades
			tmp(169) := LDA  &  R0  &  '1'  &  x"61";	-- LDA @353, R0 	# Guarda a leitura de KEY1
			tmp(170) := ANDI  &  R0  &  '0'  &  x"01";	-- ANDI @1, R0 	# Depois de fazer a leitura do bot�o aplica a m�scara
			tmp(171) := CEQ  &  R0  &  '0'  &  x"07";	-- CEQ @7, R0 	#Compara com o valor 0
			tmp(172) := LDA  &  R2  &  '1'  &  x"40";	-- LDA @320, R2 	# L� de novo o valor das chaves e salva no REG
			tmp(173) := JEQ  &  R0  &  '0'  &  x"a7";	-- JEQ @LIM_CENTMILHAR
			tmp(174) := STA  &  R2  &  '0'  &  x"0f";	-- STA @15, R2 	# Guarda o valor limite nas centenas de milhar
			tmp(175) := STA  &  R0  &  '1'  &  x"fe";	-- STA @510, R0 	# Para limpar a leitura do bot�o 1
			tmp(176) := LDA  &  R3  &  '0'  &  x"07";	-- LDA @7, R3 	# Carrega o 0 
			tmp(177) := STA  &  R3  &  '1'  &  x"00";	-- STA @256, R3 	# Desliga os LEDS
			tmp(178) := RET  &  R0  &  '0'  &  x"00";	-- RET
			tmp(179) := NOP  &  R0  &  '0'  &  x"00";	-- NOP 	# Aqui come�a a confer�ncia dos limites
			tmp(180) := LDA  &  R0  &  '0'  &  x"00";	-- LDA @0, R0 	# Carrega o valor das unidades
			tmp(181) := CEQ  &  R0  &  '0'  &  x"0a";	-- CEQ @10, R0 	# Compara com o limite de unidades
			tmp(182) := JEQ  &  R0  &  '0'  &  x"b8";	-- JEQ @CONFERE_LIMITE_DEZENA 	# Se for 0, vai para a dezena
			tmp(183) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# Caso o contr�rio j� retorna
			tmp(184) := LDA  &  R1  &  '0'  &  x"01";	-- LDA @1, R1 	# Carrega o valor das dezenas
			tmp(185) := CEQ  &  R1  &  '0'  &  x"0b";	-- CEQ @11, R1 	# Compara com o limite de dezenas
			tmp(186) := JEQ  &  R0  &  '0'  &  x"bc";	-- JEQ @CONFERE_LIMITE_CENTENA 	# Se for 0, vai para a centena
			tmp(187) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# Caso o contr�rio j� retorna
			tmp(188) := LDA  &  R2  &  '0'  &  x"02";	-- LDA @2, R2 	#Carrega o valor das centenas
			tmp(189) := CEQ  &  R2  &  '0'  &  x"0c";	-- CEQ @12, R2 	#Compara com o limite das centenas
			tmp(190) := JEQ  &  R0  &  '0'  &  x"c0";	-- JEQ @CONFERE_LIMITE_MILHAR 	# Se for 0, vai para os milhares
			tmp(191) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# Caso o contr�rio j� retorna
			tmp(192) := LDA  &  R3  &  '0'  &  x"03";	-- LDA @3, R3 	#Carrega o valor dos milhares
			tmp(193) := CEQ  &  R3  &  '0'  &  x"0d";	-- CEQ @13, R3 	#Compara com o limite dos milhares
			tmp(194) := JEQ  &  R0  &  '0'  &  x"c4";	-- JEQ @CONFERE_LIMITE_DEZMILHAR 	# Se for 0, vai para as dezenas de milhr
			tmp(195) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# Caso o contr�rio j� retorna
			tmp(196) := LDA  &  R0  &  '0'  &  x"04";	-- LDA @4, R0 	#Carrega o valor das dezenas de milhar
			tmp(197) := CEQ  &  R0  &  '0'  &  x"0e";	-- CEQ @14, R0 	#Compara com o limite das dezenas de milhar
			tmp(198) := JEQ  &  R0  &  '0'  &  x"c8";	-- JEQ @CONFERE_LIMITE_CENTMILHAR 	# Se for 0, vai para as centenas de milhar
			tmp(199) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# Caso o contr�rio j� retorna
			tmp(200) := LDA  &  R1  &  '0'  &  x"05";	-- LDA @5, R1 	#Carrega as dezenas de centenas de milhar
			tmp(201) := CEQ  &  R1  &  '0'  &  x"0f";	-- CEQ @15, R1 	#Compara com o limite das centenas de milhar
			tmp(202) := JEQ  &  R0  &  '0'  &  x"cc";	-- JEQ @ATIVAR_FLAG_INIBIR_CONTAGEM 	# Se for 0, vai ativar a flag de inibir a contagem
			tmp(203) := RET  &  R0  &  '0'  &  x"00";	-- RET 	# Caso o contr�rio j� retorna
			tmp(204) := LDA  &  R2  &  '0'  &  x"08";	-- LDA @8, R2 	# Carrega o valor 1
			tmp(205) := STA  &  R2  &  '1'  &  x"01";	-- STA @257, R2 	# Armazena o valor 1 no LED8
			tmp(206) := STA  &  R2  &  '0'  &  x"06";	-- STA @6, R2 	#  Armazena o valor 1 na flag de inibir contagem
			tmp(207) := RET  &  R0  &  '0'  &  x"00";	-- RET
			tmp(208) := LDA  &  R0  &  '0'  &  x"07";	-- LDA @7 	# Carrega o acumulador com o valor 0
			tmp(209) := STA  &  R0  &  '0'  &  x"00";	-- STA @0 	#  Armazena o valor 0 nas unidades
			tmp(210) := STA  &  R0  &  '0'  &  x"01";	-- STA @1 	#  Armazena o valor 0 nas dezenas
			tmp(211) := STA  &  R0  &  '0'  &  x"02";	-- STA @2 	#  Armazena o valor 0 nas centenas
			tmp(212) := STA  &  R0  &  '0'  &  x"03";	-- STA @3 	#  Armazena o valor 0 nos milhares
			tmp(213) := STA  &  R0  &  '0'  &  x"04";	-- STA @4 	#  Armazena o valor 0 nas dezenas de milhar
			tmp(214) := STA  &  R0  &  '0'  &  x"05";	-- STA @5 	#  Armazena o valor 0 nas centenas de milhar
			tmp(215) := STA  &  R0  &  '0'  &  x"06";	-- STA @6 	# Armazena o valor 0 na flag de inibir contagem
			tmp(216) := STA  &  R0  &  '1'  &  x"01";	-- STA @257 	# Armazena o valor 0 no LED8
			tmp(217) := STA  &  R0  &  '1'  &  x"02";	-- STA @258 	# Armazena o valor 0 no LED9
			tmp(218) := RET  &  R0  &  '0'  &  x"00";	-- RET
			tmp(219) := LDA  &  R0  &  '0'  &  x"00";	-- LDA @0, R0 	# Carrega o valor das unidades
			tmp(220) := STA  &  R0  &  '1'  &  x"20";	-- STA @288, R0 	# Guarda o valor das unidades no HEX0
			tmp(221) := LDA  &  R0  &  '0'  &  x"01";	-- LDA @1, R0 	# Carrega o valor das dezenas
			tmp(222) := STA  &  R0  &  '1'  &  x"21";	-- STA @289, R0 	# Guarda o valor das dezenas no HEX1
			tmp(223) := LDA  &  R0  &  '0'  &  x"02";	-- LDA @2, R0 	# Carrega o valor das centenas
			tmp(224) := STA  &  R0  &  '1'  &  x"22";	-- STA @290, R0 	# Guarda o valor das centenas no HEX2
			tmp(225) := LDA  &  R0  &  '0'  &  x"03";	-- LDA @3, R0 	# Carrega o valor dos milhares
			tmp(226) := STA  &  R0  &  '1'  &  x"23";	-- STA @291, R0 	# Guarda o valor do milhar no HEX3
			tmp(227) := LDA  &  R0  &  '0'  &  x"04";	-- LDA @4, R0 	# Carrega o valor das dezenas de milhar
			tmp(228) := STA  &  R0  &  '1'  &  x"24";	-- STA @292, R0 	# Guarda o valor das dezenas de milhar no HEX4
			tmp(229) := LDA  &  R0  &  '0'  &  x"05";	-- LDA @5, R0 	# Carrega o valor das centenas de milhar
			tmp(230) := STA  &  R0  &  '1'  &  x"25";	-- STA @293, R0 	# Guarda o valor das centenas de milhar no HEX5
			tmp(231) := RET  &  R0  &  '0'  &  x"00";	-- RET
			tmp(232) := STA  &  R0  &  '1'  &  x"fc";	-- STA @508, R0 	# Limpa a leitura do bot�o
			tmp(233) := LDA  &  R1  &  '0'  &  x"07";	-- LDA @7, R1 	#Carrega o 0 no registrador
			tmp(234) := STA  &  R1  &  '0'  &  x"06";	-- STA @6, R1 	# Armazena o valor 0 na flag de inibir contagem
			tmp(235) := STA  &  R1  &  '1'  &  x"01";	-- STA @257, R1 	# Armazena o valor 0 no LED8
			tmp(236) := LDA  &  R2  &  '0'  &  x"00";	-- LDA @0, R2 	# Carrega o valor das unidades
			tmp(237) := CEQ  &  R2  &  '0'  &  x"07";	-- CEQ @7, R2 	# Compara com 0
			tmp(238) := JEQ  &  R0  &  '0'  &  x"f2";	-- JEQ @DEC_DEZENA 	# Se for 0, vai para a dezenas
			tmp(239) := SUB  &  R2  &  '0'  &  x"08";	-- SUB @8, R2 	# Se n�o, subtrai 1
			tmp(240) := STA  &  R2  &  '0'  &  x"00";	-- STA @0, R2 	# Armazena o valor das unidades
			tmp(241) := RET  &  R0  &  '0'  &  x"00";	-- RET
			tmp(242) := LDI  &  R3  &  '0'  &  x"09";	-- LDI $9, R3 	# Carrega o valor 9 no imediato
			tmp(243) := STA  &  R3  &  '0'  &  x"00";	-- STA @0, R3 	# Armazena o valor 9 nas unidades
			tmp(244) := LDA  &  R0  &  '0'  &  x"01";	-- LDA @1, R0 	# Carrega o valor das dezenas
			tmp(245) := CEQ  &  R0  &  '0'  &  x"07";	-- CEQ @7, R0 	# Compara com 0
			tmp(246) := JEQ  &  R0  &  '0'  &  x"fa";	-- JEQ @DEC_CENTENA 	# Se for 0, vai para as centenas
			tmp(247) := SUB  &  R0  &  '0'  &  x"08";	-- SUB @8, R0 	# Se n�o, subtrai 1
			tmp(248) := STA  &  R0  &  '0'  &  x"01";	-- STA @1, R0 	# Armazena o valor das dezenas
			tmp(249) := RET  &  R0  &  '0'  &  x"00";	-- RET
			tmp(250) := LDI  &  R0  &  '0'  &  x"09";	-- LDI $9, R0 	# Carrega o valor 9 no imediato
			tmp(251) := STA  &  R0  &  '0'  &  x"01";	-- STA @1, R0 	# Armazena o valor 9 nas dezenas
			tmp(252) := LDA  &  R1  &  '0'  &  x"02";	-- LDA @2, R1 	# Carrega o valor das centenas
			tmp(253) := CEQ  &  R1  &  '0'  &  x"07";	-- CEQ @7, R1 	# Compara com 0
			tmp(254) := JEQ  &  R0  &  '1'  &  x"02";	-- JEQ @DEC_MILHAR 	# Se for 0, vai para os milhares
			tmp(255) := SUB  &  R1  &  '0'  &  x"08";	-- SUB @8, R1 	# Se n�o, subtrai 1
			tmp(256) := STA  &  R1  &  '0'  &  x"02";	-- STA @2, R1 	# Armazena o valor das centenas
			tmp(257) := RET  &  R0  &  '0'  &  x"00";	-- RET
			tmp(258) := LDI  &  R2  &  '0'  &  x"09";	-- LDI $9, R2 	# Carrega o valor 9 no imediato
			tmp(259) := STA  &  R2  &  '0'  &  x"02";	-- STA @2, R2 	#  Armazena o valor 9 nas centenas
			tmp(260) := LDA  &  R3  &  '0'  &  x"03";	-- LDA @3, R3 	# Carrega o valor dos milhares
			tmp(261) := CEQ  &  R3  &  '0'  &  x"07";	-- CEQ @7, R3 	# Compara com 0
			tmp(262) := JEQ  &  R0  &  '1'  &  x"0a";	-- JEQ @DEC_DEZMILHAR 	# Se for 0, vai para as dezenas de milhar
			tmp(263) := SUB  &  R3  &  '0'  &  x"08";	-- SUB @8, R3 	# Se n�o, subtrai 1
			tmp(264) := STA  &  R3  &  '0'  &  x"03";	-- STA @3, R3 	# Armazena o valor dos milhares
			tmp(265) := RET  &  R0  &  '0'  &  x"00";	-- RET
			tmp(266) := LDI  &  R1  &  '0'  &  x"09";	-- LDI $9, R1 	# Carrega o valor 9 no imediato
			tmp(267) := STA  &  R1  &  '0'  &  x"03";	-- STA @3, R1 	# Armazena o valor 9 nos milhares
			tmp(268) := LDA  &  R0  &  '0'  &  x"04";	-- LDA @4, R0 	# Carrega o valor das dezenas de milhar
			tmp(269) := CEQ  &  R0  &  '0'  &  x"07";	-- CEQ @7, R0 	# Compara com o 0
			tmp(270) := JEQ  &  R0  &  '1'  &  x"12";	-- JEQ @DEC_CENTMILHAR 	# Se for 0, vai para as centenas de milhares
			tmp(271) := SUB  &  R0  &  '0'  &  x"08";	-- SUB @8, R0 	# Se n�o, subtrai 1 
			tmp(272) := STA  &  R0  &  '0'  &  x"04";	-- STA @4, R0 	# Armazena o valor das dezenas de milhar
			tmp(273) := RET  &  R0  &  '0'  &  x"00";	-- RET
			tmp(274) := LDI  &  R1  &  '0'  &  x"09";	-- LDI $9, R1 	# Carrega o valor 9 no imediato
			tmp(275) := STA  &  R1  &  '0'  &  x"04";	-- STA @4, R1 	# Armazena o valor 9 nas centenas de milhar
			tmp(276) := LDA  &  R2  &  '0'  &  x"05";	-- LDA @5, R2 	# Carrega o valor das centenas de milhar
			tmp(277) := CEQ  &  R2  &  '0'  &  x"07";	-- CEQ @7, R2 	# Compara com 0
			tmp(278) := JEQ  &  R0  &  '1'  &  x"19";	-- JEQ @TUDO_ZERO 	# Se for 0, j� deixa tudo 0
			tmp(279) := SUB  &  R2  &  '0'  &  x"08";	-- SUB @8, R2 	# Se n�o, subtrai 1
			tmp(280) := STA  &  R2  &  '0'  &  x"05";	-- STA @5, R2	# Armazena o valor das centenas de milhar
			tmp(281) := LDA  &  R3  &  '0'  &  x"07";	-- LDA @7, R3 	#Carrega o valor 0
			tmp(282) := STA  &  R3  &  '0'  &  x"00";	-- STA @0, R3 	#Zera as unidades
			tmp(283) := STA  &  R3  &  '0'  &  x"01";	-- STA @1, R3 	#Zera as dezenas
			tmp(284) := STA  &  R3  &  '0'  &  x"02";	-- STA @2, R3 	#Zera as centenas
			tmp(285) := STA  &  R3  &  '0'  &  x"03";	-- STA @3, R3 	#Zera os milhares
			tmp(286) := STA  &  R3  &  '0'  &  x"04";	-- STA @4, R3 	#Zera as dezenas de milhar
			tmp(287) := STA  &  R3  &  '0'  &  x"05";	-- STA @5, R3 	#Zera as centenas de milhar
			tmp(288) := STA  &  R3  &  '1'  &  x"02";	-- STA @258, R3 	# Armazena o valor 0 no LED9
			tmp(289) := STA  &  R3  &  '1'  &  x"01";	-- STA @257, R3 	# Armazena o valor 0 no LED8
			tmp(290) := RET  &  R0  &  '0'  &  x"00";	-- RET
						

		  return tmp;
		  
    end initMemory;

    signal memROM : blocoMemoria := initMemory;

begin
    Dado <= memROM (to_integer(unsigned(Endereco)));
end architecture;