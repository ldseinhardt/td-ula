library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
port(
  a, b, carry_in: in std_logic;
  s, carry_out: out std_logic
);
end FullAdder;

architecture ArqAdder of FullAdder IS
begin
  s         <= a xor b xor carry_in;
  carry_out <= (a and b) or (a and carry_in) or (b and carry_in);
end ArqAdder;
