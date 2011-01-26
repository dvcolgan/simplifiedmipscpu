library ieee;
use ieee.std_logic_1164.all;

entity ground32_tb is
end ground32_tb;

architecture behavior of ground32_tb is
	component ground32
		port (G: out std_logic_vector(31 downto 0));
	end component;

	signal G: std_logic_vector(31 downto 0);
begin
	ground32_0: ground32 port map (G=>G);

	process
	begin
		assert false report "Testing ground32" severity note;
		wait for 1 ns;
		assert G = X"0000_0000" report "test failed" severity error;

		wait;
	end process;
end behavior;

