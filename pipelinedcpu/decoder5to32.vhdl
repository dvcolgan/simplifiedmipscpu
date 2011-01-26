library ieee;
use ieee.std_logic_1164.all;

use work.decoder4to16;
use work.decoder1to2;

entity decoder5to32 is
	port (S: in std_logic_vector(4 downto 0);
	      R: in std_logic;
	      O: out std_logic_vector(31 downto 0));
end decoder5to32;

architecture behavior of decoder5to32 is
	component decoder4to16
		port (S: in std_logic_vector(3 downto 0);
		      R: in std_logic;
		      O: out std_logic_vector(15 downto 0));
	end component;
	component decoder1to2 is
		port (S: in std_logic;
		      R: in std_logic;
		      O: out std_logic_vector(1 downto 0));
	end component;

	signal con: std_logic_vector(1 downto 0);
begin
	decoder4to16_0: decoder4to16 port map (S=>S(3 downto 0), R=>con(0), O=>O(15 downto 0));
	decoder4to16_1: decoder4to16 port map (S=>S(3 downto 0), R=>con(1), O=>O(31 downto 16));

	decoder1to2_0: decoder1to2 port map (S=>S(4), R=>R, O=>con);
end behavior;
