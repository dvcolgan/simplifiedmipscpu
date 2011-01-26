library ieee;
use ieee.std_logic_1164.all;

entity decoder2to4 is
	port (S: in std_logic_vector(1 downto 0);
	      R: in std_logic;
	      O: out std_logic_vector(3 downto 0));
end decoder2to4;

architecture behavior of decoder2to4 is
begin
	O(0) <= ((not S(0)) and (not S(1))) and R after 105 ps;
	O(1) <= (S(0) and (not S(1))) and R after 105 ps;
	O(2) <= ((not S(0)) and S(1)) and R after 105 ps;
	O(3) <= (S(0) and S(1)) and R after 70 ps;
end behavior;
