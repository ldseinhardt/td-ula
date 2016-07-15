library ieee;
use ieee.std_logic_1164.all;

entity BcdToSeg7 is
port(
  bcd: in std_logic_vector(3 downto 0);
  seg: out std_logic_vector(13 downto 0)
);
end BcdToSeg7;

architecture ArqBcdToSeg7 of BcdToSeg7 is
begin
  with bcd select
  seg <= "10000001000000" when "0000",
         "10000001111001" when "0001",
         "10000000100100" when "0010",
         "10000000110000" when "0011",
         "10000000011001" when "0100",
         "10000000010010" when "0101",
         "10000000000010" when "0110",
         "10000001111000" when "0111",
         "10000000000000" when "1000",
         "10000000010000" when "1001",
         "11110011000000" when "1010",
         "11110011111001" when "1011",
         "11110010100100" when "1100",
         "11110010110000" when "1101",
         "11110010011001" when "1110",
         "11110010010010" when "1111";
end ArqBcdToSeg7;
