ghdl -a bustypes.vhdl
ghdl -a std_logic_arith.vhdl
ghdl -a std_logic_unsigned.vhdl

ghdl -a mux2to1.vhdl
ghdl -a mux4to1.vhdl
ghdl -a mux16to1.vhdl
ghdl -a mux32to1.vhdl
ghdl -a mux32x2to1.vhdl
ghdl -a mux32x4to1.vhdl
ghdl -a mux32x32to1.vhdl
ghdl -a mux5x4to1.vhdl
ghdl -a mux5x2to1.vhdl

ghdl -a decoder1to2.vhdl
ghdl -a decoder2to4.vhdl
ghdl -a decoder4to16.vhdl
ghdl -a decoder5to32.vhdl

ghdl -a dff.vhdl
ghdl -a reg.vhdl
ghdl -a reg5.vhdl
ghdl -a reg7.vhdl
ghdl -a reg11.vhdl
ghdl -a ground32.vhdl

ghdl -a smoosher.vhdl

ghdl -a fulladder1.vhdl
ghdl -a fulladder32.vhdl
ghdl -a addersubtractor32.vhdl

ghdl -a nor1.vhdl
ghdl -a nor32.vhdl
ghdl -a or1.vhdl
ghdl -a or32.vhdl

ghdl -a shifter32x1tol.vhdl
ghdl -a shifter32x1tor.vhdl
ghdl -a shifter32x2tol.vhdl
ghdl -a shifter32x2tor.vhdl
ghdl -a shifter32x4tol.vhdl
ghdl -a shifter32x4tor.vhdl
ghdl -a shifter32x8tol.vhdl
ghdl -a shifter32x8tor.vhdl
ghdl -a shifter32x16tol.vhdl
ghdl -a shifter32x16tor.vhdl
ghdl -a shiftertol.vhdl
ghdl -a shiftertor.vhdl

ghdl -a comparator.vhdl

ghdl -a extender.vhdl

ghdl -a datamemory.vhdl
ghdl -a instructionmemory.vhdl

ghdl -a sram.vhdl

ghdl -a regfile.vhdl
ghdl -a alu.vhdl
ghdl -a control.vhdl
ghdl -a alucontrol.vhdl

ghdl -a ifidreg.vhdl
ghdl -a idexreg.vhdl
ghdl -a exmemreg.vhdl
ghdl -a memwbreg.vhdl

ghdl -a forwardingunit.vhdl

ghdl -a cpu.vhdl
ghdl -e cpu
ghdl -r cpu --vcd=cpu.vcd
