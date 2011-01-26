library ieee;
use ieee.std_logic_1164.all;

entity or1 is
	port (R1: in std_logic;
	      R2: in std_logic;
	      O: out std_logic);
end or1;

architecture behavior of or1 is
begin
	O <= R1 or R2 after 35 ps;
end behavior;
