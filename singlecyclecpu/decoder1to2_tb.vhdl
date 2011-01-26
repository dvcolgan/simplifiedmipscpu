library ieee;
use ieee.std_logic_1164.all;

use work.decoder1to2;

entity decoder1to2_tb is
end decoder1to2_tb;

architecture behavior of decoder1to2_tb is
	component decoder1to2
		port (S: in std_logic;
		      R: in std_logic;
		      O: out std_logic_vector(1 downto 0));
	end component;

	signal S: std_logic;
	signal R: std_logic;
	signal O: std_logic_vector(1 downto 0);
begin
	decoder1to2_0: decoder1to2 port map (S, R, O);

	process
		type pattern_type is record
			S, R, O0, O1: std_logic;
		end record;

	type pattern_array is array (natural range <>) of pattern_type;
	constant patterns : pattern_array :=
		-- S    R    O0   O1
		(('0', '0', '0', '0'),
		 ('1', '0', '0', '0'),
		 ('0', '1', '1', '0'),
		 ('1', '1', '0', '1'));

	begin
		assert false report "Testing decoder1to2" severity note;
		for c in patterns'range loop
			S <= patterns(c).S;
			R <= patterns(c).R;
			wait for 1 ns;
			assert O(0) = patterns(c).O0 report "test failed" severity error;
			assert O(1) = patterns(c).O1 report "test failed" severity error;
		end loop;

		wait;
	end process;
end behavior;

