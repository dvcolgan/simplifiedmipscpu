library ieee;
use ieee.std_logic_1164.all;

entity fulladder1 is
	port (A: in std_logic;
	      B: in std_logic;
	      Cin: in std_logic;
	      S: out std_logic;
	      Cout: out std_logic);
end fulladder1;

architecture behavior of fulladder1 is
	signal con0: std_logic;
	signal con1: std_logic;
	signal con2: std_logic;
	signal con3: std_logic;
begin
	con0 <= A xor B after 35 ps;
	S <= con0 xor Cin after 35 ps;

	con1 <= con0 and Cin after 35 ps;
	con2 <= A and B after 35 ps;
	Cout <= con1 or con2 after 35 ps;
end behavior;
