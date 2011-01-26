library ieee;
use ieee.std_logic_1164.all;

use work.decoder2to4;

entity decoder4to16 is
	port (S: in std_logic_vector(3 downto 0);
	      R: in std_logic;
	      O: out std_logic_vector(15 downto 0));
end decoder4to16;

architecture behavior of decoder4to16 is
	component decoder2to4
		port (S: in std_logic_vector(1 downto 0);
		      R: in std_logic;
		      O: out std_logic_vector(3 downto 0));
	end component;

	signal con: std_logic_vector(3 downto 0);
begin
	decoder2to4_0: decoder2to4 port map (S=>S(1 downto 0), R=>con(0), O=>O(3 downto 0));
	decoder2to4_1: decoder2to4 port map (S=>S(1 downto 0), R=>con(1), O=>O(7 downto 4));
	decoder2to4_2: decoder2to4 port map (S=>S(1 downto 0), R=>con(2), O=>O(11 downto 8));
	decoder2to4_3: decoder2to4 port map (S=>S(1 downto 0), R=>con(3), O=>O(15 downto 12));

	decoder2to4_4: decoder2to4 port map (S=>S(3 downto 2), R=>R, O=>con);
end behavior;
