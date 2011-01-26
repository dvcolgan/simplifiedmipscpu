library ieee;
use ieee.std_logic_1164.all;

use work.datatypes.bus32x32;
use work.mux32x32to1;
use work.decoder5to32;
use work.reg;
use work.ground32;

entity RegFile is
	port (reg1, reg2, writeReg: in std_logic_vector(4 downto 0);
	      WE, clock: in std_logic;
	      writeData: in std_logic_vector(31 downto 0);
	      read1Data, read2Data: out std_logic_vector(31 downto 0));
end RegFile;

architecture behavior of RegFile is
	component mux32x32to1 is
		port (S: in std_logic_vector(4 downto 0);
		      R: in bus32x32;
		      O: out std_logic_vector(31 downto 0));
	end component;
	component decoder5to32
		port (S: in std_logic_vector(4 downto 0);
		      R: in std_logic;
		      O: out std_logic_vector(31 downto 0));
	end component;
	component reg
		port (WE, clock: in std_logic;
		      D: in std_logic_vector(31 downto 0);
		      Q: out std_logic_vector(31 downto 0));
	end component;
	component ground32
		port (G: out std_logic_vector(31 downto 0));
	end component;

	signal WEIntoRegisters: std_logic_vector(31 downto 0);
	signal regOutBus: bus32x32;
begin

	dataInDecoder: decoder5to32 port map (S=>writeReg, R=>WE, O=>WEIntoRegisters);

	regs: for i in 31 downto 0 generate

		zero: if i=0 generate
			reg_0: ground32 port map (G=>regOutBus(i));
		end generate;

		otherwise: if i/=0 generate
			reg_x: reg port map (WE=>WEIntoRegisters(i), clock=>clock, D=>writeData, Q=>regOutBus(i));
		end generate;
	end generate;

	mux32x32to1_0: mux32x32to1 port map (S=>reg1, R=>regOutBus, O=>read1Data);
	mux32x32to1_1: mux32x32to1 port map (S=>reg2, R=>regOutBus, O=>read2Data);
end behavior;
