library ieee;
use ieee.std_logic_1164.all;

entity extendSignal is

    generic (
        larguraDadoEntrada : natural  :=    16;
        larguraDadoSaida   : natural  :=    32
    );
    port (
		  ori_andi_signal : in std_logic;
        in_signal : in  std_logic_vector(larguraDadoEntrada-1 downto 0);
        out_signal: out std_logic_vector(larguraDadoSaida-1 downto 0)
    );
	 
end entity;

architecture comportamento of extendSignal is
	
	signal mux_out_signal : std_logic_vector(15 DOWNTO 0);

begin

	 MUX_extended : entity work.muxGenerico2x1 generic map(larguraDados => 16)
		port map(
			entradaA_MUX => (others => in_signal(larguraDadoEntrada-1)),
			entradaB_MUX => x"0000",
			seletor_MUX => ori_andi_signal,
			saida_MUX => mux_out_signal
		);

    out_signal <= mux_out_signal & in_signal;

end architecture;