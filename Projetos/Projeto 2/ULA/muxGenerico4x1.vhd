library ieee;
use ieee.std_logic_1164.all;

entity muxGenerico4x1 is
  generic ( larguraDados : natural := 8);
  port (
    MUX_AND, MUX_OR, MUX_SUMSUB, MUX_SLT	: in 	std_logic_vector((larguraDados - 1) downto 0);
    SEL_MUX 			: in 	std_logic_vector(1 downto 0);
    MUX_OUT 			: out std_logic_vector((larguraDados - 1) downto 0)
  );
end entity;

architecture arch_name of muxGenerico4x1 is
	begin
		MUX_OUT <= 	MUX_AND when (SEL_MUX = "00") else
						MUX_OR when (SEL_MUX = "01") else
						MUX_SUMSUB when (SEL_MUX = "10") else
						MUX_SLT;
end architecture;