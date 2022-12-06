library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Banco_Registradores is
    generic (
        larguradados : natural := 32;
        larguraendbancoregs : natural := 5 
    );

    port (
        clk : in std_logic;
        enderecoa : in std_logic_vector((larguraendbancoregs - 1) downto 0);
        enderecob : in std_logic_vector((larguraendbancoregs - 1) downto 0);
        enderecoc : in std_logic_vector((larguraendbancoregs - 1) downto 0);
        dadoescritac : in std_logic_vector((larguradados - 1) downto 0);
        escrevec : in std_logic := '0';
        saidaa : out std_logic_vector((larguradados - 1) downto 0);
        saidab : out std_logic_vector((larguradados - 1) downto 0)
    );
end entity;

architecture comportamento of Banco_Registradores is

    subtype palavra_t is std_logic_vector((larguradados - 1) downto 0);
    type memoria_t is array(2 ** larguraendbancoregs - 1 downto 0) of palavra_t;

	function initmemory
        return memoria_t is variable tmp : memoria_t := (others => (others => '0'));
	begin
        -- inicializa os endereços:
        tmp(8)  := 32x"00";  -- $t0 = 0x00
        tmp(9)  := 32x"0a";  -- $t1 = 0x0a
        tmp(10) := 32x"0b";  -- $t2 = 0x0b
        tmp(11) := 32x"0c";  -- $t3 = 0x0c
        tmp(12) := 32x"0d";  -- $t4 = 0x0d
        tmp(13) := 32x"16";  -- $t5 = 0x16
        return tmp;
    end initmemory;

    shared variable registrador : memoria_t := initmemory;
    constant zero : std_logic_vector(larguradados - 1 downto 0) := (others => '0');
begin
    process (clk) is
    begin
        if (rising_edge(clk)) then
            if (escrevec = '1') then
                registrador(to_integer(unsigned(enderecoc))) := dadoescritac;
            end if;
        end if;
    end process;

    saidab <= zero when to_integer(unsigned(enderecob)) = to_integer(unsigned(zero)) else
        registrador(to_integer(unsigned(enderecob)));
    saidaa <= zero when to_integer(unsigned(enderecoa)) = to_integer(unsigned(zero)) else
        registrador(to_integer(unsigned(enderecoa)));
end architecture;