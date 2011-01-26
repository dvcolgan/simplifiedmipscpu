library ieee;
use ieee.std_logic_1164.all;

use work.or1;

entity or32 is
	port (R1: in std_logic_vector(31 downto 0);
	      R2: in std_logic_vector(31 downto 0);
	      O: out std_logic_vector(31 downto 0));
end or32;

architecture behavior of or32 is
	component or1 is
		port (R1: in std_logic;
		      R2: in std_logic;
		      O: out std_logic);
	end component;

begin
	or1s: for i in 31 downto 0 generate
		or1_x: or1 port map (R1=>R1(i), R2=>R2(i), O=>O(i));
	end generate;
end behavior;
