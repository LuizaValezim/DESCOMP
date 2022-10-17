library ieee;
use ieee.std_logic_1164.all;

entity decoderInstru is
  port ( opcode : in std_logic_vector(3 downto 0);
			ler : out std_logic;
			escrever : out std_logic; 
         saida : out std_logic_vector(3 downto 0)
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
  
  -- MUX HABILITA OPERACAO // DECODER : LER ESCREVER
saida <= "0000" when opcode = NOP and ler = '0' and escrever = '0' else  -- SelMUX HabilitaA Reset Operacao
         "0110" when opcode = LDA and ler = '1' and escrever = '0' else  -- operação final não importa/ carrega Y: A
         "0101" when opcode = SOMA and ler = '1' and escrever = '0' else -- soma valor da mem com acumulador
         "0100" when opcode = SUB and ler = '1' and escrever = '0' else
			"1110" when opcode = LDI and ler = '0' and escrever = '0' else
			"X1XX" when opcode = STA and ler = '0' and escrever = '1' else
         "0000" when opcode = NOP and ler = '0' and escrever = '0';  -- NOP para os opcodes Indefinidos
end architecture;