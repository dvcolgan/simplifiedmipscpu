library ieee;
USE ieee.std_logic_1164.all;

use work.reg;
use work.reg5;
use work.reg7;

entity memwbreg is
	port (WE, clock, init: in std_logic;
	      ControlFlagRegWriteIn: in std_logic;
	      ControlFlagMemToRegIn: in std_logic_vector(1 downto 0);
	      ALUValueIn, PCPlus8In: in std_logic_vector(31 downto 0);
	      DataMemoryIn: in std_logic_vector(31 downto 0);
	      RegWriteAddressIn: in std_logic_vector(4 downto 0);

	      ControlFlagRegWriteOut: out std_logic;
	      ControlFlagMemToRegOut: out std_logic_vector(1 downto 0);
	      ALUValueOut, PCPlus8Out: out std_logic_vector(31 downto 0);
	      DataMemoryOut: out std_logic_vector(31 downto 0);
	      RegWriteAddressOut: out std_logic_vector(4 downto 0));
end memwbreg;

architecture behavior of memwbreg is

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
	ControlFlagsMux: reg5 port map (WE=>WE,
                                    clock=>clock,
                                    init=>init,
                                    D(1 downto 0)=>ControlFlagMemToRegIn,
                                    D(2)=>ControlFlagRegWriteIn,
                                    D(3)=>'0',
                                    D(4)=>'0',
                                    Q(1 downto 0)=>ControlFlagMemToRegOut,
                                    Q(2)=>ControlFlagRegWriteOut,
                                    Q(3)=>ground,
                                    Q(4)=>ground);

	ALUValueReg: reg port map (WE=>WE,
                               clock=>clock,
                               init=>init,
                               D=>ALUValueIn,
                               Q=>ALUValueOut);

	PCPlus8Reg: reg port map (WE=>WE,
                              clock=>clock,
                              init=>init,
                              D=>PCPlus8In,
                              Q=>PCPlus8Out);

	DataMemoryReg: reg port map (WE=>WE,
                                 clock=>clock,
                                 init=>init,
                                 D=>DataMemoryIn,
                                 Q=>DataMemoryOut);

	RegWriteAddressReg: reg5 port map (WE=>WE,
                                       clock=>clock,
                                       init=>init,
                                       D=>RegWriteAddressIn,
                                       Q=>RegWriteAddressOut);
end behavior;

