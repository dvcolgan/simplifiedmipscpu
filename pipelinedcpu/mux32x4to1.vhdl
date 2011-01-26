library ieee;
use ieee.std_logic_1164.all;

use work.mux4to1;
use work.datatypes.bus4x32;
use work.datatypes.bus32x4;

entity mux32x4to1 is
	port (S: in std_logic_vector(1 downto 0);
	      R: in bus4x32;
	      O: out std_logic_vector(31 downto 0));
end mux32x4to1;

architecture behavior of mux32x4to1 is
	component mux4to1
		port (S: in std_logic_vector(1 downto 0);
		      R: in std_logic_vector(3 downto 0);
		      O: out std_logic);
	end component;

signal cons: bus32x4;

begin
	muxen: for i in 31 downto 0 generate
		mux4to1_x: mux4to1 port map (S=>S, R=>cons(i), O=>O(i));
	end generate;

	input_bit: for j in 31 downto 0 generate
		input_bus: for k in 3 downto 0 generate
			cons(j)(k) <= R(k)(j);
		end generate;
	end generate;
end behavior;
