library ieee;
use ieee.std_logic_1164.all;

entity dff is
	port (D, WE, clock: in std_logic;
	      Q, Qprime: out std_logic);
end dff;

architecture behavior of dff is
begin
	process
	begin
	wait until clock'event and clock = '1';
	-- could also be rising_edge(clock);
	if we = '1' then
		Q <= D after 135 ps;
		Qprime <= not D after 135 ps;
	end if;
	end process;
end behavior;
