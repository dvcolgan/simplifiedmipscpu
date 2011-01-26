library ieee;
use ieee.std_logic_1164.all;

use work.mux4to1;

entity mux16to1 is
	port (S: in std_logic_vector(3 downto 0);
	      R: in std_logic_vector(15 downto 0);
	      O: out std_logic);
end mux16to1;

architecture behavior of mux16to1 is
	component mux4to1
		port (S: in std_logic_vector(1 downto 0);
		      R: in std_logic_vector(3 downto 0);
		      O: out std_logic);
	end component;

	signal con: std_logic_vector(3 downto 0);
begin
	mux4to1_0: mux4to1 port map (R=>R(3 downto 0),   S=>S(1 downto 0), O=>con(0));
	mux4to1_1: mux4to1 port map (R=>R(7 downto 4),   S=>S(1 downto 0), O=>con(1));
	mux4to1_2: mux4to1 port map (R=>R(11 downto 8),  S=>S(1 downto 0), O=>con(2));
	mux4to1_3: mux4to1 port map (R=>R(15 downto 12), S=>S(1 downto 0), O=>con(3));

	mux4to1_4: mux4to1 port map (R=>con,  S(1 downto 0)=>S(3 downto 2), O=>O);
end behavior;
