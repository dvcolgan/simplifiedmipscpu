library ieee;
use ieee.std_logic_1164.all;

entity comparator is
	port (Value1, Value2: in std_logic_vector(31 downto 0);
	      Output: out std_logic);
end comparator;

architecture behavior of comparator is

	signal xors: std_logic_vector(31 downto 0);
	signal ortree: std_logic_vector(7 downto 0);
	signal ortree2: std_logic_vector(1 downto 0);

begin

	xorpile: for i in 31 downto 0 generate
		xors(i) <= Value1(i) xor Value2(i) after 35 ps;
	end generate;

	ortreepile: for i in 7 downto 0 generate
		ortree(i) <= xors(i*4) or xors(i*4+1) or xors(i*4+2) or xors(i*4+3) after 35 ps;
	end generate;

	ortree2(0) <= ortree(0) or ortree(1) or ortree(2) or ortree(3) after 35 ps;
	ortree2(1) <= ortree(4) or ortree(5) or ortree(6) or ortree(7) after 35 ps;
	Output <= ortree2(0) or ortree2(1) after 35 ps;

end behavior;
