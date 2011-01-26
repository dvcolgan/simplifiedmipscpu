library ieee;
use ieee.std_logic_1164.all;

use work.mux16to1;
use work.mux2to1;

entity mux32to1 is
	port (S: in std_logic_vector(4 downto 0);
	      R: in std_logic_vector(31 downto 0);
	      O: out std_logic);
end mux32to1;

architecture behavior of mux32to1 is
	component mux16to1
		port (S: in std_logic_vector(3 downto 0);
		      R: in std_logic_vector(15 downto 0);
		      O: out std_logic);
	end component;
	component mux2to1
		port (S: in std_logic;
		      R: in std_logic_vector(1 downto 0);
		      O: out std_logic);
	end component;

	signal con: std_logic_vector(1 downto 0);
begin
	mux16to1_0: mux16to1 port map (R=>R(15 downto 0), S=>S(3 downto 0), O=>con(0));
	mux16to1_1: mux16to1 port map (R=>R(31 downto 16), S=>S(3 downto 0), O=>con(1));

	mux2to1_0: mux2to1 port map (R(0)=>con(0), R(1)=>con(1), S=>S(4), O=>O);
end behavior;
