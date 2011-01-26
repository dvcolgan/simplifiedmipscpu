library ieee;
use ieee.std_logic_1164.all;

use work.reg;

entity reg_tb is
end reg_tb;

architecture behavior of reg_tb is

	component reg
		port (WE, clock: in std_logic;
		      D: in std_logic_vector(31 downto 0);
		      Q: out std_logic_vector(31 downto 0));
	end component;

	signal WE: std_logic;
	signal D, Q: std_logic_vector(31 downto 0);
	signal clock: std_logic := '1';
begin
	process
		begin
		for i in 1 to 5 loop
			clock <= not clock;
			wait for 1 ns;
			clock <= not clock;
			wait for 1 ns;
		end loop;
		wait;
	end process;

	reg_0: reg port map (WE, clock, D, Q);

	process
	begin
		assert false report "Testing reg" severity note;
		D <= X"00000000";
		WE <= '1';
		wait for 1.5 ns;
		assert Q = X"00000000" report "test failed";

		D <= X"11111111";
		WE <= '1';
		wait for 2 ns;

		assert Q = X"11111111" report "test failed";

		D <= X"00000000";
		WE <= '0';
		wait for 2 ns;

		assert Q = X"11111111" report "test failed";

		wait;
	end process;
end behavior;

