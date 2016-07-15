library ieee;
use ieee.std_logic_1164.all;

entity Adder4bits is
port(
  a, b: in std_logic_vector(3 downto 0);
  control: in std_logic;
  result: out std_logic_vector(3 downto 0);
  overflow: out std_logic
);
end Adder4bits;

architecture ArqAdder4bits of Adder4bits is
signal carry: std_logic_vector(3 downto 0);
component FullAdder
port(
  a, b, carry_in: in std_logic;
  s, carry_out: out std_logic
);
end component;
begin
  bit1: FullAdder
    port map(a => a(0), b => (b(0) xor control), carry_in => control, s => result(0), carry_out => carry(0));

  bit2: FullAdder
    port map(a => a(1), b => (b(1) xor control), carry_in => carry(0), s => result(1), carry_out => carry(1));

  bit3: FullAdder
    port map(a => a(2), b => (b(2) xor control), carry_in => carry(1), s => result(2), carry_out => carry(2));

  bit4: FullAdder
    port map(a => a(3), b => (b(3) xor control), carry_in => carry(2), s => result(3), carry_out => carry(3));
  overflow <= carry(3) xor carry(2);

end ArqAdder4bits;
