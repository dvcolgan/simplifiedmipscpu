library ieee;
use ieee.std_logic_1164.all;

use work.datatypes.bus4x32;
use work.datatypes.bus2x32;
use work.datatypes.bus4x5;

use work.extender;
use work.mux32x4to1;
use work.mux32x2to1;
use work.mux5x4to1;
use work.shifter32x2tol;
use work.smoosher;
use work.fulladder32;
use work.RegFile;
use work.alu;
use work.control;
use work.alucontrol;
use work.instructionmemory;
use work.datamemory;
use work.reg;

entity cpu is
end cpu;

architecture behavior of cpu is

	component extender is
		port (Input: in std_logic_vector(15 downto 0);
		      ExtendMethod: in std_logic;
		      Output: out std_logic_vector(31 downto 0));
	end component;

	component mux32x4to1 is
		port (S: in std_logic_vector(1 downto 0);
		      R: in bus4x32;
		      O: out std_logic_vector(31 downto 0));
	end component;

	component mux32x2to1 is
		port (S: in std_logic;
		      R: in bus2x32;
		      O: out std_logic_vector(31 downto 0));
	end component;

	component mux5x4to1 is
		port (S: in std_logic_vector(1 downto 0);
		      R: in bus4x5;
		      O: out std_logic_vector(4 downto 0));
	end component;

	component shifter32x2tol is
		port (S: in std_logic;
		      R: in std_logic_vector(31 downto 0);
		      O: out std_logic_vector(31 downto 0);
		      C: out std_logic);
	end component;

	component smoosher is
		port (JumpAddress: in std_logic_vector(25 downto 0);
		      PCPlus4: in std_logic_vector(31 downto 28);
		      Output: out std_logic_vector(31 downto 0));
	end component;

	component fulladder32 is
		port (A: in std_logic_vector(31 downto 0);
		      B: in std_logic_vector(31 downto 0);
		      Cin: in std_logic;
		      S: out std_logic_vector(31 downto 0);
		      Cout: out std_logic;
		      Over: out std_logic);
	end component;

	component RegFile is
		port (Reg1, Reg2, WriteReg: in std_logic_vector(4 downto 0);
		      WE, Clock: in std_logic;
		      WriteData: in std_logic_vector(31 downto 0);
		      Read1Data, Read2Data: out std_logic_vector(31 downto 0));
	end component;

	component alu is
		port (Value1, Value2: in std_logic_vector(31 downto 0);
		      Operation: in std_logic_vector(2 downto 0);
		      ValueOut: out std_logic_vector(31 downto 0);
		      Overflow, Negative, Zero, CarryOut: out std_logic);
	end component;

	component control is
		port(Operation: in std_logic_vector(31 downto 26);
		     Function_: in std_logic_vector(5 downto 0);
		     Branch, MemRead, MemWrite, RegWrite, SignExtend: out std_logic;
		     MemToReg, RegDst, Jump, ALUSrc, ALUOp: out std_logic_vector(1 downto 0));
	end component;

	component alucontrol is
		port(ALUOp: in std_logic_vector(1 downto 0);
		     Function_: in std_logic_vector(5 downto 0);
		     Operation: out std_logic_vector(2 downto 0));
	end component;

	component instructionmemory is
		port (Address: in std_logic_vector(31 downto 0);
		      InstructionOut: out std_logic_vector(31 downto 0));
	end component;

	component sram64kx8 is
		generic (rom_data_file_name: string := "datamemoryinit.dat");

		port (ncs: in std_logic;       -- not chip select
		      addr: in std_logic_vector(31 downto 0);
		      data: inout std_logic_vector(31 downto 0);
		      nwe: in std_logic;       -- not write enable
		      noe: in std_logic);      -- not output enable
	end component;

	component datamemory
		port (Address: in std_logic_vector(31 downto 0);
		      WriteEnable, ReadEnable: in std_logic;
		      Clock: in std_logic;
		      DataIn: in std_logic_vector(31 downto 0);
		      DataOut: out std_logic_vector(31 downto 0));
	end component;

	component reg is
		port (WE, clock: in std_logic;
		      D: in std_logic_vector(31 downto 0);
		      Q: out std_logic_vector(31 downto 0));
	end component;

	signal Clock: std_logic;
	signal ProgramCounterIn: std_logic_vector(31 downto 0);
	signal ProgramCounterOut: std_logic_vector(31 downto 0);
	signal ProgramCounterInit: std_logic_vector(31 downto 0);
	signal ProgramCounterInitFlag: std_logic;

	signal RegisterFileWriteIn: std_logic_vector(4 downto 0);
	signal RegisterFileData1Out: std_logic_vector(31 downto 0);
	signal RegisterFileData2Out: std_logic_vector(31 downto 0);
	signal ALUSrcMuxOut: std_logic_vector(31 downto 0);
	signal MemToRegMuxOut: std_logic_vector(31 downto 0);
	signal ImmediateValue: std_logic_vector(15 downto 0);

	signal ALUValueOut: std_logic_vector(31 downto 0);
	signal ALUOverflow: std_logic;
	signal ALUNegative: std_logic;
	signal ALUZero: std_logic;
	signal ALUCarryOut: std_logic;
	signal BranchAndZero: std_logic;
	signal BranchAdderOut: std_logic_vector(31 downto 0);
	signal BranchMuxOut: std_logic_vector(31 downto 0);
	signal JumpMuxOut: std_logic_vector(31 downto 0);

	signal DataMemoryOut: std_logic_vector(31 downto 0);
	signal InstructionMemoryOut: std_logic_vector(31 downto 0);
	signal ExtenderOut: std_logic_vector(31 downto 0);
	signal DataMemoryReadEnableConnect: std_logic;
	signal DataMemoryWriteEnableConnect: std_logic;


	signal ControlFlagBranch: std_logic;
	signal ControlFlagMemRead: std_logic;
	signal ControlFlagMemWrite: std_logic;
	signal ControlFlagALUSrc: std_logic_vector(1 downto 0);
	signal ControlFlagRegWrite: std_logic;
	signal ControlFlagSignExtend: std_logic;
	signal ControlFlagMemToReg: std_logic_vector(1 downto 0);
	signal ControlFlagRegDst: std_logic_vector(1 downto 0);
	signal ControlFlagJump: std_logic_vector(1 downto 0);
	signal ControlFlagALUOp: std_logic_vector(1 downto 0);

	signal ALUControlOperationOut: std_logic_vector(2 downto 0);

	signal Rs, Rt, Rd, ShiftAmnt: std_logic_vector(4 downto 0);
	signal ExtendedShiftAmnt: std_logic_vector(31 downto 0);

	signal PCPlus4: std_logic_vector(31 downto 0);

	signal SmoosherOutput: std_logic_vector(31 downto 0);
begin

	InitializationMux: mux32x2to1 port map(S=>ProgramCounterInitFlag,
                                           R(0)=>ProgramCounterInit,
                                           R(1)=>JumpMuxOut,
                                           O=>ProgramCounterIn);

	ProgramCounter: reg port map (WE=>'1',
                                  clock=>Clock,
                                  D=>ProgramCounterIn,
                                  Q=>ProgramCounterOut);

	Smoosher_0: smoosher port map (JumpAddress=>InstructionMemoryOut(25 downto 0),
                                   PCPlus4=>PCPlus4(31 downto 28),
                                   Output=>SmoosherOutput);

	PCPlus4Adder: fulladder32 port map (A=>ProgramCounterOut,
                                        B=>X"0000_0004",
                                        Cin=>'0',
                                        S=>PCPlus4);

	BranchAdder: fulladder32 port map (A=>PCPlus4,
                                       B(31 downto 2)=>ExtenderOut(29 downto 0),
                                       B(1 downto 0)=>"00", --left shift by 2
                                       Cin=>'0',
                                       S=>BranchAdderOut);

	BranchAndZero <= ControlFlagBranch and ALUZero after 35 ps;
	BranchMux: mux32x2to1 port map (S=>BranchAndZero,
                                    R(0)=>PCPlus4,
                                    R(1)=>BranchAdderOut,
                                    O=>BranchMuxOut);

	JumpMux: mux32x4to1 port map (S=>ControlFlagJump,
                                  R(0)=>BranchMuxOut,
                                  R(1)=>SmoosherOutput,
                                  R(2)=>RegisterFileData1Out,
                                  R(3)=>X"0000_0000",
                                  O=>JumpMuxOut);

	InstructionMemory_0: instructionmemory port map (Address=>ProgramCounterOut,
                                                     InstructionOut=>InstructionMemoryOut);

	Rs <= InstructionMemoryOut(25 downto 21);
	Rt <= InstructionMemoryOut(20 downto 16);
	Rd <= InstructionMemoryOut(15 downto 11);
	ShiftAmnt <= InstructionMemoryOut(10 downto 6);
	ImmediateValue <= InstructionMemoryOut(15 downto 0);

	Extender_0: extender port map (Input=>ImmediateValue,
                                   ExtendMethod=>ControlFlagSignExtend,
                                   Output=>ExtenderOut);

	RegDstMux: mux5x4to1 port map (S=>ControlFlagRegDst,
                                   R(0)=>Rt,
                                   R(1)=>Rd,
                                   R(2)=>"11111",
                                   R(3)=>"00000", --unused
                                   O=>RegisterFileWriteIn);

	RegisterFile: RegFile port map (Reg1=>Rs,
                                    Reg2=>Rt,
                                    WE=>ControlFlagRegWrite,
                                    Clock=>clock,
                                    WriteReg=>RegisterFileWriteIn,
                                    WriteData=>MemToRegMuxOut,
                                    Read1Data=>RegisterFileData1Out,
                                    Read2Data=>RegisterFileData2Out);

	ExtendedShiftAmnt(31 downto 5) <= "000000000000000000000000000";
	ExtendedShiftAmnt(4 downto 0) <= ShiftAmnt;
	ALUSrcMux: mux32x4to1 port map (S=>ControlFlagALUSrc,
                                    R(0)=>RegisterFileData2Out,
                                    R(1)=>ExtenderOut,
                                    R(2)=>ExtendedShiftAmnt,
                                    R(3)=>X"0000_0000", --unused
                                    O=>ALUSrcMuxOut);

	ALU_0: alu port map (Value1=>RegisterFileData1Out,
                         Value2=>ALUSrcMuxOut,
                         Operation=>ALUControlOperationOut,
                         ValueOut=>ALUValueOut,
                         Overflow=>ALUOverflow,
                         Negative=>ALUNegative,
                         Zero=>ALUZero,
                         CarryOut=>ALUCarryOut);

	DataMemory_0: datamemory port map (Address=>ALUValueOut,
                                       DataIn=>RegisterFileData2Out,
                                       DataOut=>DataMemoryOut,
                                       WriteEnable=>ControlFlagMemWrite,
                                       ReadEnable=>ControlFlagMemRead,
                                       Clock=>Clock);

	MemToRegMux: mux32x4to1 port map (S=>ControlFlagMemToReg,
                                      R(0)=>ALUValueOut,
                                      R(1)=>DataMemoryOut,
                                      R(2)=>PCPlus4,
                                      R(3)=>X"0000_0000", --unused
                                      O=>MemToRegMuxOut);

	Control_0: control port map (Operation=>InstructionMemoryOut(31 downto 26),
                                 Function_=>InstructionMemoryOut(5 downto 0),
                                 Branch=>ControlFlagBranch,
                                 MemRead=>ControlFlagMemRead,
                                 MemWrite=>ControlFlagMemWrite,
                                 ALUSrc=>ControlFlagALUSrc,
                                 RegWrite=>ControlFlagRegWrite,
                                 SignExtend=>ControlFlagSignExtend,
                                 MemToReg=>ControlFlagMemToReg,
                                 RegDst=>ControlFlagRegDst,
                                 Jump=>ControlFlagJump,
                                 ALUOp=>ControlFlagALUOp);

	ALUControl_0: alucontrol port map (ALUOp=>ControlFlagALUOp,
                                       Function_=>InstructionMemoryOut(5 downto 0),
                                       Operation=>ALUControlOperationOut);

	process
	begin
		--initialize the program counter
		ProgramCounterInitFlag <= '0';
		ProgramCounterInit <= X"0000_4000";
		Clock <= '0';
		wait for 1 ns;
		Clock <= '1';
		wait for 1 ns;
		ProgramCounterInitFlag <= '1';

		for i in 1 to 1000 loop
			Clock <= not Clock;
			if InstructionMemoryOut(31 downto 26) = "111111" then
				wait;
			end if;
			wait for 2 ns;
		end loop;
		wait;
	end process;
end behavior;
