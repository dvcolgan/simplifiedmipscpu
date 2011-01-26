library ieee;
use ieee.std_logic_1164.all;

use work.addersubtractor32;
use work.nor32;
use work.or32;
use work.shiftertol;
use work.shiftertor;
use work.mux32x4to1;
use work.mux32x2to1;
use work.mux4to1;
use work.mux2to1;
use work.datatypes.bus4x32;
use work.datatypes.bus2x32;

entity alu is
	port (Value1, Value2: in std_logic_vector(31 downto 0);
	      Operation: in std_logic_vector(2 downto 0);
	      ValueOut: out std_logic_vector(31 downto 0);
	      Overflow, Negative, Zero, CarryOut: out std_logic);
end alu;

architecture behavior of alu is
	component addersubtractor32 is
		port (A: in std_logic_vector(31 downto 0);
		      B: in std_logic_vector(31 downto 0);
		      Cin: in std_logic;
		      S: out std_logic_vector(31 downto 0);
		      Cout: out std_logic;
		      Over: out std_logic);
	end component;

	component nor32 is
		port (R1: in std_logic_vector(31 downto 0);
		      R2: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0));
	end component;

	component or32 is
		port (R1: in std_logic_vector(31 downto 0);
		      R2: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0));
	end component;


	component shiftertol
		port (S: in std_logic_vector(4 downto 0);
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component shiftertor
		port (S: in std_logic_vector(4 downto 0);
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component mux32x4to1
		port (S: in std_logic_vector(1 downto 0);
		      R: in bus4x32;
		      O: out std_logic_vector(31 downto 0));
	end component;

	component mux32x2to1
		port (S: in std_logic;
		      R: in bus2x32;
		      O: out std_logic_vector(31 downto 0));
	end component;

	component mux2to1
		port (S: in std_logic;
		      R: in std_logic_vector(1 downto 0);
		      O: out std_logic);
	end component;

	component mux4to1
		port (S: in std_logic_vector(1 downto 0);
		      R: in std_logic_vector(3 downto 0);
		      O: out std_logic);
	end component;

	signal AdderSubtractorOut: std_logic_vector(31 downto 0);
	signal NorOut: std_logic_vector(31 downto 0);
	signal LShiftOutTemp: std_logic_vector(31 downto 0);
	signal LShiftOut: std_logic_vector(31 downto 0);
	signal RShiftOutTemp: std_logic_vector(31 downto 0);
	signal RShiftOut: std_logic_vector(31 downto 0);
	signal TempCarryOuts: std_logic_vector(3 downto 0);

	signal TempValueOut: std_logic_vector(31 downto 0);
	signal TempZero1: std_logic_vector(7 downto 0);
	signal TempZero2: std_logic_vector(1 downto 0);

	signal IsBigShiftTemp1: std_logic_vector(7 downto 0);
	signal IsBigShiftTemp2: std_logic_vector(1 downto 0);
	signal IsBigShift: std_logic;

	signal NotSetLessThanZero: std_logic;
	signal SetLessThanZero: std_logic;
	signal IsSetLessThan: std_logic;
	signal AllZeros: std_logic_vector(31 downto 0);
	signal SetLessThanBit: std_logic;
	signal SetLessThanValue: std_logic_vector(31 downto 0);

	signal BeforeOrIOut: std_logic_vector(31 downto 0);
	signal OrIOut: std_logic_vector(31 downto 0);
	signal IsOrI: std_logic;
begin
	AllZeros <= X"0000_0000";

	--make the adder subtractor
	addersubtractor_0: addersubtractor32 port map (A=>Value1, B=>Value2, Cin=>Operation(2), S=>AdderSubtractorOut, Cout=>TempCarryOuts(0), Over=>Overflow);

	--make the nor
	nor_0: nor32 port map (R1=>Value1, R2=>Value2, O=>NorOut);

	--make the shifters
	shiftertol_0: shiftertol port map (S=>Value2(4 downto 0), R=>Value1, O=>LShiftOutTemp, C=>TempCarryOuts(2));
	shiftertor_0: shiftertor port map (S=>Value2(4 downto 0), R=>Value1, O=>RShiftOutTemp, C=>TempCarryOuts(3));

	--fix the value of the shifter for shifting more than 31 bits
	--figure out if the value of Value2 is greater than 31
	big_shift: for i in 7 downto 2 generate
		IsBigShiftTemp1(i) <= Value2(i*4) or Value2(i*4+1) or Value2(i*4+2) or Value2(i*4+3) after 35 ps;
	end generate;
	IsBigShiftTemp1(1) <= Value2(7) or Value2(6) or Value2(5) after 35 ps;

	IsBigShiftTemp2(0) <= IsBigShiftTemp1(1) or IsBigShiftTemp1(2) or IsBigShiftTemp1(3) after 35 ps;
	IsBigShiftTemp2(1) <= IsBigShiftTemp1(4) or IsBigShiftTemp1(5) or IsBigShiftTemp1(6) or IsBigShiftTemp1(7) after 35 ps;
	IsBigShift <= IsBigShiftTemp2(0) or IsBigShiftTemp2(1) after 35 ps;

	mux32x2to1_ls: mux32x2to1 port map (S=>IsBigShift, R(0)=>LShiftOutTemp, R(1)=>AllZeros, O=>LShiftOut);
	mux32x2to1_rs: mux32x2to1 port map (S=>IsBigShift, R(0)=>RShiftOutTemp, R(1)=>AllZeros, O=>RShiftOut);

	--decide which output to use based on the Operation
	mux32x4to1_0: mux32x4to1 port map (S=>Operation(1 downto 0), R(0)=>AdderSubtractorOut, R(1)=>NorOut, R(2)=>LShiftOut, R(3)=>RShiftOut, O=>TempValueOut);

	--negative bit
	Negative <= TempValueOut(31);

	--carry out bit
	mux4to1_0: mux4to1 port map (S=>Operation(1 downto 0), R=>TempCarryOuts, O=>CarryOut);

	--zero bit
	zero_bit: for i in 7 downto 0 generate
		TempZero1(i) <= TempValueOut(i*4) or TempValueOut(i*4+1) or TempValueOut(i*4+2) or TempValueOut(i*4+3) after 35 ps;
	end generate;
	TempZero2(0) <= (TempZero1(0) or TempZero1(1) or TempZero1(2) or TempZero1(3)) after 35 ps;
	TempZero2(1) <= (TempZero1(4) or TempZero1(5) or TempZero1(6) or TempZero1(7)) after 35 ps;
	Zero <= not (TempZero2(0) or TempZero2(1)) after 70 ps;

	--set less than
	IsSetLessThan <= Operation(0) and (not Operation(1)) and Operation(2) after 70 ps;

	SetLessThanBit <= AdderSubtractorOut(31);
	SetLessThanValue(31 downto 1) <= AllZeros(31 downto 1);
	SetLessThanValue(0) <= SetLessThanBit;

	mux32x2to1_0: mux32x2to1 port map (S=>IsSetLessThan, R(0)=>TempValueOut, R(1)=>SetLessThanValue, O=>BeforeOrIOut);

	--a hack to add ori to the alu
	or32_0: or32 port map (R1=>Value1, R2=>Value2, O=>OrIOut);

	IsOrI <= Operation(2) and Operation(1) and Operation(0) after 35 ps;
	OrHackMux: mux32x2to1 port map (S=>IsOrI, R(0)=>BeforeOrIOut, R(1)=>OrIOut, O=>ValueOut);
end behavior;
