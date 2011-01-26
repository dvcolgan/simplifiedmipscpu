library ieee;
use ieee.std_logic_1164.all;

use work.extender;

entity extender_tb is
end extender_tb;

architecture behavior of extender_tb is

	component extender
		port (Input: in std_logic_vector(15 downto 0);
		      ExtendMethod: in std_logic;
		      Output: out std_logic_vector(31 downto 0));
	end component;

	signal Input: std_logic_vector(15 downto 0);
	signal ExtendMethod: std_logic;
	signal Output: std_logic_vector(31 downto 0);

begin
	extender_0: extender port map (Input, ExtendMethod, Output);

	process
	begin
		assert false report "Testing extender" severity note;

		Input <= X"FFFF";
		ExtendMethod <= '0';
		wait for 10 ns;
		assert Output = X"0000_FFFF" report "test failed" severity error;

		Input <= X"0FFF";
		ExtendMethod <= '1';
		wait for 10 ns;
		assert Output = X"0000_0FFF" report "test failed" severity error;

		Input <= X"FFFF";
		ExtendMethod <= '1';
		wait for 10 ns;
		assert Output = X"FFFF_FFFF" report "test failed" severity error;
		wait;
	end process;
end behavior;

