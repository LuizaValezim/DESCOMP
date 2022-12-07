library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is

  port (  
		entradaA 	: in std_logic_vector(31 DOWNTO 0);
		entradaB		: in std_logic_vector(31 DOWNTO 0);
		sel_mux		: in std_logic_vector(1 DOWNTO 0);
		inverteB		: in std_logic;
		resultado	: out std_logic_vector(31 DOWNTO 0);
		flagZero		: out std_logic
  );
  
end entity;

architecture arquitetura of ULA is

	signal carryOUT0, carryOUT1, carryOUT2, carryOUT3, carryOUT4, carryOUT5, carryOUT6, carryOUT7 		 	: std_logic;
	signal carryOUT8, carryOUT9, carryOUT10, carryOUT11, carryOUT12, carryOUT13, carryOUT14, carryOUT15 	: std_logic;
	signal carryOUT16, carryOUT17, carryOUT18, carryOUT19, carryOUT20, carryOUT21, carryOUT22, carryOUT23	: std_logic;
	signal carryOUT24, carryOUT25, carryOUT26, carryOUT27, carryOUT28, carryOUT29, carryOUT30, carryOUT31 : std_logic;
	signal SLT_inverteB, somadorBit31 : std_logic;
	
begin	
	
ULA_0 : entity work.ULA_0_31
		port map(
			SLT			=> (carryOUT30 xor carryOUT31) xor somadorBit31,
			entradaA 	=> entradaA(0),
			entradaB 	=> entradaB(0),
			inverteB		=> inverteB,
			carryIN		=> inverteB,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT0,
			resultado	=> resultado(0)
		);

ULA_1 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(1),
			entradaB 	=> entradaB(1),
			inverteB		=> inverteB,
			carryIN		=> carryOUT0,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT1,
			resultado	=> resultado(1)
		);
		
ULA_2 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(2),
			entradaB 	=> entradaB(2),
			inverteB		=> inverteB,
			carryIN		=> carryOUT1,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT2,
			resultado	=> resultado(2)
		);
		
ULA_3 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(3),
			entradaB 	=> entradaB(3),
			inverteB		=> inverteB,
			carryIN		=> carryOUT2,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT3,
			resultado	=> resultado(3)
		);
		
ULA_4 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(4),
			entradaB 	=> entradaB(4),
			inverteB		=> inverteB,
			carryIN		=> carryOUT3,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT4,
			resultado	=> resultado(4)
		);
		
ULA_5 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(5),
			entradaB 	=> entradaB(5),
			inverteB		=> inverteB,
			carryIN		=> carryOUT4,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT5,
			resultado	=> resultado(5)
		);
		
ULA_6 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(6),
			entradaB 	=> entradaB(6),
			inverteB		=> inverteB,
			carryIN		=> carryOUT5,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT6,
			resultado	=> resultado(6)
		);
		
		
ULA_7 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(7),
			entradaB 	=> entradaB(7),
			inverteB		=> inverteB,
			carryIN		=> carryOUT6,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT7,
			resultado	=> resultado(7)
		);
		
ULA_8 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(8),
			entradaB 	=> entradaB(8),
			inverteB		=> inverteB,
			carryIN		=> carryOUT7,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT8,
			resultado	=> resultado(8)
		);
		
ULA_9 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(9),
			entradaB 	=> entradaB(9),
			inverteB		=> inverteB,
			carryIN		=> carryOUT8,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT9,
			resultado	=> resultado(9)
		);
		
ULA_10 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(10),
			entradaB 	=> entradaB(10),
			inverteB		=> inverteB,
			carryIN		=> carryOUT9,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT10,
			resultado	=> resultado(10)
		);
		
ULA_11 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(11),
			entradaB 	=> entradaB(11),
			inverteB		=> inverteB,
			carryIN		=> carryOUT10,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT11,
			resultado	=> resultado(11)
		);
		
ULA_12 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(12),
			entradaB 	=> entradaB(12),
			inverteB		=> inverteB,
			carryIN		=> carryOUT11,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT12,
			resultado	=> resultado(12)
		);

ULA_13 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(13),
			entradaB 	=> entradaB(13),
			inverteB		=> inverteB,
			carryIN		=> carryOUT12,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT13,
			resultado	=> resultado(13)
		);		
		
ULA_14 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(14),
			entradaB 	=> entradaB(14),
			inverteB		=> inverteB,
			carryIN		=> carryOUT13,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT14,
			resultado	=> resultado(14)
		);		
		
ULA_15 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(15),
			entradaB 	=> entradaB(15),
			inverteB		=> inverteB,
			carryIN		=> carryOUT14,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT15,
			resultado	=> resultado(15)
		);		
		
ULA_16 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(16),
			entradaB 	=> entradaB(16),
			inverteB		=> inverteB,
			carryIN		=> carryOUT15,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT16,
			resultado	=> resultado(16)
		);		
		
ULA_17 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(17),
			entradaB 	=> entradaB(17),
			inverteB		=> inverteB,
			carryIN		=> carryOUT16,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT17,
			resultado	=> resultado(17)
		);		
		
ULA_18 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(18),
			entradaB 	=> entradaB(18),
			inverteB		=> inverteB,
			carryIN		=> carryOUT17,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT18,
			resultado	=> resultado(18)
		);
		
ULA_19 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(19),
			entradaB 	=> entradaB(19),
			inverteB		=> inverteB,
			carryIN		=> carryOUT18,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT19,
			resultado	=> resultado(19)
		);	
		
ULA_20 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(20),
			entradaB 	=> entradaB(20),
			inverteB		=> inverteB,
			carryIN		=> carryOUT19,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT20,
			resultado	=> resultado(20)
		);	
		
ULA_21 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(21),
			entradaB 	=> entradaB(21),
			inverteB		=> inverteB,
			carryIN		=> carryOUT20,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT21,
			resultado	=> resultado(21)
		);	
		
ULA_22 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(22),
			entradaB 	=> entradaB(22),
			inverteB		=> inverteB,
			carryIN		=> carryOUT21,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT22,
			resultado	=> resultado(22)
		);	
		
ULA_23 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(23),
			entradaB 	=> entradaB(23),
			inverteB		=> inverteB,
			carryIN		=> carryOUT22,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT23,
			resultado	=> resultado(23)
		);	

ULA_24 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(24),
			entradaB 	=> entradaB(24),
			inverteB		=> inverteB,
			carryIN		=> carryOUT23,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT24,
			resultado	=> resultado(24)
		);	

ULA_25 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(25),
			entradaB 	=> entradaB(25),
			inverteB		=> inverteB,
			carryIN		=> carryOUT24,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT25,
			resultado	=> resultado(25)
		);
	
ULA_26 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(26),
			entradaB 	=> entradaB(26),
			inverteB		=> inverteB,
			carryIN		=> carryOUT25,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT26,
			resultado	=> resultado(26)
		);

ULA_27 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(27),
			entradaB 	=> entradaB(27),
			inverteB		=> inverteB,
			carryIN		=> carryOUT26,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT27,
			resultado	=> resultado(27)
		);

ULA_28 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(28),
			entradaB 	=> entradaB(28),
			inverteB		=> inverteB,
			carryIN		=> carryOUT27,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT28,
			resultado	=> resultado(28)
		);

ULA_29 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(29),
			entradaB 	=> entradaB(29),
			inverteB		=> inverteB,
			carryIN		=> carryOUT28,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT29,
			resultado	=> resultado(29)
		);

ULA_30 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(30),
			entradaB 	=> entradaB(30),
			inverteB		=> inverteB,
			carryIN		=> carryOUT29,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT30,
			resultado	=> resultado(30)
		);
		
ULA_31 : entity work.ULA_0_31
		port map(
			SLT			=> '0',
			entradaA 	=> entradaA(31),
			entradaB 	=> entradaB(31),
			inverteB		=> inverteB,
			carryIN		=> carryOUT30,
			seletor		=> sel_mux,
			carryOUT		=> carryOUT31,
			resultado	=> resultado(31)
		);
		

SLT_inverteB <= not entradaB(31) when inverteB = '1' else entradaB(31);
somadorBit31 <= carryOUT30 xor (entradaA(31) xor SLT_inverteB); 
flagZero <= '1' when resultado = x"00000000" else '0';		

end architecture;