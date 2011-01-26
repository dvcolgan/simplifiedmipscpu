library ieee;
use ieee.std_logic_1164.all;

use work.shiftertol;

entity shiftertol_tb is
end shiftertol_tb;

architecture behavior of shiftertol_tb is
	component shiftertol
		port (S: in std_logic_vector(4 downto 0);
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	signal S: std_logic_vector(4 downto 0);
	signal R: std_logic_vector(31 downto 0);
	signal O: std_logic_vector(31 downto 0);
	signal C: std_logic;
begin
	shiftertol_0: shiftertol port map (S, R, O, C);

	process
	begin
		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00000";
		wait for 2 ns;
		assert O="11111111111111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00001";
		wait for 2 ns;
		assert O="11111111111111111111111111111110" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00010";
		wait for 2 ns;
		assert O="11111111111111111111111111111100" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00011";
		wait for 2 ns;
		assert O="11111111111111111111111111111000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00100";
		wait for 2 ns;
		assert O="11111111111111111111111111110000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00101";
		wait for 2 ns;
		assert O="11111111111111111111111111100000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00110";
		wait for 2 ns;
		assert O="11111111111111111111111111000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00111";
		wait for 2 ns;
		assert O="11111111111111111111111110000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01000";
		wait for 2 ns;
		assert O="11111111111111111111111100000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01001";
		wait for 2 ns;
		assert O="11111111111111111111111000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01010";
		wait for 2 ns;
		assert O="11111111111111111111110000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01011";
		wait for 2 ns;
		assert O="11111111111111111111100000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01100";
		wait for 2 ns;
		assert O="11111111111111111111000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01101";
		wait for 2 ns;
		assert O="11111111111111111110000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01110";
		wait for 2 ns;
		assert O="11111111111111111100000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01111";
		wait for 2 ns;
		assert O="11111111111111111000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10000";
		wait for 2 ns;
		assert O="11111111111111110000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10001";
		wait for 2 ns;
		assert O="11111111111111100000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10010";
		wait for 2 ns;
		assert O="11111111111111000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10011";
		wait for 2 ns;
		assert O="11111111111110000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10100";
		wait for 2 ns;
		assert O="11111111111100000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10101";
		wait for 2 ns;
		assert O="11111111111000000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10110";
		wait for 2 ns;
		assert O="11111111110000000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10111";
		wait for 2 ns;
		assert O="11111111100000000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11000";
		wait for 2 ns;
		assert O="11111111000000000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11001";
		wait for 2 ns;
		assert O="11111110000000000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11010";
		wait for 2 ns;
		assert O="11111100000000000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11011";
		wait for 2 ns;
		assert O="11111000000000000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11100";
		wait for 2 ns;
		assert O="11110000000000000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11101";
		wait for 2 ns;
		assert O="11100000000000000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11110";
		wait for 2 ns;
		assert O="11000000000000000000000000000000" report "test failed" severity error;

		assert false report "Testing shiftertol" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11111";
		wait for 2 ns;
		assert O="10000000000000000000000000000000" report "test failed" severity error;

		wait;
	end process;
end behavior;

