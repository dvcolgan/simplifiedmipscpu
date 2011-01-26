library ieee;
use ieee.std_logic_1164.all;

use work.decoder2to4;

entity decoder2to4_tb is
end decoder2to4_tb;

architecture behavior of decoder2to4_tb is
	component decoder2to4
		port (S: in std_logic_vector(1 downto 0);
		      R: in std_logic;
		      O: out std_logic_vector(3 downto 0));
	end component;

	signal S: std_logic_vector(1 downto 0);
	signal R: std_logic;
	signal O: std_logic_vector(3 downto 0);
begin
	decoder2to4_0: decoder2to4 port map (S, R, O);

	process
		type pattern_type is record
			S0, S1, R, O0, O1, O2, O3: std_logic;
		end record;

	type pattern_array is array (natural range <>) of pattern_type;
	constant patterns : pattern_array :=
		-- S0  S1   R    O0  O1  O2  O3
		(('0','0', '0', '0','0','0','0'),
		 ('1','0', '0', '0','0','0','0'),
		 ('0','1', '0', '0','0','0','0'),
		 ('1','1', '0', '0','0','0','0'),
		 ('0','0', '1', '1','0','0','0'),
		 ('1','0', '1', '0','1','0','0'),
		 ('0','1', '1', '0','0','1','0'),
		 ('1','1', '1', '0','0','0','1'));

	begin
		assert false report "Testing decoder2to4" severity note;
		for c in patterns'range loop
			S(0) <= patterns(c).S0;
			S(1) <= patterns(c).S1;
			R <= patterns(c).R;
			wait for 1 ns;
			assert O(0) = patterns(c).O0 report "test failed" severity error;
			assert O(1) = patterns(c).O1 report "test failed" severity error;
			assert O(2) = patterns(c).O2 report "test failed" severity error;
			assert O(3) = patterns(c).O3 report "test failed" severity error;
		end loop;

		wait;
	end process;
end behavior;

