library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
	port (S: in std_logic_vector(1 downto 0);
	      R: in std_logic_vector(3 downto 0);
	      O: out std_logic);
end mux4to1;

architecture behavior of mux4to1 is
	signal con: std_logic_vector(3 downto 0);
begin

	con(0) <= ((not S(0)) and (not S(1)) ) and R(0) after 105 ps;
	con(1) <= (     S(0)  and (not S(1)) ) and R(1) after 105 ps;
	con(2) <= ((not S(0)) and      S(1)  ) and R(2) after 105 ps;
	con(3) <= (     S(0)  and      S(1)  ) and R(3) after 70 ps;

	O <= (con(0) or con(1) or con(2) or con(3)) after 35 ps;

end behavior;
