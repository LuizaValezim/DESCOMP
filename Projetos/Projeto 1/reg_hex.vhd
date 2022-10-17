library ieee;
use ieee.std_logic_1164.all;

entity reg_hex is
	port(
		CLK: in std_logic;
		DATA_OUT: in std_logic_vector(3 downto 0);
		Data_Address_A5 : in std_logic;
		Decoder_Posicao: in std_logic;
		habilita : in std_logic;
		escrita : in std_logic;
		HEX			: out std_logic_vector	(6 downto 0)
	);
	
	
end entity;

architecture arch_name of reg_hex is

	signal hex: std_logic_vector(3 downto 0);


begin

	REG : entity work.registradorGenerico generic map (larguraDados => 4)
			 port map (
						DIN => DATA_OUT,
						DOUT => hex,
						ENABLE => (habilita AND Decoder_Posicao AND escrita AND Data_Address_A5),
						CLK => CLK,
						RST => '0');

	HEX :  entity work.conversorHex7Seg
        port map(
					  dadoHex => hex,
                 apaga =>  '0',
                 negativo => '0',
                 overFlow =>  '0',
                 saida7seg => HEX);
					  
					  
end architecture;