library ieee;
use ieee.std_logic_1164.all;

entity decoder1to2 is
	port (S: in std_logic;
	      R: in std_logic;
	      O: out std_logic_vector(1 downto 0));
end decoder1to2;

architecture behavior of decoder1to2 is
begin
	O(0) <= (not S) and R after 70 ps;
	O(1) <= S and R after 35 ps;
end behavior;
