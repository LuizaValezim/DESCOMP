library ieee;
use ieee.std_logic_1164.all;

entity modelo_7seg is
	port(
		CLK: in std_logic;
		DATA_OUT: in std_logic_vector(3 downto 0);
		DATA_ADDRESS_5 : in std_logic;
		DecoderPosicao: in std_logic_vector (7 downto 0);
		habilita : in std_logic;
		escrita : in std_logic;
		HEX0			: out std_logic_vector	(6 downto 0);
	   HEX1			: out std_logic_vector	(6 downto 0);
	   HEX2			: out std_logic_vector	(6 downto 0);
	   HEX3			: out std_logic_vector	(6 downto 0);
	   HEX4			: out std_logic_vector	(6 downto 0);
	   HEX5			: out std_logic_vector	(6 downto 0)
	);
	
	
end entity;

architecture arch_name of modelo_7seg is

	signal hex_0: std_logic_vector(3 downto 0);
	signal hex_1: std_logic_vector(3 downto 0);
	signal hex_2: std_logic_vector(3 downto 0);
	signal hex_3: std_logic_vector(3 downto 0);
	signal hex_4: std_logic_vector(3 downto 0);
	signal hex_5: std_logic_vector(3 downto 0);


begin

	REG0 : entity work.registradorGenerico generic map (larguraDados => 4)
			 port map (
						DIN => DATA_OUT,
						DOUT => hex_0,
						ENABLE => (habilita AND DecoderPosicao(0) AND escrita AND DATA_ADDRESS_5),
						CLK => CLK,
						RST => '0');

	H0 :  entity work.conversorHex7Seg
        port map(
					  dadoHex => hex_0,
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX0);
					  
	REG1 : entity work.registradorGenerico generic map (larguraDados => 4)
			 port map (
						DIN => DATA_OUT,
						DOUT => hex_1,
						ENABLE => (habilita AND DecoderPosicao(1) AND escrita AND DATA_ADDRESS_5),
						CLK => CLK,
						RST => '0');
					  
	H1 :  entity work.conversorHex7Seg
        port map(
					  dadoHex => hex_1,
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX1);
					  
	REG2 : entity work.registradorGenerico generic map (larguraDados => 4)
			 port map (
						DIN => DATA_OUT,
						DOUT => hex_2,
						ENABLE => (habilita AND DecoderPosicao(2) AND escrita AND DATA_ADDRESS_5),
						CLK => CLK,
						RST => '0');
					  
	H2 :  entity work.conversorHex7Seg
        port map(
					  dadoHex => hex_2,
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX2);
					  
	REG3 : entity work.registradorGenerico generic map (larguraDados => 4)
			 port map (
						DIN => DATA_OUT,
						DOUT => hex_3,
						ENABLE => (habilita AND DecoderPosicao(3) AND escrita AND DATA_ADDRESS_5),
						CLK => CLK,
						RST => '0');
					  
	H3 :  entity work.conversorHex7Seg
        port map(
					  dadoHex => hex_3,
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX3);

	REG4 : entity work.registradorGenerico generic map (larguraDados => 4)
			 port map (
						DIN => DATA_OUT,
						DOUT => hex_4,
						ENABLE => (habilita AND DecoderPosicao(4) AND escrita AND DATA_ADDRESS_5),
						CLK => CLK,
						RST => '0');

	H4 :  entity work.conversorHex7Seg
        port map(
					  dadoHex => hex_4 ,
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX4); 
					  
	REG5 : entity work.registradorGenerico generic map (larguraDados => 4)
			 port map (
						DIN => DATA_OUT,
						DOUT => hex_5,
						ENABLE => (habilita AND DecoderPosicao(5) AND escrita AND DATA_ADDRESS_5),
						CLK => CLK,
						RST => '0');
					  
	H5 :  entity work.conversorHex7Seg
        port map(
					  dadoHex => hex_5,
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX5);
					  
end architecture;
