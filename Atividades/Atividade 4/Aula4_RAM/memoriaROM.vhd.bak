library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
   generic (
          dataWidth: natural := 13;
          addrWidth: natural := 4
    );
   port (
          Endereco : in std_logic_vector (7 DOWNTO 0);
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

  type blocoMemoria is array(0 TO 2**addrWidth - 1) of std_logic_vector(dataWidth-1 DOWNTO 0);

  function initMemory
        return blocoMemoria is variable tmp : blocoMemoria := (others => (others => '0'));
		
  begin
      -- Palavra de Controle = SelMUX, Habilita_A, Reset_A, Operacao_ULA
      -- Inicializa os endereços:
		  tmp(0)  := LDI & '0' & x"00"; -- A = 0, reset
        tmp(1)  := LDI & '0' & x"02";   -- agora, A = 2
        tmp(2)  := STA & '1' & x"00"; -- MEM[0] = 2
        tmp(3)  := SOMA & '1' & x"00"; -- A = A + MEM[0] = 4
        tmp(4)  := SOMA & '1' & x"00"; -- A = A + MEM[0] = 6
        tmp(5)  := STA & '1' & x"01" ; -- MEM[1] = 6
        tmp(6)  := LDI & '0' & x"04"; -- A = 4
        tmp(7)  := STA & '1' & x"02"; -- MEM[2] = 4
        tmp(8)  := LDA & '1' & x"01"; -- A = MEM[1] = 6
        tmp(9)  := SUB & '1' & x"02"; -- A = A - B = 6 - MEM[2] = 6 - 4 = 2
        tmp(10)  := STA & '1' & x"03"; -- MEM[3] = 2
        return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;

begin
    Dado <= memROM (to_integer(unsigned(Endereco)));
end architecture;