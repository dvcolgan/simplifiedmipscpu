library ieee;
USE ieee.std_logic_1164.all;

use work.dff;
use work.mux32x2to1;
use work.datatypes.bus2x32;

entity reg is
	port (WE, clock, init: in std_logic;
	      D: in std_logic_vector(31 downto 0);
	      Q: out std_logic_vector(31 downto 0));
end reg;

architecture behavior of reg is
	component dff
		port (D, WE, clock: in std_logic;
		      Q, Qprime: out std_logic);
	end component;

	component mux32x2to1 is
		port (S: in std_logic;
		      R: in bus2x32;
		      O: out std_logic_vector(31 downto 0));
	end component;

	signal Output: std_logic_vector(31 downto 0);
begin

	dffs: for i in 31 downto 0 generate
		dff_x: dff port map (D=>D(i), WE=>WE, clock=>clock, Q=>Output(i));
	end generate;

	mux: mux32x2to1 port map (S=>init, R(0)=>X"0000_0000", R(1)=>Output, O=>Q);

end behavior;
