library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modelo_7seg is
  generic   (
    in_WIDTH  	: natural :=  4;
    out_WIDTH  : natural :=  7
  );

  port   (
    datain  : in  std_logic_vector(in_WIDTH-1 downto 0);
    CLK     : in  std_logic;
    display_out : out  std_logic_vector(out_WIDTH-1 downto 0)
    
  );
end entity;


architecture arch_name of modelo_7seg is

begin
							
HEX :  entity work.conversorHex7Seg
			port map(	dadoHex 			=> datain,
							apaga 			=> '0',
							negativo 		=> '0',
							overFlow 		=> '0',
							saida7seg 		=> display_out
						);

end architecture;