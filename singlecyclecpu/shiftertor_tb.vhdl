library ieee;
use ieee.std_logic_1164.all;

use work.shiftertor;

entity shiftertor_tb is
end shiftertor_tb;

architecture behavior of shiftertor_tb is
	component shiftertor
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
	shiftertor_0: shiftertor port map (S, R, O, C);

	process
	begin
		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00000";
		wait for 2 ns;
		assert O="11111111111111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00001";
		wait for 2 ns;
		assert O="01111111111111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00010";
		wait for 2 ns;
		assert O="00111111111111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00011";
		wait for 2 ns;
		assert O="00011111111111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00100";
		wait for 2 ns;
		assert O="00001111111111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00101";
		wait for 2 ns;
		assert O="00000111111111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00110";
		wait for 2 ns;
		assert O="00000011111111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "00111";
		wait for 2 ns;
		assert O="00000001111111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01000";
		wait for 2 ns;
		assert O="00000000111111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01001";
		wait for 2 ns;
		assert O="00000000011111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01010";
		wait for 2 ns;
		assert O="00000000001111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01011";
		wait for 2 ns;
		assert O="00000000000111111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01100";
		wait for 2 ns;
		assert O="00000000000011111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01101";
		wait for 2 ns;
		assert O="00000000000001111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01110";
		wait for 2 ns;
		assert O="00000000000000111111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "01111";
		wait for 2 ns;
		assert O="00000000000000011111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10000";
		wait for 2 ns;
		assert O="00000000000000001111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10001";
		wait for 2 ns;
		assert O="00000000000000000111111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10010";
		wait for 2 ns;
		assert O="00000000000000000011111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10011";
		wait for 2 ns;
		assert O="00000000000000000001111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10100";
		wait for 2 ns;
		assert O="00000000000000000000111111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10101";
		wait for 2 ns;
		assert O="00000000000000000000011111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10110";
		wait for 2 ns;
		assert O="00000000000000000000001111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "10111";
		wait for 2 ns;
		assert O="00000000000000000000000111111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11000";
		wait for 2 ns;
		assert O="00000000000000000000000011111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11001";
		wait for 2 ns;
		assert O="00000000000000000000000001111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11010";
		wait for 2 ns;
		assert O="00000000000000000000000000111111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11011";
		wait for 2 ns;
		assert O="00000000000000000000000000011111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11100";
		wait for 2 ns;
		assert O="00000000000000000000000000001111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11101";
		wait for 2 ns;
		assert O="00000000000000000000000000000111" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11110";
		wait for 2 ns;
		assert O="00000000000000000000000000000011" report "test failed" severity error;

		assert false report "Testing shiftertor" severity note;
		R <= "11111111111111111111111111111111";
		S <= "11111";
		wait for 2 ns;
		assert O="00000000000000000000000000000001" report "test failed" severity error;

		wait;
	end process;
end behavior;

