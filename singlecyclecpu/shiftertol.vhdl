library ieee;
use ieee.std_logic_1164.all;

use work.shifter32x1tol;
use work.shifter32x2tol;
use work.shifter32x4tol;
use work.shifter32x8tol;
use work.shifter32x16tol;

entity shiftertol is
	port (S: in std_logic_vector(4 downto 0);
	      R: in std_logic_vector(31 downto 0);
	      O: out std_logic_vector(31 downto 0);
	      C: out std_logic);
end shiftertol;

architecture behavior of shiftertol is
	component shifter32x1tol is
		port (S: in std_logic;
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component shifter32x2tol is
		port (S: in std_logic;
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component shifter32x4tol is
		port (S: in std_logic;
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component shifter32x8tol is
		port (S: in std_logic;
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component shifter32x16tol is
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

	shifter32x16tol_0: shifter32x16tol port map (S=>S(4), R=>R, O=>con16to8);
	shifter32x8tol_0: shifter32x8tol port map (S=>S(3), R=>con16to8, O=>con8to4);
	shifter32x4tol_0: shifter32x4tol port map (S=>S(2), R=>con8to4, O=>con4to2);
	shifter32x2tol_0: shifter32x2tol port map (S=>S(1), R=>con4to2, O=>con2to1);
	shifter32x1tol_0: shifter32x1tol port map (S=>S(0), R=>con2to1, O=>O);

	zero <= (S(0) or S(1) or S(2)) or (S(3) or S(4)) after 70 ps;
	C <= zero and R(31) after 35 ps;

end behavior;
