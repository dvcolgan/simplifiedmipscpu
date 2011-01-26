ghdl -a mux2to1.vhdl
ghdl -a shifter32x16tol.vhdl
ghdl -a shifter32x16tol_tb.vhdl
ghdl -e shifter32x16tol_tb
ghdl -r shifter32x16tol_tb --vcd=shifter32x16tol.vcd
