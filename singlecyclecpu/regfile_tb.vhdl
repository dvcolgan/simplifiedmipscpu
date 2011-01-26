library ieee;
use ieee.std_logic_1164.all;

use work.regfile;

entity regfile_tb is
end regfile_tb;

architecture behavior of regfile_tb is

	component regfile
		port (reg1, reg2, writeReg: in std_logic_vector(4 downto 0);
		      WE, clock: in std_logic;
		      writeData: in std_logic_vector(31 downto 0);
		      read1Data, read2Data: out std_logic_vector(31 downto 0));
	end component;

	signal reg1, reg2, writeReg: std_logic_vector(4 downto 0);
	signal WE: std_logic;
	signal clock: std_logic := '1';
	signal writeData: std_logic_vector(31 downto 0);
	signal read1Data, read2Data: std_logic_vector(31 downto 0);

begin
	process
		begin
		for i in 1 to 60 loop
			clock <= not clock;
			wait for 1 ns;
			clock <= not clock;
			wait for 1 ns;
		end loop;
		wait;
	end process;

	regfile_0: regfile port map (reg1=>reg1, reg2=>reg2, writeReg=>writeReg,
	                             WE=>WE, clock=>clock, writeData=>writeData,
	                             read1Data=>read1Data, read2Data=>read2Data);

	process
	begin
		assert false report "Testing regfile" severity note;
		reg1 <= "00000";
		reg2 <= "00000";
		WE <= '1';
		--Assign a value to every register
		writeReg <= "00000"; writeData <= X"0000_0000"; wait for 1.5 ns;
		writeReg <= "00001"; writeData <= X"0000_1111"; wait for 2 ns;
		writeReg <= "00010"; writeData <= X"0000_2222"; wait for 2 ns;
		writeReg <= "00011"; writeData <= X"0000_3333"; wait for 2 ns;
		writeReg <= "00100"; writeData <= X"0000_4444"; wait for 2 ns;
		writeReg <= "00101"; writeData <= X"0000_5555"; wait for 2 ns;
		writeReg <= "00110"; writeData <= X"0000_6666"; wait for 2 ns;
		writeReg <= "00111"; writeData <= X"0000_7777"; wait for 2 ns;
		writeReg <= "01000"; writeData <= X"0000_8888"; wait for 2 ns;
		writeReg <= "01001"; writeData <= X"0000_9999"; wait for 2 ns;
		writeReg <= "01010"; writeData <= X"0000_AAAA"; wait for 2 ns;
		writeReg <= "01011"; writeData <= X"0000_BBBB"; wait for 2 ns;
		writeReg <= "01100"; writeData <= X"0000_CCCC"; wait for 2 ns;
		writeReg <= "01101"; writeData <= X"0000_DDDD"; wait for 2 ns;
		writeReg <= "01110"; writeData <= X"0000_EEEE"; wait for 2 ns;
		writeReg <= "01111"; writeData <= X"0000_FFFF"; wait for 2 ns;
		writeReg <= "10000"; writeData <= X"1111_0000"; wait for 2 ns;
		writeReg <= "10001"; writeData <= X"2222_0000"; wait for 2 ns;
		writeReg <= "10010"; writeData <= X"3333_0000"; wait for 2 ns;
		writeReg <= "10011"; writeData <= X"4444_0000"; wait for 2 ns;
		writeReg <= "10100"; writeData <= X"5555_0000"; wait for 2 ns;
		writeReg <= "10101"; writeData <= X"6666_0000"; wait for 2 ns;
		writeReg <= "10110"; writeData <= X"7777_0000"; wait for 2 ns;
		writeReg <= "10111"; writeData <= X"8888_0000"; wait for 2 ns;
		writeReg <= "11000"; writeData <= X"9999_0000"; wait for 2 ns;
		writeReg <= "11001"; writeData <= X"AAAA_0000"; wait for 2 ns;
		writeReg <= "11010"; writeData <= X"BBBB_0000"; wait for 2 ns;
		writeReg <= "11011"; writeData <= X"CCCC_0000"; wait for 2 ns;
		writeReg <= "11100"; writeData <= X"DDDD_0000"; wait for 2 ns;
		writeReg <= "11101"; writeData <= X"EEEE_0000"; wait for 2 ns;
		writeReg <= "11110"; writeData <= X"FFFF_0000"; wait for 2 ns;
		writeReg <= "11111"; writeData <= X"FFFF_FFFF"; wait for 2 ns;

		--Test the output
		reg1 <= "00000"; reg2 <= "00001"; wait for 2 ns;
		assert read1Data = X"0000_0000" report "test failed" severity error;
		assert read2Data = X"0000_1111" report "test failed" severity error;

		reg1 <= "00010"; reg2 <= "00011"; wait for 2 ns;
		assert read1Data = X"0000_2222" report "test failed" severity error;
		assert read2Data = X"0000_3333" report "test failed" severity error;

		reg1 <= "00100"; reg2 <= "00101"; wait for 2 ns;
		assert read1Data = X"0000_4444" report "test failed" severity error;
		assert read2Data = X"0000_5555" report "test failed" severity error;

		reg1 <= "00110"; reg2 <= "00111"; wait for 2 ns;
		assert read1Data = X"0000_6666" report "test failed" severity error;
		assert read2Data = X"0000_7777" report "test failed" severity error;

		reg1 <= "01000"; reg2 <= "01001"; wait for 2 ns;
		assert read1Data = X"0000_8888" report "test failed" severity error;
		assert read2Data = X"0000_9999" report "test failed" severity error;

		reg1 <= "01010"; reg2 <= "01011"; wait for 2 ns;
		assert read1Data = X"0000_AAAA" report "test failed" severity error;
		assert read2Data = X"0000_BBBB" report "test failed" severity error;

		reg1 <= "01100"; reg2 <= "01101"; wait for 2 ns;
		assert read1Data = X"0000_CCCC" report "test failed" severity error;
		assert read2Data = X"0000_DDDD" report "test failed" severity error;

		reg1 <= "01110"; reg2 <= "01111"; wait for 2 ns;
		assert read1Data = X"0000_EEEE" report "test failed" severity error;
		assert read2Data = X"0000_FFFF" report "test failed" severity error;

		reg1 <= "10000"; reg2 <= "10001"; wait for 2 ns;
		assert read1Data = X"1111_0000" report "test failed" severity error;
		assert read2Data = X"2222_0000" report "test failed" severity error;

		reg1 <= "10010"; reg2 <= "10011"; wait for 2 ns;
		assert read1Data = X"3333_0000" report "test failed" severity error;
		assert read2Data = X"4444_0000" report "test failed" severity error;

		reg1 <= "10100"; reg2 <= "10101"; wait for 2 ns;
		assert read1Data = X"5555_0000" report "test failed" severity error;
		assert read2Data = X"6666_0000" report "test failed" severity error;

		reg1 <= "10110"; reg2 <= "10111"; wait for 2 ns;
		assert read1Data = X"7777_0000" report "test failed" severity error;
		assert read2Data = X"8888_0000" report "test failed" severity error;

		reg1 <= "11000"; reg2 <= "11001"; wait for 2 ns;
		assert read1Data = X"9999_0000" report "test failed" severity error;
		assert read2Data = X"AAAA_0000" report "test failed" severity error;

		reg1 <= "11010"; reg2 <= "11011"; wait for 2 ns;
		assert read1Data = X"BBBB_0000" report "test failed" severity error;
		assert read2Data = X"CCCC_0000" report "test failed" severity error;

		reg1 <= "11100"; reg2 <= "11101"; wait for 2 ns;
		assert read1Data = X"DDDD_0000" report "test failed" severity error;
		assert read2Data = X"EEEE_0000" report "test failed" severity error;

		reg1 <= "11110"; reg2 <= "11111"; wait for 2 ns;
		assert read1Data = X"FFFF_0000" report "test failed" severity error;
		assert read2Data = X"FFFF_FFFF" report "test failed" severity error;

		--Try writing to a register with WE set to 0
		WE <= '0';
		writeReg <= "11111";
		writeData <= X"AAAA_AAAA";
		reg1 <= "11111";
		wait for 2 ns;
		assert read2Data = X"FFFF_FFFF";

		--Glitches in WE don't effect registers
		WE <= '1';
		wait for 10 ps;
		WE <= '0';
		wait for 10 ps;
		WE <= '1';
		wait for 10 ps;
		WE <= '0';
		wait for 10 ps;
		WE <= '1';
		wait for 10 ps;
		WE <= '0';
		wait for 10 ps;
		WE <= '1';
		wait for 10 ps;
		WE <= '0';
		wait for 10 ps;

		--Change the value of a register
		writeReg <= "11111";
		writeData <= X"AAAA_AAAA";
		reg1 <= "11111";
		wait for 2 ns;
		assert read2Data = X"FFFF_FFFF";

		wait;
	end process;
end behavior;

