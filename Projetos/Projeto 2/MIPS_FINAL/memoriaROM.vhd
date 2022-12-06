library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
   generic (
      datawidth : natural := 32;
      addrwidth : natural := 32;
      memoryaddrwidth : natural := 6); -- 64 posicoes de 32 bits cada
   port (
      clk : in std_logic;
      endereco : in std_logic_vector (addrwidth - 1 downto 0);
      dado : out std_logic_vector (datawidth - 1 downto 0));
end entity;

architecture assincrona of memoriaROM is
   type blocomemoria is array(0 to 2 ** memoryaddrwidth - 1) of std_logic_vector(datawidth - 1 downto 0);

   constant lw : std_logic_vector(5 downto 0) := "100011";
   constant sw : std_logic_vector(5 downto 0) := "101011";
   constant beq : std_logic_vector(5 downto 0) := "000100";
	constant addr : std_logic_vector(5 downto 0) := "100000";
	constant subr : std_logic_vector(5 downto 0) := "100010";
   constant j : std_logic_vector(5 downto 0) := "000010";  
   constant slt : std_logic_vector(5 downto 0) := "101010";
   constant andr : std_logic_vector(5 downto 0) := "100100";
	constant orr : std_logic_vector(5 downto 0) := "100101";
   
   constant ori : std_logic_vector(5 downto 0) := "001101";
	constant addi : std_logic_vector(5 downto 0) := "001000";
	constant andi : std_logic_vector(5 downto 0) := "001100";
	constant slti : std_logic_vector(5 downto 0) := "001010";
	constant lui : std_logic_vector(5 downto 0) := "001111";

   constant t0 : std_logic_vector(4 downto 0) := "01000";
   constant t1 : std_logic_vector(4 downto 0) := "01001";
   constant t2 : std_logic_vector(4 downto 0) := "01010";
   constant t3 : std_logic_vector(4 downto 0) := "01011";
   constant t4 : std_logic_vector(4 downto 0) := "01100";
   constant t5 : std_logic_vector(4 downto 0) := "01101";
   constant t6 : std_logic_vector(4 downto 0) := "01110";

   constant shamt : std_logic_vector(4 downto 0) := "00000";
   constant tipor : std_logic_vector(5 downto 0) := "000000";
   constant im1 : std_logic_vector(15 downto 0) := "0000000000000001";
   constant im2 : std_logic_vector(15 downto 0) := "0000000000000010";
   constant im3 : std_logic_vector(15 downto 0) := "0000000000001000";
   constant im4 : std_logic_vector(15 downto 0) := "0000000000000000";
   constant im2_n : std_logic_vector(15 downto 0) := "1111111111101101";
   constant im5 : std_logic_vector(25 downto 0) := "00000000000000000000001110";
   constant im6 : std_logic_vector(15 downto 0) := "0000000000001001";
   constant tudo_f : std_logic_vector(15 downto 0) := "1111111111111111";


--   function initmemory
--      return blocomemoria is variable tmp : blocomemoria := (others => (others => '0'));

--   begin

      -- falta fazer os testesssssssss
            -- 6      5    5      16     bits
   --    --     opcode  rs   rt   imediato
   --    tmp(0) := sw & t0 & t1 & im4; --mem_dados[r[rs] + estendesinal(imediato)]=r[rt]    | mem[0] = 10
   --    tmp(1) := lw & t0 & t2 & im4; --lw t2, 0x00($t0) -- load em t2 o que está em mem[0] | t2 = 10
   --    tmp(2) := addi & t2 & t3 & im2; --t3 = 10 + 2 = 12
   --    tmp(3) := slti & t2 & t3 & im2; -- t3 = 10 < 2 = 0
   --    tmp(4) := slti & t3 & t2 & im3; -- t3 = 0 < 8 = 1 ;
   --    tmp(5) := andi & t4 & t1 & im6; -- t1 = 13 & 9 = 1101 & 1001 = 1001 = 9 
   --    tmp(6) := ori  & t1 & t2 & im2; -- t2 = 9 | 1 = 1001 | 0010 = 1011 = 11
   --    tmp(7) := lui & "00000" & t0 & tudo_f; -- t1 = 10


   --    return tmp;
   -- end initmemory;

   -- signal memrom : blocomemoria := initmemory;

  signal memrom: blocomemoria;
  attribute ram_init_file : string;
  attribute ram_init_file of memrom:
  signal is "toplevel.mif";

   -- utiliza uma quantidade menor de endereços locais:
   signal enderecolocal : std_logic_vector(memoryaddrwidth - 1 downto 0);

begin
   enderecolocal <= endereco(memoryaddrwidth + 1 downto 2);
   dado <= memrom (to_integer(unsigned(enderecolocal)));
end architecture;