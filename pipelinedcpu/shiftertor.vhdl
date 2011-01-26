library ieee;
use ieee.std_logic_1164.all;

use work.shifter32x1tor;
use work.shifter32x2tor;
use work.shifter32x4tor;
use work.shifter32x8tor;
use work.shifter32x16tor;

entity shiftertor is
	port (S: in std_logic_vector(4 downto 0);
	      R: in std_logic_vector(31 downto 0);
	      O: out std_logic_vector(31 downto 0);
	      C: out std_logic);
end shiftertor;

architecture behavior of shiftertor is
	component shifter32x1tor is
		port (S: in std_logic;
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component shifter32x2tor is
		port (S: in std_logic;
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component shifter32x4tor is
		port (S: in std_logic;
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component shifter32x8tor is
		port (S: in std_logic;
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component shifter32x16tor is
		port (S: in std_logic;
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	signal con16to8: std_logic_vector(31 downto 0);
	signal con8to4: std_logic_vector(31 downto 0);
	signal con4to2: std_logic_vector(31 downto 0);
	signal con2to1: std_logic_vector(31 downto 0);
	signal zero: std_logic;
begin

	shifter32x16tor_0: shifter32x16tor port map (S=>S(4), R=>R, O=>con16to8);
	shifter32x8tor_0: shifter32x8tor port map (S=>S(3), R=>con16to8, O=>con8to4);
	shifter32x4tor_0: shifter32x4tor port map (S=>S(2), R=>con8to4, O=>con4to2);
	shifter32x2tor_0: shifter32x2tor port map (S=>S(1), R=>con4to2, O=>con2to1);
	shifter32x1tor_0: shifter32x1tor port map (S=>S(0), R=>con2to1, O=>O);

	zero <= (S(0) or S(1) or S(2)) or (S(3) or S(4)) after 70 ps;
	C <= zero and R(0) after 35 ps;
end behavior;
