library ieee;
use ieee.std_logic_1164.all;

use work.decoder5to32;

entity decoder5to32_tb is
end decoder5to32_tb;

architecture behavior of decoder5to32_tb is
	component decoder5to32
		port (S: in std_logic_vector(4 downto 0);
		      R: in std_logic;
		      O: out std_logic_vector(31 downto 0));
	end component;

	signal S: std_logic_vector(4 downto 0);
	signal R: std_logic;
	signal O: std_logic_vector(31 downto 0);
begin
	decoder5to32_0: decoder5to32 port map (S, R, O);

	process
		type pattern_type is record
			S0, S1, S2, S3, S4, R, O0, O1, O2, O3, O4, O5, O6, O7, O8, O9, O10, O11, O12, O13, O14, O15,
			O16, O17, O18, O19, O20, O21, O22, O23, O24, O25, O26, O27, O28, O29, O30, O31: std_logic;
		end record;

	type pattern_array is array (natural range <>) of pattern_type;
	constant patterns : pattern_array :=
		-- S0  S1  S2  S3  S3   R    O0  O1  O2  O3  O4  O5  O6  O7  O8  O9  O10 O11 O12 O13 O14 O15 O16 O17 O18 O19 O20 O21 O22 O23 O24 O25 O26 O27 O28 O29 O30 O31
		(('0','0','0','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','0','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','0','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','0','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','1','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','1','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','1','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','1','0','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','0','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','0','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','0','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','0','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','1','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','1','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','1','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','1','1','0', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','0','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','0','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','0','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','0','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','1','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','1','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','1','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','1','0','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','0','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','0','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','0','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','0','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','1','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','1','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','1','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','1','1','1', '0', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),

		 ('0','0','0','0','0', '1', '1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','0','0','0', '1', '0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','0','0','0', '1', '0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','0','0','0', '1', '0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','1','0','0', '1', '0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','1','0','0', '1', '0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','1','0','0', '1', '0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','1','0','0', '1', '0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','0','1','0', '1', '0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','0','1','0', '1', '0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','0','1','0', '1', '0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','0','1','0', '1', '0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','1','1','0', '1', '0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','1','1','0', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','1','1','0', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','1','1','0', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','0','0','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','0','0','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','0','0','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','1','0','0','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0'),
		 ('0','0','1','0','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0'),
		 ('1','0','1','0','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0'),
		 ('0','1','1','0','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0'),
		 ('1','1','1','0','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0'),
		 ('0','0','0','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0'),
		 ('1','0','0','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0'),
		 ('0','1','0','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0'),
		 ('1','1','0','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0'),
		 ('0','0','1','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0'),
		 ('1','0','1','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0'),
		 ('0','1','1','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0'),
		 ('1','1','1','1','1', '1', '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1'));

	begin
		assert false report "Testing decoder5to32" severity note;
		for c in patterns'range loop
			S(0) <= patterns(c).S0;
			S(1) <= patterns(c).S1;
			S(2) <= patterns(c).S2;
			S(3) <= patterns(c).S3;
			S(4) <= patterns(c).S4;
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
			assert O(16) = patterns(c).O16 report "test failed" severity error;
			assert O(17) = patterns(c).O17 report "test failed" severity error;
			assert O(18) = patterns(c).O18 report "test failed" severity error;
			assert O(19) = patterns(c).O19 report "test failed" severity error;
			assert O(20) = patterns(c).O20 report "test failed" severity error;
			assert O(21) = patterns(c).O21 report "test failed" severity error;
			assert O(22) = patterns(c).O22 report "test failed" severity error;
			assert O(23) = patterns(c).O23 report "test failed" severity error;
			assert O(24) = patterns(c).O24 report "test failed" severity error;
			assert O(25) = patterns(c).O25 report "test failed" severity error;
			assert O(26) = patterns(c).O26 report "test failed" severity error;
			assert O(27) = patterns(c).O27 report "test failed" severity error;
			assert O(28) = patterns(c).O28 report "test failed" severity error;
			assert O(29) = patterns(c).O29 report "test failed" severity error;
			assert O(30) = patterns(c).O30 report "test failed" severity error;
			assert O(31) = patterns(c).O31 report "test failed" severity error;
		end loop;

		wait;
	end process;
end behavior;

