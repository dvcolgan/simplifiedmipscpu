library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
	port (S: in std_logic;
	      R: in std_logic_vector(1 downto 0);
	      O: out std_logic);
end mux2to1;

architecture behavior of mux2to1 is
begin
	O <= ((not S) and R(0)) or (S and R(1)) after 105 ps;
end behavior;
