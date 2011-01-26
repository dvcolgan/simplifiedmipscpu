library ieee;
use ieee.std_logic_1164.all;

use work.datatypes.bus32x32;
use work.datatypes.bus2x32;
use work.mux32x32to1;
use work.mux32x2to1;
use work.mux2to1;
use work.decoder5to32;
use work.reg;
use work.ground32;
use work.comparator;

entity RegFile is
	port (reg1, reg2, writeReg: in std_logic_vector(4 downto 0);
	      WE, clock, init: in std_logic;
	      writeData: in std_logic_vector(31 downto 0);
	      read1Data, read2Data: out std_logic_vector(31 downto 0));
end RegFile;

architecture behavior of RegFile is

	component mux2to1 is
		port (S: in std_logic;
		      R: in std_logic_vector(1 downto 0);
		      O: out std_logic);
	end component;

	component mux32x2to1 is
		port (S: in std_logic;
		      R: in bus2x32;
		      O: out std_logic_vector(31 downto 0));
	end component;

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
		port (WE, clock, init: in std_logic;
		      D: in std_logic_vector(31 downto 0);
		      Q: out std_logic_vector(31 downto 0));
	end component;

	component ground32
		port (G: out std_logic_vector(31 downto 0));
	end component;

	component comparator is
		port (Value1, Value2: in std_logic_vector(31 downto 0);
		      Output: out std_logic);
	end component;

	signal WEIntoRegisters: std_logic_vector(31 downto 0);
	signal regOutBus: bus32x32;
	signal AddrNotSame1, AddrNotSame2: std_logic;
	signal RegMuxOutValue1, RegMuxOutValue2: std_logic_vector(31 downto 0);
	signal ChooserMuxFlag1, ChooserMuxFlag2: std_logic;
	signal Reg1IsNotZero, Reg2IsNotZero: std_logic;
	signal ForwardingMuxSelector1, ForwardingMuxSelector2: std_logic;
begin

	dataInDecoder: decoder5to32 port map (S=>writeReg, R=>WE, O=>WEIntoRegisters);

	regs: for i in 31 downto 0 generate

		zero: if i=0 generate
			reg_0: ground32 port map (G=>regOutBus(i));
		end generate;

		otherwise: if i/=0 generate
			reg_x: reg port map (WE=>WEIntoRegisters(i), clock=>clock, D=>writeData, Q=>regOutBus(i), init=>init);
		end generate;
	end generate;

	mux32x32to1_0: mux32x32to1 port map (S=>reg1, R=>regOutBus, O=>RegMuxOutValue1);
	mux32x32to1_1: mux32x32to1 port map (S=>reg2, R=>regOutBus, O=>RegMuxOutValue2);

	--added in-registerfile forwarding
	comparator_0: comparator port map (Value1(4 downto 0)=>reg1, Value1(31 downto 5)=>"000000000000000000000000000",
	                                   Value2(4 downto 0)=>writeReg, Value2(31 downto 5)=>"000000000000000000000000000",
	                                   Output=>AddrNotSame1);

	comparator_1: comparator port map (Value1(4 downto 0)=>reg2, Value1(31 downto 5)=>"000000000000000000000000000",
	                                   Value2(4 downto 0)=>writeReg, Value2(31 downto 5)=>"000000000000000000000000000",
	                                   Output=>AddrNotSame2);

	comparator_IsNotZero1: comparator port map (Value1(4 downto 0)=>reg1, Value1(31 downto 5)=>"000000000000000000000000000",
	                                         Value2=>X"0000_0000",
	                                         Output=>Reg1IsNotZero);

	comparator_IsNotZero2: comparator port map (Value1(4 downto 0)=>reg2, Value1(31 downto 5)=>"000000000000000000000000000",
	                                         Value2=>X"0000_0000",
	                                         Output=>Reg2IsNotZero);

	ForwardingMuxSelector1 <= (not AddrNotSame1) and Reg1IsNotZero after 70 ps;
	ForwardingMuxSelector2 <= (not AddrNotSame2) and Reg2IsNotZero after 70 ps;

	mux32x2to1_0: mux32x2to1 port map (S=>ForwardingMuxSelector1, R(0)=>RegMuxOutValue1, R(1)=>writedata, O=>read1Data);
	mux32x2to1_1: mux32x2to1 port map (S=>ForwardingMuxSelector2, R(0)=>RegMuxOutValue2, R(1)=>writedata, O=>read2Data);
	--fix this to not work for register 0

end behavior;
