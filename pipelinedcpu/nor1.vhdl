library ieee;
use ieee.std_logic_1164.all;

entity nor1 is
	port (R1: in std_logic;
	      R2: in std_logic;
	      O: out std_logic);
end nor1;

architecture behavior of nor1 is
begin
	O <= R1 nor R2 after 35 ps;
end behavior;
