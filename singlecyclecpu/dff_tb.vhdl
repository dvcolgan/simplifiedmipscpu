library ieee;
use ieee.std_logic_1164.all;

use work.dff;

entity dff_tb is
end dff_tb;

architecture behavior of dff_tb is

	component dff
		port (D, WE, clock: in std_logic;
			Q, Qprime: out std_logic);
	end component;

	signal D, WE, Q, Qprime: std_logic;
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

	dff_0: dff port map (D, WE, clock, Q, Qprime);

	process
	begin
		assert false report "Testing dff" severity note;
		D <= '1';
		WE <= '1';
		wait for 1.5 ns;
		assert Q = '1' report "test failed";
		assert Qprime = '0' report "test failed";

		D <= '0';
		WE <= '1';
		wait for 2 ns;

		assert Q = '0' report "test failed";
		assert Qprime = '1' report "test failed";

		wait;
	end process;
end behavior;

