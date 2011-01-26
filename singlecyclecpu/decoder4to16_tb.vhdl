library ieee;
use ieee.std_logic_1164.all;

use work.decoder4to16;

entity decoder4to16_tb is
end decoder4to16_tb;

architecture behavior of decoder4to16_tb is
	component decoder4to16
		port (S: in std_logic_vector(3 downto 0);
		      R: in std_logic;
		      O: out std_logic_vector(15 downto 0));
	end component;

	signal S: std_logic_vector(3 downto 0);
	signal R: std_logic;
	signal O: std_logic_vector(15 downto 0);
begin
	decoder4to16_0: decoder4to16 port map (S, R, O);

	process
		type pattern_type is record
			S0, S1, S2, S3, R, O0, O1, O2, O3, O4, O5, O6, O7, O8, O9, O10, O11, O12, O13, O14, O15: std_logic;
		end record;

	type pattern_array is array (natural range <>) of pattern_type;
	constant patterns : pattern_array :=
		-- S0  S1  S2  S3   R    O0  O1  O2  O3  O4  O5  O6  O7  O8  O9  O10 O11 O12 O13 O14 O15
		(('0','0','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),

		 ('0','0','0','0', '1', '1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','0','0', '1', '0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','0','0', '1', '0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','0','0', '1', '0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','1','0', '1', '0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','1','0', '1', '0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','1','0', '1', '0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0'),
		 ('1','1','1','0', '1', '0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0'),
		 ('0','0','0','1', '1', '0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0'),
		 ('1','0','0','1', '1', '0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0'),
		 ('0','1','0','1', '1', '0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0'),
		 ('1','1','0','1', '1', '0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0'),
		 ('0','0','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0'),
		 ('1','0','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0'),
		 ('0','1','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0'),
		 ('1','1','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1'));

	begin
		assert false report "Testing decoder4to16" severity note;
		for c in patterns'range loop
			S(0) <= patterns(c).S0;
			S(1) <= patterns(c).S1;
			S(2) <= patterns(c).S2;
			S(3) <= patterns(c).S3;
			R <= patterns(c).R;
			wait for 1 ns;
			assert O(0) = patterns(c).O0 report "test failed" severity error;
			assert O(1) = patterns(c).O1 report "test failed" severity error;
			assert O(2) = patterns(c).O2 report "test failed" severity error;
			assert O(3) = patterns(c).O3 report "test failed" severity error;
			assert O(4) = patterns(c).O4 report "test failed" severity error;
			assert O(5) = patterns(c).O5 report "test failed" severity error;
			assert O(6) = patterns(c).O6 report "test failed" severity error;
			assert O(7) = patterns(c).O7 report "test failed" severity error;
			assert O(8) = patterns(c).O8 report "test failed" severity error;
			assert O(9) = patterns(c).O9 report "test failed" severity error;
			assert O(10) = patterns(c).O10 report "test failed" severity error;
			assert O(11) = patterns(c).O11 report "test failed" severity error;
			assert O(12) = patterns(c).O12 report "test failed" severity error;
			assert O(13) = patterns(c).O13 report "test failed" severity error;
			assert O(14) = patterns(c).O14 report "test failed" severity error;
			assert O(15) = patterns(c).O15 report "test failed" severity error;
		end loop;

		wait;
	end process;
end behavior;

