ghdl -a mux2to1.vhdl
ghdl -a shifter32x1tol.vhdl
ghdl -a shifter32x1tol_tb.vhdl
ghdl -e shifter32x1tol_tb
ghdl -r shifter32x1tol_tb --vcd=shifter32x1tol.vcd
