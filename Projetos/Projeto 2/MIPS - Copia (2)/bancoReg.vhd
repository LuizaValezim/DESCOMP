library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Baseado no apendice C (Register Files) do COD (Patterson & Hennessy).

entity bancoReg is
    generic (
        larguraDados : natural := 32;
        larguraendBancoRegs : natural := 5 --Resulta em 2^5=32 posicoes
    );
    -- Leitura de 2 registradores e escrita em 1 registrador simultaneamente.
    port (
        clk : in STD_LOGIC;
        --
        enderecoA : in std_logic_vector((larguraendBancoRegs - 1) downto 0);
        enderecoB : in std_logic_vector((larguraendBancoRegs - 1) downto 0);
        enderecoC : in std_logic_vector((larguraendBancoRegs - 1) downto 0);
        --
        dadoEscritaC : in std_logic_vector((larguraDados - 1) downto 0);
        --
        escreveC : in STD_LOGIC := '0';
        saidaA : out std_logic_vector((larguraDados - 1) downto 0);
        saidaB : out std_logic_vector((larguraDados - 1) downto 0)
    );
end entity;

architecture comportamento OF bancoReg is

    SUBTYPE palavra_t is std_logic_vector((larguraDados - 1) downto 0);
    TYPE memoria_t is ARRAY(2 ** larguraendBancoRegs - 1 downto 0) OF palavra_t;

	function initMemory
        return memoria_t is variable tmp : memoria_t := (others => (others => '0'));
	begin
        -- inicializa os endereços:
        tmp(8)  := 32x"00";  -- $t0 = 0x00
        tmp(9)  := 32x"0A";  -- $t1 = 0x0A
        tmp(10) := 32x"0B";  -- $t2 = 0x0B
        tmp(11) := 32x"0C";  -- $t3 = 0x0C
        tmp(12) := 32x"0D";  -- $t4 = 0x0D
        tmp(13) := 32x"16";  -- $t5 = 0x16
        return tmp;
    end initMemory;

    -- Declaracao dos registradores:
    SHARED VARIABLE registrador : memoria_t := initMemory;
    constant zero : std_logic_vector(larguraDados - 1 downto 0) := (OTHERS => '0');
begin
    process (clk) is
    begin
        IF (rising_edge(clk)) THEN
            IF (escreveC = '1') THEN
                registrador(to_integer(unsigned(enderecoC))) := dadoEscritaC;
            end IF;
        end IF;
    end process;
    -- Se endereco = 0 : retorna ZERO
    saidaB <= zero when to_integer(unsigned(enderecoB)) = to_integer(unsigned(zero)) else
        registrador(to_integer(unsigned(enderecoB)));
    saidaA <= zero when to_integer(unsigned(enderecoA)) = to_integer(unsigned(zero)) else
        registrador(to_integer(unsigned(enderecoA)));
end architecture;