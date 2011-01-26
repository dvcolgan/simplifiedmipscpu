library ieee;
use ieee.std_logic_1164.all;

use work.control;

entity control_tb is
end control_tb;

architecture behavior of control_tb is

	component control
		port(Operation: in std_logic_vector(31 downto 26);
		     Function_: in std_logic_vector(5 downto 0);
		     Branch, MemRead, MemWrite, RegWrite, SignExtend: out std_logic;
		     MemToReg, RegDst, Jump, ALUSrc, ALUOp: out std_logic_vector(1 downto 0));
	end component;

	signal Operation: std_logic_vector(31 downto 26);
	signal Function_: std_logic_vector(5 downto 0);
	signal Branch, MemRead, MemWrite, ALUSrc, RegWrite, SignExtend: std_logic;
	signal MemToReg, RegDst, Jump, ALUOp: std_logic_vector(1 downto 0);

begin
	control_0: control port map (Operation, Function_, Branch, MemRead, MemWrite, ALUSrc, RegWrite, SignExtend, MemToReg, RegDst, Jump, ALUOp);

	process
	begin
		assert false report "Testing control" severity note;

		--test add
		Operation <= "000000";
		Function_ <= "100000";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert ALUSrc = '0' report "bad ALUSrc" severity error;
		assert RegWrite = '1' report "bad RegWrite" severity error;
		assert MemToReg = "00" report "bad MemToReg" severity error;
		assert RegDst = "01" report "bad RegDst" severity error;
		assert Jump = "00" report "bad Jump" severity error;
		assert ALUOp = "10" report "bad ALUOp" severity error;

		--test nor
		Operation <= "000000";
		Function_ <= "100111";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert ALUSrc = '0' report "bad ALUSrc" severity error;
		assert RegWrite = '1' report "bad RegWrite" severity error;
		assert MemToReg = "00" report "bad MemToReg" severity error;
		assert RegDst = "01" report "bad RegDst" severity error;
		assert Jump = "00" report "bad Jump" severity error;
		assert ALUOp = "10" report "bad ALUOp" severity error;

		--test set less than
		Operation <= "000000";
		Function_ <= "101010";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert ALUSrc = '0' report "bad ALUSrc" severity error;
		assert RegWrite = '1' report "bad RegWrite" severity error;
		assert MemToReg = "00" report "bad MemToReg" severity error;
		assert RegDst = "01" report "bad RegDst" severity error;
		assert Jump = "00" report "bad Jump" severity error;
		assert ALUOp = "10" report "bad ALUOp" severity error;

		--test shift left
		Operation <= "000000";
		Function_ <= "000000";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert ALUSrc = '0' report "bad ALUSrc" severity error;
		assert RegWrite = '1' report "bad RegWrite" severity error;
		assert MemToReg = "00" report "bad MemToReg" severity error;
		assert RegDst = "01" report "bad RegDst" severity error;
		assert Jump = "00" report "bad Jump" severity error;
		assert ALUOp = "10" report "bad ALUOp" severity error;

		--test shift right
		Operation <= "000000";
		Function_ <= "000010";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert ALUSrc = '0' report "bad ALUSrc" severity error;
		assert RegWrite = '1' report "bad RegWrite" severity error;
		assert MemToReg = "00" report "bad MemToReg" severity error;
		assert RegDst = "01" report "bad RegDst" severity error;
		assert Jump = "00" report "bad Jump" severity error;
		assert ALUOp = "10" report "bad ALUOp" severity error;

		--test subtract
		Operation <= "000000";
		Function_ <= "100010";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert ALUSrc = '0' report "bad ALUSrc" severity error;
		assert RegWrite = '1' report "bad RegWrite" severity error;
		assert MemToReg = "00" report "bad MemToReg" severity error;
		assert RegDst = "01" report "bad RegDst" severity error;
		assert Jump = "00" report "bad Jump" severity error;
		assert ALUOp = "10" report "bad ALUOp" severity error;

		--test beq
		Operation <= "000100";
		wait for 10 ns;
		assert Branch = '1' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert ALUSrc = '0' report "bad ALUSrc" severity error;
		assert RegWrite = '0' report "bad RegWrite" severity error;
		assert SignExtend = '1' report "bad SignExtend" severity error;
		assert Jump = "00" report "bad Jump" severity error;
		assert ALUOp = "01" report "bad ALUOp" severity error;

		--test jump
		Operation <= "000010";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert RegWrite = '0' report "bad RegWrite" severity error;
		assert Jump = "01" report "bad Jump" severity error;

		--test jal
		Operation <= "000011";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert RegWrite = '1' report "bad RegWrite" severity error;
		assert MemToReg = "10" report "bad MemToReg" severity error;
		assert RegDst = "10" report "bad RegDst" severity error;
		assert Jump = "01" report "bad Jump" severity error;

		--test jr
		Operation <= "000000";
		Function_ <= "001000";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert RegWrite = '0' report "bad RegWrite" severity error;
		assert MemToReg = "10" report "bad MemToReg" severity error;
		assert Jump = "10" report "bad Jump" severity error;
		assert ALUOp = "00" report "bad ALUOp" severity error;

		--test lw
		Operation <= "100011";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '1' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert ALUSrc = '1' report "bad ALUSrc" severity error;
		assert RegWrite = '1' report "bad RegWrite" severity error;
		assert SignExtend = '1' report "bad SignExtend" severity error;
		assert MemToReg = "01" report "bad MemToReg" severity error;
		assert RegDst = "00" report "bad RegDst" severity error;
		assert Jump = "00" report "bad Jump" severity error;
		assert ALUOp = "00" report "bad ALUOp" severity error;

		--test sw
		Operation <= "101011";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '1' report "bad MemWrite" severity error;
		assert ALUSrc = '1' report "bad ALUSrc" severity error;
		assert RegWrite = '0' report "bad RegWrite" severity error;
		assert SignExtend = '1' report "bad SignExtend" severity error;
		assert Jump = "00" report "bad Jump" severity error;
		assert ALUOp = "00" report "bad ALUOp" severity error;

		--test ori
		Operation <= "001101";
		wait for 10 ns;
		assert Branch = '0' report "bad Branch" severity error;
		assert MemRead = '0' report "bad MemRead" severity error;
		assert MemWrite = '0' report "bad MemWrite" severity error;
		assert ALUSrc = '1' report "bad ALUSrc" severity error;
		assert RegWrite = '1' report "bad RegWrite" severity error;
		assert SignExtend = '0' report "bad SignExtend" severity error;
		assert MemToReg = "00" report "bad MemToReg" severity error;
		assert RegDst = "00" report "bad RegDst" severity error;
		assert Jump = "00" report "bad Jump" severity error;
		assert ALUOp = "11" report "bad ALUOp" severity error;
		wait;
	end process;
end behavior;

