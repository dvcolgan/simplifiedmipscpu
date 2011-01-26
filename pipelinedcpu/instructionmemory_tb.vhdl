library ieee;
use ieee.std_logic_1164.all;

use work.instructionmemory;

entity instructionmemory_tb is
end instructionmemory_tb;

architecture behavior of instructionmemory_tb is

	component instructionmemory
		port (Address: in std_logic_vector(31 downto 0);
		      InstructionOut: out std_logic_vector(31 downto 0));
	end component;

	signal Address, InstructionOut: std_logic_vector(31 downto 0);

begin
	instructionmemory_0: instructionmemory port map (Address, InstructionOut);

	process
	begin
		assert false report "Testing instructionmemory" severity note;
		Address <= X"0000_0000";
		wait for 1.5 ns;
		assert InstructionOut = X"1111_1111" report "bad out value" severity error;

		Address <= X"0000_3333";
		wait for 2 ns;
		assert InstructionOut = X"2222_2222" report "bad out value" severity error;

		Address <= X"0000_0008";
		wait for 2 ns;
		assert InstructionOut = X"3333_3333" report "bad out value" severity error;

		Address <= X"0000_0004";
		wait for 2 ns;
		assert InstructionOut = X"4444_4444" report "bad out value" severity error;

		wait;
	end process;
end behavior;

