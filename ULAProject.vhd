library ieee;
use ieee.std_logic_1164.all;

entity ULAProject is
port(
  a, b    : in std_logic_vector(3 downto 0);
  f       : in std_logic_vector(2 downto 0);
  s       : out std_logic_vector(3 downto 0);
  v, n, z : out std_logic
);
end ULAProject;

architecture ArqULAProject of ULAProject is
signal add, sl, sr, result: std_logic_vector(3 downto 0);
signal control, shift, input, overflow, slv, asm: std_logic;
component Adder4bits
port(
  a, b     : in std_logic_vector(3 downto 0);
  control  : in std_logic;
  result   : out std_logic_vector(3 downto 0);
  overflow : out std_logic
);
end component;
begin
  --Entrada para deslocamento, esquerda e direita
  input <= '0';

  --Se a operação for subtração, control=1, somador passa a ser um subtrator
  control <= '1' when f = "101" else '0';

  --Se a operação for de deslocamento (esquerda ou direita), shift=1, ativa o deslocamento
  with f select shift <= '1' when "110", '1' when "111", '0' when others;

  --Faz o deslocamento esquerdo (Multiplicão)
  sl(0) <= b(0) when shift = '0' else input;
  sl(1) <= b(1) when shift = '0' else b(0);
  sl(2) <= b(2) when shift = '0' else b(1);
  slv   <= b(3); -- Overflow para deslocamento esquerdo
  sl(3) <= b(3) when shift = '0' else b(2);
  --Faz o deslocamento direito (Divisão)

  sr(0) <= b(0) when shift = '0' else b(1);
  sr(1) <= b(1) when shift = '0' else b(2);
  sr(2) <= b(2) when shift = '0' else b(3);
  sr(3) <= b(3) when shift = '0' else input;

  --Faz a soma/subtração por componente, Passa o valor para o flag OVERFLOW
  Adder: Adder4bits
    port map(a => a, b => b, result => add, overflow => overflow, control => control);

  --Coloca em result o valor de saída que for pedido pela operação
  with f select
  result <= add     when "000",
          a and b   when "001",
          a or b    when "010",
          not a     when "011",
          a         when "100",
          add       when "101",
          sl        when "110",
          sr        when "111";

  --Caso a soma seja igual a zero ativa o flag Z (Zero)
  z <= '1' when result = "0000" else '0';

  --Flag N (Negativo) = control and (a < b)
  asm <= '1' when a < b else '0';
  n <= control and asm;

  --Flag V (Overlow) = Overlow em Soma ou Overflow em Multiplicão
  with f select v <= overflow when "000", slv when "110", '0' when others;

  --Coloca na saída o resultado
  s <= result;
end ArqULAProject;
