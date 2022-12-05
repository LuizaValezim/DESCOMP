library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
   generic (
      dataWidth : natural := 32;
      addrWidth : natural := 32;
      memoryAddrWidth : natural := 6); -- 64 posicoes de 32 bits cada
   port (
      clk : in STD_LOGIC;
      endereco : in std_logic_vector (addrWidth - 1 downto 0);
      Dado : out std_logic_vector (dataWidth - 1 downto 0));
end entity;

architecture assincrona OF memoriaROM is
   TYPE blocoMemoria is ARRAY(0 TO 2 ** memoryAddrWidth - 1) OF std_logic_vector(dataWidth - 1 downto 0);

   constant LW : std_logic_vector(5 downto 0) := "100011";
   constant SW : std_logic_vector(5 downto 0) := "101011";
   constant BEQ : std_logic_vector(5 downto 0) := "000100";
	constant ADDR : std_logic_vector(5 downto 0) := "100000";
	constant SUBR : std_logic_vector(5 downto 0) := "100010";
   constant J : std_logic_vector(5 downto 0) := "000010";  
   constant SLT : std_logic_vector(5 downto 0) := "101010";
   constant ANDR : std_logic_vector(5 downto 0) := "100100";
	constant ORR : std_logic_vector(5 downto 0) := "100101";

   constant T0 : std_logic_vector(4 downto 0) := "01000";
   constant T1 : std_logic_vector(4 downto 0) := "01001";
   constant T2 : std_logic_vector(4 downto 0) := "01010";
   constant T3 : std_logic_vector(4 downto 0) := "01011";
   constant T4 : std_logic_vector(4 downto 0) := "01100";
   constant T5 : std_logic_vector(4 downto 0) := "01101";
   constant T6 : std_logic_vector(4 downto 0) := "01110";

   constant SHAMT : std_logic_vector(4 downto 0) := "00000";
   constant TIPOR : std_logic_vector(5 downto 0) := "000000";
   constant IM1 : std_logic_vector(15 downto 0) := "0000000000000001";
   constant IM2 : std_logic_vector(15 downto 0) := "0000000000000010";
   constant IM3 : std_logic_vector(15 downto 0) := "0000000000001000";
   constant IM4 : std_logic_vector(15 downto 0) := "0000000000000000";
   constant IM2_N : std_logic_vector(15 downto 0) := "1111111111101101";
   constant IM5 : std_logic_vector(25 downto 0) := "00000000000000000000001110";

	signal memROM: blocoMemoria;
   attribute ram_init_file : string;
   attribute ram_init_file of memROM:
   signal is "Toplevel.mif";

   signal enderecoLocal : std_logic_vector(memoryAddrWidth - 1 downto 0);

begin
   enderecoLocal <= endereco(memoryAddrWidth + 1 downto 2);
   Dado <= memROM (to_integer(unsigned(enderecoLocal)));
end architecture;