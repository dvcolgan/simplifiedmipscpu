library ieee;
use ieee.std_logic_1164.all;

use work.datamemory;

entity datamemory_tb is
end datamemory_tb;

architecture behavior of datamemory_tb is

	component datamemory
		port (Address: in std_logic_vector(31 downto 0);
		      WriteEnable, ReadEnable: in std_logic;
		      Clock: in std_logic;
		      DataIn: in std_logic_vector(31 downto 0);
		      DataOut: out std_logic_vector(31 downto 0));
	end component;

	signal Address, DataIn, DataOut: std_logic_vector(31 downto 0);
	signal WriteEnable, ReadEnable, Clock: std_logic;

begin
	datamemory_0: datamemory port map (Address, WriteEnable, ReadEnable, Clock, DataIn, DataOut);

	process
	begin
		assert false report "Testing datamemory" severity note;
		Address <= X"0000_0000";
		WriteEnable <= '1';
		ReadEnable <= '0';
		DataIn <= X"cccc_cccc";
		wait for 1 ns;

		Address <= X"0000_0004";
		WriteEnable <= '1';
		ReadEnable <= '0';
		DataIn <= X"dddd_dddd";
		wait for 1 ns;

		WriteEnable <= '0';
		ReadEnable <= '1';
		wait for 1 ns;
		Address <= X"0000_0000";
		wait for 1 ns;
		assert DataOut = X"cccc_cccc" report "bad out value" severity error;
		Address <= X"0000_0004";
		WriteEnable <= '0';
		ReadEnable <= '1';
		wait for 1 ns;
		assert DataOut = X"dddd_dddd" report "bad out value" severity error;

		wait;
	end process;
end behavior;

