library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULA_0_30 is
    port (
		 entradaA :  in std_logic;
		 entradaB :  in std_logic;
		 slt  :  in std_logic;
		 inverteB :  in std_logic;
		 seletor  :  in std_logic_vector(1 downto 0);
		 vem_1    :  in std_logic;
		 vai_1    :  out std_logic;
		 saida    :  out std_logic
    );
end entity;

architecture comportamento of ULA_0_30 is

    signal saida_inversao : std_logic;
    signal saida_somador : std_logic;

begin

    MUX_Inversao_B : entity work.muxGenerico2x1 generic map (larguraDados => 1)
    port map(
        entradaA_MUX(0) => entradaB,
        entradaB_MUX(0) => not(entradaB),
        seletor_MUX => inverteB,
        saida_MUX(0) => saida_inversao
    );

    Somador : entity work.somadorGenerico_1bit 
    port map(
        entradaA => saida_inversao,
        entradaB => entradaA,
        cIn   => vem_1,
        saida => saida_somador,
        cOut  => vai_1
    );

    MUX_Selecao: entity work.muxGenerico4x1 generic map (larguraDados => 1)
    port map(
        MUX_AND(0) => (saida_inversao and entradaA),
        MUX_OR(0) => (saida_inversao or entradaA),  
        MUX_SUMSUB(0) => saida_somador, 
        MUX_SLT(0) => slt,
        SEL_MUX => seletor,
        MUX_OUT(0) => saida
    );

end architecture;