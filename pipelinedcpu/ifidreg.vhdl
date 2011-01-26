library ieee;
USE ieee.std_logic_1164.all;

use work.reg;
use work.mux32x2to1;
use work.datatypes.bus2x32;

entity ifidreg is
	port (WE, clock, init: in std_logic;
	      PCPlus4In: in std_logic_vector(31 downto 0);
	      InstructionMemoryIn: in std_logic_vector(31 downto 0);
	      IFFlush: in std_logic;
	      PCPlus4Out: out std_logic_vector(31 downto 0);
	      InstructionMemoryOut: out std_logic_vector(31 downto 0));
end ifidreg;

architecture behavior of ifidreg is

	component reg is
		port (WE, clock, init: in std_logic;
		      D: in std_logic_vector(31 downto 0);
		      Q: out std_logic_vector(31 downto 0));
	end component;

	component mux32x2to1 is
		port (S: in std_logic;
		      R: in bus2x32;
		      O: out std_logic_vector(31 downto 0));
	end component;

	signal InstructionMemoryRegIn: std_logic_vector(31 downto 0);
	signal PCPlus4: std_logic_vector(31 downto 0);
	signal InstructionMemory: std_logic_vector(31 downto 0);
begin

	PCPlus4Reg: reg port map (WE=>WE,
                              clock=>clock,
                              init=>init,
                              D=>PCPlus4In,
                              Q=>PCPlus4Out);

	FlusherMux: mux32x2to1 port map (S=>IFFlush,
	                                 R(0)=>InstructionMemoryIn,
	                                 R(1)=>X"0000_0000",
	                                 O=>InstructionMemoryRegIn);

	InstructionMemoryReg: reg port map (WE=>WE,
                                        clock=>clock,
                                        init=>init,
                                        D=>InstructionMemoryRegIn,
                                        Q=>InstructionMemoryOut);

end behavior;
