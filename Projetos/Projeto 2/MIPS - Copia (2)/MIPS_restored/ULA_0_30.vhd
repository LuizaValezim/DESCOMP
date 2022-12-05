library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULA_0_30 is
    port
    (
      entradaA :  in std_logic;
		entradaB :  in std_logic;
		slt      :  in std_logic;
      inverteB :  in std_logic;
      seletor  :  in std_logic_vector(1 downto 0);
		cin      :  in std_logic;
		cout     :  out std_logic;
		saida    :  out std_logic
    );
end entity;

architecture comportamento of ULA_0_30 is

    signal saida_inversao : std_logic;
    signal saida_somador : std_logic;

begin

    inverterOuNao : entity work.muxgenerico2x1 generic map (larguraDados => 1)
    port map(
        entradaA_MUX(0) => entradaB,
        entradaB_MUX(0) => not(entradaB),
        seletor_MUX => inverteB,
        saida_MUX(0) => saida_inversao
    );

    Somador : entity work.somadorgenerico1bit 
    port map(
        entradaA => saida_inversao,
        entradaB => entradaA,
        cin   => cin,
        saida => saida_somador,
        cout  => cout
    );

    MuxOperacao: entity work.muxgenerico4x1 generic map (larguraDados => 1)
    port map(
        E0(0) => (saida_inversao and entradaA), -- faz a operação de and
        E1(0) => (saida_inversao or entradaA),  -- faz a operação de or
        E2(0) => saida_somador, -- faz ou soma ou subtração
        E3(0) => slt, -- seta a flag de menor
        SEL_MUX => seletor,
        MUX_out(0) => saida
    );

end architecture;