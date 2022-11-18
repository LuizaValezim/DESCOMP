library ieee;
use ieee.std_logic_1164.all;

entity muxGenerico4x1 is
  generic ( larguraDados : natural := 8);
  port (
    E0, E1, E2, E3	: in 	std_logic_vector((larguraDados-1) downto 0);
    SEL_MUX 			: in 	std_logic_vector(1 downto 0);
    MUX_OUT 			: out std_logic_vector((larguraDados-1) downto 0)
  );
end entity;

architecture arch_name of muxGenerico4x1 is
  
	begin
	
		MUX_OUT <= 	E0 when (SEL_MUX = "00") else
						E1 when (SEL_MUX = "01") else
						E2 when (SEL_MUX = "10") else
						E3;

end architecture;