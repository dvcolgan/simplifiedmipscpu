library ieee;
use ieee.std_logic_1164.all;

entity ground32 is
	port (G: out std_logic_vector(31 downto 0));
end ground32;

architecture behavior of ground32 is
begin
	G <= X"0000_0000";
end behavior;
