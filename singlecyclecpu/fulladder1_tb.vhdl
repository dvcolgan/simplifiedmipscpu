library ieee;
use ieee.std_logic_1164.all;

use work.fulladder1;

entity fulladder1_tb is
end fulladder1_tb;

architecture behavior of fulladder1_tb is
	component fulladder1 is
		port (A: in std_logic;
		      B: in std_logic;
		      Cin: in std_logic;
		      S: out std_logic;
		      Cout: out std_logic);
	end component;

	signal A: std_logic;
	signal B: std_logic;
	signal Cin: std_logic;
	signal S: std_logic;
	signal Cout: std_logic;
begin
	fulladder1_0: fulladder1 port map (A, B, Cin, S, Cout);

	process
		type pattern_type is record
			A, B, Cin, S, Cout: std_logic;
		end record;

	type pattern_array is array (natural range <>) of pattern_type;
	constant patterns : pattern_array :=
		-- A,  B   Cin, S, Cout
		(('0','0','0', '0','0'),
		 ('0','0','1', '1','0'),
		 ('0','1','0', '1','0'),
		 ('1','0','0', '1','0'),
		 ('0','1','1', '0','1'),
		 ('1','1','0', '0','1'),
		 ('1','0','1', '0','1'),
		 ('1','1','1', '1','1'));
	begin
		assert false report "Testing fulladder1" severity note;
		for c in patterns'range loop
			A <= patterns(c).A;
			B <= patterns(c).B;
			Cin <= patterns(c).Cin;
			wait for 2 ns;
			assert S = patterns(c).S report "test failed" severity error;
			assert Cout = patterns(c).Cout report "test failed" severity error;
		end loop;

		wait;
	end process;
end behavior;

