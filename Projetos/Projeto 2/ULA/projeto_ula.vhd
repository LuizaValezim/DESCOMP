library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Biblioteca IEEE para funções aritméticas

entity projeto_ula is
   generic (larguraDados : natural := 32);
   port (
      entradaA, entradaB : in std_logic_vector((larguraDados - 1) downto 0);
      sel                : in std_logic_vector(1 downto 0);
      inverteB           : in std_logic;
      saida              : out std_logic_vector((larguraDados - 1) downto 0);
      flagZero           : out std_logic
   );
end entity;

architecture comportamento of projeto_ula is
   constant zero : std_logic_vector((larguraDados - 1) downto 0) := (others => '0');

   signal carry_0, carry_1, carry_2, carry_3, carry_4, carry_5, carry_6, carry_7, carry_8, carry_9, carry_10, 
	carry_11, carry_12, carry_13, carry_14, carry_15, carry_16, carry_17, carry_18, carry_19, carry_20, 
   carry_21, carry_22, carry_23, carry_24, carry_25, carry_26, carry_27, 
   carry_28, carry_29, carry_30 : std_logic;
   signal slt_hab : std_logic;
   
begin

		ULA0 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(0),
			 entradaB => entradaB(0),
			 slt => slt_hab,
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => inverteB,
			 vai_1 => carry_0,
			 saida => saida(0)
		);

		ULA1 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(1),
			 entradaB => entradaB(1),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_0,
			 vai_1 => carry_1,
			 saida => saida(1)
		);
		  
		ULA2 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(2),
			 entradaB => entradaB(2),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_1,
			 vai_1 => carry_2,
			 saida => saida(2)
		);

		ULA3 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(3),
			 entradaB => entradaB(3),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_2,
			 vai_1 => carry_3,
			 saida => saida(3)
		);

		ULA4 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(4),
			 entradaB => entradaB(4),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_3,
			 vai_1 => carry_4,
			 saida => saida(4)
		);

		ULA5 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(5),
			 entradaB => entradaB(5),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_4,
			 vai_1 => carry_5,
			 saida => saida(5)
		);

		ULA6 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(6),
			 entradaB => entradaB(6),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_5,
			 vai_1 => carry_6,
			 saida => saida(6)
		);

		ULA7 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(7),
			 entradaB => entradaB(7),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_6,
			 vai_1 => carry_7,
			 saida => saida(7)
		);

		ULA8 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(8),
			 entradaB => entradaB(8),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_7,
			 vai_1 => carry_8,
			 saida => saida(8)
		);

		ULA9 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(9),
			 entradaB => entradaB(9),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_8,
			 vai_1 => carry_9,
			 saida => saida(9)
		);

		ULA10 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(10),
			 entradaB => entradaB(10),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_9,
			 vai_1 => carry_10,
			 saida => saida(10)
		);

		ULA11 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(11),
			 entradaB => entradaB(11),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_10,
			 vai_1 => carry_11,
			 saida => saida(11)
		);

		ULA12 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(12),
			 entradaB => entradaB(12),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_11,
			 vai_1 => carry_12,
			 saida => saida(12)
		);

		ULA13 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(13),
			 entradaB => entradaB(13),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_12,
			 vai_1 => carry_13,
			 saida => saida(13)
		);

		ULA14 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(14),
			 entradaB => entradaB(14),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_13,
			 vai_1 => carry_14,
			 saida => saida(14)
		);

		ULA15 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(15),
			 entradaB => entradaB(15),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_14,
			 vai_1 => carry_15,
			 saida => saida(15)
		);

		ULA16 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(16),
			 entradaB => entradaB(16),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_15,
			 vai_1 => carry_16,
			 saida => saida(16)
		);

		ULA17 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(17),
			 entradaB => entradaB(17),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_16,
			 vai_1 => carry_17,
			 saida => saida(17)
		);

		ULA18 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(18),
			 entradaB => entradaB(18),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_17,
			 vai_1 => carry_18,
			 saida => saida(18)
		);

		ULA19 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(19),
			 entradaB => entradaB(19),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_18,
			 vai_1 => carry_19,
			 saida => saida(19)
		);

		ULA20 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(20),
			 entradaB => entradaB(20),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_19,
			 vai_1 => carry_20,
			 saida => saida(20)
		);

		ULA21 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(21),
			 entradaB => entradaB(21),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_20,
			 vai_1 => carry_21,
			 saida => saida(21)
		);

		ULA22 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(22),
			 entradaB => entradaB(22),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_21,
			 vai_1 => carry_22,
			 saida => saida(22)
		);

		ULA23 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(23),
			 entradaB => entradaB(23),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_22,
			 vai_1 => carry_23,
			 saida => saida(23)
		);

		ULA24 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(24),
			 entradaB => entradaB(24),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_23,
			 vai_1 => carry_24,
			 saida => saida(24)
		);

		ULA25 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(25),
			 entradaB => entradaB(25),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_24,
			 vai_1 => carry_25,
			 saida => saida(25)
		);

		ULA26 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(26),
			 entradaB => entradaB(26),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_25,
			 vai_1 => carry_26,
			 saida => saida(26)
		);

		ULA27 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(27),
			 entradaB => entradaB(27),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_26,
			 vai_1 => carry_27,
			 saida => saida(27)
		);

		ULA28 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(28),
			 entradaB => entradaB(28),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_27,
			 vai_1 => carry_28,
			 saida => saida(28)
		);

		ULA29 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(29),
			 entradaB => entradaB(29),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_28,
			 vai_1 => carry_29,
			 saida => saida(29)
		);

		ULA30 : entity work.ULA_0_30
		port map(
			 entradaA => entradaA(30),
			 entradaB => entradaB(30),
			 slt => '0',
			 inverteB => inverteB, 
			 seletor => sel,
			 vem_1 => carry_29,
			 vai_1 => carry_30,
			 saida => saida(30)
		);


		ULA31 : entity work.ULA_31
		port map(
			entradaA => entradaA(31),
			entradaB => entradaB(31),
			slt      =>  '0',
			inverteB => inverteB,
			seletor  => sel,
			vem_1    => carry_30,
			saida    =>  saida(31),
			set      =>  slt_hab
		);

		flagZero <= '1' when unsigned(saida) = unsigned(zero) else '0';

end architecture;