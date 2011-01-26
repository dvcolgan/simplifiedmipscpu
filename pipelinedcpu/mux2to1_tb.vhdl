library ieee;
use ieee.std_logic_1164.all;

use work.mux2to1;

entity mux2to1_tb is
end mux2to1_tb;

architecture behavior of mux2to1_tb is
	component mux2to1
		port (S: in std_logic;
		      R: in std_logic_vector(1 downto 0);
		      O: out std_logic);
	end component;

	signal S: std_logic;
	signal R: std_logic_vector(1 downto 0);
	signal O: std_logic;
begin
	mux2to1_0: mux2to1 port map (S, R, O);

	process
		type pattern_type is record
			S, R0, R1, O: std_logic;
		end record;

	type pattern_array is array (natural range <>) of pattern_type;
	constant patterns : pattern_array :=
		-- S0   R0  R1   O
		(('0', '0','0', '0'),
		 ('0', '1','0', '1'),
		 ('0', '0','1', '0'),
		 ('0', '1','1', '1'),
		 ('1', '0','0', '0'),
		 ('1', '1','0', '0'),
		 ('1', '0','1', '1'),
		 ('1', '1','1', '1'));
	begin
		assert false report "Testing mux2to1" severity note;
		for c in patterns'range loop
			S <= patterns(c).S;
			R(0) <= patterns(c).R0;
			R(1) <= patterns(c).R1;
			wait for 1 ns;
			assert O = patterns(c).O
				report "test failed" severity error;
		end loop;

		wait;
	end process;
end behavior;

