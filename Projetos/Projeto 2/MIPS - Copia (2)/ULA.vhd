library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Biblioteca IEEE para funções aritméticas

entity ULA is
   generic (larguraDados : natural := 32);
   port (
      entradaA, entradaB : in std_logic_vector((larguraDados - 1) downto 0);
      seletor : in std_logic_vector(1 downto 0);
      inverteB : in STD_LOGIC;
      saida : out std_logic_vector((larguraDados - 1) downto 0);
      flagZero : out STD_LOGIC
   );
end entity;

architecture comportamento OF ULA is
   constant zero : std_logic_vector((larguraDados - 1) downto 0) := (OTHERS => '0');

   signal carry0, carry1, carry2, carry3, carry4, carry5, carry6, 
   carry7, carry8, carry9, carry10, carry11, carry12, carry13, 
   carry14, carry15, carry16, carry17, carry18, carry19, carry20, 
   carry21, carry22, carry23, carry24, carry25, carry26, carry27, 
   carry28, carry29, carry30 : STD_LOGIC;
   signal slt_hab : STD_LOGIC;
   
begin

ULA1 : entity work.ULA_0_30
port map(
    entradaA => entradaA(0),
    entradaB => entradaB(0),
    slt => slt_hab,
    inverteB => inverteB, 
    seletor => seletor,
    cin => inverteB,
    cout => carry0,
    saida => saida(0)
);

ULA2 : entity work.ULA_0_30
port map(
    entradaA => entradaA(1),
    entradaB => entradaB(1),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry0,
    cout => carry1,
    saida => saida(1)
);
  
ULA3 : entity work.ULA_0_30
port map(
    entradaA => entradaA(2),
    entradaB => entradaB(2),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry1,
    cout => carry2,
    saida => saida(2)
);

ULA4 : entity work.ULA_0_30
port map(
    entradaA => entradaA(3),
    entradaB => entradaB(3),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry2,
    cout => carry3,
    saida => saida(3)
);

ULA5 : entity work.ULA_0_30
port map(
    entradaA => entradaA(4),
    entradaB => entradaB(4),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry3,
    cout => carry4,
    saida => saida(4)
);

ULA6 : entity work.ULA_0_30
port map(
    entradaA => entradaA(5),
    entradaB => entradaB(5),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry4,
    cout => carry5,
    saida => saida(5)
);

ULA7 : entity work.ULA_0_30
port map(
    entradaA => entradaA(6),
    entradaB => entradaB(6),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry5,
    cout => carry6,
    saida => saida(6)
);

ULA8 : entity work.ULA_0_30
port map(
    entradaA => entradaA(7),
    entradaB => entradaB(7),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry6,
    cout => carry7,
    saida => saida(7)
);

ULA9 : entity work.ULA_0_30
port map(
    entradaA => entradaA(8),
    entradaB => entradaB(8),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry7,
    cout => carry8,
    saida => saida(8)
);

ULA10 : entity work.ULA_0_30
port map(
    entradaA => entradaA(9),
    entradaB => entradaB(9),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry8,
    cout => carry9,
    saida => saida(9)
);

ULA11 : entity work.ULA_0_30
port map(
    entradaA => entradaA(10),
    entradaB => entradaB(10),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry9,
    cout => carry10,
    saida => saida(10)
);

ULA12 : entity work.ULA_0_30
port map(
    entradaA => entradaA(11),
    entradaB => entradaB(11),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry10,
    cout => carry11,
    saida => saida(11)
);

ULA13 : entity work.ULA_0_30
port map(
    entradaA => entradaA(12),
    entradaB => entradaB(12),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry11,
    cout => carry12,
    saida => saida(12)
);

ULA14 : entity work.ULA_0_30
port map(
    entradaA => entradaA(13),
    entradaB => entradaB(13),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry12,
    cout => carry13,
    saida => saida(13)
);

ULA15 : entity work.ULA_0_30
port map(
    entradaA => entradaA(14),
    entradaB => entradaB(14),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry13,
    cout => carry14,
    saida => saida(14)
);

ULA16 : entity work.ULA_0_30
port map(
    entradaA => entradaA(15),
    entradaB => entradaB(15),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry14,
    cout => carry15,
    saida => saida(15)
);

ULA17 : entity work.ULA_0_30
port map(
    entradaA => entradaA(16),
    entradaB => entradaB(16),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry15,
    cout => carry16,
    saida => saida(16)
);

ULA18 : entity work.ULA_0_30
port map(
    entradaA => entradaA(17),
    entradaB => entradaB(17),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry16,
    cout => carry17,
    saida => saida(17)
);

ULA19 : entity work.ULA_0_30
port map(
    entradaA => entradaA(18),
    entradaB => entradaB(18),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry17,
    cout => carry18,
    saida => saida(18)
);

ULA20 : entity work.ULA_0_30
port map(
    entradaA => entradaA(19),
    entradaB => entradaB(19),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry18,
    cout => carry19,
    saida => saida(19)
);

ULA21 : entity work.ULA_0_30
port map(
    entradaA => entradaA(20),
    entradaB => entradaB(20),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry19,
    cout => carry20,
    saida => saida(20)
);

ULA22 : entity work.ULA_0_30
port map(
    entradaA => entradaA(21),
    entradaB => entradaB(21),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry20,
    cout => carry21,
    saida => saida(21)
);

ULA23 : entity work.ULA_0_30
port map(
    entradaA => entradaA(22),
    entradaB => entradaB(22),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry21,
    cout => carry22,
    saida => saida(22)
);

ULA24 : entity work.ULA_0_30
port map(
    entradaA => entradaA(23),
    entradaB => entradaB(23),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry22,
    cout => carry23,
    saida => saida(23)
);

ULA25 : entity work.ULA_0_30
port map(
    entradaA => entradaA(24),
    entradaB => entradaB(24),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry23,
    cout => carry24,
    saida => saida(24)
);

ULA26 : entity work.ULA_0_30
port map(
    entradaA => entradaA(25),
    entradaB => entradaB(25),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry24,
    cout => carry25,
    saida => saida(25)
);

ULA27 : entity work.ULA_0_30
port map(
    entradaA => entradaA(26),
    entradaB => entradaB(26),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry25,
    cout => carry26,
    saida => saida(26)
);

ULA28 : entity work.ULA_0_30
port map(
    entradaA => entradaA(27),
    entradaB => entradaB(27),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry26,
    cout => carry27,
    saida => saida(27)
);

ULA29 : entity work.ULA_0_30
port map(
    entradaA => entradaA(28),
    entradaB => entradaB(28),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry27,
    cout => carry28,
    saida => saida(28)
);

ULA30 : entity work.ULA_0_30
port map(
    entradaA => entradaA(29),
    entradaB => entradaB(29),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry28,
    cout => carry29,
    saida => saida(29)
);

ULA31 : entity work.ULA_0_30
port map(
    entradaA => entradaA(30),
    entradaB => entradaB(30),
    slt => '0',
    inverteB => inverteB, 
    seletor => seletor,
    cin => carry29,
    cout => carry30,
    saida => saida(30)
);

ULA32 : entity work.ULA_31
port map(
   entradaA => entradaA(31),
   entradaB => entradaB(31),
   slt      =>  '0',
   inverteB => inverteB,
   seletor  => seletor,
   cin      => carry30,
   saida    =>  saida(31),
   set      =>  slt_hab
);


flagZero <= '1' when unsigned(saida) = unsigned(zero) else '0';

end architecture;