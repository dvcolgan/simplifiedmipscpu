ghdl -a mux2to1.vhdl
ghdl -a shifter32x2tol.vhdl
ghdl -a shifter32x2tol_tb.vhdl
ghdl -e shifter32x2tol_tb
ghdl -r shifter32x2tol_tb --vcd=shifter32x2tol.vcd
