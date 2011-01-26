ghdl -a mux2to1.vhdl

ghdl -a shifter32x1tol.vhdl
ghdl -a shifter32x2tol.vhdl
ghdl -a shifter32x4tol.vhdl
ghdl -a shifter32x8tol.vhdl
ghdl -a shifter32x16tol.vhdl

ghdl -a shiftertol.vhdl
ghdl -a shiftertol_tb.vhdl
ghdl -e shiftertol_tb
ghdl -r shiftertol_tb --vcd=shiftertol.vcd
