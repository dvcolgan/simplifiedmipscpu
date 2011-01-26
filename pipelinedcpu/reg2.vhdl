library ieee;
USE ieee.std_logic_1164.all;

use work.dff;

entity reg2 is
	port (WE, clock: in std_logic;
	      D: in std_logic_vector(1 downto 0);
	      Q: out std_logic_vector(1 downto 0));
end reg2;

architecture behavior of reg2 is
	component dff
		port (D, WE, clock: in std_logic;
		      Q, Qprime: out std_logic);
	end component;
begin

	dffs: for i in 1 downto 0 generate
		dff_x: dff port map (D=>D(i), WE=>WE, clock=>clock, Q=>Q(i));
	end generate;
end behavior;

