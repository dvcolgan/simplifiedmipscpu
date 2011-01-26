library ieee;
use ieee.std_logic_1164.all;

use work.fulladder32;
use work.mux2to1;

entity addersubtractor32 is
	port (A: in std_logic_vector(31 downto 0);
	      B: in std_logic_vector(31 downto 0);
	      Cin: in std_logic;
	      S: out std_logic_vector(31 downto 0);
	      Cout: out std_logic;
	      Over: out std_logic);
end addersubtractor32;

architecture behavior of addersubtractor32 is

	component fulladder32 is
		port (A: in std_logic_vector(31 downto 0);
		      B: in std_logic_vector(31 downto 0);
		      Cin: in std_logic;
		      S: out std_logic_vector(31 downto 0);
		      Cout: out std_logic;
		      Over: out std_logic);
	end component;

	component mux2to1
		port (S: in std_logic;
		      R: in std_logic_vector(1 downto 0);
		      O: out std_logic);
	end component;

signal notbs: std_logic_vector(31 downto 0);
signal bcons_from_mux: std_logic_vector(31 downto 0);

begin
	notbs <= not B after 35 ps;

	invert_muxen: for i in 31 downto 0 generate
		mux2to1_x: mux2to1 port map (S=>Cin, R(0)=>B(i), R(1)=>notbs(i), O=>bcons_from_mux(i));
	end generate;

	fulladder32_0: fulladder32 port map (A=>A, B=>bcons_from_mux, Cin=>Cin, S=>S, Cout=>Cout, Over=>Over);
end behavior;
