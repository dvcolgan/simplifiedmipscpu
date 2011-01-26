library ieee;
use ieee.std_logic_1164.all;

entity instructionmemory is
	port (Address: in std_logic_vector(31 downto 0);
	      InstructionOut: out std_logic_vector(31 downto 0));
end instructionmemory;

architecture behavior of instructionmemory is
	component sram64kx8 is
		generic (rom_data_file_name: string := "instructionmemoryinit.dat");

		port (ncs: in std_logic;       -- not chip select
		      addr: in std_logic_vector(31 downto 0);
		      data: inout std_logic_vector(31 downto 0);
		      nwe: in std_logic;       -- not write enable
		      noe: in std_logic);      -- not output enable
	end component;
	signal InstructionOutConnect: std_logic_vector(31 downto 0);
begin
	sram: sram64kx8 port map (ncs=>'0', addr=>Address, data=>InstructionOutConnect, nwe=>'1', noe=>'0');

	InstructionOut <= InstructionOutConnect;
end architecture;
