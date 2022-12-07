library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shift is
  
    generic (
        larguraDados : natural  :=    32
    );
    port (
		  input      : in std_logic_vector((larguraDados - 1) DOWNTO 0);
		  shamt	    : in std_logic_vector(4 DOWNTO 0);
		  sll_signal : in std_logic;
		  srl_signal : in std_logic;
		  output  : out std_logic_vector((larguraDados - 1) DOWNTO 0)
    );
	 
end entity;

architecture comportamento of Shift is
	
	signal leftShift : std_logic_vector((larguraDados - 1) DOWNTO 0);
	signal rightShift : std_logic_vector((larguraDados - 1) DOWNTO 0);

begin
	
	leftShift <= std_logic_vector(unsigned(input) sll to_integer(unsigned(shamt)));
	rightShift <= std_logic_vector(unsigned(input) srl to_integer(unsigned(shamt)));
	
	output <= leftShift when sll_signal = '1' else rightshift when srl_signal = '1' else x"00000000";

end architecture;