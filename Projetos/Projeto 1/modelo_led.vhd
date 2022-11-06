library ieee;
use ieee.std_logic_1164.all;

entity modelo_led is
	port(
		CLK: in std_logic;
		endereco_LED: in std_logic_vector(2 downto 0);
		habilita : in std_logic;
		escrita : in std_logic;
		DATA_ADDRESS_5 : in std_logic;		
		DATA_OUT: in std_logic_vector(7 downto 0);
		conjunto_LED : out std_logic_vector(7 downto 0);
		LED_endereco1: out std_logic;
		LED_endereco2: out std_logic
	);
	
end entity;

architecture arch_name of modelo_led is
	
begin
	
		FlipFlop2: entity work.flipflopGenerico
			port map (
				DIN		=> DATA_OUT(0), 
				DOUT		=> LED_endereco2,
				ENABLE 	=> (habilita AND endereco_LED(2) AND escrita AND NOT(DATA_ADDRESS_5)),
				CLK 		=> CLK,
				RST 		=> '0'
		);
		
		FlipFlop1: entity work.flipflopGenerico
			port map (
				DIN		=> DATA_OUT(0), 
				DOUT		=> LED_endereco1,
				ENABLE 	=> (habilita AND endereco_LED(1) AND escrita AND NOT(DATA_ADDRESS_5)),
				CLK 		=> CLK,
				RST 		=> '0'
		);
			
		REG_LEDS : entity work.registradorGenerico generic map (larguraDados => 8)
				 port map (
							DIN => DATA_OUT,
							DOUT => conjunto_LED,
							ENABLE => (habilita AND endereco_LED(0) AND escrita AND NOT(DATA_ADDRESS_5)),
							CLK => CLK,
							RST => '0');


end architecture;
