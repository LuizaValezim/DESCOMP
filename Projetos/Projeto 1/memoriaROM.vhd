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
					

			tmp(0) := LDI  &  R0  &  '0'  &  x"00";	
			tmp(1) := LDI  &  R1  &  '0'  &  x"01";	
			tmp(2) := LDI  &  R2  &  '0'  &  x"09";	
			tmp(3) := LDI  &  R3  &  '0'  &  x"0a";	
			tmp(4) := STA  &  R0  &  '1'  &  x"00";	
			tmp(5) := STA  &  R0  &  '1'  &  x"01";	
			tmp(6) := STA  &  R0  &  '1'  &  x"02";	
			tmp(7) := STA  &  R0  &  '1'  &  x"20";	
			tmp(8) := STA  &  R0  &  '1'  &  x"21";	
			tmp(9) := STA  &  R0  &  '1'  &  x"22";	
			tmp(10) := STA  &  R0  &  '1'  &  x"23";	
			tmp(11) := STA  &  R0  &  '1'  &  x"24";	
			tmp(12) := STA  &  R0  &  '1'  &  x"25";	
			tmp(13) := STA  &  R0  &  '0'  &  x"00";	-- MEM[0] -> unidades
			tmp(14) := STA  &  R0  &  '0'  &  x"01";	-- MEM[1] -> dezenas
			tmp(15) := STA  &  R0  &  '0'  &  x"02";	-- MEM[2] -> centenas
			tmp(16) := STA  &  R0  &  '0'  &  x"03";	-- MEM[3] -> unidades de milhares
			tmp(17) := STA  &  R0  &  '0'  &  x"04";	-- MEM[4] -> dezenas de milhar
			tmp(18) := STA  &  R0  &  '0'  &  x"05";	-- MEM[5] -> centenas de milhar
			tmp(19) := STA  &  R0  &  '0'  &  x"06";	-- MEM[6] -> flag de parar contagem
			tmp(20) := STA  &  R0  &  '0'  &  x"07";	-- 
			tmp(21) := STA  &  R1  &  '0'  &  x"08";	-- MEM[8] -> variavel de incremento (1 unidade)
			tmp(22) := STA  &  R3  &  '0'  &  x"09";	-- MEM[9] -> variavel de comparacao (1 dezena)
			tmp(23) := STA  &  R2  &  '0'  &  x"0a";	-- MEM[10] -> limite para unidade
			tmp(24) := STA  &  R2  &  '0'  &  x"0b";	-- MEM[11] -> limite para dezena
			tmp(25) := STA  &  R2  &  '0'  &  x"0c";	-- MEM[12] -> limite para centena
			tmp(26) := STA  &  R2  &  '0'  &  x"0d";	-- MEM[13] -> limite para unidade de milhar
			tmp(27) := STA  &  R2  &  '0'  &  x"0e";	-- MEM[14] -> limite para dezena de milhar
			tmp(28) := STA  &  R2  &  '0'  &  x"0f";	-- MEM[15] -> limite para centena de milhar
			tmp(29) := NOP  &  R0  &  '0'  &  x"00";
			tmp(30) := LDA  &  R0  &  '0'  &  x"06";	
			tmp(31) := CEQ  &  R0  &  '0'  &  x"08";	
			tmp(32) := JEQ  &  R0  &  '0'  &  x"27";	
			tmp(33) := LDA  &  R0  &  '1'  &  x"60";	
			tmp(34) := ANDI  &  R0  &  '0'  &  x"01";
			tmp(35) := CEQ  &  R0  &  '0'  &  x"07";	
			tmp(36) := JEQ  &  R0  &  '0'  &  x"27";	
			tmp(37) := JSR  &  R0  &  '0'  &  x"3c";
			tmp(38) := NOP  &  R0  &  '0'  &  x"00";
			tmp(39) := LDA  &  R1  &  '1'  &  x"61";	
			tmp(40) := ANDI  &  R1  &  '0'  &  x"01";
			tmp(41) := CEQ  &  R1  &  '0'  &  x"07";	
			tmp(42) := JEQ  &  R0  &  '0'  &  x"2d";	
			tmp(43) := JSR  &  R0  &  '0'  &  x"79";	
			tmp(44) := NOP  &  R0  &  '0'  &  x"00";	
			tmp(45) := JSR  &  R0  &  '0'  &  x"b3";	
			tmp(46) := NOP  &  R0  &  '0'  &  x"00";	
			tmp(47) := LDA  &  R1  &  '1'  &  x"62";	
			tmp(48) := ANDI  &  R1  &  '0'  &  x"01";	
			tmp(49) := CEQ  &  R1  &  '0'  &  x"07";	
			tmp(50) := JEQ  &  R0  &  '0'  &  x"35";	
			tmp(51) := JSR  &  R0  &  '0'  &  x"e8";	
			tmp(52) := NOP  &  R0  &  '0'  &  x"00";	
			tmp(53) := LDA  &  R3  &  '1'  &  x"64";	
			tmp(54) := ANDI  &  R3  &  '0'  &  x"01";	
			tmp(55) := CEQ  &  R3  &  '0'  &  x"08";	
			tmp(56) := JEQ  &  R0  &  '0'  &  x"3a";	
			tmp(57) := JSR  &  R0  &  '0'  &  x"d0";	
			tmp(58) := JSR  &  R0  &  '0'  &  x"db";	
			tmp(59) := JMP  &  R0  &  '0'  &  x"1d";	
			tmp(60) := STA  &  R0  &  '1'  &  x"ff";	
			tmp(61) := LDA  &  R1  &  '0'  &  x"06";	
			tmp(62) := CEQ  &  R1  &  '0'  &  x"08";	
			tmp(63) := JEQ  &  R0  &  '0'  &  x"78";	
			tmp(64) := LDA  &  R0  &  '0'  &  x"00";	
			tmp(65) := SOMA  &  R0  &  '0'  &  x"08";	
			tmp(66) := CEQ  &  R0  &  '0'  &  x"09";	
			tmp(67) := JEQ  &  R0  &  '0'  &  x"46";	
			tmp(68) := STA  &  R0  &  '0'  &  x"00";	
			tmp(69) := RET  &  R0  &  '0'  &  x"00";	
			tmp(70) := LDA  &  R0  &  '0'  &  x"07";	
			tmp(71) := STA  &  R0  &  '0'  &  x"00";	
			tmp(72) := LDA  &  R0  &  '0'  &  x"01";	
			tmp(73) := SOMA  &  R0  &  '0'  &  x"08";	
			tmp(74) := CEQ  &  R0  &  '0'  &  x"09";	
			tmp(75) := JEQ  &  R0  &  '0'  &  x"4e";	
			tmp(76) := STA  &  R0  &  '0'  &  x"01";	
			tmp(77) := RET  &  R0  &  '0'  &  x"00";	
			tmp(78) := LDA  &  R0  &  '0'  &  x"07";	
			tmp(79) := STA  &  R0  &  '0'  &  x"01";	
			tmp(80) := LDA  &  R0  &  '0'  &  x"02";	
			tmp(81) := SOMA  &  R0  &  '0'  &  x"08";	
			tmp(82) := CEQ  &  R0  &  '0'  &  x"09";	
			tmp(83) := JEQ  &  R0  &  '0'  &  x"56";	
			tmp(84) := STA  &  R0  &  '0'  &  x"02";	
			tmp(85) := RET  &  R0  &  '0'  &  x"00";	
			tmp(86) := LDA  &  R0  &  '0'  &  x"07";	
			tmp(87) := STA  &  R0  &  '0'  &  x"02";	
			tmp(88) := LDA  &  R0  &  '0'  &  x"03";	
			tmp(89) := SOMA  &  R0  &  '0'  &  x"08";	
			tmp(90) := CEQ  &  R0  &  '0'  &  x"09";	
			tmp(91) := JEQ  &  R0  &  '0'  &  x"5e";	
			tmp(92) := STA  &  R0  &  '0'  &  x"03";	
			tmp(93) := RET  &  R0  &  '0'  &  x"00";	
			tmp(94) := LDA  &  R0  &  '0'  &  x"07";	
			tmp(95) := STA  &  R0  &  '0'  &  x"03";	
			tmp(96) := LDA  &  R0  &  '0'  &  x"04";	
			tmp(97) := SOMA  &  R0  &  '0'  &  x"08";	
			tmp(98) := CEQ  &  R0  &  '0'  &  x"09";	
			tmp(99) := JEQ  &  R0  &  '0'  &  x"66";	
			tmp(100) := STA  &  R0  &  '0'  &  x"04";	
			tmp(101) := RET  &  R0  &  '0'  &  x"00";	
			tmp(102) := LDA  &  R0  &  '0'  &  x"07";	
			tmp(103) := STA  &  R0  &  '0'  &  x"04";	
			tmp(104) := LDA  &  R0  &  '0'  &  x"05";	
			tmp(105) := SOMA  &  R0  &  '0'  &  x"08";	
			tmp(106) := CEQ  &  R0  &  '0'  &  x"09";	
			tmp(107) := JEQ  &  R0  &  '0'  &  x"6e";	
			tmp(108) := STA  &  R0  &  '0'  &  x"05";	
			tmp(109) := RET  &  R0  &  '0'  &  x"00";	
			tmp(110) := LDA  &  R2  &  '0'  &  x"08";	
			tmp(111) := STA  &  R2  &  '0'  &  x"06";	
			tmp(112) := STA  &  R2  &  '1'  &  x"02";	
			tmp(113) := LDI  &  R3  &  '0'  &  x"09";	
			tmp(114) := STA  &  R3  &  '0'  &  x"00";	
			tmp(115) := STA  &  R3  &  '0'  &  x"01";	
			tmp(116) := STA  &  R3  &  '0'  &  x"02";	
			tmp(117) := STA  &  R3  &  '0'  &  x"03";	
			tmp(118) := STA  &  R3  &  '0'  &  x"04";	
			tmp(119) := STA  &  R3  &  '0'  &  x"05";	
			tmp(120) := RET  &  R0  &  '0'  &  x"00";	
			tmp(121) := STA  &  R0  &  '1'  &  x"fe";	
			tmp(122) := LDA  &  R1  &  '0'  &  x"08";	
			tmp(123) := STA  &  R1  &  '1'  &  x"00";	
			tmp(124) := LDA  &  R0  &  '1'  &  x"61";	
			tmp(125) := ANDI  &  R0  &  '0'  &  x"01";	
			tmp(126) := CEQ  &  R0  &  '0'  &  x"07";	
			tmp(127) := LDA  &  R2  &  '1'  &  x"40";
			tmp(128) := JEQ  &  R0  &  '0'  &  x"7a";	
			tmp(129) := STA  &  R2  &  '0'  &  x"0a";	
			tmp(130) := STA  &  R0  &  '1'  &  x"fe";
			tmp(131) := LDI  &  R1  &  '0'  &  x"02";
			tmp(132) := STA  &  R1  &  '1'  &  x"00";	
			tmp(133) := LDA  &  R0  &  '1'  &  x"61";	
			tmp(134) := ANDI  &  R0  &  '0'  &  x"01";	
			tmp(135) := CEQ  &  R0  &  '0'  &  x"07";	
			tmp(136) := LDA  &  R2  &  '1'  &  x"40";	
			tmp(137) := JEQ  &  R0  &  '0'  &  x"83";	
			tmp(138) := STA  &  R2  &  '0'  &  x"0b";	
			tmp(139) := STA  &  R0  &  '1'  &  x"fe";	
			tmp(140) := LDI  &  R1  &  '0'  &  x"04";	
			tmp(141) := STA  &  R1  &  '1'  &  x"00";	
			tmp(142) := LDA  &  R0  &  '1'  &  x"61";	
			tmp(143) := ANDI  &  R0  &  '0'  &  x"01";	
			tmp(144) := CEQ  &  R0  &  '0'  &  x"07";	
			tmp(145) := LDA  &  R2  &  '1'  &  x"40";	
			tmp(146) := JEQ  &  R0  &  '0'  &  x"8c";	
			tmp(147) := STA  &  R2  &  '0'  &  x"0c";	
			tmp(148) := STA  &  R0  &  '1'  &  x"fe";	
			tmp(149) := LDI  &  R1  &  '0'  &  x"08";	
			tmp(150) := STA  &  R1  &  '1'  &  x"00";	
			tmp(151) := LDA  &  R0  &  '1'  &  x"61";	
			tmp(152) := ANDI  &  R0  &  '0'  &  x"01";	
			tmp(153) := CEQ  &  R0  &  '0'  &  x"07";	
			tmp(154) := LDA  &  R2  &  '1'  &  x"40";	
			tmp(155) := JEQ  &  R0  &  '0'  &  x"95";	
			tmp(156) := STA  &  R2  &  '0'  &  x"0d";	
			tmp(157) := STA  &  R0  &  '1'  &  x"fe";	 
			tmp(158) := LDI  &  R1  &  '0'  &  x"10";	
			tmp(159) := STA  &  R1  &  '1'  &  x"00";	
			tmp(160) := LDA  &  R0  &  '1'  &  x"61";	
			tmp(161) := ANDI  &  R0  &  '0'  &  x"01";	
			tmp(162) := CEQ  &  R0  &  '0'  &  x"07";	
			tmp(163) := LDA  &  R2  &  '1'  &  x"40";	
			tmp(164) := JEQ  &  R0  &  '0'  &  x"9e";	
			tmp(165) := STA  &  R2  &  '0'  &  x"0e";	
			tmp(166) := STA  &  R0  &  '1'  &  x"fe";	
			tmp(167) := LDI  &  R1  &  '0'  &  x"20";	
			tmp(168) := STA  &  R1  &  '1'  &  x"00";	
			tmp(169) := LDA  &  R0  &  '1'  &  x"61";	
			tmp(170) := ANDI  &  R0  &  '0'  &  x"01";	
			tmp(171) := CEQ  &  R0  &  '0'  &  x"07";	
			tmp(172) := LDA  &  R2  &  '1'  &  x"40";	
			tmp(173) := JEQ  &  R0  &  '0'  &  x"a7";	
			tmp(174) := STA  &  R2  &  '0'  &  x"0f";	
			tmp(175) := STA  &  R0  &  '1'  &  x"fe";	
			tmp(176) := LDA  &  R3  &  '0'  &  x"07";	
			tmp(177) := STA  &  R3  &  '1'  &  x"00";	
			tmp(178) := RET  &  R0  &  '0'  &  x"00";	
			tmp(179) := NOP  &  R0  &  '0'  &  x"00";	
			tmp(180) := LDA  &  R0  &  '0'  &  x"00";	
			tmp(181) := CEQ  &  R0  &  '0'  &  x"0a";	
			tmp(182) := JEQ  &  R0  &  '0'  &  x"b8";	
			tmp(183) := RET  &  R0  &  '0'  &  x"00";	
			tmp(184) := LDA  &  R1  &  '0'  &  x"01";	
			tmp(185) := CEQ  &  R1  &  '0'  &  x"0b";	
			tmp(186) := JEQ  &  R0  &  '0'  &  x"bc";	
			tmp(187) := RET  &  R0  &  '0'  &  x"00";	
			tmp(188) := LDA  &  R2  &  '0'  &  x"02";	
			tmp(189) := CEQ  &  R2  &  '0'  &  x"0c";	
			tmp(190) := JEQ  &  R0  &  '0'  &  x"c0";	
			tmp(191) := RET  &  R0  &  '0'  &  x"00";	
			tmp(192) := LDA  &  R3  &  '0'  &  x"03";	
			tmp(193) := CEQ  &  R3  &  '0'  &  x"0d";	
			tmp(194) := JEQ  &  R0  &  '0'  &  x"c4";	
			tmp(195) := RET  &  R0  &  '0'  &  x"00";	
			tmp(196) := LDA  &  R0  &  '0'  &  x"04";	
			tmp(197) := CEQ  &  R0  &  '0'  &  x"0e";	
			tmp(198) := JEQ  &  R0  &  '0'  &  x"c8";	
			tmp(199) := RET  &  R0  &  '0'  &  x"00";	
			tmp(200) := LDA  &  R1  &  '0'  &  x"05";	
			tmp(201) := CEQ  &  R1  &  '0'  &  x"0f";	
			tmp(202) := JEQ  &  R0  &  '0'  &  x"cc";	
			tmp(203) := RET  &  R0  &  '0'  &  x"00";	
			tmp(204) := LDA  &  R2  &  '0'  &  x"08";	
			tmp(205) := STA  &  R2  &  '1'  &  x"01";	
			tmp(206) := STA  &  R2  &  '0'  &  x"06";	
			tmp(207) := RET  &  R0  &  '0'  &  x"00";	
			tmp(208) := LDA  &  R0  &  '0'  &  x"07";
			tmp(209) := STA  &  R0  &  '0'  &  x"00";	
			tmp(210) := STA  &  R0  &  '0'  &  x"01";	
			tmp(211) := STA  &  R0  &  '0'  &  x"02";	
			tmp(212) := STA  &  R0  &  '0'  &  x"03";	
			tmp(213) := STA  &  R0  &  '0'  &  x"04";	
			tmp(214) := STA  &  R0  &  '0'  &  x"05";	
			tmp(215) := STA  &  R0  &  '0'  &  x"06";
			tmp(216) := STA  &  R0  &  '1'  &  x"01";	
			tmp(217) := STA  &  R0  &  '1'  &  x"02";	
			tmp(218) := RET  &  R0  &  '0'  &  x"00";	
			tmp(219) := LDA  &  R0  &  '0'  &  x"00";	
			tmp(220) := STA  &  R0  &  '1'  &  x"20";	
			tmp(221) := LDA  &  R0  &  '0'  &  x"01";	
			tmp(222) := STA  &  R0  &  '1'  &  x"21";	
			tmp(223) := LDA  &  R0  &  '0'  &  x"02";	
			tmp(224) := STA  &  R0  &  '1'  &  x"22";	
			tmp(225) := LDA  &  R0  &  '0'  &  x"03";	
			tmp(226) := STA  &  R0  &  '1'  &  x"23";	
			tmp(227) := LDA  &  R0  &  '0'  &  x"04";	
			tmp(228) := STA  &  R0  &  '1'  &  x"24";	
			tmp(229) := LDA  &  R0  &  '0'  &  x"05";	
			tmp(230) := STA  &  R0  &  '1'  &  x"25";	
			tmp(231) := RET  &  R0  &  '0'  &  x"00";
			tmp(232) := STA  &  R0  &  '1'  &  x"fc";	
			tmp(233) := LDA  &  R1  &  '0'  &  x"07";	
			tmp(234) := STA  &  R1  &  '0'  &  x"06";	
			tmp(235) := STA  &  R1  &  '1'  &  x"01";	
			tmp(236) := LDA  &  R2  &  '0'  &  x"00";	
			tmp(237) := CEQ  &  R2  &  '0'  &  x"07";
			tmp(238) := JEQ  &  R0  &  '0'  &  x"f2";	
			tmp(239) := SUB  &  R2  &  '0'  &  x"08";	
			tmp(240) := STA  &  R2  &  '0'  &  x"00";	
			tmp(241) := RET  &  R0  &  '0'  &  x"00";
			tmp(242) := LDI  &  R3  &  '0'  &  x"09";	
			tmp(243) := STA  &  R3  &  '0'  &  x"00";	
			tmp(244) := LDA  &  R0  &  '0'  &  x"01";	
			tmp(245) := CEQ  &  R0  &  '0'  &  x"07";
			tmp(246) := JEQ  &  R0  &  '0'  &  x"fa";	
			tmp(247) := SUB  &  R0  &  '0'  &  x"08";	
			tmp(248) := STA  &  R0  &  '0'  &  x"01";	
			tmp(249) := RET  &  R0  &  '0'  &  x"00";	
			tmp(250) := LDI  &  R0  &  '0'  &  x"09";	
			tmp(251) := STA  &  R0  &  '0'  &  x"01";	
			tmp(252) := LDA  &  R1  &  '0'  &  x"02";	
			tmp(253) := CEQ  &  R1  &  '0'  &  x"07";	
			tmp(254) := JEQ  &  R0  &  '1'  &  x"02";	
			tmp(255) := SUB  &  R1  &  '0'  &  x"08";	
			tmp(256) := STA  &  R1  &  '0'  &  x"02";	
			tmp(257) := RET  &  R0  &  '0'  &  x"00";	
			tmp(258) := LDI  &  R2  &  '0'  &  x"09";	
			tmp(259) := STA  &  R2  &  '0'  &  x"02";	
			tmp(260) := LDA  &  R3  &  '0'  &  x"03";	
			tmp(261) := CEQ  &  R3  &  '0'  &  x"07";	
			tmp(262) := JEQ  &  R0  &  '1'  &  x"0a";	
			tmp(263) := SUB  &  R3  &  '0'  &  x"08";	
			tmp(264) := STA  &  R3  &  '0'  &  x"03";	
			tmp(265) := RET  &  R0  &  '0'  &  x"00";	
			tmp(266) := LDI  &  R1  &  '0'  &  x"09";	
			tmp(267) := STA  &  R1  &  '0'  &  x"03";	
			tmp(268) := LDA  &  R0  &  '0'  &  x"04";	
			tmp(269) := CEQ  &  R0  &  '0'  &  x"07";	
			tmp(270) := JEQ  &  R0  &  '1'  &  x"12";	
			tmp(271) := SUB  &  R0  &  '0'  &  x"08";	
			tmp(272) := STA  &  R0  &  '0'  &  x"04";
			tmp(273) := RET  &  R0  &  '0'  &  x"00";
			tmp(274) := LDI  &  R1  &  '0'  &  x"09";
			tmp(275) := STA  &  R1  &  '0'  &  x"04";	
			tmp(276) := LDA  &  R2  &  '0'  &  x"05";	
			tmp(277) := CEQ  &  R2  &  '0'  &  x"07";
			tmp(278) := JEQ  &  R0  &  '1'  &  x"19";
			tmp(279) := SUB  &  R2  &  '0'  &  x"08";	
			tmp(280) := STA  &  R2  &  '0'  &  x"05";	
			tmp(281) := LDA  &  R3  &  '0'  &  x"07";	
			tmp(282) := STA  &  R3  &  '0'  &  x"00";	-- Zera as unidades
			tmp(283) := STA  &  R3  &  '0'  &  x"01";	-- Zera as dezenas
			tmp(284) := STA  &  R3  &  '0'  &  x"02";	-- Zera as centenas
			tmp(285) := STA  &  R3  &  '0'  &  x"03";	-- Zera os milhares
			tmp(286) := STA  &  R3  &  '0'  &  x"04";	-- Zera as dezenas de milhar
			tmp(287) := STA  &  R3  &  '0'  &  x"05";	-- Zera as centenas de milhar
			tmp(288) := STA  &  R3  &  '1'  &  x"02";	
			tmp(289) := STA  &  R3  &  '1'  &  x"01";	
			tmp(290) := RET  &  R0  &  '0'  &  x"00";	
						

		  return tmp;
		  
    end initMemory;

    signal memROM : blocoMemoria := initMemory;

begin
    Dado <= memROM (to_integer(unsigned(Endereco)));
end architecture;