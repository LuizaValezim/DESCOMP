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
  constant JMP : std_logic_vector(3 downto 0) := "0110";

  begin
  
  -- MUX HABILITA OPERACAO // DECODER : LER ESCREVER
saida <= "0000000" when opcode = NOP else  -- SelMUX HabilitaA Reset Operacao
         "0011010" when opcode = LDA else  -- operação final não importa/ carrega Y: A
         "0010110" when opcode = SOMA else -- soma valor da mem com acumulador
         "0010010" when opcode = SUB else
			"0111000" when opcode = LDI else
			"0X0XX01" when opcode = STA else
			"1000000" when opcode = JMP else
         "000000";  -- NOP para os opcodes Indefinidos
end architecture;