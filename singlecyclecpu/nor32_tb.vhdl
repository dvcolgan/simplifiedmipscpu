library ieee;
use ieee.std_logic_1164.all;

use work.nor32;

entity nor32_tb is
end nor32_tb;

architecture behavior of nor32_tb is
	component nor32 is
		port (R1: in std_logic_vector(31 downto 0);
		      R2: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0));
	end component;

	signal R1: std_logic_vector(31 downto 0);
	signal R2: std_logic_vector(31 downto 0);
	signal O: std_logic_vector(31 downto 0);
begin
	nor32_0: nor32 port map (R1, R2, O);

	process
	begin
		assert false report "Testing nor32" severity note;
		R1 <= X"FFFF_FFFF";
		R2 <= X"FFFF_FFFF";
		wait for 2 ns;
		assert O=X"0000_0000" report "test failed" severity error;

		R1 <= X"FFFF_FFFF";
		R2 <= X"0000_0000";
		wait for 2 ns;
		assert O=X"0000_0000" report "test failed" severity error;

		R1 <= X"0000_0000";
		R2 <= X"0000_0000";
		wait for 2 ns;
		assert O=X"FFFF_FFFF" report "test failed" severity error;

		R1 <= "01010101110010100011010010110101";
		R2 <= "01010011010101010011010101010010";
		wait for 2 ns;
		assert O= "10101000001000001100101000001000" report "test failed" severity error;

		wait;
	end process;
end behavior;

