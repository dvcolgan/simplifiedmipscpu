ghdl -a bustypes.vhdl

ghdl -a mux2to1.vhdl
ghdl -a mux4to1.vhdl
ghdl -a mux32x2to1.vhdl
ghdl -a mux32x4to1.vhdl

ghdl -a fulladder1.vhdl
ghdl -a fulladder32.vhdl
ghdl -a addersubtractor32.vhdl

ghdl -a nor1.vhdl
ghdl -a nor32.vhdl

ghdl -a shifter32x1tol.vhdl
ghdl -a shifter32x2tol.vhdl
ghdl -a shifter32x4tol.vhdl
ghdl -a shifter32x8tol.vhdl
ghdl -a shifter32x16tol.vhdl
ghdl -a shiftertol.vhdl

ghdl -a shifter32x1tor.vhdl
ghdl -a shifter32x2tor.vhdl
ghdl -a shifter32x4tor.vhdl
ghdl -a shifter32x8tor.vhdl
ghdl -a shifter32x16tor.vhdl
ghdl -a shiftertor.vhdl

ghdl -a alu.vhdl
ghdl -a alu_tb.vhdl
ghdl -e alu_tb
ghdl -r alu_tb --vcd=alu.vcd
