library ieee;
USE ieee.std_logic_1164.all;

use work.reg;
use work.reg5;
use work.reg7;

entity exmemreg is
	port (WE, clock, init: in std_logic;
	      RegisterFileData2In, PCPlus8In: in std_logic_vector(31 downto 0);
	      ControlFlagRegWriteIn, ControlFlagMemReadIn, ControlFlagMemWriteIn: in std_logic;
	      ControlFlagMemToRegIn: in std_logic_vector(1 downto 0);
	      ALUValueIn: in std_logic_vector(31 downto 0);
	      RegWriteAddressIn: in std_logic_vector(4 downto 0);

	      RegisterFileData2Out, PCPlus8Out: out std_logic_vector(31 downto 0);
	      ControlFlagRegWriteOut, ControlFlagMemReadOut, ControlFlagMemWriteOut: Out std_logic;
	      ControlFlagMemToRegOut: Out std_logic_vector(1 downto 0);
	      ALUValueOut: out std_logic_vector(31 downto 0);
	      RegWriteAddressOut: out std_logic_vector(4 downto 0));
end exmemreg;

architecture behavior of exmemreg is

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

	signal InstructionMemoryRegIn: std_logic_vector(31 downto 0);
	signal ground: std_logic;
begin
	ControlFlagsReg: reg5 port map (WE=>WE,
	                               clock=>clock,
	                               init=>init,
	                               D(1 downto 0)=>ControlFlagMemToRegIn,
	                               D(2)=>ControlFlagRegWriteIn,
	                               D(3)=>ControlFlagMemReadIn,
	                               D(4)=>ControlFlagMemWriteIn,
	                               Q(1 downto 0)=>ControlFlagMemToRegOut,
	                               Q(2)=>ControlFlagRegWriteOut,
	                               Q(3)=>ControlFlagMemReadOut,
	                               Q(4)=>ControlFlagMemWriteOut);

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

	ALUValueReg: reg port map (WE=>WE,
	                           clock=>clock,
	                           init=>init,
	                           D=>ALUValueIn,
	                           Q=>ALUValueOut);

	RegWriteAddressReg: reg5 port map (WE=>WE,
	                                   clock=>clock,
	                                   init=>init,
	                                   D=>RegWriteAddressIn,
	                                   Q=>RegWriteAddressOut);
end behavior;

