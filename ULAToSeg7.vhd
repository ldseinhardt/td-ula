library ieee;
use ieee.std_logic_1164.all;

entity ULAToSeg7 is
 port(
  a, b    : in std_logic_vector(3 downto 0);
  f       : in std_logic_vector(2 downto 0);
  s       : out std_logic_vector(13 downto 0);
  v, n, z : out std_logic
);
end ULAToSeg7;

architecture ArqULAToSeg7 of ULAToSeg7 is
signal add: std_logic_vector(3 downto 0);
component ULAProject
port(
  a, b    : in std_logic_vector(3 downto 0);
  f       : in std_logic_vector(2 downto 0);
  s       : out std_logic_vector(3 downto 0);
  v, n, z : out std_logic
);
end component;

component BcdToSeg7
port(
  bcd: in std_logic_vector(3 downto 0);
  seg: out std_logic_vector(13 downto 0)
);
end component;
begin
  ULAProcess: ULAProject
    port map(a => a, b => b, f => f, s => add, v => v, n => n, z => z);

  Convert: BcdToSeg7
    port map(bcd => add, seg => s);
end ArqULAToSeg7;
