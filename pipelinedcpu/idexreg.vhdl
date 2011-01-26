library ieee;
USE ieee.std_logic_1164.all;

use work.reg;
use work.reg5;
use work.reg11;
use work.mux5x2to1;
use work.mux32x2to1;
use work.datatypes.bus2x5;
use work.datatypes.bus2x32;

entity idexreg is
	port (WE, clock, init: in std_logic;
	      RegisterFileData1In, RegisterFileData2In, PCPlus8In: in std_logic_vector(31 downto 0);
	      ControlFlagRegWriteIn, ControlFlagMemReadIn, ControlFlagMemWriteIn: in std_logic;
	      ControlFlagMemToRegIn, ControlFlagRegDstIn, ControlFlagALUOpIn, ControlFlagALUSrcIn: in std_logic_vector(1 downto 0);

	      RsIn, RtIn, RdIn, ShiftAmntIn: in std_logic_vector(4 downto 0);
	      ExtendedImmediateIn: in std_logic_vector(31 downto 0);

	      RegisterFileData1Out, RegisterFileData2Out, PCPlus8Out: out std_logic_vector(31 downto 0);
	      ControlFlagRegWriteOut, ControlFlagMemReadOut, ControlFlagMemWriteOut: Out std_logic;
	      ControlFlagMemToRegOut, ControlFlagRegDstOut, ControlFlagALUOpOut, ControlFlagALUSrcOut: Out std_logic_vector(1 downto 0);
	      RsOut, RtOut, RdOut, ShiftAmntOut: out std_logic_vector(4 downto 0);
	      ExtendedImmediateOut: out std_logic_vector(31 downto 0));
end idexreg;

architecture behavior of idexreg is
	component mux32x2to1 is
		port (S: in std_logic;
		      R: in bus2x32;
		      O: out std_logic_vector(31 downto 0));
	end component;

	component reg is
		port (WE, clock, init: in std_logic;
		      D: in std_logic_vector(31 downto 0);
		      Q: out std_logic_vector(31 downto 0));
	end component;

	component reg5 is
		port (WE, clock, init: in std_logic;
		      D: in std_logic_vector(4 downto 0);
		      Q: out std_logic_vector(4 downto 0));
	end component;

	component reg7 is
		port (WE, clock, init: in std_logic;
		      D: in std_logic_vector(6 downto 0);
		      Q: out std_logic_vector(6 downto 0));
	end component;

	component reg11 is
		port (WE, clock, init: in std_logic;
		      D: in std_logic_vector(10 downto 0);
		      Q: out std_logic_vector(10 downto 0));
	end component;

	component mux5x2to1 is
		port (S: in std_logic;
		      R: in bus2x5;
		      O: out std_logic_vector(4 downto 0));
	end component;

	signal RegisterFileData1, RegisterFileData2: std_logic_vector(31 downto 0);
	signal ControlFlags: std_logic_vector(10 downto 0);
	signal ControlFlagMemToReg: std_logic_vector(1 downto 0);
	signal ControlFlagRegWrite: std_logic;
	signal ControlFlagMemRead: std_logic;
	signal ControlFlagMemWrite: std_logic;
	signal ControlFlagRegDst: std_logic_vector(1 downto 0);
	signal ControlFlagALUOp: std_logic_vector(1 downto 0);
	signal ControlFlagALUSrc: std_logic_vector(1 downto 0);
	signal Rs, Rt, Rd, ShiftAmnt: std_logic_vector(4 downto 0);
	signal ExtendedImmediate: std_logic_vector(31 downto 0);

	signal ground: std_logic_vector(31 downto 0);

begin


	RegisterFileData1Reg: reg port map (WE=>WE,
                                        clock=>clock,
                                        init=>init,
                                        D=>RegisterFileData1In,
                                        Q=>RegisterFileData1Out);

	RegisterFileData2Reg: reg port map (WE=>WE,
                                        clock=>clock,
                                        init=>init,
                                        D=>RegisterFileData2In,
                                        Q=>RegisterFileData2Out);

	PCPlus8Reg: reg port map (WE=>WE,
                              clock=>clock,
                              init=>init,
                              D=>PCPlus8In,
                              Q=>PCPlus8Out);

	ControlFlagsReg: reg11 port map (WE=>WE,
                                     clock=>clock,
                                     init=>init,
                                     D(1 downto 0)=>ControlFlagMemToRegIn,
                                     D(2)=>ControlFlagRegWriteIn,
                                     D(3)=>ControlFlagMemReadIn,
                                     D(4)=>ControlFlagMemWriteIn,
                                     D(6 downto 5)=>ControlFlagRegDstIn,
                                     D(8 downto 7)=>ControlFlagALUOpIn,
                                     D(10 downto 9)=>ControlFlagALUSrcIn,
                                     Q(1 downto 0)=>ControlFlagMemToRegOut,
                                     Q(2)=>ControlFlagRegWriteOut,
                                     Q(3)=>ControlFlagMemReadOut,
                                     Q(4)=>ControlFlagMemWriteOut,
                                     Q(6 downto 5)=>ControlFlagRegDstOut,
                                     Q(8 downto 7)=>ControlFlagALUOpOut,
                                     Q(10 downto 9)=>ControlFlagALUSrcOut);

	RsReg: reg5 port map (WE=>WE,
                          clock=>clock,
                          init=>init,
                          D=>RsIn,
                          Q=>RsOut);

	RtReg: reg5 port map (WE=>WE,
                          clock=>clock,
                          init=>init,
                          D=>RtIn,
                          Q=>RtOut);

	RdReg: reg5 port map (WE=>WE,
                          clock=>clock,
                          init=>init,
                          D=>RdIn,
                          Q=>RdOut);

	ShiftAmntReg: reg5 port map (WE=>WE,
                              clock=>clock,
                              init=>init,
                              D=>ShiftAmntIn,
                              Q=>ShiftAmntOut);

	ExtendedImmediateReg: reg port map (WE=>WE,
                                        clock=>clock,
                                        init=>init,
                                        D=>ExtendedImmediateIn,
                                        Q=>ExtendedImmediateOut);
end behavior;

