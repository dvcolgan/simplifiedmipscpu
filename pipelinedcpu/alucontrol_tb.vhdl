library ieee;
use ieee.std_logic_1164.all;

use work.alucontrol;

entity alucontrol_tb is
end alucontrol_tb;

architecture behavior of alucontrol_tb is

	component alucontrol
		port(ALUOp: in std_logic_vector(1 downto 0);
		     Function_: in std_logic_vector(5 downto 0);
		     Operation: out std_logic_vector(2 downto 0));
	end component;

	signal ALUOp: std_logic_vector(1 downto 0);
	signal Function_: std_logic_vector(5 downto 0);
	signal Operation: std_logic_vector(2 downto 0);

begin
	alucontrol_0: alucontrol port map (ALUOp, Function_, Operation);

	process
	begin
		assert false report "Testing alucontrol" severity note;

		--test always add
		ALUOp <= "00";
		wait for 10 ns;
		assert Operation = "000" report "bad Operation" severity error;

		--test always subtract
		ALUOp <= "01";
		wait for 10 ns;
		assert Operation = "100" report "bad Operation" severity error;

		--test always or
		ALUOp <= "11";
		wait for 10 ns;
		--assert Operation = "000" report "bad Operation" severity error;

		--test add
		ALUOp <= "10";
		Function_ <= "100000";
		wait for 10 ns;
		assert Operation = "000" report "bad Operation" severity error;

		--test nor
		ALUOp <= "10";
		Function_ <= "100111";
		wait for 10 ns;
		assert Operation = "001" report "bad Operation" severity error;

		--test left shift
		ALUOp <= "10";
		Function_ <= "000000";
		wait for 10 ns;
		assert Operation = "010" report "bad Operation" severity error;

		--test right shift
		ALUOp <= "10";
		Function_ <= "000010";
		wait for 10 ns;
		assert Operation = "011" report "bad Operation" severity error;

		--test subtract
		ALUOp <= "10";
		Function_ <= "100010";
		wait for 10 ns;
		assert Operation = "100" report "bad Operation" severity error;

		--test set less than
		ALUOp <= "10";
		Function_ <= "101010";
		wait for 10 ns;
		assert Operation = "101" report "bad Operation" severity error;
		wait;
	end process;
end behavior;

