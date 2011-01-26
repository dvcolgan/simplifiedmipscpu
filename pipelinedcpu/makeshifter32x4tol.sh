ghdl -a mux2to1.vhdl
ghdl -a shifter32x4tol.vhdl
ghdl -a shifter32x4tol_tb.vhdl
ghdl -e shifter32x4tol_tb
ghdl -r shifter32x4tol_tb --vcd=shifter32x4tol.vcd
