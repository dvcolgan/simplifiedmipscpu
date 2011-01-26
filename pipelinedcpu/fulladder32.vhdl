library ieee;
use ieee.std_logic_1164.all;

use work.fulladder1;

entity fulladder32 is
	port (A: in std_logic_vector(31 downto 0);
	      B: in std_logic_vector(31 downto 0);
	      Cin: in std_logic;
	      S: out std_logic_vector(31 downto 0);
	      Cout: out std_logic;
	      Over: out std_logic);
end fulladder32;

architecture behavior of fulladder32 is
	component fulladder1
		port (A: in std_logic;
		      B: in std_logic;
		      Cin: in std_logic;
		      S: out std_logic;
		      Cout: out std_logic);
	end component;

signal cons: std_logic_vector(31 downto 0);
signal temp_output: std_logic_vector(31 downto 0);

begin
	adders: for i in 31 downto 0 generate
		rightmost: if i=0 generate
			fulladder1_0: fulladder1 port map (A=>A(i), B=>B(i), Cin=>Cin, S=>temp_output(i), Cout=>cons(i));
		end generate;

		leftmost: if i=31 generate
			fulladder1_31: fulladder1 port map (A=>A(i), B=>B(i), Cin=>cons(i-1), S=>temp_output(i), Cout=>cons(i));
		end generate;

		otherwise: if i/=0 generate
			fulladder1_x: fulladder1 port map (A=>A(i), B=>B(i), Cin=>cons(i-1), S=>temp_output(i), Cout=>cons(i));
		end generate;
	end generate;

	S <= temp_output;
	Cout <= cons(31);
	Over <= cons(31) xor cons(30) after 35 ps;
end behavior;
