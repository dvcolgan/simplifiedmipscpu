library ieee;
use ieee.std_logic_1164.all;

use work.datatypes.bus4x32;
use work.datatypes.bus2x32;
use work.datatypes.bus4x5;

use work.extender;
use work.mux2to1;
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
use work.ifidreg;
use work.idexreg;
use work.exmemreg;
use work.memwbreg;
use work.forwardingunit;
use work.comparator;

entity cpu is
end cpu;

architecture pipelined of cpu is

	component mux2to1 is
		port (S: in std_logic;
		      R: in std_logic_vector(1 downto 0);
		      O: out std_logic);
	end component;

	component comparator is
		port (Value1, Value2: in std_logic_vector(31 downto 0);
		      Output: out std_logic);
	end component;

	component forwardingunit is
		port(Rs, Rt: in std_logic_vector(4 downto 0);
	         MEM_RegWriteAddress, WB_RegWriteAddress: in std_logic_vector(4 downto 0);
	         MEM_RegWriteAddressWE, WB_RegWriteAddressWE: in std_logic;
	         ForwardingUnitFlagALUSrc1, ForwardingUnitFlagALUSrc2: out std_logic_vector(1 downto 0));
	end component;

	component ifidreg is
		port (WE, clock, init: in std_logic;
	          PCPlus4In: in std_logic_vector(31 downto 0);
	          InstructionMemoryIn: in std_logic_vector(31 downto 0);
	          IFFlush: in std_logic;
	          PCPlus4Out: out std_logic_vector(31 downto 0);
	          InstructionMemoryOut: out std_logic_vector(31 downto 0));
	end component;

	component idexreg is
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
	end component;

	component exmemreg is
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
	end component;

	component memwbreg is
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
	end component;

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
		      WE, Clock, init: in std_logic;
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

	component datamemory
		port (Address: in std_logic_vector(31 downto 0);
		      WriteEnable, ReadEnable: in std_logic;
		      Clock: in std_logic;
		      DataIn: in std_logic_vector(31 downto 0);
		      DataOut: out std_logic_vector(31 downto 0));
	end component;

	component reg is
		port (WE, clock, init: in std_logic;
		      D: in std_logic_vector(31 downto 0);
		      Q: out std_logic_vector(31 downto 0));
	end component;

	signal Clock: std_logic;
	signal ProgramCounterIn: std_logic_vector(31 downto 0);
	signal ProgramCounterOut: std_logic_vector(31 downto 0);
	signal ProgramCounterInit: std_logic_vector(31 downto 0);
	signal ProgramCounterInitFlag, CPUInitFlag: std_logic;

	signal RegisterFileData1Out: std_logic_vector(31 downto 0);
	signal RegisterFileData2Out: std_logic_vector(31 downto 0);

	signal ALUValueOut: std_logic_vector(31 downto 0);
	signal JumpMuxOut: std_logic_vector(31 downto 0);

	signal IF_InstructionMemoryOut, ID_InstructionMemoryOut: std_logic_vector(31 downto 0);
	signal ID_RegisterFileData1Out: std_logic_vector(31 downto 0);
	signal ID_RegisterFileData2Out: std_logic_vector(31 downto 0);
	signal ID_ControlFlagMemToReg: std_logic_vector(1 downto 0);
	signal ID_ControlFlagRegWrite: std_logic;
	signal ID_ControlFlagMemRead: std_logic;
	signal ID_ControlFlagMemWrite: std_logic;
	signal ID_ControlFlagRegDst: std_logic_vector(1 downto 0);
	signal ID_ControlFlagALUOp: std_logic_vector(1 downto 0);
	signal ID_ControlFlagALUSrc: std_logic_vector(1 downto 0);
	signal EX_RegisterFileData1Out: std_logic_vector(31 downto 0);
	signal EX_RegisterFileData2Out: std_logic_vector(31 downto 0);
	signal EX_ControlFlagMemToReg: std_logic_vector(1 downto 0);
	signal EX_ControlFlagRegWrite: std_logic;
	signal EX_ControlFlagMemRead: std_logic;
	signal EX_ControlFlagMemWrite: std_logic;
	signal EX_ControlFlagRegDst: std_logic_vector(1 downto 0);
	signal EX_ControlFlagALUOp: std_logic_vector(1 downto 0);
	signal EX_ControlFlagALUSrc: std_logic_vector(1 downto 0);
	signal MEM_RegWriteAddress: std_logic_vector(4 downto 0);
	signal MEM_ControlFlagRegWrite: std_logic;
	signal WB_RegWriteAddress: std_logic_vector(4 downto 0);
	signal WB_ControlFlagRegWrite: std_logic;
	signal ForwardingUnitFlagALUSrc1: std_logic_vector(1 downto 0);
	signal ForwardingUnitFlagALUSrc2: std_logic_vector(1 downto 0);

	signal ID_ImmediateValue: std_logic_vector(15 downto 0);
	signal ID_ExtenderOut: std_logic_vector(31 downto 0);
	signal ID_SmoosherOutput: std_logic_vector(31 downto 0);
	signal ID_BranchAdderOut: std_logic_vector(31 downto 0);
	signal ID_BranchComparatorOut: std_logic;
	signal ID_BranchMuxOut: std_logic_vector(31 downto 0);
	signal WB_MemToRegMuxOut: std_logic_vector(31 downto 0);
	signal ID_ControlFlagBranch: std_logic;
	signal ID_ControlFlagSignExtend: std_logic;
	signal ID_ControlFlagJump: std_logic_vector(1 downto 0);
	signal EX_ExtenderOut: std_logic_vector(31 downto 0);
	signal EX_ExtendedShiftAmnt: std_logic_vector(31 downto 0);

	signal EX_RegWriteAddress: std_logic_vector(4 downto 0);
	signal EX_ALUValueOut: std_logic_vector(31 downto 0);
	signal MEM_Controlflagmemtoreg: std_logic_vector(1 downto 0);
	signal MEM_Controlflagmemread: std_logic;
	signal MEM_Controlflagmemwrite: std_logic;
	signal MEM_Aluvalueout: std_logic_vector(31 downto 0);
	signal MEM_Registerfiledata2out: std_logic_vector(31 downto 0);
	signal MEM_Datamemoryout: std_logic_vector(31 downto 0);
	signal WB_Datamemoryout: std_logic_vector(31 downto 0);
	signal WB_ControlFlagMemToReg: std_logic_vector(1 downto 0);
	signal WB_ALUValueOut: std_logic_vector(31 downto 0);
	signal instructionmemoryout: std_logic_vector(31 downto 0);

	signal ALUForwardingmux1output: std_logic_vector(31 downto 0);
	signal ALUForwardingmux2output: std_logic_vector(31 downto 0);
	signal EX_ALUSrcmuxout: std_logic_vector(31 downto 0);
	signal EX_ALUControloperationout: std_logic_vector(2 downto 0);
	signal EX_ALUOverflow: std_logic;
	signal EX_ALUNegative: std_logic;
	signal EX_ALUZero: std_logic;
	signal EX_ALUCarryout: std_logic;

	signal ID_Rs, ID_Rt, ID_Rd, ID_ShiftAmnt: std_logic_vector(4 downto 0);
	signal EX_Rs, EX_Rt, EX_Rd, EX_ShiftAmnt: std_logic_vector(4 downto 0);

	signal IF_PCPlus4, ID_PCPlus4, ID_PCPlus8, EX_PCPlus8, MEM_PCPlus8, WB_PCPlus8: std_logic_vector(31 downto 0);

	signal RegFileWriteAddress: std_logic_vector(4 downto 0);
	signal RegFileWriteAddressInitFlag: std_logic_vector(1 downto 0);

begin

	InitializationMux: mux32x2to1 port map(S=>ProgramCounterInitFlag,
                                           R(0)=>ProgramCounterInit,
                                           R(1)=>JumpMuxOut,
                                           O=>ProgramCounterIn);

	ProgramCounter: reg port map (WE=>'1',
                                  clock=>Clock,
	                              init=>'1',
                                  D=>ProgramCounterIn,
                                  Q=>ProgramCounterOut);

	PCPlus4Adder: fulladder32 port map (A=>ProgramCounterOut,
                                        B=>X"0000_0004",
                                        Cin=>'0',
                                        S=>IF_PCPlus4);

	InstructionMemory_0: instructionmemory port map (Address=>ProgramCounterOut,
                                                     InstructionOut=>IF_InstructionMemoryOut);

	IfIdReg_0: ifidreg port map (WE=>'1',
	                             clock=>Clock,
	                             init=>CPUInitFlag,
	                             PCPlus4In=>IF_PCPlus4,
	                             InstructionMemoryIn=>IF_InstructionMemoryOut,
	                             IFFlush=>'0',
	                             PCPlus4Out=>ID_PCPlus4,
	                             InstructionMemoryOut=>ID_InstructionMemoryOut);

	ID_Rs <= ID_InstructionMemoryOut(25 downto 21);
	ID_Rt <= ID_InstructionMemoryOut(20 downto 16);
	ID_Rd <= ID_InstructionMemoryOut(15 downto 11);
	ID_ShiftAmnt <= ID_InstructionMemoryOut(10 downto 6);
	ID_ImmediateValue <= ID_InstructionMemoryOut(15 downto 0);

	Extender_0: extender port map (Input=>ID_ImmediateValue,
                                   ExtendMethod=>ID_ControlFlagSignExtend,
                                   Output=>ID_ExtenderOut);

	PCPlus8Adder: fulladder32 port map (A=>ID_PCPlus4,
                                        B=>X"0000_0004",
                                        Cin=>'0',
                                        S=>ID_PCPlus8);

	Smoosher_0: smoosher port map (JumpAddress=>ID_InstructionMemoryOut(25 downto 0),
                                   PCPlus4=>ID_PCPlus4(31 downto 28),
                                   Output=>ID_SmoosherOutput);

	BranchAdder: fulladder32 port map (A=>ID_PCPlus4,
                                       B(31 downto 2)=>ID_ExtenderOut(29 downto 0),
                                       B(1 downto 0)=>"00", --left shift by 2
                                       Cin=>'0',
                                       S=>ID_BranchAdderOut);

	BranchComparator: comparator port map (Value1=>ID_RegisterFileData1Out,
	                                       Value2=>ID_RegisterFileData2Out,
	                                       Output=>ID_BranchComparatorOut);

	BranchMux: mux32x2to1 port map (S=>ID_BranchComparatorOut,
                                    R(0)=>ID_BranchAdderOut,
                                    R(1)=>IF_PCPlus4,
                                    O=>ID_BranchMuxOut);

	JumpMux: mux32x4to1 port map (S=>ID_ControlFlagJump,
	                              R(0)=>IF_PCPlus4,
                                  R(1)=>ID_SmoosherOutput,
                                  R(2)=>ID_RegisterFileData1Out,
                                  R(3)=>ID_BranchMuxOut,
                                  O=>JumpMuxOut);

	RegisterFile: RegFile port map (Reg1=>ID_Rs,
                                    Reg2=>ID_Rt,
                                    Clock=>clock,
	                                init=>CPUInitFlag,
                                    Read1Data=>ID_RegisterFileData1Out,
                                    Read2Data=>ID_RegisterFileData2Out,
                                    WE=>WB_ControlFlagRegWrite,
                                    WriteReg=>WB_RegWriteAddress,
                                    WriteData=>WB_MemToRegMuxOut);

	Control_0: control port map (Operation=>ID_InstructionMemoryOut(31 downto 26),
                                 Function_=>ID_InstructionMemoryOut(5 downto 0),
                                 Branch=>ID_ControlFlagBranch,
                                 MemRead=>ID_ControlFlagMemRead,
                                 MemWrite=>ID_ControlFlagMemWrite,
                                 ALUSrc=>ID_ControlFlagALUSrc,
                                 RegWrite=>ID_ControlFlagRegWrite,
                                 SignExtend=>ID_ControlFlagSignExtend,
                                 MemToReg=>ID_ControlFlagMemToReg,
                                 RegDst=>ID_ControlFlagRegDst,
                                 Jump=>ID_ControlFlagJump,
                                 ALUOp=>ID_ControlFlagALUOp);

	IdExReg_0: idexreg port map (WE=>'1',
	                             clock=>Clock,
	                             init=>CPUInitFlag,
	                             RegisterFileData1In=>ID_RegisterFileData1Out,
	                             RegisterFileData2In=>ID_RegisterFileData2Out,
	                             ControlFlagMemToRegIn=>ID_ControlFlagMemToReg,
	                             ControlFlagRegWriteIn=>ID_ControlFlagRegWrite,
	                             ControlFlagMemReadIn=>ID_ControlFlagMemRead,
	                             ControlFlagMemWriteIn=>ID_ControlFlagMemWrite,
	                             ControlFlagRegDstIn=>ID_ControlFlagRegDst,
	                             ControlFlagALUOpIn=>ID_ControlFlagALUOp,
	                             ControlFlagALUSrcIn=>ID_ControlFlagALUSrc,
	                             PCPlus8In=>ID_PCPlus8,

	                             RsIn=>ID_Rs,
	                             RtIn=>ID_Rt,
	                             RdIn=>ID_Rd,
	                             ShiftAmntIn=>ID_ShiftAmnt,
	                             ExtendedImmediateIn=>ID_ExtenderOut,

	                             RegisterFileData1Out=>EX_RegisterFileData1Out,
	                             RegisterFileData2Out=>EX_RegisterFileData2Out,
	                             ControlFlagMemToRegOut=>EX_ControlFlagMemToReg,
	                             ControlFlagRegWriteOut=>EX_ControlFlagRegWrite,
	                             ControlFlagMemReadOut=>EX_ControlFlagMemRead,
	                             ControlFlagMemWriteOut=>EX_ControlFlagMemWrite,
	                             ControlFlagRegDstOut=>EX_ControlFlagRegDst,
	                             ControlFlagALUOpOut=>EX_ControlFlagALUOp,
	                             ControlFlagALUSrcOut=>EX_ControlFlagALUSrc,

	                             RsOut=>EX_Rs,
	                             RtOut=>EX_Rt,
	                             RdOut=>EX_Rd,
	                             ShiftAmntOut=>EX_ShiftAmnt,
	                             ExtendedImmediateOut=>EX_ExtenderOut,
	                             PCPlus8Out=>EX_PCPlus8);

	EX_ExtendedShiftAmnt(31 downto 5) <= "000000000000000000000000000";
	EX_ExtendedShiftAmnt(4 downto 0) <= EX_ShiftAmnt;

	ForwardingUnit_0: forwardingunit port map (Rs=>EX_Rs,
	                                           Rt=>EX_Rt,
	                                           MEM_RegWriteAddress=>MEM_RegWriteAddress,
	                                           MEM_RegWriteAddressWE=>MEM_ControlFlagRegWrite,
	                                           WB_RegWriteAddress=>WB_RegWriteAddress,
	                                           WB_RegWriteAddressWE=>WB_ControlFlagRegWrite,
	                                           ForwardingUnitFlagALUSrc1=>ForwardingUnitFlagALUSrc1,
	                                           ForwardingUnitFlagALUSrc2=>ForwardingUnitFlagALUSrc2);

	ALUForwardingMux1: mux32x4to1 port map (S=>ForwardingUnitFlagALUSrc1,
	                                        R(0)=>EX_RegisterFileData1Out,
	                                        R(1)=>MEM_ALUValueOut,
	                                        R(2)=>WB_MemToRegMuxOut,
	                                        R(3)=>X"0000_0000", --unused
	                                        O=>ALUForwardingMux1Output);

	ALUForwardingMux2: mux32x4to1 port map (S=>ForwardingUnitFlagALUSrc2,
	                                        R(0)=>EX_RegisterFileData2Out,
	                                        R(1)=>MEM_ALUValueOut,
	                                        R(2)=>WB_MemToRegMuxOut,
	                                        R(3)=>X"0000_0000", --unused
	                                        O=>ALUForwardingMux2Output);

	ALUSrcMux: mux32x4to1 port map (S=>EX_ControlFlagALUSrc,
                                    R(0)=>ALUForwardingMux2Output,
                                    R(1)=>EX_ExtenderOut,
                                    R(2)=>EX_ExtendedShiftAmnt,
                                    R(3)=>X"0000_0000", --unused
                                    O=>EX_ALUSrcMuxOut);

	ALU_0: alu port map (Value1=>ALUForwardingMux1Output,
                         Value2=>EX_ALUSrcMuxOut,
                         Operation=>EX_ALUControlOperationOut,
                         ValueOut=>EX_ALUValueOut,
                         Overflow=>EX_ALUOverflow,
                         Negative=>EX_ALUNegative,
                         Zero=>EX_ALUZero,
                         CarryOut=>EX_ALUCarryOut);

	ALUControl_0: alucontrol port map (ALUOp=>EX_ControlFlagALUOp,
                                       Function_=>EX_ExtenderOut(5 downto 0),
                                       Operation=>EX_ALUControlOperationOut);


	RegDstMux: mux5x4to1 port map (S=>EX_ControlFlagRegDst,
                                   R(0)=>EX_Rt,
                                   R(1)=>EX_Rd,
                                   R(2)=>"11111",
                                   R(3)=>"00000", --unused
                                   O=>EX_RegWriteAddress);

	ExMemReg_0: exmemreg port map (WE=>'1',
	                               clock=>Clock,
	                               init=>CPUInitFlag,
	                               ControlFlagMemToRegIn=>EX_ControlFlagMemToReg,
	                               ControlFlagRegWriteIn=>EX_ControlFlagRegWrite,
	                               ControlFlagMemReadIn=>EX_ControlFlagMemRead,
	                               ControlFlagMemWriteIn=>EX_ControlFlagMemWrite,
	                               ALUValueIn=>EX_ALUValueOut,
	                               RegisterFileData2In=>ALUForwardingMux2Output,
	                               RegWriteAddressIn=>EX_RegWriteAddress,
	                               PCPlus8In=>EX_PCPlus8,

	                               ControlFlagMemToRegOut=>MEM_ControlFlagMemToReg,
	                               ControlFlagRegWriteOut=>MEM_ControlFlagRegWrite,
	                               ControlFlagMemReadOut=>MEM_ControlFlagMemRead,
	                               ControlFlagMemWriteOut=>MEM_ControlFlagMemWrite,
	                               ALUValueOut=>MEM_ALUValueOut,
	                               RegisterFileData2Out=>MEM_RegisterFileData2Out,
	                               RegWriteAddressOut=>MEM_RegWriteAddress,
	                               PCPlus8Out=>MEM_PCPlus8);

	DataMemory_0: datamemory port map (Address=>MEM_ALUValueOut,
                                       DataIn=>MEM_RegisterFileData2Out,
                                       DataOut=>MEM_DataMemoryOut,
                                       WriteEnable=>MEM_ControlFlagMemWrite,
                                       ReadEnable=>MEM_ControlFlagMemRead,
                                       Clock=>Clock);

	MemWbReg_0: memwbreg port map (WE=>'1',
	                               clock=>Clock,
	                               init=>CPUInitFlag,
	                               ControlFlagMemToRegIn=>MEM_ControlFlagMemToReg,
	                               ControlFlagRegWriteIn=>MEM_ControlFlagRegWrite,
	                               ALUValueIn=>MEM_ALUValueOut,
	                               DataMemoryIn=>MEM_DataMemoryOut,
	                               RegWriteAddressIn=>MEM_RegWriteAddress,
	                               PCPlus8In=>MEM_PCPlus8,

	                               ControlFlagMemToRegOut=>WB_ControlFlagMemToReg,
	                               ControlFlagRegWriteOut=>WB_ControlFlagRegWrite,
	                               ALUValueOut=>WB_ALUValueOut,
	                               DataMemoryOut=>WB_DataMemoryOut,
	                               RegWriteAddressOut=>WB_RegWriteAddress,
	                               PCPlus8Out=>WB_PCPlus8);

	MemToRegMux: mux32x4to1 port map (S=>WB_ControlFlagMemToReg,
                                      R(0)=>WB_ALUValueOut,
                                      R(1)=>WB_DataMemoryOut,
                                      R(2)=>WB_PCPlus8,
                                      R(3)=>X"0000_0000", --unused
                                      O=>WB_MemToRegMuxOut);

	process
	begin
		--initialize the program counter
		CPUInitFlag <= '0';
		ProgramCounterInit <= X"0000_4000";
		ProgramCounterInitFlag <= '0';
		Clock <= '0';
		wait for 2 ns;
		Clock <= '1';
		wait for 2 ns;
		CPUInitFlag <= '1';
		ProgramCounterInitFlag <= '1';

		for i in 1 to 1000 loop
			Clock <= not Clock;
			if ID_InstructionMemoryOut(31 downto 26) = "111111" then
				wait;
			end if;
			wait for 2 ns;
		end loop;
		wait;
	end process;
end pipelined;


--
--architecture singlecycle of cpu is
--
--	component extender is
--		port (Input: in std_logic_vector(15 downto 0);
--		      ExtendMethod: in std_logic;
--		      Output: out std_logic_vector(31 downto 0));
--	end component;
--
--	component mux32x4to1 is
--		port (S: in std_logic_vector(1 downto 0);
--		      R: in bus4x32;
--		      O: out std_logic_vector(31 downto 0));
--	end component;
--
--	component mux32x2to1 is
--		port (S: in std_logic;
--		      R: in bus2x32;
--		      O: out std_logic_vector(31 downto 0));
--	end component;
--
--	component mux5x4to1 is
--		port (S: in std_logic_vector(1 downto 0);
--		      R: in bus4x5;
--		      O: out std_logic_vector(4 downto 0));
--	end component;
--
--	component shifter32x2tol is
--		port (S: in std_logic;
--		      R: in std_logic_vector(31 downto 0);
--		      O: out std_logic_vector(31 downto 0);
--		      C: out std_logic);
--	end component;
--
--	component smoosher is
--		port (JumpAddress: in std_logic_vector(25 downto 0);
--		      PCPlus4: in std_logic_vector(31 downto 28);
--		      Output: out std_logic_vector(31 downto 0));
--	end component;
--
--	component fulladder32 is
--		port (A: in std_logic_vector(31 downto 0);
--		      B: in std_logic_vector(31 downto 0);
--		      Cin: in std_logic;
--		      S: out std_logic_vector(31 downto 0);
--		      Cout: out std_logic;
--		      Over: out std_logic);
--	end component;
--
--	component RegFile is
--		port (Reg1, Reg2, WriteReg: in std_logic_vector(4 downto 0);
--		      WE, Clock: in std_logic;
--		      WriteData: in std_logic_vector(31 downto 0);
--		      Read1Data, Read2Data: out std_logic_vector(31 downto 0));
--	end component;
--
--	component alu is
--		port (Value1, Value2: in std_logic_vector(31 downto 0);
--		      Operation: in std_logic_vector(2 downto 0);
--		      ValueOut: out std_logic_vector(31 downto 0);
--		      Overflow, Negative, Zero, CarryOut: out std_logic);
--	end component;
--
--	component control is
--		port(Operation: in std_logic_vector(31 downto 26);
--		     Function_: in std_logic_vector(5 downto 0);
--		     Branch, MemRead, MemWrite, RegWrite, SignExtend: out std_logic;
--		     MemToReg, RegDst, Jump, ALUSrc, ALUOp: out std_logic_vector(1 downto 0));
--	end component;
--
--	component alucontrol is
--		port(ALUOp: in std_logic_vector(1 downto 0);
--		     Function_: in std_logic_vector(5 downto 0);
--		     Operation: out std_logic_vector(2 downto 0));
--	end component;
--
--	component instructionmemory is
--		port (Address: in std_logic_vector(31 downto 0);
--		      InstructionOut: out std_logic_vector(31 downto 0));
--	end component;
--
--	component sram64kx8 is
--		generic (rom_data_file_name: string := "datamemoryinit.dat");
--
--		port (ncs: in std_logic;       -- not chip select
--		      addr: in std_logic_vector(31 downto 0);
--		      data: inout std_logic_vector(31 downto 0);
--		      nwe: in std_logic;       -- not write enable
--		      noe: in std_logic);      -- not output enable
--	end component;
--
--	component datamemory
--		port (Address: in std_logic_vector(31 downto 0);
--		      WriteEnable, ReadEnable: in std_logic;
--		      Clock: in std_logic;
--		      DataIn: in std_logic_vector(31 downto 0);
--		      DataOut: out std_logic_vector(31 downto 0));
--	end component;
--
--	component reg is
--		port (WE, clock: in std_logic;
--		      D: in std_logic_vector(31 downto 0);
--		      Q: out std_logic_vector(31 downto 0));
--	end component;
--
--	signal Clock: std_logic;
--	signal ProgramCounterIn: std_logic_vector(31 downto 0);
--	signal ProgramCounterOut: std_logic_vector(31 downto 0);
--	signal ProgramCounterInit: std_logic_vector(31 downto 0);
--	signal ProgramCounterInitFlag: std_logic;
--
--	signal RegisterFileWriteIn: std_logic_vector(4 downto 0);
--	signal RegisterFileData1Out: std_logic_vector(31 downto 0);
--	signal RegisterFileData2Out: std_logic_vector(31 downto 0);
--	signal ALUSrcMuxOut: std_logic_vector(31 downto 0);
--	signal MemToRegMuxOut: std_logic_vector(31 downto 0);
--	signal ImmediateValue: std_logic_vector(15 downto 0);
--
--	signal ALUValueOut: std_logic_vector(31 downto 0);
--	signal ALUOverflow: std_logic;
--	signal ALUNegative: std_logic;
--	signal ALUZero: std_logic;
--	signal ALUCarryOut: std_logic;
--	signal BranchAndZero: std_logic;
--	signal BranchAdderOut: std_logic_vector(31 downto 0);
--	signal BranchMuxOut: std_logic_vector(31 downto 0);
--	signal JumpMuxOut: std_logic_vector(31 downto 0);
--
--	signal DataMemoryOut: std_logic_vector(31 downto 0);
--	signal InstructionMemoryOut: std_logic_vector(31 downto 0);
--	signal ExtenderOut: std_logic_vector(31 downto 0);
--	signal DataMemoryReadEnableConnect: std_logic;
--	signal DataMemoryWriteEnableConnect: std_logic;
--
--
--	signal ControlFlagBranch: std_logic;
--	signal ControlFlagMemRead: std_logic;
--	signal ControlFlagMemWrite: std_logic;
--	signal ControlFlagALUSrc: std_logic_vector(1 downto 0);
--	signal ControlFlagRegWrite: std_logic;
--	signal ControlFlagSignExtend: std_logic;
--	signal ControlFlagMemToReg: std_logic_vector(1 downto 0);
--	signal ControlFlagRegDst: std_logic_vector(1 downto 0);
--	signal ControlFlagJump: std_logic_vector(1 downto 0);
--	signal ControlFlagALUOp: std_logic_vector(1 downto 0);
--
--	signal ALUControlOperationOut: std_logic_vector(2 downto 0);
--
--	signal Rs, Rt, Rd, ShiftAmnt: std_logic_vector(4 downto 0);
--	signal ExtendedShiftAmnt: std_logic_vector(31 downto 0);
--
--	signal PCPlus4: std_logic_vector(31 downto 0);
--
--	signal SmoosherOutput: std_logic_vector(31 downto 0);
--begin
--
--	InitializationMux: mux32x2to1 port map(S=>ProgramCounterInitFlag,
--                                           R(0)=>ProgramCounterInit,
--                                           R(1)=>JumpMuxOut,
--                                           O=>ProgramCounterIn);
--
--	ProgramCounter: reg port map (WE=>'1',
--                                  clock=>Clock,
--                                  D=>ProgramCounterIn,
--                                  Q=>ProgramCounterOut);
--
--	Smoosher_0: smoosher port map (JumpAddress=>InstructionMemoryOut(25 downto 0),
--                                   PCPlus4=>PCPlus4(31 downto 28),
--                                   Output=>SmoosherOutput);
--
--	PCPlus4Adder: fulladder32 port map (A=>ProgramCounterOut,
--                                        B=>X"0000_0004",
--                                        Cin=>'0',
--                                        S=>PCPlus4);
--
--	BranchAdder: fulladder32 port map (A=>PCPlus4,
--                                       B(31 downto 2)=>ExtenderOut(29 downto 0),
--                                       B(1 downto 0)=>"00", --left shift by 2
--                                       Cin=>'0',
--                                       S=>BranchAdderOut);
--
--	BranchAndZero <= ControlFlagBranch and ALUZero after 35 ps;
--	BranchMux: mux32x2to1 port map (S=>BranchAndZero,
--                                    R(0)=>PCPlus4,
--                                    R(1)=>BranchAdderOut,
--                                    O=>BranchMuxOut);
--
--	JumpMux: mux32x4to1 port map (S=>ControlFlagJump,
--                                  R(0)=>BranchMuxOut,
--                                  R(1)=>SmoosherOutput,
--                                  R(2)=>RegisterFileData1Out,
--                                  R(3)=>X"0000_0000",
--                                  O=>JumpMuxOut);
--
--	InstructionMemory_0: instructionmemory port map (Address=>ProgramCounterOut,
--                                                     InstructionOut=>InstructionMemoryOut);
--
--	Rs <= InstructionMemoryOut(25 downto 21);
--	Rt <= InstructionMemoryOut(20 downto 16);
--	Rd <= InstructionMemoryOut(15 downto 11);
--	ShiftAmnt <= InstructionMemoryOut(10 downto 6);
--	ImmediateValue <= InstructionMemoryOut(15 downto 0);
--
--	Extender_0: extender port map (Input=>ImmediateValue,
--                                   ExtendMethod=>ControlFlagSignExtend,
--                                   Output=>ExtenderOut);
--
--	RegDstMux: mux5x4to1 port map (S=>ControlFlagRegDst,
--                                   R(0)=>Rt,
--                                   R(1)=>Rd,
--                                   R(2)=>"11111",
--                                   R(3)=>"00000", --unused
--                                   O=>RegisterFileWriteIn);
--
--	RegisterFile: RegFile port map (Reg1=>Rs,
--                                    Reg2=>Rt,
--                                    WE=>ControlFlagRegWrite,
--                                    Clock=>clock,
--                                    WriteReg=>RegisterFileWriteIn,
--                                    WriteData=>MemToRegMuxOut,
--                                    Read1Data=>RegisterFileData1Out,
--                                    Read2Data=>RegisterFileData2Out);
--
--	ExtendedShiftAmnt(31 downto 5) <= "000000000000000000000000000";
--	ExtendedShiftAmnt(4 downto 0) <= ShiftAmnt;
--	ALUSrcMux: mux32x4to1 port map (S=>ControlFlagALUSrc,
--                                    R(0)=>RegisterFileData2Out,
--                                    R(1)=>ExtenderOut,
--                                    R(2)=>ExtendedShiftAmnt,
--                                    R(3)=>X"0000_0000", --unused
--                                    O=>ALUSrcMuxOut);
--
--	ALU_0: alu port map (Value1=>RegisterFileData1Out,
--                         Value2=>ALUSrcMuxOut,
--                         Operation=>ALUControlOperationOut,
--                         ValueOut=>ALUValueOut,
--                         Overflow=>ALUOverflow,
--                         Negative=>ALUNegative,
--                         Zero=>ALUZero,
--                         CarryOut=>ALUCarryOut);
--
--	DataMemory_0: datamemory port map (Address=>ALUValueOut,
--                                       DataIn=>RegisterFileData2Out,
--                                       DataOut=>DataMemoryOut,
--                                       WriteEnable=>ControlFlagMemWrite,
--                                       ReadEnable=>ControlFlagMemRead,
--                                       Clock=>Clock);
--
--	MemToRegMux: mux32x4to1 port map (S=>ControlFlagMemToReg,
--                                      R(0)=>ALUValueOut,
--                                      R(1)=>DataMemoryOut,
--                                      R(2)=>PCPlus4,
--                                      R(3)=>X"0000_0000", --unused
--                                      O=>MemToRegMuxOut);
--
--	Control_0: control port map (Operation=>InstructionMemoryOut(31 downto 26),
--                                 Function_=>InstructionMemoryOut(5 downto 0),
--                                 Branch=>ControlFlagBranch,
--                                 MemRead=>ControlFlagMemRead,
--                                 MemWrite=>ControlFlagMemWrite,
--                                 ALUSrc=>ControlFlagALUSrc,
--                                 RegWrite=>ControlFlagRegWrite,
--                                 SignExtend=>ControlFlagSignExtend,
--                                 MemToReg=>ControlFlagMemToReg,
--                                 RegDst=>ControlFlagRegDst,
--                                 Jump=>ControlFlagJump,
--                                 ALUOp=>ControlFlagALUOp);
--
--	ALUControl_0: alucontrol port map (ALUOp=>ControlFlagALUOp,
--                                       Function_=>InstructionMemoryOut(5 downto 0),
--                                       Operation=>ALUControlOperationOut);
--
--	process
--	begin
--		--initialize the program counter
--		ProgramCounterInitFlag <= '0';
--		ProgramCounterInit <= X"0000_4000";
--		Clock <= '0';
--		wait for 1 ns;
--		Clock <= '1';
--		wait for 1 ns;
--		ProgramCounterInitFlag <= '1';
--
--		for i in 1 to 1000 loop
--			Clock <= not Clock;
--			if InstructionMemoryOut(31 downto 26) = "111111" then
--				wait;
--			end if;
--			wait for 2 ns;
--		end loop;
--		wait;
--	end process;
--end singlecycle;

