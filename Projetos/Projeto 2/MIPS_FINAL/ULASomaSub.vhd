library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- biblioteca ieee para funções aritméticas

entity ULASomaSub is
   generic (larguradados : natural := 32);
   port (
      entradaa, entradab : in std_logic_vector((larguradados - 1) downto 0);
      seletor : in std_logic_vector(1 downto 0);
      inverteb : in std_logic;
      saida : out std_logic_vector((larguradados - 1) downto 0);
      flagzero : out std_logic
   );
end entity;

architecture comportamento of ULASomaSub is
   constant zero : std_logic_vector((larguradados - 1) downto 0) := (others => '0');

   signal carry0, carry1, carry2, carry3, carry4, carry5, carry6, 
   carry7, carry8, carry9, carry10, carry11, carry12, carry13, 
   carry14, carry15, carry16, carry17, carry18, carry19, carry20, 
   carry21, carry22, carry23, carry24, carry25, carry26, carry27, 
   carry28, carry29, carry30 : std_logic;
   signal slt_hab : std_logic;
   
	begin

	ula1 : entity work.ULA_0_30ULA_0_30
	port map(
		 entradaa => entradaa(0),
		 entradab => entradab(0),
		 slt => slt_hab,
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => inverteb,
		 cout => carry0,
		 saida => saida(0)
	);

	ula2 : entity work.ULA_0_30ULA_0_30
	port map(
		 entradaa => entradaa(1),
		 entradab => entradab(1),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry0,
		 cout => carry1,
		 saida => saida(1)
	);
	  
	ula3 : entity work.ULA_0_30ULA_0_30
	port map(
		 entradaa => entradaa(2),
		 entradab => entradab(2),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry1,
		 cout => carry2,
		 saida => saida(2)
	);

	ula4 : entity work.ULA_0_30ULA_0_30	
	port map(
		 entradaa => entradaa(3),
		 entradab => entradab(3),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry2,
		 cout => carry3,
		 saida => saida(3)
	);

	ula5 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(4),
		 entradab => entradab(4),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry3,
		 cout => carry4,
		 saida => saida(4)
	);

	ula6 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(5),
		 entradab => entradab(5),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry4,
		 cout => carry5,
		 saida => saida(5)
	);

	ula7 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(6),
		 entradab => entradab(6),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry5,
		 cout => carry6,
		 saida => saida(6)
	);

	ula8 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(7),
		 entradab => entradab(7),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry6,
		 cout => carry7,
		 saida => saida(7)
	);

	ula9 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(8),
		 entradab => entradab(8),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry7,
		 cout => carry8,
		 saida => saida(8)
	);

	ula10 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(9),
		 entradab => entradab(9),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry8,
		 cout => carry9,
		 saida => saida(9)
	);

	ula11 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(10),
		 entradab => entradab(10),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry9,
		 cout => carry10,
		 saida => saida(10)
	);

	ula12 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(11),
		 entradab => entradab(11),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry10,
		 cout => carry11,
		 saida => saida(11)
	);

	ula13 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(12),
		 entradab => entradab(12),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry11,
		 cout => carry12,
		 saida => saida(12)
	);

	ula14 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(13),
		 entradab => entradab(13),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry12,
		 cout => carry13,
		 saida => saida(13)
	);

	ula15 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(14),
		 entradab => entradab(14),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry13,
		 cout => carry14,
		 saida => saida(14)
	);

	ula16 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(15),
		 entradab => entradab(15),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry14,
		 cout => carry15,
		 saida => saida(15)
	);

	ula17 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(16),
		 entradab => entradab(16),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry15,
		 cout => carry16,
		 saida => saida(16)
	);

	ula18 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(17),
		 entradab => entradab(17),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry16,
		 cout => carry17,
		 saida => saida(17)
	);

	ula19 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(18),
		 entradab => entradab(18),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry17,
		 cout => carry18,
		 saida => saida(18)
	);

	ula20 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(19),
		 entradab => entradab(19),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry18,
		 cout => carry19,
		 saida => saida(19)
	);

	ula21 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(20),
		 entradab => entradab(20),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry19,
		 cout => carry20,
		 saida => saida(20)
	);

	ula22 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(21),
		 entradab => entradab(21),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry20,
		 cout => carry21,
		 saida => saida(21)
	);

	ula23 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(22),
		 entradab => entradab(22),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry21,
		 cout => carry22,
		 saida => saida(22)
	);

	ula24 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(23),
		 entradab => entradab(23),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry22,
		 cout => carry23,
		 saida => saida(23)
	);

	ula25 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(24),
		 entradab => entradab(24),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry23,
		 cout => carry24,
		 saida => saida(24)
	);

	ula26 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(25),
		 entradab => entradab(25),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry24,
		 cout => carry25,
		 saida => saida(25)
	);

	ula27 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(26),
		 entradab => entradab(26),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry25,
		 cout => carry26,
		 saida => saida(26)
	);

	ula28 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(27),
		 entradab => entradab(27),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry26,
		 cout => carry27,
		 saida => saida(27)
	);

	ula29 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(28),
		 entradab => entradab(28),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry27,
		 cout => carry28,
		 saida => saida(28)
	);

	ula30 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(29),
		 entradab => entradab(29),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry28,
		 cout => carry29,
		 saida => saida(29)
	);

	ula31 : entity work.ULA_0_30	
	port map(
		 entradaa => entradaa(30),
		 entradab => entradab(30),
		 slt => '0',
		 inverteb => inverteb, 
		 seletor => seletor,
		 cin => carry29,
		 cout => carry30,
		 saida => saida(30)
	);

	ula32 : entity work.ULA_31
	port map(
		entradaa => entradaa(31),
		entradab => entradab(31),
		slt      =>  '0',
		inverteb => inverteb,
		seletor  => seletor,
		cin      => carry30,
		saida    =>  saida(31),
		set      =>  slt_hab
	);


flagzero <= '1' when unsigned(saida) = unsigned(zero) else '0';

end architecture;