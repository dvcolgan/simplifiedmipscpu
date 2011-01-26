library ieee;
use ieee.std_logic_1164.all;

use work.addersubtractor32;

entity addersubtractor32_tb is
end addersubtractor32_tb;

architecture behavior of addersubtractor32_tb is
	component addersubtractor32 is
		port (A: in std_logic_vector(31 downto 0);
		      B: in std_logic_vector(31 downto 0);
		      Cin: in std_logic;
		      S: out std_logic_vector(31 downto 0);
		      Cout: out std_logic;
		      Over: out std_logic);
	end component;

	signal A: std_logic_vector(31 downto 0);
	signal B: std_logic_vector(31 downto 0);
	signal Cin: std_logic;
	signal S: std_logic_vector(31 downto 0);
	signal Cout: std_logic;
	signal Over: std_logic;
begin
	addersubtractor32_0: addersubtractor32 port map (A, B, Cin, S, Cout, Over);

	process
	begin
		assert false report "Testing addersubtractor32" severity note;
		A <= X"0000_0000";
		B <= X"0000_0000";
		Cin <= '0'; --add
		wait for 5 ns;
		assert S=X"0000_0000" report "test failed" severity error;
		assert Cout='0' report "test failed" severity error;

		A <= X"FFFF_FFFF";
		B <= X"0000_0000";
		Cin <= '0'; --add
		wait for 5 ns;
		assert S=X"FFFF_FFFF" report "test failed" severity error;
		assert Cout='0' report "test failed" severity error;

		A <= "00000000000000000000000000000110";
		B <= "00000000000000000000000000000101";
		Cin <= '0'; --add
		wait for 5 ns;
		assert S = "00000000000000000000000000001011" report "test failed" severity error;
		assert Cout = '0' report "test failed" severity error;

		A <= "01010101110010100011010010110101"; --1439315125
		B <= "01010011010101010011010101010010"; --1398093138
		Cin <= '0'; --add
		wait for 5 ns;
		assert S = "10101001000111110110101000000111" report "test failed" severity error;
		assert Cout = '0' report "test failed" severity error;

		A <= X"0000_0000";
		B <= X"0000_0000";
		Cin <= '1'; --subtract
		wait for 5 ns;
		assert S=X"0000_0000" report "test failed" severity error;
		assert Cout='1' report "test failed" severity error;

		A <= X"FFFF_FFFF";
		B <= X"0000_0000";
		Cin <= '1'; --subtract
		wait for 5 ns;
		assert S=X"FFFF_FFFF" report "test failed" severity error;
		assert Cout='1' report "test failed" severity error;

		A <= X"0000_0000";
		B <= X"FFFF_FFFF";
		Cin <= '1'; --subtract
		wait for 5 ns;
		assert S=X"0000_0001" report "test failed" severity error;
		assert Cout='0' report "test failed" severity error;

		A <= "01010101110010100011010010110101";
		B <= "01010011010101010011010101010010";
		Cin <= '1'; --subtract
		wait for 5 ns;
		assert S = "00000010011101001111111101100011" report "test failed" severity error;
		assert Cout = '1' report "test failed" severity error;
		wait;
	end process;
end behavior;
