library ieee;
use ieee.std_logic_1164.all;

use work.nor1;

entity nor32 is
	port (R1: in std_logic_vector(31 downto 0);
	      R2: in std_logic_vector(31 downto 0);
	      O: out std_logic_vector(31 downto 0));
end nor32;

architecture behavior of nor32 is
	component nor1 is
		port (R1: in std_logic;
		      R2: in std_logic;
		      O: out std_logic);
	end component;

begin
	nor1s: for i in 31 downto 0 generate
		nor1_x: nor1 port map (R1=>R1(i), R2=>R2(i), O=>O(i));
	end generate;
end behavior;
