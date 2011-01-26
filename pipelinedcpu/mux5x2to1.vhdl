library ieee;
use ieee.std_logic_1164.all;

use work.mux2to1;
use work.datatypes.bus2x5;
use work.datatypes.bus5x2;

entity mux5x2to1 is
	port (S: in std_logic;
	      R: in bus2x5;
	      O: out std_logic_vector(4 downto 0));
end mux5x2to1;

architecture behavior of mux5x2to1 is
	component mux2to1
		port (S: in std_logic;
		      R: in std_logic_vector(1 downto 0);
		      O: out std_logic);
	end component;

signal cons: bus5x2;

begin
	muxen: for i in 4 downto 0 generate
		mux2to1_x: mux2to1 port map (S=>S, R=>cons(i), O=>O(i));
	end generate;

	input_bit: for j in 4 downto 0 generate
		input_bus: for k in 1 downto 0 generate
			cons(j)(k) <= R(k)(j);
		end generate;
	end generate;
end behavior;
