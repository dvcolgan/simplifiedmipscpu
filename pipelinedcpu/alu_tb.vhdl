library ieee;
use ieee.std_logic_1164.all;

use work.alu;

entity alu_tb is
end alu_tb;

architecture behavior of alu_tb is

	component alu
		port (Value1, Value2: in std_logic_vector(31 downto 0);
		      Operation: in std_logic_vector(2 downto 0);
		      ValueOut: out std_logic_vector(31 downto 0);
		      Overflow, Negative, Zero, CarryOut: out std_logic);
	end component;

	signal Value1, Value2: std_logic_vector(31 downto 0);
	signal Operation: std_logic_vector(2 downto 0);
	signal ValueOut: std_logic_vector(31 downto 0);
	signal Overflow, Negative, Zero, CarryOut: std_logic;

begin
	alu_0: alu port map (Value1, Value2, Operation, ValueOut, Overflow, Negative, Zero, CarryOut);

	process
	begin
		assert false report "Testing alu" severity note;

		--test add
		Value1 <= "01010101010101010101010101010101";
		Value2 <= "00101010101010101010101010101010";
		Operation <= "000";
		wait for 10 ns;
		assert ValueOut = X"7FFF_FFFF" report "bad out value" severity error;
		assert Overflow = '0' report "bad overflow" severity error;
		assert Negative = '0' report "bad negative" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--positive overflow
		Value1 <= "01010101010101010101010101010101";
		Value2 <= "01101010101010101010101010101010";
		Operation <= "000";
		wait for 10 ns;
		assert ValueOut = X"BFFF_FFFF" report "bad out value" severity error;
		assert Overflow = '1' report "bad overflow" severity error;
		assert Negative = '1' report "bad negative" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--negative overflow and carry out
		Value1 <= "11010101010101010101010101010101";
		Value2 <= "10101010101010101010101010101010";
		Operation <= "000";
		wait for 10 ns;
		assert ValueOut = X"7FFF_FFFF" report "bad out value" severity error;
		assert Overflow = '1' report "bad overflow" severity error;
		assert Negative = '0' report "bad negative" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;

		--negative bit
		Value1 <= "01010101010101010101010101010101";
		Value2 <= "10101010101010101010101010101010";
		Operation <= "000";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFFF" report "bad out value" severity error;
		assert Overflow = '0' report "bad overflow" severity error;
		assert Negative = '1' report "bad negative" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--zero bit
		Value1 <= "00000000000000000000000000000000";
		Value2 <= "00000000000000000000000000000000";
		Operation <= "000";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Overflow = '0' report "bad overflow" severity error;
		assert Negative = '0' report "bad negative" severity error;
		assert Zero = '1' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--test subtract
		Value1 <= "01010101010101010101010101010101";
		Value2 <= "00101010101010101010101010101010";
		Operation <= "100";
		wait for 10 ns;
		assert ValueOut = "00101010101010101010101010101011" report "bad out value" severity error;
		assert Overflow = '0' report "bad overflow" severity error;
		assert Negative = '0' report "bad negative" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;

		--positive overflow and negative bit
		Value1 <= "01010101010101010101010101010101";
		Value2 <= "11010101010101010101010101010101";
		Operation <= "100";
		wait for 10 ns;
		assert ValueOut = "10000000000000000000000000000000" report "bad out value" severity error;
		assert Overflow = '1' report "bad overflow" severity error;
		assert Negative = '1' report "bad negative" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--negative overflow and carry out
		Value1 <= "10000000000000000000000000000000";
		Value2 <= "01000000000000000000000000000000";
		Operation <= "100";
		wait for 10 ns;
		assert ValueOut = "01000000000000000000000000000000" report "bad out value" severity error;
		assert Overflow = '1' report "bad overflow" severity error;
		assert Negative = '0' report "bad negative" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;

		--zero bit
		Value1 <= "00000000000000000000000000000000";
		Value2 <= "00000000000000000000000000000000";
		Operation <= "100";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Overflow = '0' report "bad overflow" severity error;
		assert Negative = '0' report "bad negative" severity error;
		assert Zero = '1' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;

		--nor
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "11111111111111111111111111111111";
		Operation <= "001";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Negative = '0' report "bad negative" severity error;
		assert Zero = '1' report "bad zero" severity error;

		--nor with negative
		Value1 <= "00000000000000000000000000000000";
		Value2 <= "00000000000000000000000000000000";
		Operation <= "001";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFFF" report "bad out value" severity error;
		assert Negative = '1' report "bad negative" severity error;
		assert Zero = '0' report "bad zero" severity error;

		--nor with zero
		Value1 <= "01010101010101010101010101010101";
		Value2 <= "10101010101010101010101010101010";
		Operation <= "001";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Negative = '0' report "bad negative" severity error;
		assert Zero = '1' report "bad zero" severity error;

		--left shift by 0
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000000";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--left shift by 1
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000001";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFFE" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--left shift by 1
		Value1 <= "01111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000001";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFFE" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--left shift by 2
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000010";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFFC" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--left shift by 2
		Value1 <= "00111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000010";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFFC" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--left shift by 3
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000011";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFF8" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--left shift by 3
		Value1 <= "00011111111111111111111111111111";
		Value2 <= "00000000000000000000000000000011";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFF8" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--left shift by 4
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000100";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFF0" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--left shift by 4
		Value1 <= "00001111111111111111111111111111";
		Value2 <= "00000000000000000000000000000100";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFF0" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--left shift by 5
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000101";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFE0" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--left shift by 5
		Value1 <= "00000111111111111111111111111111";
		Value2 <= "00000000000000000000000000000101";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFE0" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--left shift by 7
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000111";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FF80" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--left shift by 7
		Value1 <= "00000001111111111111111111111111";
		Value2 <= "00000000000000000000000000000111";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FF80" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--left shift by 8
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000001000";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FF00" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--left shift by 8
		Value1 <= "00000000111111111111111111111111";
		Value2 <= "00000000000000000000000000001000";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FF00" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--left shift by 12
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000001100";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_F000" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--left shift by 12
		Value1 <= "00000000000011111111111111111111";
		Value2 <= "00000000000000000000000000001100";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"FFFF_F000" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--left shift by 31
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000011111";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"8000_0000" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--left shift by 31
		Value1 <= "00000000000000000000000000000001";
		Value2 <= "00000000000000000000000000011111";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"8000_0000" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--left shift by more than 31
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000011111111";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Zero = '1' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--left shift by more than 31
		Value1 <= "00000000000000000000000000000000";
		Value2 <= "10000001000000000100001000011111";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Zero = '1' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;


		--left shift zero bit (shift 17)
		Value1 <= "11111111111111111000000000000000";
		Value2 <= "00000000000000000000000000010001";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Zero = '1' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;

		--right shift by 0
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000000";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"FFFF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--right shift by 1
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000001";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"7FFF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--right shift by 1
		Value1 <= "11111111111111111111111111111110";
		Value2 <= "00000000000000000000000000000001";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"7FFF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--right shift by 2
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000010";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"3FFF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--right shift by 2
		Value1 <= "11111111111111111111111111111100";
		Value2 <= "00000000000000000000000000000010";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"3FFF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--right shift by 3
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000011";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"1FFF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--right shift by 3
		Value1 <= "11111111111111111111111111111000";
		Value2 <= "00000000000000000000000000000011";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"1FFF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--right shift by 4
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000100";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"0FFF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--right shift by 4
		Value1 <= "11111111111111111111111111110000";
		Value2 <= "00000000000000000000000000000100";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"0FFF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--right shift by 5
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000101";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"07FF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--right shift by 5
		Value1 <= "11111111111111111111111111100000";
		Value2 <= "00000000000000000000000000000101";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"07FF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--right shift by 7
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000000111";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"01FF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--right shift by 7
		Value1 <= "11111111111111111111111110000000";
		Value2 <= "00000000000000000000000000000111";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"01FF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--right shift by 8
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000001000";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"00FF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--right shift by 8
		Value1 <= "11111111111111111111111100000000";
		Value2 <= "00000000000000000000000000001000";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"00FF_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--right shift by 12
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000001100";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"000F_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--right shift by 12
		Value1 <= "11111111111111111111000000000000";
		Value2 <= "00000000000000000000000000001100";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"000F_FFFF" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--right shift by 31
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000000011111";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"0000_0001" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--right shift by 31
		Value1 <= "10000000000000000000000000000000";
		Value2 <= "00000000000000000000000000011111";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"0000_0001" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out a" severity error;

		--right shift by more than 31
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "00000000000000000000000011111111";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Zero = '1' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;
		--right shift by more than 31
		Value1 <= "00000000000000000000000000000000";
		Value2 <= "10000001000000000100001000011111";
		Operation <= "010";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Zero = '1' report "bad zero" severity error;
		assert CarryOut = '0' report "bad carry out" severity error;

		--right shift zero bit (shift 17)
		Value1 <= "00000000000000011111111111111111";
		Value2 <= "00000000000000000000000000010001";
		Operation <= "011";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Zero = '1' report "bad zero" severity error;
		assert CarryOut = '1' report "bad carry out" severity error;

		--set less than true
		Value1 <= "00000000000000000000000000000000";
		Value2 <= "00000000000000000000000000000001";
		Operation <= "101";
		wait for 10 ns;
		assert ValueOut = X"0000_0001" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;

		--set less than false
		Value1 <= "00000000000000000000000000000001";
		Value2 <= "00000000000000000000000000000000";
		Operation <= "101";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;

		--set less than equal values
		Value1 <= "00000000000000000000000000000000";
		Value2 <= "00000000000000000000000000000000";
		Operation <= "101";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Zero = '0' report "bad zero" severity error;

		--set less than negatives true
		Value1 <= "11111111111111111111111111111110";
		Value2 <= "11111111111111111111111111111111";
		Operation <= "101";
		wait for 10 ns;
		assert ValueOut = X"0000_0001" report "bad out value" severity error;
		assert Zero = '1' report "bad zero" severity error;

		--set less than negatives false
		Value1 <= "11111111111111111111111111111111";
		Value2 <= "11111111111111111111111111111110";
		Operation <= "101";
		wait for 10 ns;
		assert ValueOut = X"0000_0000" report "bad out value" severity error;
		assert Zero = '1' report "bad zero" severity error;
		wait;
	end process;
end behavior;

