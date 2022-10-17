library ieee;
use ieee.std_logic_1164.all;

entity decoderInstru is
  port ( opcode : in std_logic_vector(3 downto 0);
         saida : out std_logic_vector(5 downto 0)
  );
end entity;

architecture comportamento of decoderInstru is

  constant NOP  : std_logic_vector(3 downto 0) := "0000";
  constant LDA  : std_logic_vector(3 downto 0) := "0001";
  constant SOMA : std_logic_vector(3 downto 0) := "0010";
  constant SUB  : std_logic_vector(3 downto 0) := "0011";
  constant LDI : std_logic_vector(3 downto 0) := "0100";
  constant STA : std_logic_vector(3 downto 0) := "0101";

  begin
saida <= "000000" when opcode = NOP else
         "011010" when opcode = LDA else
         "010110" when opcode = SOMA else
         "010010" when opcode = SUB else
			"111000" when opcode = LDI else
         "000001" when opcode = STA else
         "000000";  -- NOP para os opcodes Indefinidos
end architecture;