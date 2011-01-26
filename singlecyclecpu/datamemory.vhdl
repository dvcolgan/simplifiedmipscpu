library ieee;
use ieee.std_logic_1164.all;
use work.mux32x2to1;
use work.datatypes.bus2x32;

entity datamemory is
	port (Address: in std_logic_vector(31 downto 0);
	      WriteEnable, ReadEnable: in std_logic;
	      Clock: in std_logic;
	      DataIn: in std_logic_vector(31 downto 0);
	      DataOut: out std_logic_vector(31 downto 0));
end datamemory;

architecture behavior of datamemory is
	component sram64kx8 is
		generic (rom_data_file_name: string := "datamemoryinit.dat");

		port (ncs: in std_logic;       -- not chip select
		      addr: in std_logic_vector(31 downto 0);
		      data: inout std_logic_vector(31 downto 0);
		      nwe: in std_logic;       -- not write enable
		      noe: in std_logic);      -- not output enable
	end component;

	signal WriteEnableConnect: std_logic;
	signal ReadEnableConnect: std_logic;
	signal DataConnect:std_logic_vector(31 downto 0);
begin
	process
	begin
		wait until clock'event and clock = '1';
		DataConnect <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
		WriteEnableConnect <= '1';
		ReadEnableConnect <= '1';
		wait for 1 ns;

		if WriteEnable = '1' then
			WriteEnableConnect <= '0';
			ReadEnableConnect <= '1';
			DataConnect <= DataIn;
		else
			if ReadEnable = '1' then
				ReadEnableConnect <= '0';
				WriteEnableConnect <= '1';
			else
				ReadEnableConnect <= '1';
				WriteEnableConnect <= '1';
			end if;
		end if;
	end process;

	sram: sram64kx8 port map (ncs=>'0',
                              addr=>Address,
                              data=>DataConnect,
                              nwe=>WriteEnableConnect,
                              noe=>ReadEnableConnect);
	DataOut <= DataConnect;
end architecture;
